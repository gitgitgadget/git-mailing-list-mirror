From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] submodule: add verbose mode for add/update
Date: Wed, 10 Apr 2013 21:24:22 +0300
Message-ID: <1365618262-8024-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 20:25:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPziW-0006bD-QR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937262Ab3DJSYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 14:24:47 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:35037 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937243Ab3DJSYp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 14:24:45 -0400
Received: by mail-ea0-f176.google.com with SMTP id h10so379122eaj.35
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=PA1CW01UOU7hWwFe8/xt/2OZ7/SnkjIYAI4jVRz7T0g=;
        b=DKQgI01CGGokpGfy49l3iL/kz4DUAn+wD6NRaGcG9XDKfhMvNmtVAUoENNlJ1VqMDW
         V1z8MK78hz7dZteJpXHLSailHJ3CG7j8wg5KIh82B92XpAIIWn3GXZeActdArmL2lIgU
         DmWjrY/CAY9rYKFPGHJtKSEnBWW/o9jcaBrWpFAwVMaSIh8UVf3GvsYicD0F8rzWuxqF
         NkcxG6IgTakI2Y6SW0APNmzj/pf1JHbHFpDto9gRz+ZJby0Ll1eV3ndu9aT6Eovur5sq
         DEmR5oUJuFYH3Q+lfiPL35vBiWrydZxe5q/JtoCz89dvuGh6tbkCXZQtNoL+IR1gbCcG
         Mi7Q==
X-Received: by 10.14.1.130 with SMTP id 2mr8046068eed.15.1365618283868;
        Wed, 10 Apr 2013 11:24:43 -0700 (PDT)
Received: from localhost.localdomain ([77.127.168.32])
        by mx.google.com with ESMTPS id f47sm1226231eep.13.2013.04.10.11.24.41
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 11:24:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220715>

Executes checkout without -q
---
 git-submodule.sh |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..f7964ad 100755
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
@@ -309,6 +309,9 @@ cmd_add()
 			custom_name=$2
 			shift
 			;;
+		-v|--verbose)
+			VERBOSE=1
+			;;
 		--)
 			shift
 			break
@@ -408,11 +411,15 @@ Use -f if you really want to add it." >&2
 		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" || exit
 		(
 			clear_local_git_env
+			if test -z "$VERBOSE"
+			then
+				subquiet=-q
+			fi
 			cd "$sm_path" &&
 			# ash fails to wordsplit ${branch:+-b "$branch"...}
 			case "$branch" in
-			'') git checkout -f -q ;;
-			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
+			'') git checkout -f $subquiet ;;
+			?*) git checkout -f $subquiet -B "$branch" "origin/$branch" ;;
 			esac
 		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
 	fi
@@ -676,6 +683,9 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		-v|--verbose)
+			VERBOSE=1
+			;;
 		--)
 			shift
 			break
@@ -799,7 +809,11 @@ Maybe you want to use 'update --init'?")"
 				must_die_on_failure=yes
 				;;
 			*)
-				command="git checkout $subforce -q"
+				if test -z "$VERBOSE"
+				then
+					subquiet=-q
+				fi
+				command="git checkout $subforce $subquiet"
 				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
 				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': checked out '\$sha1'")"
 				;;
-- 
1.7.10.4
