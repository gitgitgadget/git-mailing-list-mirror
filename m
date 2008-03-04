From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 3/3] Teach git-fetch to exploit server side automatic tag following
Date: Mon, 3 Mar 2008 22:27:40 -0500
Message-ID: <20080304032740.GC16462@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 04:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNpF-0001CL-Mr
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 04:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757748AbYCDD1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 22:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757549AbYCDD1o
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 22:27:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43096 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382AbYCDD1n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 22:27:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWNoQ-0007jq-5s; Mon, 03 Mar 2008 22:27:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9248E20FBAE; Mon,  3 Mar 2008 22:27:40 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76027>

If the remote peer upload-pack process supports the auto-include-tag
protocol extension then we can avoid running a second fetch cycle
on the client side by letting the server send us the annotated tags
along with the objects it is packing for us.  In the following graph
we can now fetch both "tag1" and "tag2" on the same connection that
we fetched "master" from the remote when we only have L available
on the local side:

         T - tag1          S - tag2
        /                 /
   L - o ------ o ------ B
    \                     \
     \                     \
      origin/master         master

The objects for "tag1" are implicitly downloaded without our direct
knowledge.  The existing "quickfetch" optimization within git-fetch
discovers that tag1 is complete after the first connection and does
not open a second connection.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c      |    3 +++
 t/t5503-tagfollow.sh |   26 ++++++++++++++++++++++++++
 transport.c          |    5 +++++
 transport.h          |    3 +++
 4 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 26c3d74..55f611e 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -555,6 +555,8 @@ static int do_fetch(struct transport *transport,
 			read_ref(rm->peer_ref->name, rm->peer_ref->old_sha1);
 	}
 
+	if (tags == TAGS_DEFAULT && autotags)
+		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (fetch_refs(transport, ref_map)) {
 		free_refs(ref_map);
 		return 1;
@@ -568,6 +570,7 @@ static int do_fetch(struct transport *transport,
 		ref_map = NULL;
 		find_non_local_tags(transport, &ref_map, &tail);
 		if (ref_map) {
+			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 			fetch_refs(transport, ref_map);
 		}
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 45ff982..86e5b9b 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -121,4 +121,30 @@ test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
 	git diff expect actual
 '
 
+cat - <<EOF >expect
+#S
+want $B
+want $S
+#E
+EOF
+test_expect_success 'new clone fetch master and tags' '
+	git branch -D cat
+	rm -f $U
+	(
+		mkdir clone2 &&
+		cd clone2 &&
+		git init &&
+		git remote add origin .. &&
+		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
+		test $B = $(git rev-parse --verify origin/master) &&
+		test $S = $(git rev-parse --verify tag2) &&
+		test $B = $(git rev-parse --verify tag2^0) &&
+		test $T = $(git rev-parse --verify tag1) &&
+		test $A = $(git rev-parse --verify tag1^0)
+	) &&
+	test -s $U &&
+	cut -d" " -f1,2 $U >actual &&
+	git diff expect actual
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 166c1d1..12873db 100644
--- a/transport.c
+++ b/transport.c
@@ -560,6 +560,7 @@ static int close_bundle(struct transport *transport)
 struct git_transport_data {
 	unsigned thin : 1;
 	unsigned keep : 1;
+	unsigned followtags : 1;
 	int depth;
 	struct child_process *conn;
 	int fd[2];
@@ -580,6 +581,9 @@ static int set_git_option(struct transport *connection,
 	} else if (!strcmp(name, TRANS_OPT_THIN)) {
 		data->thin = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_FOLLOWTAGS)) {
+		data->followtags = !!value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_KEEP)) {
 		data->keep = !!value;
 		return 0;
@@ -628,6 +632,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.keep_pack = data->keep;
 	args.lock_pack = 1;
 	args.use_thin_pack = data->thin;
+	args.auto_include_tag = data->followtags;
 	args.verbose = transport->verbose > 0;
 	args.depth = data->depth;
 
diff --git a/transport.h b/transport.h
index 6fb4526..8abfc0a 100644
--- a/transport.h
+++ b/transport.h
@@ -53,6 +53,9 @@ struct transport *transport_get(struct remote *, const char *);
 /* Limit the depth of the fetch if not null */
 #define TRANS_OPT_DEPTH "depth"
 
+/* Aggressively fetch annotated tags if possible */
+#define TRANS_OPT_FOLLOWTAGS "followtags"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
1.5.4.3.529.gb25fb
