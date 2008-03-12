From: Jeff King <peff@peff.net>
Subject: [PATCH 05/16] remove use of "tail -n 1" and "tail -1"
Date: Wed, 12 Mar 2008 17:34:34 -0400
Message-ID: <20080312213434.GF26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:35:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYbV-0008Av-6j
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYCLVei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbYCLVeh
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:34:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4864 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbYCLVeh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:34:37 -0400
Received: (qmail 2993 invoked by uid 111); 12 Mar 2008 21:34:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:34:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:34:34 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76995>

The "-n" syntax is not supported by System V versions of
tail (which prefer "tail -1"). Unfortunately "tail -1" is
not actually POSIX.  We had some of both forms in our
scripts.

Since neither form works everywhere, this patch replaces
both with the equivalent sed invocation:

  sed -ne '$p'

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, "tail -1" _does_ seem to be accepted everywhere, even though
it isn't POSIX. I remember the GNU utils complaining about it (but maybe
just with POSIXLY_CORRECT?) a while back, but that seems to have been
reverted. But certainly this sed invocation should work everywhere.

 git-am.sh                       |    2 +-
 git-rebase--interactive.sh      |    2 +-
 t/t3404-rebase-interactive.sh   |    4 ++--
 t/t5302-pack-index.sh           |    4 ++--
 t/t6030-bisect-porcelain.sh     |    6 +++---
 t/t7600-merge.sh                |    2 +-
 t/t9400-git-cvsserver-server.sh |   20 ++++++++++----------
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 1f6b5e0..ac5c388 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -357,7 +357,7 @@ do
 		LAST_SIGNED_OFF_BY=`
 		    sed -ne '/^Signed-off-by: /p' \
 		    "$dotest/msg-clean" |
-		    tail -n 1
+		    sed -ne '$p'
 		`
 		ADD_SIGNOFF=`
 		    test "$LAST_SIGNED_OFF_BY" = "$SIGNOFF" || {
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4c3280a..8aa7371 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -218,7 +218,7 @@ nth_string () {
 make_squash_message () {
 	if test -f "$SQUASH_MSG"; then
 		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
-			< "$SQUASH_MSG" | tail -n 1)+1))
+			< "$SQUASH_MSG" | sed -ne '$p')+1))
 		echo "# This is a combination of $COUNT commits."
 		sed -e 1d -e '2,/^./{
 			/^$/d
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f098231..9c0acc5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -122,8 +122,8 @@ test_expect_success 'reflog for the branch shows state before rebase' '
 
 test_expect_success 'exchange two commits' '
 	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
-	test H = $(git cat-file commit HEAD^ | tail -n 1) &&
-	test G = $(git cat-file commit HEAD | tail -n 1)
+	test H = $(git cat-file commit HEAD^ | sed -ne \$p) &&
+	test G = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
 cat > expect << EOF
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 67b9a7b..b88b5bb 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -103,7 +103,7 @@ test_expect_success \
 test_expect_success \
     '[index v1] 2) create a stealth corruption in a delta base reference' \
     '# this test assumes a delta smaller than 16 bytes at the end of the pack
-     git show-index <1.idx | sort -n | tail -n 1 | (
+     git show-index <1.idx | sort -n | sed -ne \$p | (
        read delta_offs delta_sha1 &&
        git cat-file blob "$delta_sha1" > blob_1 &&
        chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
@@ -141,7 +141,7 @@ test_expect_success \
 test_expect_success \
     '[index v2] 2) create a stealth corruption in a delta base reference' \
     '# this test assumes a delta smaller than 16 bytes at the end of the pack
-     git show-index <1.idx | sort -n | tail -n 1 | (
+     git show-index <1.idx | sort -n | sed -ne \$p | (
        read delta_offs delta_sha1 delta_crc &&
        git cat-file blob "$delta_sha1" > blob_3 &&
        chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 4908e87..f471c15 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -219,7 +219,7 @@ test_expect_success 'bisect run & skip: cannot tell between 2' '
 	add_line_into_file "6: Yet a line." hello &&
 	HASH6=$(git rev-parse --verify HEAD) &&
 	echo "#"\!"/bin/sh" > test_script.sh &&
-	echo "tail -1 hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
+	echo "sed -ne \\\$p hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
 	echo "grep line hello > /dev/null" >> test_script.sh &&
 	echo "test \$? -ne 0" >> test_script.sh &&
 	chmod +x test_script.sh &&
@@ -244,8 +244,8 @@ test_expect_success 'bisect run & skip: find first bad' '
 	add_line_into_file "7: Should be the last line." hello &&
 	HASH7=$(git rev-parse --verify HEAD) &&
 	echo "#"\!"/bin/sh" > test_script.sh &&
-	echo "tail -1 hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
-	echo "tail -1 hello | grep day > /dev/null && exit 125" >> test_script.sh &&
+	echo "sed -ne \\\$p hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
+	echo "sed -ne \\\$p hello | grep day > /dev/null && exit 125" >> test_script.sh &&
 	echo "grep Yet hello > /dev/null" >> test_script.sh &&
 	echo "test \$? -ne 0" >> test_script.sh &&
 	chmod +x test_script.sh &&
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 590505b..219411f 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -165,7 +165,7 @@ verify_mergeheads() {
 	fi &&
 	while test $# -gt 0
 	do
-		head=$(head -n $i .git/MERGE_HEAD | tail -n 1)
+		head=$(head -n $i .git/MERGE_HEAD | sed -ne \$p)
 		if test "$1" != "$head"
 		then
 			echo "[OOPS] MERGE_HEAD $i != $1"
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index e82b365..b91b151 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -54,7 +54,7 @@ test_expect_success 'setup' '
 test_expect_success 'basic checkout' \
   'GIT_CONFIG="$git_config" cvs -Q co -d cvswork master &&
    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | head -n 1))" = "empty/1.1/"
-   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | tail -n 1))" = "secondrootfile/1.1/"'
+   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | sed -ne \$p))" = "secondrootfile/1.1/"'
 
 #------------------------
 # PSERVER AUTHENTICATION
@@ -94,7 +94,7 @@ EOF
 
 test_expect_success 'pserver authentication' \
   'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
-   tail -n1 log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'pserver authentication failure (non-anonymous user)' \
   'if cat request-git | git-cvsserver pserver >log 2>&1
@@ -103,11 +103,11 @@ test_expect_success 'pserver authentication failure (non-anonymous user)' \
    else
        true
    fi &&
-   tail -n1 log | grep "^I HATE YOU$"'
+   sed -ne \$p log | grep "^I HATE YOU$"'
 
 test_expect_success 'pserver authentication (login)' \
   'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
-   tail -n1 log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'pserver authentication failure (login/non-anonymous user)' \
   'if cat login-git | git-cvsserver pserver >log 2>&1
@@ -116,7 +116,7 @@ test_expect_success 'pserver authentication failure (login/non-anonymous user)'
    else
        true
    fi &&
-   tail -n1 log | grep "^I HATE YOU$"'
+   sed -ne \$p log | grep "^I HATE YOU$"'
 
 
 # misuse pserver authentication for testing of req_Root
@@ -154,7 +154,7 @@ test_expect_success 'req_Root failure (conflicting roots)' \
 
 test_expect_success 'req_Root (strict paths)' \
   'cat request-anonymous | git-cvsserver --strict-paths pserver $SERVERDIR >log 2>&1 &&
-   tail -n1 log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (strict-paths)' '
     ! cat request-anonymous |
@@ -163,7 +163,7 @@ test_expect_success 'req_Root failure (strict-paths)' '
 
 test_expect_success 'req_Root (w/o strict-paths)' \
   'cat request-anonymous | git-cvsserver pserver $WORKDIR/ >log 2>&1 &&
-   tail -n1 log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (w/o strict-paths)' '
     ! cat request-anonymous |
@@ -181,7 +181,7 @@ EOF
 
 test_expect_success 'req_Root (base-path)' \
   'cat request-base | git-cvsserver --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
-   tail -n1 log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (base-path)' '
     ! cat request-anonymous |
@@ -192,14 +192,14 @@ GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false || exit 1
 
 test_expect_success 'req_Root (export-all)' \
   'cat request-anonymous | git-cvsserver --export-all pserver $WORKDIR >log 2>&1 &&
-   tail -n1 log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (export-all w/o whitelist)' \
   '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
 
 test_expect_success 'req_Root (everything together)' \
   'cat request-base | git-cvsserver --export-all --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
-   tail -n1 log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU$"'
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true || exit 1
 
-- 
1.5.4.4.543.g30fdd.dirty
