From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 5/8] rebase: turn rebase--interactive into a separate program
Date: Wed, 18 Mar 2015 16:55:44 +0700
Message-ID: <1426672547-11369-6-git-send-email-pclouds@gmail.com>
References: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 10:56:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAiR-0002pH-IT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933204AbbCRJ4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:56:39 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32788 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933188AbbCRJ4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:56:34 -0400
Received: by pabxg6 with SMTP id xg6so25106539pab.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sxu3LRhkB8QTiV8NrHGWRIvq5fBWWl6cvr0YXfallwA=;
        b=jTWZjbqsvshSi4TwhCZ8TutYD4IQ4F0Sh8jg7dUUC8Yvax8IVlW9xDS2vqjYSkpIut
         e78EnGk2ab/6yQNeCfdCIcF5oMCYiNym3Sfh+MNA12TiKnWwXeiyHubg+5qBsU5EgPEW
         jz8WhUHKH38AUmJZcmdN1wZJDq50FkqofBdeO1geTIPaXx3px0icU6dhZhDs0Ieg5+lX
         7NvAtDwDMv70eJwAXI8p9wocvPkjscbatY4t7POE/f/ul951lMNe3hFU+oY4BsAFZV0h
         2Aztnica7n2dufuqEgEvarAqFa2CwoTFd8JR8IVDgFp75T0+wBOzeoxpYNhHVX9WVqqB
         S/RQ==
X-Received: by 10.66.101.73 with SMTP id fe9mr162286541pab.156.1426672593519;
        Wed, 18 Mar 2015 02:56:33 -0700 (PDT)
Received: from lanh ([115.73.252.85])
        by mx.google.com with ESMTPSA id fm3sm8396596pdb.73.2015.03.18.02.56.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 02:56:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Mar 2015 16:56:29 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265707>

---
 Makefile                             |  2 +-
 git-rebase--interactive.sh (mode +x) | 36 +++++++++++++++++++++++++++++++++++-
 git-rebase.sh                        |  9 ++-------
 3 files changed, 38 insertions(+), 9 deletions(-)
 mode change 100644 => 100755 git-rebase--interactive.sh

diff --git a/Makefile b/Makefile
index 7ee8df7..83972a2 100644
--- a/Makefile
+++ b/Makefile
@@ -446,6 +446,7 @@ SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-rebase--am.sh
+SCRIPT_SH += git-rebase--interactive.sh
 SCRIPT_SH += git-rebase--merge.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
@@ -455,7 +456,6 @@ SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
-SCRIPT_LIB += git-rebase--interactive
 SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
old mode 100644
new mode 100755
index 44901d5..b1c71a9
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -9,7 +9,14 @@
 #
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
-#
+
+. git-sh-setup
+. git-sh-i18n
+set_reflog_action "rebase -i ($action)"
+require_work_tree_exists
+
+GIT_QUIET=$git_quiet
+
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
 # the lines are processed, they are removed from the front of this
@@ -80,6 +87,33 @@ rewritten_pending="$state_dir"/rewritten-pending
 GIT_CHERRY_PICK_HELP="$resolvemsg"
 export GIT_CHERRY_PICK_HELP
 
+write_basic_state () {
+	echo "$head_name" > "$state_dir"/head-name &&
+	echo "$onto" > "$state_dir"/onto &&
+	echo "$orig_head" > "$state_dir"/orig-head &&
+	echo "$GIT_QUIET" > "$state_dir"/quiet &&
+	test t = "$verbose" && : > "$state_dir"/verbose
+	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
+	test -n "$strategy_opts" && echo "$strategy_opts" > \
+		"$state_dir"/strategy_opts
+	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
+		"$state_dir"/allow_rerere_autoupdate
+}
+
+output () {
+	case "$verbose" in
+	'')
+		output=$("$@" 2>&1 )
+		status=$?
+		test $status != 0 && printf "%s\n" "$output"
+		return $status
+		;;
+	*)
+		"$@"
+		;;
+	esac
+}
+
 warn () {
 	printf '%s\n' "$*" >&2
 }
diff --git a/git-rebase.sh b/git-rebase.sh
index ff2c2ae..86119e7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -154,13 +154,8 @@ run_specific_rebase () {
 	export action allow_rerere_autoupdate git_am_opt git_quiet head_name keep_empty
 	export onto orig_head rebase_root resolvemsg revisions
 	export state_dir verbose strategy strategy_opts
-	if [ "$type" = am ]; then
-		exec git-rebase--am
-	elif [ "$type" = merge ]; then
-		exec git-rebase--merge
-	else
-		. git-rebase--$type
-	fi
+	export autosquash cmd force_rebase preserve_merges squash_onto switch_to upstream
+	exec git-rebase--$type
 }
 
 run_pre_rebase_hook () {
-- 
2.3.0.rc1.137.g477eb31
