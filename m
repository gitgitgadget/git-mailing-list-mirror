From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 19/20] rebase: extract am code to new source file
Date: Thu, 25 Nov 2010 20:58:02 +0100
Message-ID: <1290715083-16919-20-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLnay-00026e-SB
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab0KZB6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:32 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62199 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab0KZB62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:28 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347969vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S53ZQiqbkjvTJmOmGxtcKc37nIIXMtyuF7QOFniKVhU=;
        b=RF4wD9mg/IkRUlAJbiEHFF9Q9oFAjwMrQd1W8dwCS0BMrvVyvKKPhkbh2/Ao/opJT4
         /khE4aU2Scg8Pdft+ze1/n1UWwc8ySro/uyRPPKk+kxqp7WD+TVkACQJmPMuKqTJRi43
         Wgluml/WiViwlJsgd1Z05qq8WpSH9yYyrvIbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lppDe3iqG6vVTTvI0YPNNB1YNGL5wjmecS61zeNEOEGAEHPfQbD8Ry2St7lNLthqLm
         FRcDd3NHfBYZR68YQ4USvgAcuxMKsRK0CIGVJpCTndxSNNBI+6YKVfujwiVc9RXtOUUU
         +qSe2iltCyL4vKre0DpyYud6gUgI6tpwCl/o8=
Received: by 10.220.182.203 with SMTP id cd11mr417566vcb.36.1290736708424;
        Thu, 25 Nov 2010 17:58:28 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:28 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162173>

Extract the code for am-based rebase to git-rebase--am.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 .gitignore        |    1 +
 Makefile          |    1 +
 git-rebase--am.sh |   34 ++++++++++++++++++++++++++++++++++
 git-rebase.sh     |   34 +++-------------------------------
 4 files changed, 39 insertions(+), 31 deletions(-)
 create mode 100644 git-rebase--am.sh

diff --git a/.gitignore b/.gitignore
index 8f68f8a..22b7907 100644
--- a/.gitignore
+++ b/.gitignore
@@ -102,6 +102,7 @@
 /git-quiltimport
 /git-read-tree
 /git-rebase
+/git-rebase--am
 /git-rebase--interactive
 /git-rebase--merge
 /git-receive-pack
diff --git a/Makefile b/Makefile
index 213ceaf..62e9e1e 100644
--- a/Makefile
+++ b/Makefile
@@ -396,6 +396,7 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
+SCRIPT_SH += git-rebase--am.sh
 SCRIPT_SH += git-rebase--interactive.sh
 SCRIPT_SH += git-rebase--merge.sh
 SCRIPT_SH += git-rebase.sh
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
new file mode 100644
index 0000000..162dd6c
--- /dev/null
+++ b/git-rebase--am.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Junio C Hamano.
+#
+
+. git-sh-setup
+
+case "$action" in
+continue)
+	git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
+	move_to_original_branch
+	exit
+	;;
+skip)
+	git am --skip --3way --resolvemsg="$RESOLVEMSG" &&
+	move_to_original_branch
+	exit
+	;;
+esac
+
+test -n "$rebase_root" && root_flag=--root
+
+git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+	--src-prefix=a/ --dst-prefix=b/ \
+	--no-renames $root_flag "$revisions" |
+git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
+move_to_original_branch
+ret=$?
+test 0 != $ret -a -d "$state_dir" &&
+	echo $head_name > "$state_dir/head-name" &&
+	echo $onto > "$state_dir/onto" &&
+	echo $orig_head > "$state_dir/orig-head" &&
+	echo "$GIT_QUIET" > "$state_dir/quiet"
+exit $ret
diff --git a/git-rebase.sh b/git-rebase.sh
index 0773968..e2e97af 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -92,9 +92,9 @@ run_specific_rebase () {
 	export onto autosquash strategy strategy_opts verbose rebase_root \
 	force_rebase action preserve_merges upstream switch_to head_name \
 	in_progress state_dir head_name orig_head GIT_QUIET revisions \
-	RESOLVEMSG
+	RESOLVEMSG git_am_opt
 	export -f move_to_original_branch
-	test "$type" != am && exec git-rebase--$type
+	exec git-rebase--$type
 }
 
 run_pre_rebase_hook () {
@@ -284,17 +284,11 @@ continue)
 	}
 	read_basic_state
 	run_specific_rebase
-	git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
-	move_to_original_branch
-	exit
 	;;
 skip)
 	git reset --hard HEAD || exit $?
 	read_basic_state
 	run_specific_rebase
-	git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
-	move_to_original_branch
-	exit
 	;;
 abort)
 	git rerere clear
@@ -331,14 +325,12 @@ then
 	shift
 	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
 	die "invalid upstream $upstream_name"
-	unset root_flag
 	upstream_arg="$upstream_name"
 else
 	test -z "$onto" && die "You must specify --onto when using --root"
 	unset upstream_name
 	unset upstream
-	root_flag="--root"
-	upstream_arg="$root_flag"
+	upstream_arg=--root
 fi
 
 # Make sure the branch to rebase onto is valid.
@@ -464,24 +456,4 @@ else
 	revisions="$upstream..$orig_head"
 fi
 
-if test -z "$do_merge"
-then
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		--src-prefix=a/ --dst-prefix=b/ \
-		--no-renames $root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
-	move_to_original_branch
-	ret=$?
-	test 0 != $ret -a -d "$apply_dir" &&
-		echo $head_name > "$apply_dir/head-name" &&
-		echo $onto > "$apply_dir/onto" &&
-		echo $orig_head > "$apply_dir/orig-head" &&
-		echo "$GIT_QUIET" > "$apply_dir/quiet"
-	exit $ret
-fi
-
-
-# start doing a rebase with git-merge
-# this is rename-aware if the recursive (default) strategy is used
-
 run_specific_rebase
-- 
1.7.3.2.864.gbbb96
