From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 19/31] rebase: extract am code to new source file
Date: Tue, 28 Dec 2010 10:30:36 +0100
Message-ID: <1293528648-21873-20-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYl-0005Wr-E5
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab0L1Pc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:58 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48315 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab0L1Pc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:56 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so10443701qyk.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lNL20KWciNnvOTOVkq9XeGeAOoFMf1cmCjoKkELSPRc=;
        b=Qteq30pfaqAkiaubDEIW8WpN8qiRiC6qHhAT9wh74wKWcaASt8XxI2ZjxmpK/3+9xd
         UezmeUyteVrD+v97pUIIy9e+AJTVvfzfRPiH7RS5H17/1dojdTbAzju3e6a/bP/NZEkZ
         rAmUMuDguDztfnVnP8BluPxiFihcg9lMi0Oyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DVrG2LKKNc0nqvG+WW3LYxV+N5AeUHLPy1vq5rHfsFhI0e7M4uW5IrcCUlppmam/7k
         jUHvy2GRcKxLCy1fTiFt9f7V1v3qzYyGbOBdevEaKfY0rZ3N66N+PPFma3Unn9KkGXEc
         dYGt/n5cIgsP8Iu+i3TWRXZc6KecbM2E4ICEA=
Received: by 10.229.74.9 with SMTP id s9mr12193995qcj.165.1293550376273;
        Tue, 28 Dec 2010 07:32:56 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:55 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164253>

Extract the code for am-based rebase to git-rebase--am.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 .gitignore        |    1 +
 Makefile          |    1 +
 git-rebase--am.sh |   34 ++++++++++++++++++++++++++++++++++
 git-rebase.sh     |   33 +++------------------------------
 4 files changed, 39 insertions(+), 30 deletions(-)
 create mode 100644 git-rebase--am.sh

diff --git a/.gitignore b/.gitignore
index 40506ff..ef04058 100644
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
index ffc3a5d..459df3a 100644
--- a/Makefile
+++ b/Makefile
@@ -369,6 +369,7 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
+SCRIPT_SH += git-rebase--am.sh
 SCRIPT_SH += git-rebase--interactive.sh
 SCRIPT_SH += git-rebase--merge.sh
 SCRIPT_SH += git-rebase.sh
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
new file mode 100644
index 0000000..9316761
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
+	git am --skip -3 --resolvemsg="$RESOLVEMSG" &&
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
index ee586e8..615d9dd 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -94,9 +94,9 @@ run_specific_rebase () {
 	export onto autosquash strategy strategy_opts verbose rebase_root \
 	force_rebase action preserve_merges upstream switch_to head_name \
 	state_dir orig_head onto_name GIT_QUIET revisions RESOLVEMSG \
-	allow_rerere_autoupdate
+	allow_rerere_autoupdate git_am_opt
 	export -f move_to_original_branch
-	test "$type" != am && exec git-rebase--$type
+	exec git-rebase--$type
 }
 
 run_pre_rebase_hook () {
@@ -266,17 +266,11 @@ continue)
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
@@ -329,14 +323,12 @@ then
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
@@ -461,23 +453,4 @@ else
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
-# start doing a rebase with git-merge
-# this is rename-aware if the recursive (default) strategy is used
-
 run_specific_rebase
-- 
1.7.3.2.864.gbbb96
