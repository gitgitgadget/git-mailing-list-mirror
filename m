From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 4/8] rebase: turn rebase--merge into a separate program
Date: Wed, 18 Mar 2015 16:55:43 +0700
Message-ID: <1426672547-11369-5-git-send-email-pclouds@gmail.com>
References: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 10:56:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAiN-0002l8-9B
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195AbbCRJ4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:56:34 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33619 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933187AbbCRJ42 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:56:28 -0400
Received: by pdnc3 with SMTP id c3so38518032pdn.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 02:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OkkmPuReGlfUFcNQ/4voQJfF3+MuCKLfz4FqoK+R9/Y=;
        b=E9rJgYoMkuOUaTllTi6FpkmSKhg+2DorugeNlQnB0Lrp+qycLJOa798TeQLom+miCr
         eIanb27sg/YDVw4/ucDmbtmFpQRSSFGMqRWpc0uWE6BxxQGaVD/uzRF1mzunXNiOYOrA
         cljUuL4Q2bzgcfhB98Yy6yj2H6KvslZkgbPzw9QBPaJyK0r0LW8pHcFtbEa54b8EERoV
         WAX5DPgWFrkLdwkLt+F4zxQBLuSAYaS+ijAML21LqGYgi4swVE1oR7wCKdtfY8f7Tptz
         smGkoQsBXdOs3QFvAWpbiVbg36R2mWto7Q0D1TuK0B1zL+/oKFVKMU/h2mGYcUR89k8h
         d80g==
X-Received: by 10.70.64.193 with SMTP id q1mr97764309pds.94.1426672587774;
        Wed, 18 Mar 2015 02:56:27 -0700 (PDT)
Received: from lanh ([115.73.252.85])
        by mx.google.com with ESMTPSA id rk5sm26711903pab.37.2015.03.18.02.56.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 02:56:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Mar 2015 16:56:24 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265705>

---
 Makefile                       |  2 +-
 git-rebase--merge.sh (mode +x) | 34 ++++++++++++++++++++++++++++++++++
 git-rebase.sh                  |  2 ++
 3 files changed, 37 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 git-rebase--merge.sh

diff --git a/Makefile b/Makefile
index 93151f4..7ee8df7 100644
--- a/Makefile
+++ b/Makefile
@@ -446,6 +446,7 @@ SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-rebase--am.sh
+SCRIPT_SH += git-rebase--merge.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
@@ -455,7 +456,6 @@ SCRIPT_SH += git-web--browse.sh
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--interactive
-SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
old mode 100644
new mode 100755
index b10f2cf..baaef41
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -3,8 +3,42 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
+. git-sh-setup
+. git-sh-i18n
+set_reflog_action rebase
+require_work_tree_exists
+
+GIT_QUIET=$git_quiet
+
 prec=4
 
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
 read_state () {
 	onto_name=$(cat "$state_dir"/onto_name) &&
 	end=$(cat "$state_dir"/end) &&
diff --git a/git-rebase.sh b/git-rebase.sh
index 42e868d..ff2c2ae 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -156,6 +156,8 @@ run_specific_rebase () {
 	export state_dir verbose strategy strategy_opts
 	if [ "$type" = am ]; then
 		exec git-rebase--am
+	elif [ "$type" = merge ]; then
+		exec git-rebase--merge
 	else
 		. git-rebase--$type
 	fi
-- 
2.3.0.rc1.137.g477eb31
