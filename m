From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] rebase -i: fix post-rewrite hook with failed exec command
Date: Thu, 21 May 2015 20:13:02 +0200
Message-ID: <1432231982-31314-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1432231982-31314-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 21 20:13:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUyP-0004Uh-RV
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746AbbEUSNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:13:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39406 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755170AbbEUSNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:13:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4LIDNd6023783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 May 2015 20:13:24 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4LIDPEJ011293;
	Thu, 21 May 2015 20:13:25 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YvUyD-0008Fn-Qb; Thu, 21 May 2015 20:13:25 +0200
X-Mailer: git-send-email 2.4.1.171.g060e6ae.dirty
In-Reply-To: <1432231982-31314-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 21 May 2015 20:13:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4LIDNd6023783
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1432836807.04688@sXeJO1yYVCi9pFwnG7Rj/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269635>

Usually, when 'git rebase' stops before completing the rebase, it is to
give the user an opportunity to edit a commit (e.g. with the 'edit'
command). In such cases, 'git rebase' leaves the sha1 of the commit being
rewritten in "$state_dir"/stopped-sha, and subsequent 'git rebase
--continue' will call the post-rewrite hook with this sha1 as <old-sha1>
argument to the post-rewrite hook.

The case of 'git rebase' stopping because of a failed 'exec' command is
different: it gives the opportunity to the user to examine or fix the
failure, but does not stop saying "here's a commit to edit, use
--continue when you're done". So, there's no reason to call the
post-rewrite hook for 'exec' commands. If the user did rewrite the
commit, it would be with 'git commit --amend' which already called the
post-rewrite hook.

Fix the behavior to leave no stopped-sha file in case of failed exec
command, and teach 'git rebase --continue' to skip record_in_rewritten if
no stopped-sha file is found.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I'm afraid I'm the one to blame for the bug :-(.

 git-rebase--interactive.sh   | 10 +++++-----
 t/t5407-post-rewrite-hook.sh |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 08e5d86..1c321e4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -486,7 +486,7 @@ do_pick () {
 }
 
 do_next () {
-	rm -f "$msg" "$author_script" "$amend" || exit
+	rm -f "$msg" "$author_script" "$amend" "$state_dir"/stopped-sha || exit
 	read -r command sha1 rest < "$todo"
 	case "$command" in
 	"$comment_char"*|''|noop)
@@ -576,9 +576,6 @@ do_next () {
 		read -r command rest < "$todo"
 		mark_action_done
 		printf 'Executing: %s\n' "$rest"
-		# "exec" command doesn't take a sha1 in the todo-list.
-		# => can't just use $sha1 here.
-		git rev-parse --verify HEAD > "$state_dir"/stopped-sha
 		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
 		status=$?
 		# Run in subshell because require_clean_work_tree can die.
@@ -874,7 +871,10 @@ first and then run 'git rebase --continue' again."
 		fi
 	fi
 
-	record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
+	if test -r "$state_dir"/stopped-sha
+	then
+		record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
+	fi
 
 	require_clean_work_tree "rebase"
 	do_rest
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index ecef820..24ba796 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -212,7 +212,7 @@ EOF
 	verify_hook_input
 '
 
-test_expect_failure 'git rebase -i (exec)' '
+test_expect_success 'git rebase -i (exec)' '
 	git reset --hard D &&
 	clear_hook_input &&
 	FAKE_LINES="edit 1 exec_false 2" git rebase -i B
-- 
2.4.1.171.g060e6ae.dirty
