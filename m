From: Jeff King <peff@peff.net>
Subject: [PATCHv2 10/10] remote-curl: always parse incoming refs
Date: Mon, 18 Feb 2013 04:30:56 -0500
Message-ID: <20130218093056.GJ5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:31:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7N4F-00055F-6g
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230Ab3BRJa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:30:59 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51705 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500Ab3BRJa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:30:58 -0500
Received: (qmail 17806 invoked by uid 107); 18 Feb 2013 09:32:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:32:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:30:56 -0500
Content-Disposition: inline
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216457>

When remote-curl receives a list of refs from a server, it
keeps the whole buffer intact. When we get a "list" command,
we feed the result to get_remote_heads, and when we get a
"fetch" or "push" command, we feed it to fetch-pack or
send-pack, respectively.

If the HTTP response from the server is truncated for any
reason, we will get an incomplete ref advertisement. If we
then feed this incomplete list to fetch-pack, one of a few
things may happen:

  1. If the truncation is in a packet header, fetch-pack
     will notice the bogus line and complain.

  2. If the truncation is inside a packet, fetch-pack will
     keep waiting for us to send the rest of the packet,
     which we never will.

  3. If the truncation is at a packet boundary, fetch-pack
     will keep waiting for us to send the next packet, which
     we never will.

As a result, fetch-pack hangs, waiting for input.  However,
remote-curl believes it has sent all of the advertisement,
and therefore waits for fetch-pack to speak. The two
processes end up in a deadlock.

We do notice the broken ref list if we feed it to
get_remote_heads. So if git asks the helper to do a "list"
followed by a "fetch", we are safe; we'll abort during the
list operation, which parses the refs.

This patch teaches remote-curl to always parse and save the
incoming ref list when we read the ref advertisement from a
server. That means that we will always verify and abort
before even running fetch-pack (or send-pack) when reading a
corrupted list, even if we do not run the "list" command
explicitly.

Since we save the result, in the common case of running
"list" then "fetch", we do not do any extra parsing at all.
In the case of just a "fetch", we do an extra round of
parsing, but only once.

Note also that the "fetch" case will now also initialize
server_capabilities from the remote (in remote-curl; we
already would do so inside fetch-pack).  Doing "list+fetch"
already does this. It doesn't actually matter now, but the
new behavior is arguably more correct, should remote-curl
ever start caring about the server's capability list.

Signed-off-by: Jeff King <peff@peff.net>
---
And this does the equivalent of patch 3/3 from the first series, but I
think this is much more robust (certainly it solves the ERR problem, but
more importantly, it uses the exact same function that other code paths
do, so we do not have to worry about it diverging).

 remote-curl.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 62f82d1..33af198 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -76,6 +76,7 @@ struct discovery {
 	char *buf_alloc;
 	char *buf;
 	size_t len;
+	struct ref *refs;
 	unsigned proto_git : 1;
 };
 static struct discovery *last_discovery;
@@ -145,11 +146,12 @@ static void free_discovery(struct discovery *d)
 		if (d == last_discovery)
 			last_discovery = NULL;
 		free(d->buf_alloc);
+		free_refs(d->refs);
 		free(d);
 	}
 }
 
-static struct discovery* discover_refs(const char *service)
+static struct discovery* discover_refs(const char *service, int for_push)
 {
 	struct strbuf exp = STRBUF_INIT;
 	struct strbuf type = STRBUF_INIT;
@@ -224,6 +226,11 @@ static struct discovery* discover_refs(const char *service)
 		last->proto_git = 1;
 	}
 
+	if (last->proto_git)
+		last->refs = parse_git_refs(last, for_push);
+	else
+		last->refs = parse_info_refs(last);
+
 	free(refs_url);
 	strbuf_release(&exp);
 	strbuf_release(&type);
@@ -232,19 +239,16 @@ static struct ref *get_refs(int for_push)
 	return last;
 }
 
-
 static struct ref *get_refs(int for_push)
 {
 	struct discovery *heads;
 
 	if (for_push)
-		heads = discover_refs("git-receive-pack");
+		heads = discover_refs("git-receive-pack", for_push);
 	else
-		heads = discover_refs("git-upload-pack");
+		heads = discover_refs("git-upload-pack", for_push);
 
-	if (heads->proto_git)
-		return parse_git_refs(heads, for_push);
-	return parse_info_refs(heads);
+	return heads->refs;
 }
 
 static void output_refs(struct ref *refs)
@@ -258,7 +262,6 @@ static void output_refs(struct ref *refs)
 	}
 	printf("\n");
 	fflush(stdout);
-	free_refs(refs);
 }
 
 struct rpc_state {
@@ -674,7 +677,7 @@ static int fetch(int nr_heads, struct ref **to_fetch)
 
 static int fetch(int nr_heads, struct ref **to_fetch)
 {
-	struct discovery *d = discover_refs("git-upload-pack");
+	struct discovery *d = discover_refs("git-upload-pack", 0);
 	if (d->proto_git)
 		return fetch_git(d, nr_heads, to_fetch);
 	else
@@ -793,7 +796,7 @@ static int push(int nr_spec, char **specs)
 
 static int push(int nr_spec, char **specs)
 {
-	struct discovery *heads = discover_refs("git-receive-pack");
+	struct discovery *heads = discover_refs("git-receive-pack", 1);
 	int ret;
 
 	if (heads->proto_git)
-- 
1.8.1.20.g7078b03
