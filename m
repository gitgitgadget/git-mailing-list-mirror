From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] rebase -i: fix misleading error message after 'exec no-such'
 instruction
Date: Tue, 18 Sep 2012 13:15:26 +0200
Message-ID: <505857CE.3050909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:15:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDvmG-0007Cj-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 13:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953Ab2IRLPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 07:15:31 -0400
Received: from lilzmailso03.liwest.at ([212.33.55.24]:32964 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757156Ab2IRLPb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 07:15:31 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TDvm2-00052i-O9; Tue, 18 Sep 2012 13:15:27 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7A3671660F;
	Tue, 18 Sep 2012 13:15:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205818>

From: Johannes Sixt <j6t@kdbg.org>

When the todo sheet of interactive rebase instructs to run a non-existing
command, the operation stops with the following error:

  Execution failed: no-such
  You can fix the problem, and then run

          git rebase --continue

  fatal: 'rebase' appears to be a git command, but we were not
  able to execute it. Maybe git-rebase is broken?

The reason is that the shell that attempted to run the command exits with
code 127. rebase--interactive just forwards this code to the caller (the
git wrapper). But our smart run-command infrastructure detects this
special exit code and turns it into ENOENT, which in turn is interpreted
by the git wrapper as if the external command that it just executed did
not exist. This is finally translated to the misleading last two lines in
error message cited above.

Fix it by translating the error code before it is forwarded.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 An alternative fix would be to just ignore the shell's status code.
 I decided that it is worth keeping it: better safe than sorry.

 BTW, the problem existed since day 1 of the 'exec' feature.

 git-rebase--interactive.sh    |  4 ++++
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a09e842..56707d7 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -544,6 +544,10 @@ do_next () {
 			warn
 			warn "	git rebase --continue"
 			warn
+			if test $status -eq 127		# command not found
+			then
+				status=1
+			fi
 			exit "$status"
 		elif test "$dirty" = t
 		then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7304b66..7a71760 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -118,6 +118,17 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 	git rebase --continue
 '
 
+test_expect_success 'rebase -i with exec of inexistent command' '
+	git checkout master &&
+	test_when_finished "git rebase --abort" &&
+	(
+	FAKE_LINES="exec_this-command-does-not-exist 1" &&
+	export FAKE_LINES &&
+	test_must_fail git rebase -i HEAD^ >actual 2>&1
+	) &&
+	! grep "Maybe git-rebase is broken" actual
+'
+
 test_expect_success 'no changes are a nop' '
 	git checkout branch2 &&
 	git rebase -i F &&
-- 
1.7.12.1720.gb55457a.dirty
