From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH] stash: treat numerical arguments as shorthand for stash@{n}
Date: Tue, 25 Dec 2012 16:38:34 -0800
Message-ID: <1356482314-29044-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 26 02:22:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnfhS-0006Yx-3e
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 02:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab2LZBWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2012 20:22:07 -0500
Received: from master.pcc.me.uk ([207.192.74.179]:36327 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677Ab2LZBWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2012 20:22:06 -0500
X-Greylist: delayed 2578 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Dec 2012 20:22:06 EST
Received: from c-76-102-13-246.hsd1.ca.comcast.net ([76.102.13.246] helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1Tnf1M-0005Kg-Bx; Tue, 25 Dec 2012 16:38:56 -0800
Received: from peter by lapas.pcc.me.uk with local (Exim 4.72)
	(envelope-from <peter@pcc.me.uk>)
	id 1Tnf1F-0007ZA-OP; Tue, 25 Dec 2012 16:38:49 -0800
X-Mailer: git-send-email 1.7.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212125>

This patch causes git-stash to treat any argument consisting of
between one and three numerical digits as if it were of the form
`stash@{<n>}`, where `<n>` is the argument supplied.

This is a significant usability improvement for people dealing with
multiple stashes, as it avoids redundantly typing 'stash@{' ... '}'
(which involves shifted characters on most keyboards) in the very
common case that the stash was created using git-stash.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 Documentation/git-stash.txt |    4 ++++
 git-stash.sh                |   15 ++++++++++++++-
 t/t3903-stash.sh            |   18 +++++++++---------
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 711ffe1..8ffcc97 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -40,6 +40,10 @@ the usual reflog syntax (e.g. `stash@{0}` is the most recently
 created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
 is also possible).
 
+Any argument supplied to this command consisting of between one
+and three numerical digits is treated as if it were of the
+form `stash@{<n>}`, where `<n>` is the argument supplied.
+
 OPTIONS
 -------
 
diff --git a/git-stash.sh b/git-stash.sh
index bbefdf6..2232719 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -327,7 +327,20 @@ parse_flags_and_rev()
 	i_tree=
 	u_tree=
 
-	REV=$(git rev-parse --no-flags --symbolic "$@") || exit 1
+	ARGS=
+	for arg
+	do
+		case "$arg" in
+			[0-9]|[0-9][0-9]|[0-9][0-9][0-9])
+				ARGS="${ARGS}${ARGS:+ }${ref_stash}@{$arg}"
+			;;
+			*)
+				ARGS="${ARGS}${ARGS:+ }$arg"
+			;;
+		esac
+	done
+
+	REV=$(git rev-parse --no-flags --symbolic $ARGS) || exit 1
 
 	FLAGS=
 	for opt
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5dfbda7..5467acf 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -38,7 +38,7 @@ test_expect_success 'parents of stash' '
 '
 
 test_expect_success 'applying bogus stash does nothing' '
-	test_must_fail git stash apply stash@{1} &&
+	test_must_fail git stash apply 1 &&
 	echo 1 >expect &&
 	test_cmp expect file
 '
@@ -113,7 +113,7 @@ test_expect_success 'drop middle stash' '
 	git stash &&
 	echo 9 > file &&
 	git stash &&
-	git stash drop stash@{1} &&
+	git stash drop 1 &&
 	test 2 = $(git stash list | wc -l) &&
 	git stash apply &&
 	test 9 = $(cat file) &&
@@ -570,16 +570,16 @@ test_expect_success 'ref with non-existent reflog' '
 
 test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	git stash clear &&
-	test_must_fail git stash drop stash@{0} &&
+	test_must_fail git stash drop 0 &&
 	echo bar5 > file &&
 	echo bar6 > file2 &&
 	git add file2 &&
 	git stash &&
-	test_must_fail git stash drop stash@{1} &&
-	test_must_fail git stash pop stash@{1} &&
-	test_must_fail git stash apply stash@{1} &&
-	test_must_fail git stash show stash@{1} &&
-	test_must_fail git stash branch tmp stash@{1} &&
+	test_must_fail git stash drop 1 &&
+	test_must_fail git stash pop 1 &&
+	test_must_fail git stash apply 1 &&
+	test_must_fail git stash show 1 &&
+	test_must_fail git stash branch tmp 1 &&
 	git stash drop
 '
 
@@ -590,7 +590,7 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
 	git commit -m initial &&
 	echo bar >file &&
 	git stash &&
-	test_must_fail git stash branch master stash@{0} &&
+	test_must_fail git stash branch master 0 &&
 	git rev-parse stash@{0} --
 '
 
-- 
1.7.5.3
