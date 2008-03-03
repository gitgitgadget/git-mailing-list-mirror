From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 8/8] Teach git-fetch to grab a tag at the same time as a commit
Date: Sun, 2 Mar 2008 21:35:33 -0500
Message-ID: <20080303023533.GH9966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 03:36:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW0XK-0001hX-9m
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764AbYCCCfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 21:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755752AbYCCCfh
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:35:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59591 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620AbYCCCfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 21:35:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JW0WR-0002Tm-5E; Sun, 02 Mar 2008 21:35:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6BFC120FBAE; Sun,  2 Mar 2008 21:35:33 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75877>

If the situation is the following on the remote and L is the common
base between both sides:

          T - tag1    S - tag2
         /           /
    L - A - O - O - B
     \               \
      origin/master   master

and we have decided to fetch "master" to acquire the range L..B we
can also nab tag S at the same time during the first connection,
as we can clearly see from the refs advertised by upload-pack that
S^{} = B and master = B.

Unfortunately we still cannot nab T at the same time as we are not
able to see that T^{} will also be in the range implied by L..B.
Such computations must be performed on the remote side (not yet
supported) or on the client side as post-processing (the current
behavior).

This optimization is an extension of the previous one in that it
helps on projects which tend to publish both a new commit and a
new tag, then lay idle for a while before publishing anything else.
Most followers are able to download both the new commit and the new
tag in one connection, rather than two.  git.git tends to follow
such patterns with its roughly once-daily updates from Junio.

A protocol extension and additional server side logic would be
necessary to also ensure T is grabbed on the first connection.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c      |   14 +++++-
 t/t5503-tagfollow.sh |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 1 deletions(-)
 create mode 100755 t/t5503-tagfollow.sh

diff --git a/builtin-fetch.c b/builtin-fetch.c
index a58efa6..26c3d74 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -459,6 +459,17 @@ static int add_existing(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
+static int will_fetch(struct ref **head, const unsigned char *sha1)
+{
+	struct ref *rm = *head;
+	while (rm) {
+		if (!hashcmp(rm->old_sha1, sha1))
+			return 1;
+		rm = rm->next;
+	}
+	return 0;
+}
+
 static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
@@ -495,7 +506,8 @@ static void find_non_local_tags(struct transport *transport,
 
 		if (!path_list_has_path(&existing_refs, ref_name) &&
 		    !path_list_has_path(&new_refs, ref_name) &&
-		    has_sha1_file(ref->old_sha1)) {
+		    (has_sha1_file(ref->old_sha1) ||
+		     will_fetch(head, ref->old_sha1))) {
 			path_list_insert(ref_name, &new_refs);
 
 			rm = alloc_ref(strlen(ref_name) + 1);
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
new file mode 100755
index 0000000..45ff982
--- /dev/null
+++ b/t/t5503-tagfollow.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+
+test_description='test automatic tag following'
+
+. ./test-lib.sh
+
+# End state of the repository:
+#
+#         T - tag1          S - tag2
+#        /                 /
+#   L - A ------ O ------ B
+#    \   \                 \
+#     \   C - origin/cat    \
+#      origin/master         master
+
+test_expect_success setup '
+	test_tick &&
+	echo ichi >file &&
+	git add file &&
+	git commit -m L &&
+	L=$(git rev-parse --verify HEAD) &&
+
+	(
+		mkdir cloned &&
+		cd cloned &&
+		git init-db &&
+		git remote add -f origin ..
+	) &&
+
+	test_tick &&
+	echo A >file &&
+	git add file &&
+	git commit -m A &&
+	A=$(git rev-parse --verify HEAD)
+'
+
+U=UPLOAD_LOG
+
+cat - <<EOF >expect
+#S
+want $A
+#E
+EOF
+test_expect_success 'fetch A (new commit : 1 connection)' '
+	rm -f $U
+	(
+		cd cloned &&
+		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
+		test $A = $(git rev-parse --verify origin/master)
+	) &&
+	test -s $U &&
+	cut -d" " -f1,2 $U >actual &&
+	git diff expect actual
+'
+
+test_expect_success "create tag T on A, create C on branch cat" '
+	git tag -a -m tag1 tag1 $A &&
+	T=$(git rev-parse --verify tag1) &&
+
+	git checkout -b cat &&
+	echo C >file &&
+	git add file &&
+	git commit -m C &&
+	C=$(git rev-parse --verify HEAD) &&
+	git checkout master
+'
+
+cat - <<EOF >expect
+#S
+want $C
+want $T
+#E
+EOF
+test_expect_success 'fetch C, T (new branch, tag : 1 connection)' '
+	rm -f $U
+	(
+		cd cloned &&
+		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
+		test $C = $(git rev-parse --verify origin/cat) &&
+		test $T = $(git rev-parse --verify tag1) &&
+		test $A = $(git rev-parse --verify tag1^0)
+	) &&
+	test -s $U &&
+	cut -d" " -f1,2 $U >actual &&
+	git diff expect actual
+'
+
+test_expect_success "create commits O, B, tag S on B" '
+	test_tick &&
+	echo O >file &&
+	git add file &&
+	git commit -m O &&
+
+	test_tick &&
+	echo B >file &&
+	git add file &&
+	git commit -m B &&
+	B=$(git rev-parse --verify HEAD) &&
+
+	git tag -a -m tag2 tag2 $B &&
+	S=$(git rev-parse --verify tag2)
+'
+
+cat - <<EOF >expect
+#S
+want $B
+want $S
+#E
+EOF
+test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
+	rm -f $U
+	(
+		cd cloned &&
+		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
+		test $B = $(git rev-parse --verify origin/master) &&
+		test $B = $(git rev-parse --verify tag2^0) &&
+		test $S = $(git rev-parse --verify tag2)
+	) &&
+	test -s $U &&
+	cut -d" " -f1,2 $U >actual &&
+	git diff expect actual
+'
+
+test_done
-- 
1.5.4.3.468.g36990
