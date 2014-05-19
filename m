From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] rebase -i: handle "Nothing to do" case with autostash
Date: Mon, 19 May 2014 18:05:20 -0400
Message-ID: <1400537120-9995-1-git-send-email-artagnon@gmail.com>
Cc: Karen Etheridge <ether@cpan.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 20 00:03:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmVeU-0005OF-KC
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 00:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbaESWDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 18:03:19 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:61955 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbaESWDS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 18:03:18 -0400
Received: by mail-qg0-f43.google.com with SMTP id 63so9831129qgz.16
        for <git@vger.kernel.org>; Mon, 19 May 2014 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CLYiQzwatmnBN2cdtzApVty3dl7Jesbl05do1f/3h1k=;
        b=hQo48app+N+bm2c/zRHDya4fNQxYrKYeGRH/hAfHGBI8BZHXtRfal3z9Xgx/OQ8YIf
         8NYq1IUUeQZDLu8BlqO7PyrPb2XADQwFWU/+QH1W6bQ9sjSusnYm3p0QNOzHgcwT88Sb
         CdtbZto+rypzGaQfjpZtLYAw08UG6KKP+wd2NgVhnGKHvIgbBXfXuUowZvCP0LQmZBIf
         INAi70wuPWXagjrh+zbSw6OB3nbw4F1ZWrJWXPd4xW7fwkkz+KJ+sBxC1mgLzDHHeJcv
         IyBWyu35IzsAJpK8nP5tk0UngEiGLIeua4uhXjx87rYdq7brb8uDubX/Ys1zo2n42VAe
         /cGQ==
X-Received: by 10.224.115.135 with SMTP id i7mr51068389qaq.50.1400536997555;
        Mon, 19 May 2014 15:03:17 -0700 (PDT)
Received: from localhost.localdomain (dyn-160-39-37-27.dyn.columbia.edu. [160.39.37.27])
        by mx.google.com with ESMTPSA id y79sm11599585qgy.18.2014.05.19.15.03.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 May 2014 15:03:16 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc2.20.gfc2568d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249628>

When a user invokes

  $ git rebase -i @~3

with dirty files and rebase.autostash turned on, and exits the $EDITOR
with an empty buffer, the autostash fails to apply. Although the primary
focus of rr/rebase-autostash was to get the git-rebase--backend.sh
scripts to return control to git-rebase.sh, it missed this case in
git-rebase--interactive.sh. Since this case is unlike the other cases
which return control for housekeeping, assign it a special return status
and handle that return value explicitly in git-rebase.sh.

Reported-by: Karen Etheridge <ether@cpan.org>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Thanks to Karen for reporting this.

 I chose 2 arbitrarily. Let me know if you have a rationale for other
 return values.

 git-rebase--interactive.sh |  4 ++--
 git-rebase.sh              | 11 ++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6ec9d3c..f267d8b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1049,14 +1049,14 @@ fi
 
 
 has_action "$todo" ||
-	die_abort "Nothing to do"
+	return 2
 
 cp "$todo" "$todo".backup
 git_sequence_editor "$todo" ||
 	die_abort "Could not execute editor"
 
 has_action "$todo" ||
-	die_abort "Nothing to do"
+	return 2
 
 expand_todo_ids
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 4543815..47ca3b9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -155,7 +155,7 @@ move_to_original_branch () {
 	esac
 }
 
-finish_rebase () {
+apply_autostash () {
 	if test -f "$state_dir/autostash"
 	then
 		stash_sha1=$(cat "$state_dir/autostash")
@@ -171,6 +171,10 @@ You can run "git stash pop" or "git stash drop" at any time.
 '
 		fi
 	fi
+}
+
+finish_rebase () {
+	apply_autostash &&
 	git gc --auto &&
 	rm -rf "$state_dir"
 }
@@ -186,6 +190,11 @@ run_specific_rebase () {
 	if test $ret -eq 0
 	then
 		finish_rebase
+	elif test $ret -eq 2 # special exit status for rebase -i
+	then
+		apply_autostash &&
+		rm -rf "$state_dir" &&
+		die "Nothing to do"
 	fi
 	exit $ret
 }
-- 
2.0.0.rc2.20.gfc2568d.dirty
