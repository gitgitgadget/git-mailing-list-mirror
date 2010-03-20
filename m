From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] Use test_expect_success for test setups
Date: Sat, 20 Mar 2010 04:29:11 -0400
Message-ID: <1269073751-64588-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 20 09:37:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsuBL-0003R5-QA
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 09:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab0CTIhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 04:37:11 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56226 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab0CTIhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 04:37:09 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Mar 2010 04:37:09 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 6A8F91FFC2ED; Sat, 20 Mar 2010 08:29:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	by silverinsanity.com (Postfix) with ESMTPA id 4C1F21FFC2EA;
	Sat, 20 Mar 2010 08:29:01 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.2.455.g91132
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142695>

Several tests did not use test_expect_success for their setup
commands.  Putting these start commands into the testing framework
means both that errors during setup will be caught quickly and that
non-error text will be suppressed without -v.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Noticed some extra output when updating my server's copy of git from
 source.

 Tested on OS X using bash and dash.

 t/t3020-ls-files-error-unmatch.sh        |    8 ++-
 t/t3800-mktag.sh                         |   10 +++--
 t/t4103-apply-binary.sh                  |   40 +++++++++++--------
 t/t4200-rerere.sh                        |   64 +++++++++++++++--------------
 t/t9501-gitweb-standalone-http-status.sh |    7 ++-
 5 files changed, 71 insertions(+), 58 deletions(-)

diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index f4066cb..a7d8187 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -11,9 +11,11 @@ line.
 '
 . ./test-lib.sh
 
-touch foo bar
-git update-index --add foo bar
-git commit -m "add foo bar"
+test_expect_success 'setup' '
+	touch foo bar &&
+	git update-index --add foo bar &&
+	git commit -m "add foo bar"
+'
 
 test_expect_success \
     'git ls-files --error-unmatch should fail with unmatched path.' \
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 6fb027b..8eb4794 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -22,10 +22,12 @@ check_verify_failure () {
 ###########################################################
 # first create a commit, so we have a valid object/type
 # for the tag.
-echo Hello >A
-git update-index --add A
-git commit -m "Initial commit"
-head=$(git rev-parse --verify HEAD)
+test_expect_success 'setup' '
+	echo Hello >A &&
+	git update-index --add A &&
+	git commit -m "Initial commit" &&
+	head=$(git rev-parse --verify HEAD)
+'
 
 ############################################################
 #  1. length check
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index ad4cc1a..c12a4bd 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -20,23 +20,29 @@ EOF
 cat file1 >file2
 cat file1 >file4
 
-git update-index --add --remove file1 file2 file4
-git commit -m 'Initial Version' 2>/dev/null
-
-git checkout -b binary
-perl -pe 'y/x/\000/' <file1 >file3
-cat file3 >file4
-git add file2
-perl -pe 'y/\000/v/' <file3 >file1
-rm -f file2
-git update-index --add --remove file1 file2 file3 file4
-git commit -m 'Second Version'
-
-git diff-tree -p master binary >B.diff
-git diff-tree -p -C master binary >C.diff
-
-git diff-tree -p --binary master binary >BF.diff
-git diff-tree -p --binary -C master binary >CF.diff
+test_expect_success 'setup' "
+	git update-index --add --remove file1 file2 file4 &&
+	git commit -m 'Initial Version' 2>/dev/null &&
+
+	git checkout -b binary &&
+	perl -pe 'y/x/\000/' <file1 >file3 &&
+	cat file3 >file4 &&
+	git add file2 &&
+	perl -pe 'y/\000/v/' <file3 >file1 &&
+	rm -f file2 &&
+	git update-index --add --remove file1 file2 file3 file4 &&
+	git commit -m 'Second Version'
+"
+
+test_expect_success 'non-binary diffs' '
+	git diff-tree -p master binary >B.diff &&
+	git diff-tree -p -C master binary >C.diff
+'
+
+test_expect_success 'binary diffs' '
+	git diff-tree -p --binary master binary >BF.diff &&
+	git diff-tree -p --binary -C master binary >CF.diff
+'
 
 test_expect_success 'stat binary diff -- should not fail.' \
 	'git checkout master
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index bb402c3..70856d0 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -8,40 +8,42 @@ test_description='git rerere
 
 . ./test-lib.sh
 
-cat > a1 << EOF
-Some title
-==========
-Whether 'tis nobler in the mind to suffer
-The slings and arrows of outrageous fortune,
-Or to take arms against a sea of troubles,
-And by opposing end them? To die: to sleep;
-No more; and by a sleep to say we end
-The heart-ache and the thousand natural shocks
-That flesh is heir to, 'tis a consummation
-Devoutly to be wish'd.
-EOF
-
-git add a1
-git commit -q -a -m initial
-
-git checkout -b first
-cat >> a1 << EOF
-Some title
-==========
-To die, to sleep;
-To sleep: perchance to dream: ay, there's the rub;
-For in that sleep of death what dreams may come
-When we have shuffled off this mortal coil,
-Must give us pause: there's the respect
-That makes calamity of so long life;
-EOF
-git commit -q -a -m first
-
-git checkout -b second master
-git show first:a1 |
-sed -e 's/To die, t/To die! T/' -e 's/Some title/Some Title/' > a1
-echo "* END *" >>a1
-git commit -q -a -m second
+test_expect_success 'setup' "
+	cat > a1 <<- EOF &&
+	Some title
+	==========
+	Whether 'tis nobler in the mind to suffer
+	The slings and arrows of outrageous fortune,
+	Or to take arms against a sea of troubles,
+	And by opposing end them? To die: to sleep;
+	No more; and by a sleep to say we end
+	The heart-ache and the thousand natural shocks
+	That flesh is heir to, 'tis a consummation
+	Devoutly to be wish'd.
+	EOF
+
+	git add a1 &&
+	git commit -q -a -m initial &&
+
+	git checkout -b first &&
+	cat >> a1 <<- EOF &&
+	Some title
+	==========
+	To die, to sleep;
+	To sleep: perchance to dream: ay, there's the rub;
+	For in that sleep of death what dreams may come
+	When we have shuffled off this mortal coil,
+	Must give us pause: there's the respect
+	That makes calamity of so long life;
+	EOF
+	git commit -q -a -m first &&
+
+	git checkout -b second master &&
+	git show first:a1 |
+	sed -e 's/To die, t/To die! T/' -e 's/Some title/Some Title/' > a1 &&
+	echo '* END *' >>a1 &&
+	git commit -q -a -m second
+"
 
 test_expect_success 'nothing recorded without rerere' '
 	(rm -rf .git/rr-cache; git config rerere.enabled false) &&
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index d196cc5..2487da1 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -15,9 +15,10 @@ code and message.'
 # ----------------------------------------------------------------------
 # snapshot settings
 
-test_commit \
-	'SnapshotTests' \
-	'i can has snapshot?'
+test_expect_success 'setup' "
+	test_commit 'SnapshotTests' 'i can has snapshot?'
+"
+
 
 cat >>gitweb_config.perl <<\EOF
 $feature{'snapshot'}{'override'} = 0;
-- 
1.7.0.2.455.g91132
