From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH 1/3] t4150-am: refactor and clean common setup
Date: Tue, 26 May 2015 23:32:53 +0200
Message-ID: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 23:33:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMTy-0005z3-QW
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 23:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbbEZVdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 17:33:50 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:40245 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078AbbEZVdt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 17:33:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 18CE5271E;
	Tue, 26 May 2015 23:33:46 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gUedRuRBGA7E; Tue, 26 May 2015 23:33:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 07D0926FF;
	Tue, 26 May 2015 23:33:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 0429420DF;
	Tue, 26 May 2015 23:33:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UUNmxu-ZTqTq; Tue, 26 May 2015 23:33:45 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-368-161.w82-122.abo.wanadoo.fr [82.122.243.161])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 7F0C020D1;
	Tue, 26 May 2015 23:33:45 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269978>

Add new functions to keep the setup cleaner:
 - setup_temporary_branch: creates a new branch, check it out
   and automatically delete it after the test is over
 - setup_fixed_branch: creates a fixed branch, which can be re-used
   in later tests

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 t/t4150-am.sh | 138 ++++++++++++++++++++--------------------------------------
 1 file changed, 47 insertions(+), 91 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 306e6f3..8370951 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -4,6 +4,20 @@ test_description='git am running'
 
 . ./test-lib.sh
 
+setup_temporary_branch () {
+	tmp_name=${2-"temporary"}
+	git reset --hard &&
+	rm -fr .git/rebase-apply &&
+	test_when_finished "git checkout $1 && git branch -D $tmp_name" &&
+	git checkout -b "$tmp_name" "$1"
+}
+
+setup_fixed_branch () {
+	git reset --hard &&
+	rm -fr .git/rebase-apply &&
+	git checkout -b "$1" "$2"
+}
+
 test_expect_success 'setup: messages' '
 	cat >msg <<-\EOF &&
 	second
@@ -143,9 +157,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'am applies patch correctly' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	test_tick &&
 	git am <patch1 &&
 	test_path_is_missing .git/rebase-apply &&
@@ -155,9 +167,7 @@ test_expect_success 'am applies patch correctly' '
 '
 
 test_expect_success 'am applies patch e-mail not in a mbox' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	git am patch1.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
@@ -166,9 +176,7 @@ test_expect_success 'am applies patch e-mail not in a mbox' '
 '
 
 test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	git am patch1-crlf.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
@@ -177,9 +185,7 @@ test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
 '
 
 test_expect_success 'am applies patch e-mail with preceding whitespace' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	git am patch1-ws.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
