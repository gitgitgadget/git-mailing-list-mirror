From: Jeff King <peff@peff.net>
Subject: [PATCHv2 07/10] teach get_remote_heads to read from a memory buffer
Date: Mon, 18 Feb 2013 04:27:59 -0500
Message-ID: <20130218092759.GG5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:28:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7N1P-0003jc-Bx
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756992Ab3BRJ2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:28:03 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51688 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264Ab3BRJ2B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:28:01 -0500
Received: (qmail 17701 invoked by uid 107); 18 Feb 2013 09:29:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:29:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:27:59 -0500
Content-Disposition: inline
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216453>

Now that we can read packet data from memory as easily as a
descriptor, get_remote_heads can take either one as a
source. This will allow further refactoring in remote-curl.

Signed-off-by: Jeff King <peff@peff.net>
---
There aren't that many callers of get_remote_heads, so I just added the
optional parameters and tweaked each callsite. We can do it as a
get_remote_heads_from_buf wrapper function and leave them be, if we
want.

 builtin/fetch-pack.c |  2 +-
 builtin/send-pack.c  |  2 +-
 cache.h              |  4 +++-
 connect.c            | 10 +++++++---
 remote-curl.c        |  2 +-
 transport.c          |  6 +++---
 6 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index b59e60e..bf850d0 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -128,7 +128,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
-	get_remote_heads(fd[0], &ref, 0, NULL);
+	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL);
 
 	ref = fetch_pack(&args, fd, conn, ref, dest,
 			 &sought, pack_lockfile_ptr);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8778519..152c4ea 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -207,7 +207,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 
 	memset(&extra_have, 0, sizeof(extra_have));
 
-	get_remote_heads(fd[0], &remote_refs, REF_NORMAL, &extra_have);
+	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_have);
 
 	transport_verify_remote_names(nr_refspecs, refspecs);
 
diff --git a/cache.h b/cache.h
index e493563..db646a2 100644
--- a/cache.h
+++ b/cache.h
@@ -1049,7 +1049,9 @@ struct extra_have_objects {
 	int nr, alloc;
 	unsigned char (*array)[20];
 };
-extern struct ref **get_remote_heads(int in, struct ref **list, unsigned int flags, struct extra_have_objects *);
+extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
+				     struct ref **list, unsigned int flags,
+				     struct extra_have_objects *);
 extern int server_supports(const char *feature);
 extern int parse_feature_request(const char *features, const char *feature);
 extern const char *server_feature_value(const char *feature, int *len_ret);
diff --git a/connect.c b/connect.c
index 59266b1..28f21d0 100644
--- a/connect.c
+++ b/connect.c
@@ -62,8 +62,8 @@ static void die_initial_contact(int got_at_least_one_head)
 /*
  * Read all the refs from the other end
  */
-struct ref **get_remote_heads(int in, struct ref **list,
-			      unsigned int flags,
+struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
+			      struct ref **list, unsigned int flags,
 			      struct extra_have_objects *extra_have)
 {
 	int got_at_least_one_head = 0;
@@ -76,7 +76,11 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		char *name;
 		int len, name_len;
 
-		len = packet_read_gently(in, buffer, sizeof(buffer));
+		if (src_buf)
+			len = packet_read_from_buf_gently(buffer, sizeof(buffer),
+							  &src_buf, &src_len);
+		else
+			len = packet_read_gently(in, buffer, sizeof(buffer));
 		if (len < 0)
 			die_initial_contact(got_at_least_one_head);
 
diff --git a/remote-curl.c b/remote-curl.c
index 2ec5854..6e43463 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -195,7 +195,7 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 
 	if (start_async(&async))
 		die("cannot start thread to parse advertised refs");
-	get_remote_heads(async.out, &list,
+	get_remote_heads(async.out, NULL, 0, &list,
 			for_push ? REF_NORMAL : 0, NULL);
 	close(async.out);
 	if (finish_async(&async))
diff --git a/transport.c b/transport.c
index 886ffd8..62df466 100644
--- a/transport.c
+++ b/transport.c
@@ -507,7 +507,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	struct ref *refs;
 
 	connect_setup(transport, for_push, 0);
-	get_remote_heads(data->fd[0], &refs,
+	get_remote_heads(data->fd[0], NULL, 0, &refs,
 			 for_push ? REF_NORMAL : 0, &data->extra_have);
 	data->got_remote_heads = 1;
 
@@ -541,7 +541,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
-		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL);
+		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0, NULL);
 		data->got_remote_heads = 1;
 	}
 
@@ -799,7 +799,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 		struct ref *tmp_refs;
 		connect_setup(transport, 1, 0);
 
-		get_remote_heads(data->fd[0], &tmp_refs, REF_NORMAL, NULL);
+		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL, NULL);
 		data->got_remote_heads = 1;
 	}
 
-- 
1.8.1.20.g7078b03
