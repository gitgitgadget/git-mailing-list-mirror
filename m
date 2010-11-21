From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] rebase --abort: do not update branch ref
Date: Sun, 21 Nov 2010 12:11:21 +0100
Message-ID: <1290337881-26449-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 21 18:12:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKDSl-00051y-79
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 18:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab0KURMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 12:12:21 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62888 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab0KURMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 12:12:21 -0500
Received: by qyk1 with SMTP id 1so1299348qyk.19
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=tZ5kN0pTIdP+MCvEifT+oaBcRWU72JSQKk9YraME6wE=;
        b=qo6AMf7+EWeVlPujeywjTOOBzmCCyfXgFcChUi33Oqn4zekMUucOpvTMfmA8WyxdLl
         FRG1xOt17kgWKxifk3j7tM2j+xXitO7AYw7+Apf6ye5/6CWJzqhzU1zRe2ISl5X27XGm
         2T9S1C2zh7um+iHP8CZbVeatn0Xhyf92+o6ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=L3VPioAP0GcA2+QNWeRnVndo98Nqz5Fr2V+cWjbV0jgIkBI0lx+d/iHYVzJvF1EvV3
         mLlDOSEyQIKsnBbhm+5sAIBwaD2wR5/+1tXpRE7LPUOAZD1M2iyrfUAgSu7NsfiXVmt0
         Z6uj3llB5fVjc/CQ4mgxQD4iI+Or+24W66OMg=
Received: by 10.229.228.76 with SMTP id jd12mr4072559qcb.291.1290359540012;
        Sun, 21 Nov 2010 09:12:20 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id mz11sm2306739qcb.27.2010.11.21.09.12.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Nov 2010 09:12:19 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.190.gfb4ae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161867>

If a non-interactive rebase of a ref fails at commit X and is aborted by
the user, the ref will be updated twice. First to point at X (with the
reflog message "rebase finished: $head_name onto $onto"), and then back
to $orig_head. It should not be updated at all.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
This patch unfortunately duplicates some code from
move_to_original_branch, but since I'm refactoring the rebase code quite
a bit, I don't want to change too much in this patch. I will see what I
can do to reduce the duplication after some of the refactoring.

 git-rebase.sh           |    9 +++++++--
 t/t3407-rebase-abort.sh |   11 +++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index ec08f9c..3d194b1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -278,12 +278,17 @@ do
 		if test -d "$dotest"
 		then
 			GIT_QUIET=$(cat "$dotest/quiet")
-			move_to_original_branch
 		else
 			dotest="$GIT_DIR"/rebase-apply
 			GIT_QUIET=$(cat "$dotest/quiet")
-			move_to_original_branch
 		fi
+		head_name="$(cat "$dotest"/head-name)" &&
+		case "$head_name" in
+		refs/*)
+			git symbolic-ref HEAD $head_name ||
+			die "Could not move back to $head_name"
+			;;
+		esac
 		git reset --hard $(cat "$dotest/orig-head")
 		rm -r "$dotest"
 		exit
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index fbb3f2e..f3250c3 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -72,6 +72,17 @@ testrebase() {
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
 		test ! -d "$dotest"
 	'
+
+	test_expect_success "rebase$type --abort does not update reflog" '
+		cd "$work_dir" &&
+		# Clean up the state from the previous one
+		git reset --hard pre-rebase &&
+		reflog_entries_before=$(git reflog show to-rebase | wc -l) &&
+		test_must_fail git rebase$type master &&
+		git rebase --abort &&
+		reflog_entries_after=$(git reflog show to-rebase | wc -l) &&
+		test $reflog_entries_before -eq $reflog_entries_after
+	'
 }
 
 testrebase "" .git/rebase-apply
-- 
1.7.3.2.190.gfb4ae
