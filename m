From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] drop "match" parameter from get_remote_heads
Date: Mon, 12 Dec 2011 19:41:37 -0500
Message-ID: <20111213004137.GA3699@sigill.intra.peff.net>
References: <20111213003925.GA28403@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Sawicki <kevin@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 01:41:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGRF-0002KI-VX
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab1LMAll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:41:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48419
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753759Ab1LMAlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:41:40 -0500
Received: (qmail 8128 invoked by uid 107); 13 Dec 2011 00:48:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 19:48:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 19:41:37 -0500
Content-Disposition: inline
In-Reply-To: <20111213003925.GA28403@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186988>

The get_remote_heads function reads the list of remote refs
during git protocol session. It dates all the way back to
def88e9 (Commit first cut at "git-fetch-pack", 2005-07-04).
At that time, the idea was to come up with a list of refs we
were interested in, and then filter the list as we got it
from the remote side.

Later, 1baaae5 (Make maximal use of the remote refs,
2005-10-28) stopped filtering at the get_remote_heads layer,
letting us use the non-matching refs to find common history.

As a result, all callers now simply pass an empty match
list (and any future callers will want to do the same). So
let's drop these now-useless parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
This one isn't necessary for the bugfix, but since it is the only other
caller of path_match besides fetch-pack, it gives us freedom to modify
or get rid of path_match later.

 builtin/fetch-pack.c |    2 +-
 builtin/send-pack.c  |    3 +--
 cache.h              |    2 +-
 connect.c            |    3 ---
 remote-curl.c        |    2 +-
 transport.c          |    7 +++----
 6 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c6bc8eb..46688dc 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -976,7 +976,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
-	get_remote_heads(fd[0], &ref, 0, NULL, 0, NULL);
+	get_remote_heads(fd[0], &ref, 0, NULL);
 
 	ref = fetch_pack(&args, fd, conn, ref, dest,
 		nr_heads, heads, pack_lockfile_ptr);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index e0b8030..cd1115f 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -494,8 +494,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 
 	memset(&extra_have, 0, sizeof(extra_have));
 
-	get_remote_heads(fd[0], &remote_refs, 0, NULL, REF_NORMAL,
-			 &extra_have);
+	get_remote_heads(fd[0], &remote_refs, REF_NORMAL, &extra_have);
 
 	transport_verify_remote_names(nr_refspecs, refspecs);
 
diff --git a/cache.h b/cache.h
index 8c98d05..408e880 100644
--- a/cache.h
+++ b/cache.h
@@ -1034,7 +1034,7 @@ struct extra_have_objects {
 	int nr, alloc;
 	unsigned char (*array)[20];
 };
-extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags, struct extra_have_objects *);
+extern struct ref **get_remote_heads(int in, struct ref **list, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
diff --git a/connect.c b/connect.c
index 51990fa..48df90b 100644
--- a/connect.c
+++ b/connect.c
@@ -53,7 +53,6 @@ static void add_extra_have(struct extra_have_objects *extra, unsigned char *sha1
  * Read all the refs from the other end
  */
 struct ref **get_remote_heads(int in, struct ref **list,
-			      int nr_match, char **match,
 			      unsigned int flags,
 			      struct extra_have_objects *extra_have)
 {
@@ -92,8 +91,6 @@ struct ref **get_remote_heads(int in, struct ref **list,
 
 		if (!check_ref(name, name_len, flags))
 			continue;
-		if (nr_match && !path_match(name, nr_match, match))
-			continue;
 		ref = alloc_ref(buffer + 41);
 		hashcpy(ref->old_sha1, old_sha1);
 		*list = ref;
diff --git a/remote-curl.c b/remote-curl.c
index 0e720ee..94dc488 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -200,7 +200,7 @@ static struct ref *parse_git_refs(struct discovery *heads)
 
 	if (start_async(&async))
 		die("cannot start thread to parse advertised refs");
-	get_remote_heads(async.out, &list, 0, NULL, 0, NULL);
+	get_remote_heads(async.out, &list, 0, NULL);
 	close(async.out);
 	if (finish_async(&async))
 		die("ref parsing thread failed");
diff --git a/transport.c b/transport.c
index 51814b5..c2245d4 100644
--- a/transport.c
+++ b/transport.c
@@ -502,7 +502,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	struct ref *refs;
 
 	connect_setup(transport, for_push, 0);
-	get_remote_heads(data->fd[0], &refs, 0, NULL,
+	get_remote_heads(data->fd[0], &refs,
 			 for_push ? REF_NORMAL : 0, &data->extra_have);
 	data->got_remote_heads = 1;
 
@@ -537,7 +537,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
-		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0, NULL);
+		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL);
 		data->got_remote_heads = 1;
 	}
 
@@ -772,8 +772,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 		struct ref *tmp_refs;
 		connect_setup(transport, 1, 0);
 
-		get_remote_heads(data->fd[0], &tmp_refs, 0, NULL, REF_NORMAL,
-				 NULL);
+		get_remote_heads(data->fd[0], &tmp_refs, REF_NORMAL, NULL);
 		data->got_remote_heads = 1;
 	}
 
-- 
1.7.8.13.g74677
