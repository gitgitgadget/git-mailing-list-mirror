From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 3/8] rebase: turn rebase--am into a separate program
Date: Wed, 18 Mar 2015 16:55:42 +0700
Message-ID: <1426672547-11369-4-git-send-email-pclouds@gmail.com>
References: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 10:56:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAiJ-0002kC-0m
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933186AbbCRJ40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:56:26 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33577 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814AbbCRJ4X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:56:23 -0400
Received: by pabxg6 with SMTP id xg6so25102281pab.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tt9nF3KZW3LAvzd0zHWQ87MkfSWIqIbhPWuW+3eid/I=;
        b=aG4Vme5XJHdKvsHk4usbz7CkPbVU6phOzu1TDpOFT0PgMOUERjOUeIREOBd9UAOq7k
         QPcudtz42d7GhVewqV6dk4/6YD1uMB2ChVAKWyFH2yptUzMvm+4j+/cSxLPtlXubhvQ7
         C/zyjRNG/9oSUHLQ1Y7DuTseKGzGaONszsYeFRk7lSPp9++mxhFDfFT25w4cHxXI91Og
         jpOnE1AUGzGQV8Yd8gaulO450UbYXMxaHJohYZzCnxKaqe5alUdqsDwJPK+d+B0BQR4Z
         jsIS/mhwr6jqN0kGl4q3gDOOA1hzy9Q1YIxG09PHGSZq0u0rWL+yjc1txZy4hxXkUDS1
         BD/A==
X-Received: by 10.66.216.136 with SMTP id oq8mr107897328pac.20.1426672582475;
        Wed, 18 Mar 2015 02:56:22 -0700 (PDT)
Received: from lanh ([115.73.252.85])
        by mx.google.com with ESMTPSA id z4sm26612351pdi.90.2015.03.18.02.56.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 02:56:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Mar 2015 16:56:18 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265706>

---
 Makefile                    |  2 +-
 git-rebase--am.sh (mode +x) | 34 ++++++++++++++++++++++++++++++++++
 git-rebase.sh               | 11 ++++++++++-
 3 files changed, 45 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 git-rebase--am.sh

diff --git a/Makefile b/Makefile
index 1b30d7b..93151f4 100644
--- a/Makefile
+++ b/Makefile
@@ -445,6 +445,7 @@ SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
+SCRIPT_SH += git-rebase--am.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
@@ -453,7 +454,6 @@ SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
-SCRIPT_LIB += git-rebase--am
 SCRIPT_LIB += git-rebase--interactive
 SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
old mode 100644
new mode 100755
index 97f31dc..ab84330
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -3,6 +3,40 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
+. git-sh-setup
+. git-sh-i18n
+set_reflog_action rebase
+require_work_tree_exists
+
+GIT_QUIET=$git_quiet
+
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
+move_to_original_branch () {
+	case "$head_name" in
+	refs/*)
+		message="rebase finished: $head_name onto $onto"
+		git update-ref -m "$message" \
+			$head_name $(git rev-parse HEAD) $orig_head &&
+		git symbolic-ref \
+			-m "rebase finished: returning to $head_name" \
+			HEAD $head_name ||
+		die "$(gettext "Could not move back to $head_name")"
+		;;
+	esac
+}
+
 case "$action" in
 continue)
 	git am --resolved --resolvemsg="$resolvemsg" &&
diff --git a/git-rebase.sh b/git-rebase.sh
index b2f1c76..42e868d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -149,7 +149,16 @@ run_specific_rebase () {
 		export GIT_EDITOR
 		autosquash=
 	fi
-	. git-rebase--$type
+	git_quiet=$GIT_QUIET
+	export GIT_PAGER
+	export action allow_rerere_autoupdate git_am_opt git_quiet head_name keep_empty
+	export onto orig_head rebase_root resolvemsg revisions
+	export state_dir verbose strategy strategy_opts
+	if [ "$type" = am ]; then
+		exec git-rebase--am
+	else
+		. git-rebase--$type
+	fi
 }
 
 run_pre_rebase_hook () {
-- 
2.3.0.rc1.137.g477eb31
