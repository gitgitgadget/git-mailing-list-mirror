From: William Entriken <fulldecent@gmail.com>
Subject: [PATCH] submodule update: when using recursion, show full path
Date: Sat,  2 Mar 2013 14:44:59 -0500
Message-ID: <1362253499-48847-1-git-send-email-github.com@phor.net>
References: <5127C45C.2020204@web.de>
Cc: William Entriken <github.com@phor.net>
To: git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 02 20:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBsNI-0001hs-3h
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 20:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab3CBTpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 14:45:01 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:62041 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab3CBTpA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 14:45:00 -0500
Received: by mail-qa0-f49.google.com with SMTP id o13so405037qaj.8
        for <git@vger.kernel.org>; Sat, 02 Mar 2013 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bd09iCjQ3qI1CiDvgmeso2/BxZnIiXvBhL7lXQyUy9c=;
        b=MqtOVo2twN330Y048O8kz2x8OVPd7hZDT3n+kZa0b73FPflk5t1fkYXUZ17hyfmnfG
         QE59FMgExhXUv4dZVJU6cc7H85Jbw7hqpORJExx86KLiVR0R4QvaFwz5R4EE6lN52u/S
         JVnVt/E/srllyL/6oOQlCe5fcTyz0kHcNZvZ7YEnlZXLYtDAXv6AWsM3bTyBx9mCmoVZ
         cxI0AzsGw/5AtwQqXOvUD4lDatx5ur3wdslnp0NbyQgjPkKL6E/rPNK/rThIZX1Sebbr
         9Q9XXJ6sGb1dH1D0b6fcc3AK8n9ZRDPOtKrXB/zrkWFDbVZtqJ/zTPCItVEix35eSqNr
         +Xnw==
X-Received: by 10.49.58.173 with SMTP id s13mr9909516qeq.29.1362253499655;
        Sat, 02 Mar 2013 11:44:59 -0800 (PST)
Received: from localhost.localdomain (c-69-139-82-16.hsd1.pa.comcast.net. [69.139.82.16])
        by mx.google.com with ESMTPS id hn9sm27419901qab.8.2013.03.02.11.44.58
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 02 Mar 2013 11:44:59 -0800 (PST)
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <5127C45C.2020204@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217334>

Previously when using update with recursion, only the path for the
inner-most module was printed. Now the path is printed relative to
the directory the command was started from. This now matches the
behavior of submodule foreach.

Signed-off-by: William Entriken <github.com@phor.net>
---
 git-submodule.sh | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2365149..f2c53c9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -588,7 +588,7 @@ cmd_update()
 		die_if_unmatched "$mode"
 		if test "$stage" = U
 		then
-			echo >&2 "Skipping unmerged submodule $sm_path"
+			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
 			continue
 		fi
 		name=$(module_name "$sm_path") || exit
@@ -602,7 +602,7 @@ cmd_update()
 
 		if test "$update_module" = "none"
 		then
-			echo "Skipping submodule '$sm_path'"
+			echo "Skipping submodule '$prefix$sm_path'"
 			continue
 		fi
 
@@ -611,7 +611,7 @@ cmd_update()
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "$(eval_gettext "Submodule path '\$sm_path' not initialized
+			say "$(eval_gettext "Submodule path '\$prefix\$sm_path' not initialized
 Maybe you want to use 'update --init'?")"
 			continue
 		fi
@@ -624,7 +624,7 @@ Maybe you want to use 'update --init'?")"
 		else
 			subsha1=$(clear_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
-			die "$(eval_gettext "Unable to find current revision in submodule path '\$sm_path'")"
+			die "$(eval_gettext "Unable to find current revision in submodule path '\$prefix\$sm_path'")"
 		fi
 
 		if test "$subsha1" != "$sha1" -o -n "$force"
@@ -643,7 +643,7 @@ Maybe you want to use 'update --init'?")"
 				(clear_local_git_env; cd "$sm_path" &&
 					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
 					 test -z "$rev") || git-fetch)) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+				die "$(eval_gettext "Unable to fetch in submodule path '\$prefix\$sm_path'")"
 			fi
 
 			# Is this something we just cloned?
@@ -657,20 +657,20 @@ Maybe you want to use 'update --init'?")"
 			case "$update_module" in
 			rebase)
 				command="git rebase"
-				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$sm_path'")"
-				say_msg="$(eval_gettext "Submodule path '\$sm_path': rebased into '\$sha1'")"
+				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$prefix\$sm_path'")"
+				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': rebased into '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			merge)
 				command="git merge"
-				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$sm_path'")"
-				say_msg="$(eval_gettext "Submodule path '\$sm_path': merged in '\$sha1'")"
+				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$prefix\$sm_path'")"
+				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			*)
 				command="git checkout $subforce -q"
-				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$sm_path'")"
-				say_msg="$(eval_gettext "Submodule path '\$sm_path': checked out '\$sha1'")"
+				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
+				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': checked out '\$sha1'")"
 				;;
 			esac
 
@@ -688,11 +688,16 @@ Maybe you want to use 'update --init'?")"
 
 		if test -n "$recursive"
 		then
-			(clear_local_git_env; cd "$sm_path" && eval cmd_update "$orig_flags")
+			(
+				prefix="$prefix$sm_path/"
+				clear_local_git_env
+				cd "$sm_path" &&
+				eval cmd_update "$orig_flags"
+			)
 			res=$?
 			if test $res -gt 0
 			then
-				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
+				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$prefix\$sm_path'")"
 				if test $res -eq 1
 				then
 					err="${err};$die_msg"
-- 
1.7.12.4 (Apple Git-37)
