From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/5] rebase: split the cherry-pick stuff
Date: Tue, 28 May 2013 08:29:13 -0500
Message-ID: <1369747757-10192-2-git-send-email-felipe.contreras@gmail.com>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:31:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJzj-0007ZK-8c
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934171Ab3E1NbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:31:06 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:43239 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934169Ab3E1NbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:31:03 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so9927201oag.37
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=R//YRi+OJxw8G9KMATp800zq2Rsl3HyZfcGnCUumhhs=;
        b=xxI3TTVZMxd64c/yO3b73dxXiv7tsRL3N0Y61VuLUKpHjUTXIQ6mIp6etstfzcr9Co
         JjRQevhvrVBBuZEbm+mN4wjuXgVC2JMmXPZMiT6zwlNwMhbOHCwf5fB3AjLK0p1RoEeJ
         GbJtuoGttMxIbysA7ej0011l2Jb2SSOmaFqQtdUIenrIxu7DaUXMpP57auSX6xcy+Pfj
         UkH8xPAKWdLab7/NIFeKxnlD6MwggVCBCdagcN0dc8WlWt+httDfp2vcS2Wi8No/nsQ2
         I4NNhVgzcO6kHjnT4dxDCm6Tt3arxQ9WGlwl/vWd18s69P7d/3BBrfyryYiQ/g2Bp+25
         w4Kw==
X-Received: by 10.60.133.240 with SMTP id pf16mr21227839oeb.28.1369747862938;
        Tue, 28 May 2013 06:31:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kd10sm35476881oeb.7.2013.05.28.06.31.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:31:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225647>

They do something completely different from 'git am', it belongs in a
different file.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore            |  1 +
 Makefile              |  1 +
 git-rebase--am.sh     | 65 ++++++++++++++++++++++-----------------------------
 git-rebase--cherry.sh | 34 +++++++++++++++++++++++++++
 git-rebase.sh         |  4 ++++
 5 files changed, 68 insertions(+), 37 deletions(-)
 create mode 100644 git-rebase--cherry.sh

diff --git a/.gitignore b/.gitignore
index 6669bf0..284fc8f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -113,6 +113,7 @@
 /git-read-tree
 /git-rebase
 /git-rebase--am
+/git-rebase--cherry
 /git-rebase--interactive
 /git-rebase--merge
 /git-receive-pack
diff --git a/Makefile b/Makefile
index 0f931a2..a3cd4bc 100644
--- a/Makefile
+++ b/Makefile
@@ -469,6 +469,7 @@ SCRIPT_SH += git-web--browse.sh
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
+SCRIPT_LIB += git-rebase--cherry
 SCRIPT_LIB += git-rebase--interactive
 SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index f84854f..ee1b1b9 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -19,52 +19,43 @@ esac
 test -n "$rebase_root" && root_flag=--root
 
 ret=0
-if test -n "$keep_empty"
-then
-	# we have to do this the hard way.  git format-patch completely squashes
-	# empty commits and even if it didn't the format doesn't really lend
-	# itself well to recording empty patches.  fortunately, cherry-pick
-	# makes this easy
-	git cherry-pick --allow-empty "$revisions"
-	ret=$?
-else
-	rm -f "$GIT_DIR/rebased-patches"
-
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
-		$root_flag "$revisions" >"$GIT_DIR/rebased-patches"
-	ret=$?
 
-	if test 0 != $ret
-	then
-		rm -f "$GIT_DIR/rebased-patches"
-		case "$head_name" in
-		refs/heads/*)
-			git checkout -q "$head_name"
-			;;
-		*)
-			git checkout -q "$orig_head"
-			;;
-		esac
+rm -f "$GIT_DIR/rebased-patches"
 
-		cat >&2 <<-EOF
+git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+	--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
+	$root_flag "$revisions" >"$GIT_DIR/rebased-patches"
+ret=$?
 
-		git encountered an error while preparing the patches to replay
-		these revisions:
+if test 0 != $ret
+then
+	rm -f "$GIT_DIR/rebased-patches"
+	case "$head_name" in
+	refs/heads/*)
+		git checkout -q "$head_name"
+		;;
+	*)
+		git checkout -q "$orig_head"
+		;;
+	esac
 
-		    $revisions
+	cat >&2 <<-EOF
 
-		As a result, git cannot rebase them.
-		EOF
-		exit $?
-	fi
+	git encountered an error while preparing the patches to replay
+	these revisions:
 
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
-	ret=$?
+	    $revisions
 
-	rm -f "$GIT_DIR/rebased-patches"
+	As a result, git cannot rebase them.
+	EOF
+	exit $?
 fi
 
+git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
+ret=$?
+
+rm -f "$GIT_DIR/rebased-patches"
+
 if test 0 != $ret
 then
 	test -d "$state_dir" && write_basic_state
diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
new file mode 100644
index 0000000..cbf80f9
--- /dev/null
+++ b/git-rebase--cherry.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Junio C Hamano.
+#
+
+case "$action" in
+continue)
+	git am --resolved --resolvemsg="$resolvemsg" &&
+	move_to_original_branch
+	exit
+	;;
+skip)
+	git am --skip --resolvemsg="$resolvemsg" &&
+	move_to_original_branch
+	exit
+	;;
+esac
+
+test -n "$rebase_root" && root_flag=--root
+
+# we have to do this the hard way.  git format-patch completely squashes
+# empty commits and even if it didn't the format doesn't really lend
+# itself well to recording empty patches.  fortunately, cherry-pick
+# makes this easy
+git cherry-pick --allow-empty "$revisions"
+ret=$?
+
+if test 0 != $ret
+then
+	test -d "$state_dir" && write_basic_state
+	exit $ret
+fi
+
+move_to_original_branch
diff --git a/git-rebase.sh b/git-rebase.sh
index 2c692c3..2754985 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -379,6 +379,10 @@ elif test -n "$do_merge"
 then
 	type=merge
 	state_dir="$merge_dir"
+elif test -n "$keep_empty"
+then
+	type=cherry
+	state_dir="$apply_dir"
 else
 	type=am
 	state_dir="$apply_dir"
-- 
1.8.3.rc3.312.g47657de
