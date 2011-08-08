From: Johannes Sixt <j6t@kdbg.org>
Subject: rebase -i: Should --continue auto-amend after failed exec?
Date: Mon, 08 Aug 2011 23:11:55 +0200
Message-ID: <4E40511B.7090206@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 08 23:12:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqX7G-0002pE-57
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 23:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab1HHVMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 17:12:00 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:56351 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751544Ab1HHVL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 17:11:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 929DF1000F;
	Mon,  8 Aug 2011 23:11:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D093919F43E;
	Mon,  8 Aug 2011 23:11:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178987>

If after a failed "exec" instruction there are staged changes, then currently rebase
--continue fails with:

.../git-rebase--interactive: line 774: .../.git/rebase-merge/author-script: No such file or directory

But shouldn't this amend the HEAD commit? The documentation is not clear
(from git-rebase.txt):

  The interactive rebase will stop when a command fails (i.e. exits with
  non-0 status) to give you an opportunity to fix the problem. You can
  continue with `git rebase --continue`.

This may be interpreted to work like "edit", and IMO would be a very useful
modus operandi.

Here is a test case.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 47c8371..2146e47 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -527,6 +527,21 @@ test_expect_success 'auto-amend only edited commits after "edit"' '
 	git rebase --abort
 '
 
+test_expect_failure 'auto-amend after failed "exec"' '
+	test_tick &&
+	test_when_finished "git rebase --abort || :" &&
+	(
+		FAKE_LINES="1 exec_false" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i HEAD^
+	) &&
+	echo "edited again" > file7 &&
+	git add file7 &&
+	FAKE_COMMIT_MESSAGE="edited file7 again" git rebase --continue &&
+	actual=$(git show HEAD:file7) &&
+	test "edited again" = "$actual"
+'
+
 test_expect_success 'rebase a detached HEAD' '
 	grandparent=$(git rev-parse HEAD~2) &&
 	git checkout $(git rev-parse HEAD) &&
