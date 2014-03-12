From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] submodule: add verbose mode for add/update
Date: Wed, 12 Mar 2014 22:03:45 +0200
Message-ID: <1394654625-4586-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 21:04:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpNx-00072t-GK
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbaCLUEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:04:08 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:53578 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbaCLUEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:04:07 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so177517wib.8
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HrwLj3Li8sXdqRZ1845w6Yce0ncGdd1jXesQLa3a+oM=;
        b=B5phJjW0D46rpRvGlXdX3BoZhQKU1avY2jkGIIYHNtvB5fF5f2j4G7vbddgupBltok
         OqCgn45riRSOeriHpFISKhjzJn6ATGKea1erolA/GsVyk2HsE5LLc6ZmKzyaAN8FGPbp
         yscmGQ5YnllnIkKHkMhFiPHFDEvddj7h9QzODbBHUzecUZCaI4kFNFebtPmiINscz7KD
         WtvXb4IMJyF4qqrtJU0Hntn1r3IiscI+Q4G36h70buyNDZsZmSzqptPobJkZjdpJMSCG
         yPpD0U2CUcmAHnaG++Y8VEba7/NNumuCXm6IWWOLMpqGaaUzN+FEKEDa0EHsAc+oRu0E
         h4aA==
X-Received: by 10.194.203.200 with SMTP id ks8mr2972043wjc.61.1394654646029;
        Wed, 12 Mar 2014 13:04:06 -0700 (PDT)
Received: from localhost.localdomain ([95.86.83.168])
        by mx.google.com with ESMTPSA id ju6sm72238508wjc.1.2014.03.12.13.04.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Mar 2014 13:04:05 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243978>

Add the verbose flag to add and update which displays the
progress of the actual submodule checkout when given. This
is useful for checkouts that take a long time, as the user
can then see the progress.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 Documentation/git-submodule.txt |  7 +++++--
 git-submodule.sh                | 24 +++++++++++++++++++-----
 t/t7406-submodule-update.sh     | 10 ++++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 21cb59a..0147b23 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -10,13 +10,13 @@ SYNOPSIS
 --------
 [verse]
 'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
-	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
+	      [--reference <repository>] [--depth <depth>] [-v|--verbose] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge|--checkout] [--reference <repository>]
-	      [--depth <depth>] [--recursive] [--] [<path>...]
+	      [--depth <depth>] [--recursive] [-v|--verbose] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -363,6 +363,9 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
+--verbose::
+	This option is valid for add and update commands. Display the progress
+	of the actual submodule	checkout.
 
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
diff --git a/git-submodule.sh b/git-submodule.sh
index a33f68d..e1df2c8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,11 +5,11 @@
 # Copyright (c) 2007 Lars Hjemli
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [-v|--verbose] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [-v|--verbose] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -319,12 +319,16 @@ module_clone()
 	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
 	(
 		clear_local_git_env
+		if test -z "$verbose"
+		then
+			subquiet=-q
+		fi
 		cd "$sm_path" &&
 		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
 		# ash fails to wordsplit ${local_branch:+-B "$local_branch"...}
 		case "$local_branch" in
-		'') git checkout -f -q ${start_point:+"$start_point"} ;;
-		?*) git checkout -f -q -B "$local_branch" ${start_point:+"$start_point"} ;;
+		'') git checkout -f ${subquiet:+"$subquiet"} ${start_point:+"$start_point"} ;;
+		?*) git checkout -f ${subquiet:+"$subquiet"} -B "$local_branch" ${start_point:+"$start_point"} ;;
 		esac
 	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
 }
@@ -380,6 +384,9 @@ cmd_add()
 		--depth=*)
 			depth=$1
 			;;
+		-v|--verbose)
+			verbose=1
+			;;
 		--)
 			shift
 			break
@@ -786,6 +793,9 @@ cmd_update()
 		--depth=*)
 			depth=$1
 			;;
+		-v|--verbose)
+			verbose=1
+			;;
 		--)
 			shift
 			break
@@ -913,7 +923,11 @@ Maybe you want to use 'update --init'?")"
 			must_die_on_failure=
 			case "$update_module" in
 			checkout)
-				command="git checkout $subforce -q"
+				if test -z "$verbose"
+				then
+					subquiet=-q
+				fi
+				command="git checkout $subforce ${subquiet:+"$subquiet"}"
 				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
 				;;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 28ca763..c3de90a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -83,6 +83,16 @@ test_expect_success 'submodule update detaching the HEAD ' '
 	)
 '
 
+test_expect_success 'submodule update verbose' '
+	(cd super/submodule &&
+	 git checkout master
+	) &&
+	(cd super &&
+	 git submodule update --verbose submodule 2>messages &&
+	 test_i18ngrep "HEAD is now at" messages
+	)
+'
+
 test_expect_success 'submodule update from subdirectory' '
 	(cd super/submodule &&
 	 git reset --hard HEAD~1
-- 
1.9.0
