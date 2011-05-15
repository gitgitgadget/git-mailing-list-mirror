From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC PATCH 2/2] submodule update: continue when a checkout fails
Date: Sun, 15 May 2011 14:42:21 +0200
Message-ID: <551b190565139229c6f374eeba11dd8486375a1d.1305462132.git.iveqy@iveqy.com>
References: <cover.1305462132.git.iveqy@iveqy.com>
Cc: jens.lehmann@web.de, hvoigt@hvoigt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 14:42:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLaeX-0004e6-UX
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 14:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab1EOMmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 08:42:24 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50451 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab1EOMmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 08:42:22 -0400
Received: by eyx24 with SMTP id 24so1045469eyx.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references:in-reply-to:references;
        bh=xo4LGY+WpN0ErNyK0R/ZIJxk2MdY+H8zhZQ1+W+gFWU=;
        b=hYWlcDlGxiIpg3/Y2UDz0yxSCX2DfMSoUnE7QP8KNds+Sjk8Dmco7SgdiYSNsTpLLN
         NFe9yFxTrP9MgPEbnVjw8GICvrG7cQYcJjif9ZIccNTIVLxzb75oT409TlyFjwLBr/41
         JKiq6q2XstP8mLndVurCGi9tbhgXxtPtYHfvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=SZzKXntL+QKKmdFAIZbSOpP5EdXm1RlDZTWCkKQm2qDZJ1zYxLmPSMXUaXLfTtoJBk
         M+MKJ9EHe9v/ch97Y0bg7e6tHmSDyuIymdpiFbIhBzRvnEEHacPu0rzoRH9lGY+MzV0B
         8+1BgV6Yn0hNXMcZC5LxJlbNx/XT6QjsmeBSM=
Received: by 10.213.26.152 with SMTP id e24mr1462792ebc.125.1305463341282;
        Sun, 15 May 2011 05:42:21 -0700 (PDT)
Received: from kolya (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id y10sm2313727eeh.3.2011.05.15.05.42.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 May 2011 05:42:20 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QLaeM-0005CI-1l; Sun, 15 May 2011 14:42:22 +0200
X-Mailer: git-send-email 1.7.5.1.219.ge2152.dirty
In-Reply-To: <cover.1305462132.git.iveqy@iveqy.com>
In-Reply-To: <cover.1305462132.git.iveqy@iveqy.com>
References: <cover.1305462132.git.iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173628>

When running git submodule update the submodules are checked out in
alphabetic order. When an update of a submodule fails because of a
checkout error, continue to the next submodule and when done with all
submodules, exit with an error.

We only do this for 'safe' case when a submodule is not marked as
rebase or merge. When the update of a submodule fails because of a merge
or rebase, the update will still die immediately to give the user an
opportunity to resolve any conflicts before continuing.

Since submodule 'b' does not necessarily need to be dependent on
submodule 'a' this behavior is helpful if we have a lot of submodules.
For example if some submodules currently experience network problems
we can securely continue with the other submodules and the user can
revisit the failed one later on.

It also is helpful if a checkout fails because a submodules working
directory is dirty. Now the user can cleanup the submodule in question
and another git submodule update will just update the failed submodule
instead of all submodules that are ordered alphabetically afterwards.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-submodule.sh            |   42 ++++++++++++++++++++++++++++++++++++------
 t/t7406-submodule-update.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bf110e9..02c41c7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -444,7 +444,8 @@ cmd_update()
 	fi
 
 	cloned_modules=
-	module_list "$@" |
+	module_list "$@" | {
+	err=
 	while read mode sha1 stage path
 	do
 		if test "$stage" = U
@@ -525,17 +526,46 @@ cmd_update()
 				;;
 			esac
 
-			(clear_local_git_env; cd "$path" && $command "$sha1") ||
-			die "Unable to $action '$sha1' in submodule path '$path'"
-			say "Submodule path '$path': $msg '$sha1'"
+			if (clear_local_git_env; cd "$path" && $command "$sha1")
+			then
+				say "Submodule path '$path': $msg '$sha1'"
+			else
+				case $action in
+				rebase|merge)
+					die "Unable to $action '$sha1' in submodule path '$path'" 2
+					;;
+				*)
+					say "Unable to $action '$sha1' in submodule path '$path'"
+					err="Failed to $action one or more submodule(s)"
+					continue
+					;;
+				esac
+			fi
 		fi
 
 		if test -n "$recursive"
 		then
-			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags") ||
-			die "Failed to recurse into submodule path '$path'"
+			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags")
+			res=$?
+			if test $res -gt 0
+			then
+				if test $res -eq 1
+				then
+					say "Failed to recurse into submodule path '$path'"
+					continue
+				else
+					die "Failed to recurse into submodule path '$path'" $res
+				fi
+			fi
 		fi
 	done
+
+	if test -n "$err"
+	then
+		die "$err"
+	fi
+
+	}
 }
 
 set_name_rev () {
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4f16fcc..e79c4df 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -298,4 +298,33 @@ test_expect_success 'submodule update ignores update=rebase config for new submo
 	)
 '
 
+test_expect_success 'submodule update continues after checkout error' '
+	(cd super &&
+	 git reset --hard HEAD &&
+	 git submodule add ../submodule submodule2 &&
+	 git submodule init &&
+	 git commit -am "new_submodule" &&
+	 (cd submodule2 &&
+	  git rev-parse HEAD > ../expect
+	 ) &&
+	 (cd submodule &&
+	  test_commit "update_submodule" file
+	 ) &&
+	 (cd submodule2 &&
+	  test_commit "update_submodule2" file
+	 ) &&
+	 git add submodule &&
+	 git add submodule2 &&
+	 git commit -m "two_new_submodule_commits" &&
+	 (cd submodule &&
+	 	echo "" > file
+	 ) &&
+	 git checkout HEAD^ &&
+	 test_must_fail git submodule update &&
+	 (cd submodule2 &&
+	  git rev-parse HEAD > ../actual
+	 ) &&
+	 test_cmp expect actual
+	) 
+'
 test_done
-- 
1.7.5.1.219.ge2152.dirty
