From: Jeff King <peff@peff.net>
Subject: [PATCH v3 19/19] remote-curl: always parse incoming refs
Date: Wed, 20 Feb 2013 15:07:19 -0500
Message-ID: <20130220200719.GS25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:07:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8FxH-0008Fs-78
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935396Ab3BTUHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:07:24 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54702 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935098Ab3BTUHW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:07:22 -0500
Received: (qmail 17944 invoked by uid 107); 20 Feb 2013 20:08:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:08:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:07:19 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216734>

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
 remote-curl.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 856decc..3d2b194 100644
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
@@ -221,6 +223,11 @@ static struct discovery* discover_refs(const char *service)
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
@@ -234,13 +241,11 @@ static struct ref *get_refs(int for_push)
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
@@ -254,7 +259,6 @@ static void output_refs(struct ref *refs)
 	}
 	printf("\n");
 	fflush(stdout);
-	free_refs(refs);
 }
 
 struct rpc_state {
@@ -670,7 +674,7 @@ static int fetch(int nr_heads, struct ref **to_fetch)
 
 static int fetch(int nr_heads, struct ref **to_fetch)
 {
-	struct discovery *d = discover_refs("git-upload-pack");
+	struct discovery *d = discover_refs("git-upload-pack", 0);
 	if (d->proto_git)
 		return fetch_git(d, nr_heads, to_fetch);
 	else
@@ -789,7 +793,7 @@ static int push(int nr_spec, char **specs)
 
 static int push(int nr_spec, char **specs)
 {
-	struct discovery *heads = discover_refs("git-receive-pack");
+	struct discovery *heads = discover_refs("git-receive-pack", 1);
 	int ret;
 
 	if (heads->proto_git)
-- 
1.8.2.rc0.9.g352092c