@@ -203,9 +209,7 @@ compare () {
 
 test_expect_success 'am changes committer and keeps author' '
 	test_tick &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	git am patch2 &&
 	test_path_is_missing .git/rebase-apply &&
 	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
@@ -218,9 +222,7 @@ test_expect_success 'am changes committer and keeps author' '
 '
 
 test_expect_success 'am --signoff adds Signed-off-by: line' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout -b master2 first &&
+	setup_fixed_branch master2 first &&
 	git am --signoff <patch2 &&
 	printf "%s\n" "$signoff" >expected &&
 	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >>expected &&
@@ -255,9 +257,7 @@ test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
 '
 
 test_expect_success 'am --keep really keeps the subject' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout HEAD^ &&
+	setup_temporary_branch master2^ &&
 	git am --keep patch4 &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD >actual &&
@@ -265,9 +265,7 @@ test_expect_success 'am --keep really keeps the subject' '
 '
 
 test_expect_success 'am --keep-non-patch really keeps the non-patch part' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout HEAD^ &&
+	setup_temporary_branch master2^ &&
 	git am --keep-non-patch patch4 &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD >actual &&
@@ -275,9 +273,7 @@ test_expect_success 'am --keep-non-patch really keeps the non-patch part' '
 '
 
 test_expect_success 'am -3 falls back to 3-way merge' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout -b lorem2 master2 &&
+	setup_fixed_branch lorem2 master2 &&
 	sed -n -e "3,\$p" msg >file &&
 	head -n 9 msg >>file &&
 	git add file &&
@@ -289,9 +285,7 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 '
 
 test_expect_success 'am -3 -p0 can read --no-prefix patch' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout -b lorem3 master2 &&
+	setup_temporary_branch lorem2 &&
 	sed -n -e "3,\$p" msg >file &&
 	head -n 9 msg >>file &&
 	git add file &&
@@ -303,10 +297,8 @@ test_expect_success 'am -3 -p0 can read --no-prefix patch' '
 '
 
 test_expect_success 'am can rename a file' '
+	setup_temporary_branch lorem &&
 	grep "^rename from" rename.patch &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout lorem^0 &&
 	git am rename.patch &&
 	test_path_is_missing .git/rebase-apply &&
 	git update-index --refresh &&
@@ -314,10 +306,8 @@ test_expect_success 'am can rename a file' '
 '
 
 test_expect_success 'am -3 can rename a file' '
+	setup_temporary_branch lorem &&
 	grep "^rename from" rename.patch &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout lorem^0 &&
 	git am -3 rename.patch &&
 	test_path_is_missing .git/rebase-apply &&
 	git update-index --refresh &&
@@ -325,10 +315,8 @@ test_expect_success 'am -3 can rename a file' '
 '
 
 test_expect_success 'am -3 can rename a file after falling back to 3-way merge' '
+	setup_temporary_branch lorem &&
 	grep "^rename from" rename-add.patch &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout lorem^0 &&
 	git am -3 rename-add.patch &&
 	test_path_is_missing .git/rebase-apply &&
 	git update-index --refresh &&
@@ -336,9 +324,7 @@ test_expect_success 'am -3 can rename a file after falling back to 3-way merge'
 '
 
 test_expect_success 'am -3 -q is quiet' '
-	rm -fr .git/rebase-apply &&
-	git checkout -f lorem2 &&
-	git reset master2 --hard &&
+	setup_temporary_branch lorem2 &&
 	sed -n -e "3,\$p" msg >file &&
 	head -n 9 msg >>file &&
 	git add file &&
@@ -349,11 +335,9 @@ test_expect_success 'am -3 -q is quiet' '
 '
 
 test_expect_success 'am pauses on conflict' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout lorem2^^ &&
+	setup_temporary_branch lorem2^^ &&
 	test_must_fail git am lorem-move.patch &&
-	test -d .git/rebase-apply
+	test_path_is_dir .git/rebase-apply
 '
 
 test_expect_success 'am --skip works' '
@@ -371,12 +355,10 @@ test_expect_success 'am --abort removes a stray directory' '
 '
 
 test_expect_success 'am --resolved works' '
+	setup_temporary_branch lorem2^^ &&
 	echo goodbye >expected &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout lorem2^^ &&
 	test_must_fail git am lorem-move.patch &&
-	test -d .git/rebase-apply &&
+	test_path_is_dir .git/rebase-apply &&
 	echo resolved >>file &&
 	git add file &&
 	git am --resolved &&
@@ -385,25 +367,21 @@ test_expect_success 'am --resolved works' '
 '
 
 test_expect_success 'am takes patches from a Pine mailbox' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	cat pine patch1 | git am &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code master^..HEAD
 '
 
 test_expect_success 'am fails on mail without patch' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
+	setup_temporary_branch first &&
 	test_must_fail git am <failmail &&
 	git am --abort &&
 	test_path_is_missing .git/rebase-apply
 '
 
 test_expect_success 'am fails on empty patch' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
+	setup_temporary_branch first &&
 	echo "---" >>failmail &&
 	test_must_fail git am <failmail &&
 	git am --skip &&
@@ -411,10 +389,8 @@ test_expect_success 'am fails on empty patch' '
 '
 
 test_expect_success 'am works from stdin in subdirectory' '
+	setup_temporary_branch first &&
 	rm -fr subdir &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
 	(
 		mkdir -p subdir &&
 		cd subdir &&
@@ -424,10 +400,8 @@ test_expect_success 'am works from stdin in subdirectory' '
 '
 
 test_expect_success 'am works from file (relative path given) in subdirectory' '
+	setup_temporary_branch first &&
 	rm -fr subdir &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
 	(
 		mkdir -p subdir &&
 		cd subdir &&
@@ -437,10 +411,8 @@ test_expect_success 'am works from file (relative path given) in subdirectory' '
 '
 
 test_expect_success 'am works from file (absolute path given) in subdirectory' '
+	setup_temporary_branch first &&
 	rm -fr subdir &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
 	P=$(pwd) &&
 	(
 		mkdir -p subdir &&
@@ -451,9 +423,7 @@ test_expect_success 'am works from file (absolute path given) in subdirectory' '
 '
 
 test_expect_success 'am --committer-date-is-author-date' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	test_tick &&
 	git am --committer-date-is-author-date patch1 &&
 	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
@@ -463,9 +433,7 @@ test_expect_success 'am --committer-date-is-author-date' '
 '
 
 test_expect_success 'am without --committer-date-is-author-date' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	test_tick &&
 	git am patch1 &&
 	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
@@ -479,9 +447,7 @@ test_expect_success 'am without --committer-date-is-author-date' '
 # by test_tick that uses -0700 timezone; if this feature does not
 # work, we will see that instead of +0000.
 test_expect_success 'am --ignore-date' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	test_tick &&
 	git am --ignore-date patch1 &&
 	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
@@ -490,9 +456,8 @@ test_expect_success 'am --ignore-date' '
 '
 
 test_expect_success 'am into an unborn branch' '
+	setup_temporary_branch first &&
 	git rev-parse first^{tree} >expected &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
 	rm -fr subdir &&
 	mkdir subdir &&
 	git format-patch --numbered-files -o subdir -1 first &&
@@ -509,9 +474,7 @@ test_expect_success 'am into an unborn branch' '
 '
 
 test_expect_success 'am newline in subject' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	test_tick &&
 	sed -e "s/second/second \\\n foo/" patch1 >patchnl &&
 	git am <patchnl >output.out 2>&1 &&
@@ -519,17 +482,14 @@ test_expect_success 'am newline in subject' '
 '
 
 test_expect_success 'am -q is quiet' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout first &&
+	setup_temporary_branch first &&
 	test_tick &&
 	git am -q <patch1 >output.out 2>&1 &&
 	! test -s output.out
 '
 
 test_expect_success 'am empty-file does not infloop' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
+	setup_temporary_branch first &&
 	touch empty-file &&
 	test_tick &&
 	test_must_fail git am empty-file 2>actual &&
@@ -538,9 +498,7 @@ test_expect_success 'am empty-file does not infloop' '
 '
 
 test_expect_success 'am --message-id really adds the message id' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout HEAD^ &&
+	setup_temporary_branch first &&
 	git am --message-id patch1.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD | tail -n1 >actual &&
@@ -549,9 +507,7 @@ test_expect_success 'am --message-id really adds the message id' '
 '
 
 test_expect_success 'am --message-id -s signs off after the message id' '
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout HEAD^ &&
+	setup_temporary_branch first &&
 	git am -s --message-id patch1.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD | tail -n2 | head -n1 >actual &&
-- 
1.9.1
