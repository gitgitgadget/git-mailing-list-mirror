From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v3 2/2] submodule update: continue when a checkout fails
Date: Thu,  9 Jun 2011 09:47:03 +0200
Message-ID: <1307605623-2831-3-git-send-email-iveqy@iveqy.com>
References: <1307605623-2831-1-git-send-email-iveqy@iveqy.com>
Cc: hvoigt@hvoigt.net, jens.lehmann@web.de, git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Thu Jun 09 09:47:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUZxZ-0003Oi-GD
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 09:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab1FIHrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 03:47:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50469 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab1FIHrG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 03:47:06 -0400
Received: by ewy4 with SMTP id 4so447721ewy.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references;
        bh=m/F+V4iyxSgqw0M5HgAoSGJ8yKTx7JnINNn2eXuIUmM=;
        b=rL4x86ME5EeriRGb3+LIqPt2P76iMzCLl5DiTNLaFOxUt5tt1pzg8JwOpYfgd9dZax
         bEx6e5IyctwaL6Cgp8TYiANAtuZFQqtcGcTg+PXgth8KnG4+720uuPZaEzdh8vhhk3Kp
         QV5kD+KfDvIfU8oQsoI7RvW+Gz42YXL0P9gJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=AykRmkHwjLj374DwXtiloQSZkujvrgK1mQ/DIzjCG9U5V7wHlJneUZrKZZF0dqfJsV
         utPbEYGhixjBSa51iP4UCPFPBKnAuFrTOXe/DQY29G0kLT+qW5vZ8kgs5oRLaFvhZt5+
         BHis7iRgt2ZmINc9bkdhEW0/r9TxbZIFctYZk=
Received: by 10.213.99.69 with SMTP id t5mr2438945ebn.14.1307605624967;
        Thu, 09 Jun 2011 00:47:04 -0700 (PDT)
Received: from kolya (1-1-3-35a.mfb.mlm.bostream.se [82.182.194.253])
        by mx.google.com with ESMTPS id p80sm1198245eeb.25.2011.06.09.00.47.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 00:47:04 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QUZxZ-0000lo-QV; Thu, 09 Jun 2011 09:47:21 +0200
X-Mailer: git-send-email 1.7.6.rc0.14.g4fc55
In-Reply-To: <1307605623-2831-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175501>

"git submodule update" stops at the first error and gives control
back to the user. Only after the user fixes the problematic
submodule and runs "git submodule update" again, the second error
is found. And the user needs to repeat until all the problems are
found and fixed one by one. This is tedious.

Instead, the command can remember which submodules it had trouble with,
continue updating the ones it can, and report which ones had errors at
the end. The user can run "git submodule update", find all the ones that
need minor fixing (e.g. working tree was dirty) to fix them in a single
pass. Then another "git submodule update" can be run to update all.

Note that the problematic submodules are skipped only when they are to
be integrated with a safer value of submodule.<name>.update option,
namely "checkout". Fixing a failure in a submodule that uses "rebase" or
"merge" may need an involved conflict resolution by the user, and
leaving too many submodules in states that need resolution would not
reduce the mental burden on the user.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-submodule.sh            |   48 +++++++++++++--
 t/t7406-submodule-update.sh |  144 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d189a24..69780a8 100755
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
@@ -525,17 +526,52 @@ cmd_update()
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
+					die_with_status 2 "Unable to $action '$sha1' in submodule path '$path'"
+					;;
+				*)
+					err="${err} \"Failed to $action in submodule path '$path'\""
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
+					err="${err} \"Failed to recurse into submodule path '$path'\""
+					continue
+				else
+					die_with_status $res "Failed to recurse into submodule path '$path'"
+				fi
+			fi
 		fi
 	done
+
+	if test -n "$err"
+	then
+		OIFS=$IFS
+		IFS=';'
+		for e in $err
+		do
+			echo $e
+		done
+		IFS=$OIFS
+		die
+	fi
+
+	}
 }
 
 set_name_rev () {
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4f16fcc..807f761 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -298,4 +298,148 @@ test_expect_success 'submodule update ignores update=rebase config for new submo
 	)
 '
 
