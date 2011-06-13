From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v4 2/2] submodule update: continue when a checkout fails
Date: Mon, 13 Jun 2011 19:15:26 +0200
Message-ID: <1307985326-3216-1-git-send-email-iveqy@iveqy.com>
References: <7vlixayl7d.fsf@alter.siamese.dyndns.org>
Cc: hvoigt@hvoigt.net, iveqy@iveqy.com, jens.lehmann@web.de,
	git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 13 19:15:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWAja-0007on-9o
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 19:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab1FMRPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 13:15:24 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37254 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab1FMRPX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 13:15:23 -0400
Received: by ewy4 with SMTP id 4so1676496ewy.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references;
        bh=OyZ2HPP8WdCh2mB5DcVezBAK3slVDIEmLLUu8+FWxcM=;
        b=YEAOUAycsO6VtHkp2koVkZFYeeQ0MR776/bTfORK3I6PJ4SfIGp+65Zb3cQnrgTmLD
         XZ8vKhYUJnWT7Oh66uo3TKCoCwgajTSiPZVhfW7ksU3husMnJ17HKyrmfX0yBasR2nAQ
         tkgPel4FqitzblqX3Ud5RaocVo0pgIwb3ajy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=nHWsjaAon6s7psmJ+gQU1VJmfaZgPWsBqlaT3c6knes00GKsZB6q5M4qoHXdkFTQhu
         0eZbvvQG0bmoj3v7G0MSHhNpoJfem9o8wmJpkM13zcuIF3+KHf4OXpYLJGfn29r1cfWx
         yncrhEob3YtW3pj97o6tmE7K2/RKiuzvO+JHI=
Received: by 10.213.104.145 with SMTP id p17mr1210751ebo.58.1307985322219;
        Mon, 13 Jun 2011 10:15:22 -0700 (PDT)
Received: from kolya (h8n2fls303o1100.telia.com [195.67.191.8])
        by mx.google.com with ESMTPS id a41sm5367848eeg.7.2011.06.13.10.15.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 10:15:21 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QWAjh-0000qy-VD; Mon, 13 Jun 2011 19:15:40 +0200
X-Mailer: git-send-email 1.7.6.rc0.12.g2c6b5
In-Reply-To: <7vlixayl7d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175721>

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
I'm sorry. You were reading a mix between two solutions that slipped
through. Here's a corrected patch.

I'll changed it to be printed to standard error output instead.

die will not print an empty line (as of the first patch in this series) but I
changed this to "exit 1" instead to be more clear.

 git-submodule.sh            |   50 +++++++++++++--
 t/t7406-submodule-update.sh |  144 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d189a24..eb5eebc 100755
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
@@ -525,17 +526,54 @@ cmd_update()
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
+					err="${err};Failed to $action in submodule path '$path'"
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
+					err="${err};Failed to recurse into submodule path '$path'"
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
+			if test -n "$e"
+			then
+				echo >&2 "$e"
+			fi
+		done
+		IFS=$OIFS
+		exit 1
+	fi
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
1.7.6.rc0.14.gc8898.dirty
