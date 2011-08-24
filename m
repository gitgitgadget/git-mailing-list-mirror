From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] rebase -i: clean error message for --continue after failed exec
Date: Wed, 24 Aug 2011 16:01:48 +0200
Message-ID: <1314194508-12067-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqk4a3rkwb.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 24 16:26:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwEPC-0001Eb-2S
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 16:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab1HXO0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 10:26:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53789 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab1HXO0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 10:26:03 -0400
X-Greylist: delayed 1443 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Aug 2011 10:26:03 EDT
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p7OE1Xsm032534
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Aug 2011 16:01:33 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1QwE1e-0007no-A2; Wed, 24 Aug 2011 16:01:50 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1QwE1e-00039O-7H; Wed, 24 Aug 2011 16:01:50 +0200
X-Mailer: git-send-email 1.7.6.580.gc2862.dirty
In-Reply-To: <vpqk4a3rkwb.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 24 Aug 2011 16:01:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7OE1Xsm032534
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1314799299.59118@RVnzNTRZ09Y15SSmwcCd2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180003>

If after a failed "exec" instruction there are staged changes, before
this patch, rebase --continue fails with this message, which is obviously
wrong:

.../git-rebase--interactive: line 774: .../.git/rebase-merge/author-script: No such file or directory

We could try auto-amending HEAD, but this goes against the logic of
.git/rebase-merge/author-script (see also the testcase 'auto-amend only
edited commits after "edit"' in t3404-rebase-interactive.sh) to
auto-amend something the user hasn't explicitely asked to edit.

Instead of doing anything automatically, detect the situation and give a
clean error message. While we're there, also clarify the error message in
case '. "$author_script"' fails, which now corresponds to really weird
senario where the author script exists but can't be read.

Test-case-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Here's my attempt at a patch. After noticing the existance of a test
'auto-amend only edited commits after "edit"', I'm convinced that
auto-amending is not the right thing here.

 git-rebase--interactive.sh    |   18 +++++++++++++++++-
 t/t3404-rebase-interactive.sh |   14 ++++++++++++++
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c6ba7c1..5c94506 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -647,8 +647,24 @@ continue)
 	then
 		: Nothing to commit -- skip this
 	else
+		if ! test -f "$author_script"
+		then
+			die "You have staged changes in your working tree. If these changes are meant to be
+squashed into the previous commit, run:
+
+  git commit --amend
+
+If they are meant to go into a new commit, run:
+
+  git commit
+
+In both case, once you're done, continue with:
+
+  git rebase --continue
+"
+		fi
 		. "$author_script" ||
-			die "Cannot find the author identity"
+			die "Error trying to find the author identity to amend commit"
 		current_head=
 		if test -f "$amend"
 		then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8538813..b981572 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -527,6 +527,20 @@ test_expect_success 'auto-amend only edited commits after "edit"' '
 	git rebase --abort
 '
 
+test_expect_success 'clean error after failed "exec"' '
+	test_tick &&
+	test_when_finished "git rebase --abort || :" &&
+	(
+		FAKE_LINES="1 exec_false" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i HEAD^
+	) &&
+	echo "edited again" > file7 &&
+	git add file7 &&
+	test_must_fail git rebase --continue 2>error &&
+	grep "You have staged changes in your working tree." error
+'
+
 test_expect_success 'rebase a detached HEAD' '
 	grandparent=$(git rev-parse HEAD~2) &&
 	git checkout $(git rev-parse HEAD) &&
-- 
1.7.6.580.gc2862.dirty
