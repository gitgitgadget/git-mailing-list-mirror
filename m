From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] rebase -i: fix post-rewrite hook with failed exec
 command
Date: Fri, 22 May 2015 13:15:49 +0000
Message-ID: <0000014d7bc3f6bf-72bd5f07-9e26-411a-8484-e9b86a1bf429-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6_1487761309.1432300549779"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 15:24:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvmvs-0003HM-Cx
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 15:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826AbbEVNYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 09:24:07 -0400
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:53024
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756587AbbEVNYF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 09:24:05 -0400
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2015 09:24:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1432300549;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Date:Feedback-ID;
	bh=I0kkDZkdLfJRD6VSbAqJw984+swdGDMo0klSAp4nW4c=;
	b=XSH1VY4l7hCyPvJSdqtyhsa87E45R9xbivL41MoKJt3enpPNaaTVlstqj8LI63Wb
	G4BB7TfjMhvIXOtJA/Beb8BLnhAl5Efxbpm5YnvPwrZgD/3h57rYZkPf5Q1GU3XbjuA
	gaLELLGaXjh6q6WdoT2f+B/YoPs6yHu2MpG9iwlA=
X-SES-Outgoing: 2015.05.22-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269711>

------=_Part_6_1487761309.1432300549779
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

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
---
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
index 53a4062..06ffad6 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -212,7 +212,7 @@ EOF
 	verify_hook_input
 '
 
-test_expect_failure 'git rebase -i (exec)' '
+test_expect_success 'git rebase -i (exec)' '
 	git reset --hard D &&
 	clear_hook_input &&
 	FAKE_LINES="edit 1 exec_false 2" git rebase -i B &&

---
https://github.com/git/git/pull/138
------=_Part_6_1487761309.1432300549779--