+test_expect_success 'submodule update continues after checkout error' '
+	(cd super &&
+	 git reset --hard HEAD &&
+	 git submodule add ../submodule submodule2 &&
+	 git submodule init &&
+	 git commit -am "new_submodule" &&
+	 (cd submodule2 &&
+	  git rev-parse --max-count=1 HEAD > ../expect
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
+	  echo "" > file
+	 ) &&
+	 git checkout HEAD^ &&
+	 test_must_fail git submodule update &&
+	 (cd submodule2 &&
+	  git rev-parse --max-count=1 HEAD > ../actual
+	 ) &&
+	 test_cmp expect actual
+	)
+'
+test_expect_success 'submodule update continues after recursive checkout error' '
+	(cd super &&
+	 git reset --hard HEAD &&
+	 git checkout master &&
+	 git submodule update &&
+	 (cd submodule &&
+	  git submodule add ../submodule subsubmodule &&
+	  git submodule init &&
+	  git commit -m "new_subsubmodule"
+	 ) &&
+	 git add submodule &&
+	 git commit -m "update_submodule" &&
+	 (cd submodule &&
+	  (cd subsubmodule &&
+	   test_commit "update_subsubmodule" file
+	  ) &&
+	  git add subsubmodule &&
+	  test_commit "update_submodule_again" file &&
+	  (cd subsubmodule &&
+	   test_commit "update_subsubmodule_again" file
+	  ) &&
+	  test_commit "update_submodule_again_again" file
+	 ) &&
+	 (cd submodule2 &&
+	  git rev-parse --max-count=1 HEAD > ../expect &&
+	  test_commit "update_submodule2_again" file
+	 ) &&
+	 git add submodule &&
+	 git add submodule2 &&
+	 git commit -m "new_commits" &&
+	 git checkout HEAD^ &&
+	 (cd submodule &&
+	  git checkout HEAD^ &&
+	  (cd subsubmodule &&
+	   echo "" > file
+	  )
+	 ) &&
+	 test_must_fail git submodule update --recursive &&
+	 (cd submodule2 &&
+	  git rev-parse --max-count=1 HEAD > ../actual
+	 ) &&
+	 test_cmp expect actual
+	)
+'
+
+test_expect_success 'submodule update exit immediately in case of merge conflict' '
+	(cd super &&
+	 git checkout master &&
+	 git reset --hard HEAD &&
+	 (cd submodule &&
+	  (cd subsubmodule &&
+	   git reset --hard HEAD
+	  )
+	 ) &&
+	 git submodule update --recursive &&
+	 (cd submodule &&
+	  test_commit "update_submodule_2" file
+	 ) &&
+	 (cd submodule2 &&
+	  test_commit "update_submodule2_2" file
+	 ) &&
+	 git add submodule &&
+	 git add submodule2 &&
+	 git commit -m "two_new_submodule_commits" &&
+	 (cd submodule &&
+	  git checkout master &&
+	  test_commit "conflict" file &&
+	  echo "conflict" > file
+	 ) &&
+	 git checkout HEAD^ &&
+	 (cd submodule2 &&
+	  git rev-parse --max-count=1 HEAD > ../expect
+	 ) &&
+	 git config submodule.submodule.update merge &&
+	 test_must_fail git submodule update &&
+	 (cd submodule2 &&
+	  git rev-parse --max-count=1 HEAD > ../actual
+	 ) &&
+	 test_cmp expect actual
+	)
+'
+test_expect_success 'submodule update exit immediately after recursive rebase error' '
+	(cd super &&
+	 git checkout master &&
+	 git reset --hard HEAD &&
+	 (cd submodule &&
+	  git reset --hard HEAD &&
+	  git submodule update --recursive
+	 ) &&
+	 (cd submodule &&
+	  test_commit "update_submodule_3" file
+	 ) &&
+	 (cd submodule2 &&
+	  test_commit "update_submodule2_3" file
+	 ) &&
+	 git add submodule &&
+	 git add submodule2 &&
+	 git commit -m "two_new_submodule_commits" &&
+	 (cd submodule &&
+	  git checkout master &&
+	  test_commit "conflict2" file &&
+	  echo "conflict" > file
+	 ) &&
+	 git checkout HEAD^ &&
+	 (cd submodule2 &&
+	  git rev-parse --max-count=1 HEAD > ../expect
+	 ) &&
+	 git config submodule.submodule.update rebase &&
+	 test_must_fail git submodule update &&
+	 (cd submodule2 &&
+	  git rev-parse --max-count=1 HEAD > ../actual
+	 ) &&
+	 test_cmp expect actual
+	)
+'
 test_done
-- 
1.7.6.rc0.14.g4fc55
