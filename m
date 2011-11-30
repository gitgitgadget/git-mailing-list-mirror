From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] rebase -i: interrupt rebase when "commit --amend" failed during "reword"
Date: Wed, 30 Nov 2011 10:52:51 -0500
Message-ID: <1322668371-21218-2-git-send-email-andrew.kw.w@gmail.com>
References: <7vk46isncq.fsf@alter.siamese.dyndns.org>
 <1322668371-21218-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 16:53:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVmTj-0003cG-UK
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 16:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab1K3Pxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 10:53:44 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45953 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291Ab1K3Pxn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 10:53:43 -0500
Received: by vbbfc26 with SMTP id fc26so467463vbb.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ke79QKhOGi2m/4RmysTZw5OBDZvYElQcM6z3DzdQwJ4=;
        b=STdE93NL98/6vnav5du0w2lsr7/iHDlliwEd7nbMc5RtbN+kwupOurbcmai8bT7OpD
         9sixeO9kf6E96SxAKm+clIuD6YJxggvUFde3atNJz+J6yn+vCSWIR6VGOnVejlmHpWvX
         IOKr5HNmv/TaoU1DJgPfWeLC18ZFRPwhsbrfw=
Received: by 10.52.35.147 with SMTP id h19mr2553906vdj.38.1322668422568;
        Wed, 30 Nov 2011 07:53:42 -0800 (PST)
Received: from nigel.sohovfx-toronto.com ([66.207.196.114])
        by mx.google.com with ESMTPS id em3sm2956136vdc.10.2011.11.30.07.53.41
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 07:53:41 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc3.32.gb0399.dirty
In-Reply-To: <1322668371-21218-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186128>

"commit --amend" could fail in cases like the user empties the commit
message, or pre-commit failed.  When it fails, rebase should be
interrupted and alert the user, rather than ignoring the error and
continue on rebasing.  This also gives users a way to gracefully
interrupt a "reword" if they decided they actually want to do an "edit",
or even "rebase --abort".

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--interactive.sh |   36 +++++++++++++++++++++++-------------
 1 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 804001b..5812222 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -143,6 +143,21 @@ die_with_patch () {
 	die "$2"
 }
 
+exit_with_patch () {
+	echo "$1" > "$state_dir"/stopped-sha
+	make_patch $1
+	git rev-parse --verify HEAD > "$amend"
+	warn "You can amend the commit now, with"
+	warn
+	warn "	git commit --amend"
+	warn
+	warn "Once you are satisfied with your changes, run"
+	warn
+	warn "	git rebase --continue"
+	warn
+	exit $2
+}
+
 die_abort () {
 	rm -rf "$state_dir"
 	die "$1"
@@ -408,7 +423,13 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		git commit --amend --no-post-rewrite
+		git commit --amend --no-post-rewrite || {
+			warn "Could not amend commit after successfully picking $sha1... $rest"
+			warn "This is most likely due to an empty commit message, or the pre-commit hook"
+			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
+			warn "you are able to reword the commit."
+			exit_with_patch $sha1 1
+		}
 		record_in_rewritten $sha1
 		;;
 	edit|e)
@@ -417,19 +438,8 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		echo "$sha1" > "$state_dir"/stopped-sha
-		make_patch $sha1
-		git rev-parse --verify HEAD > "$amend"
 		warn "Stopped at $sha1... $rest"
-		warn "You can amend the commit now, with"
-		warn
-		warn "	git commit --amend"
-		warn
-		warn "Once you are satisfied with your changes, run"
-		warn
-		warn "	git rebase --continue"
-		warn
-		exit 0
+		exit_with_patch $sha1 0
 		;;
 	squash|s|fixup|f)
 		case "$command" in
-- 
1.7.8.rc3.32.gb0399.dirty
