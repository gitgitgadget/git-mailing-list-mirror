From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC PATCH] Move git-dir for submodules
Date: Thu, 21 Jul 2011 18:52:19 +0200
Message-ID: <1311267139-14658-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, iveqy@iveqy.com, jens.lehmann@web.de,
	hvoigt@hvoigt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 18:52:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjwU3-0006oI-4o
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 18:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab1GUQwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 12:52:16 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:63495 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224Ab1GUQwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 12:52:13 -0400
Received: by eye22 with SMTP id 22so1725669eye.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=Xcpt5KcEhWeIidlXuTHOxP/hopusuNfJJeoTtFqTGtc=;
        b=IbncjXkzbVUy8e1DM1uG/2tP/ictgt2kh5vsmptfBHr3Cp/PqzFU641eGOjC/nsu7k
         mnLakg92+hU7bA+ntP77PZ1Q2ID3J/xqsi4q7ZZKqHUXli9XN9jsO0HX5rVOzFT+Fy2B
         HMDD/tkHs//sPJOlCyF+m/CNhO2TxMgx910PY=
Received: by 10.14.100.13 with SMTP id y13mr228101eef.11.1311267131782;
        Thu, 21 Jul 2011 09:52:11 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id e45sm1233818eeb.45.2011.07.21.09.52.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 09:52:11 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QjwU5-0003oy-U5; Thu, 21 Jul 2011 18:52:26 +0200
X-Mailer: git-send-email 1.7.6.132.ga34b5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177582>

Move git-dir for submodules into $GIT_DIR/modules/[name_of_submodule] of
the superproject. This is a step towards being able to delete submodule
directories without loosing the information from their .git directory
as that is now stored outside the submodules work tree.

This is done relying on the already existent .git-file functionality.
Tests that rely on .git being a directory have been fixed.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-submodule.sh               |   52 ++++++++++++++++++--
 t/t7400-submodule-basic.sh     |    4 +-
 t/t7403-submodule-sync.sh      |    2 +-
 t/t7406-submodule-update.sh    |  105 ++++++++++++++++++++++++++++++++++++++++
 t/t7407-submodule-foreach.sh   |   98 +++++++++++++++++++-------------------
 t/t7408-submodule-reference.sh |    4 +-
 6 files changed, 206 insertions(+), 59 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 87c9452..3ad3012 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -122,14 +122,56 @@ module_clone()
 	path=$1
 	url=$2
 	reference="$3"
+	gitdir=
+	gitdir_base=
+	base_path=`echo $path | sed -e 's|[^/]*$||'`
 
-	if test -n "$reference"
+	if test -z "$GIT_DIR"
 	then
-		git-clone "$reference" -n "$url" "$path"
+		gitdir=$(git rev-parse --git-dir)
+		gitdir_base="$gitdir/modules/$base_path"
+		gitdir="$gitdir/modules/$path"
 	else
-		git-clone -n "$url" "$path"
-	fi ||
-	die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
+		gitdir="$GIT_DIR/modules/$path"
+		gitdir_base="$GIT_DIR/modules/$base_path"
+	fi
+
+	case $gitdir in
+		/*)
+			a="$(cd_to_toplevel && pwd)/"
+			b=$gitdir
+			while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
+			do
+				a=${a#*/} b=${b#*/};
+			done
+
+			rel="$a$path"
+			rel=`echo $rel | sed -e 's|[^/]*|..|g'`
+			rel_gitdir="$rel/$b"
+			;;
+		*)
+			rel=`echo $path | sed -e 's|[^/]*|..|g'`
+			rel_gitdir="$rel/$gitdir"
+			;;
+	esac
+
+	if test -d "$gitdir"
+	then
+		mkdir -p "$path"
+		echo "gitdir: $rel_gitdir" > "$path/.git"
+	else
+		if !(test -d "$gitdir_base")
+		then
+			mkdir -p "$gitdir_base"
+		fi
+		if test -n "$reference"
+		then
+			git-clone "$reference" -n "$url" "$path" --separate-git-dir "$gitdir"
+		else
+			git-clone -n "$url" "$path" --separate-git-dir "$gitdir"
+		fi ||
+		die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
+	fi
 }
 
 #
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b2b26b7..57f5306 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -358,10 +358,10 @@ test_expect_success 'update --init' '
 	git submodule update init > update.out &&
 	cat update.out &&
 	test_i18ngrep "not initialized" update.out &&
-	! test -d init/.git &&
+	! test -f init/.git &&
 
 	git submodule update --init init &&
-	test -d init/.git
+	test -n $(grep "/^gitdir: /" init/.git)
 '
 
 test_expect_success 'do not add files from a submodule' '
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index d600583..b0517f0 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -55,7 +55,7 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
 	 git pull --no-recurse-submodules &&
 	 git submodule sync
 	) &&
-	test -d "$(git config -f super-clone/submodule/.git/config \
+	test -d "$(git config -f super-clone/.git/modules/submodule/config \
 	                        remote.origin.url)" &&
 	(cd super-clone/submodule &&
 	 git checkout master &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index c679f36..32d9c59 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -442,4 +442,109 @@ test_expect_success 'submodule update exit immediately after recursive rebase er
 	 test_cmp expect actual
 	)
 '
+
+test_expect_success 'submodule add places git-dir in superprojects git-dir' '
+	(cd super &&
+	 mkdir deeper &&
+	 git submodule add ../submodule deeper/submodule &&
+	 (cd deeper/submodule &&
+	  git log > ../../expected
+	 ) &&
+	 (cd .git/modules/deeper/submodule &&
+	  git log > ../../../../actual
+	 ) &&
+	 test_cmp actual expected
+	)
+'
+
+test_expect_success 'submodule update places git-dir in superprojects git-dir' '
+	(cd super &&
+	 git commit -m "added submodule"
+	) &&
+	git clone super super2 &&
+	(cd super2 &&
+	 git submodule init deeper/submodule &&
+	 git submodule update &&
+	 (cd deeper/submodule &&
+	  git log > ../../expected
+	 ) &&
+	 (cd .git/modules/deeper/submodule &&
+	  git log > ../../../../actual
+	 ) &&
+	 test_cmp actual expected
+	)
+'
+
+test_expect_success 'submodule add places git-dir in superprojects git-dir recursive' '
+	(cd super2 &&
+	 (cd deeper/submodule &&
+	  git submodule add ../submodule subsubmodule &&
+	  (cd subsubmodule &&
+	   git log > ../../../expected
+	  ) &&
+	  git commit -m "added subsubmodule" &&
+	  git push
+	 ) &&
+	 (cd .git/modules/deeper/submodule/modules/subsubmodule &&
+	  git log > ../../../../../actual
+	 ) &&
+	 git add deeper/submodule &&
+	 git commit -m "update submodule" &&
+	 git push &&
+	 test_cmp actual expected
+	)
+'
+
+test_expect_success 'submodule update places git-dir in superprojects git-dir recursive' '
+	mkdir super_update_r &&
+	(cd super_update_r &&
+	 git init --bare
+	) &&
+	mkdir subsuper_update_r &&
+	(cd subsuper_update_r &&
+	 git init --bare
+	) &&
+	mkdir subsubsuper_update_r &&
+	(cd subsubsuper_update_r &&
+	 git init --bare
+	) &&
+	git clone subsubsuper_update_r subsubsuper_update_r2 &&
+	(cd subsubsuper_update_r2 &&
+	 test_commit "update_subsubsuper" file &&
+	 git push origin master
+	) &&
+	git clone subsuper_update_r subsuper_update_r2 &&
+	(cd subsuper_update_r2 &&
+	 test_commit "update_subsuper" file &&
+	 git submodule add ../subsubsuper_update_r subsubmodule &&
+	 git commit -am "subsubmodule" &&
+	 git push origin master
+	) &&
+	git clone super_update_r super_update_r2 &&
+	(cd super_update_r2 &&
+	 test_commit "update_super" file &&
+	 git submodule add ../subsuper_update_r submodule &&
+	 git commit -am "submodule" &&
+	 git push origin master
+	) &&
+	rm -rf super_update_r2 &&
+	git clone super_update_r super_update_r2 &&
+	(cd super_update_r2 &&
+	 git submodule update --init --recursive &&
+	 (cd submodule/subsubmodule &&
+	  git log > ../../expected
+	 ) &&
+	 (cd .git/modules/submodule/modules/subsubmodule
+	  git log > ../../../../../actual
+	 )
+	 test_cmp actual expected
+	)
+'
+
+test_expect_success 'add different submodules to the same path' '
+	(cd super &&
+	 git submodule add ../submodule s1 &&
+	 test_must_fail git submodule add ../merging s1
+	)
+'
 test_done
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index be745fb..3f498a3 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -118,19 +118,19 @@ test_expect_success 'use "submodule foreach" to checkout 2nd level submodule' '
 	git clone super clone2 &&
 	(
 		cd clone2 &&
-		test ! -d sub1/.git &&
-		test ! -d sub2/.git &&
-		test ! -d sub3/.git &&
-		test ! -d nested1/.git &&
+		test ! -f sub1/.git &&
+		test ! -f sub2/.git &&
+		test ! -f sub3/.git &&
+		test ! -f nested1/.git &&
 		git submodule update --init &&
-		test -d sub1/.git &&
-		test -d sub2/.git &&
-		test -d sub3/.git &&
-		test -d nested1/.git &&
-		test ! -d nested1/nested2/.git &&
+		test -n $(grep "/^gitdir: /" sub1/.git) &&
+		test -n $(grep "/^gitdir: /" sub2/.git) &&
+		test -n $(grep "/^gitdir: /" sub3/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/.git) &&
+		test ! -f nested1/nested2/.git &&
 		git submodule foreach "git submodule update --init" &&
-		test -d nested1/nested2/.git &&
-		test ! -d nested1/nested2/nested3/.git
+		test -n $(grep "/^gitdir: /" nested1/nested2/.git) &&
+		test ! -f nested1/nested2/nested3/.git
 	)
 '
 
@@ -138,8 +138,8 @@ test_expect_success 'use "foreach --recursive" to checkout all submodules' '
 	(
 		cd clone2 &&
 		git submodule foreach --recursive "git submodule update --init" &&
-		test -d nested1/nested2/nested3/.git &&
-		test -d nested1/nested2/nested3/submodule/.git
+		test -n $(grep "/^gitdir: /" nested1/nested2/nested3/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/nested2/nested3/submodule/).git
 	)
 '
 
@@ -183,18 +183,18 @@ test_expect_success 'use "update --recursive" to checkout all submodules' '
 	git clone super clone3 &&
 	(
 		cd clone3 &&
-		test ! -d sub1/.git &&
-		test ! -d sub2/.git &&
-		test ! -d sub3/.git &&
-		test ! -d nested1/.git &&
+		test ! -f sub1/.git &&
+		test ! -f sub2/.git &&
+		test ! -f sub3/.git &&
+		test ! -f nested1/.git &&
 		git submodule update --init --recursive &&
-		test -d sub1/.git &&
-		test -d sub2/.git &&
-		test -d sub3/.git &&
-		test -d nested1/.git &&
-		test -d nested1/nested2/.git &&
-		test -d nested1/nested2/nested3/.git &&
-		test -d nested1/nested2/nested3/submodule/.git
+		test -n $(grep "/^gitdir: /" sub1/.git) &&
+		test -n $(grep "/^gitdir: /" sub2/.git) &&
+		test -n $(grep "/^gitdir: /" sub3/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/nested2/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/nested2/nested3/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/nested2/nested3/submodule/).git
 	)
 '
 
@@ -248,13 +248,13 @@ test_expect_success 'ensure "status --cached --recursive" preserves the --cached
 test_expect_success 'use "git clone --recursive" to checkout all submodules' '
 	git clone --recursive super clone4 &&
 	test -d clone4/.git &&
-	test -d clone4/sub1/.git &&
-	test -d clone4/sub2/.git &&
-	test -d clone4/sub3/.git &&
-	test -d clone4/nested1/.git &&
-	test -d clone4/nested1/nested2/.git &&
-	test -d clone4/nested1/nested2/nested3/.git &&
-	test -d clone4/nested1/nested2/nested3/submodule/.git
+	test -n $(grep "/^gitdir: /" clone4/sub1/.git) &&
+	test -n $(grep "/^gitdir: /" clone4/sub2/.git) &&
+	test -n $(grep "/^gitdir: /" clone4/sub3/.git) &&
+	test -n $(grep "/^gitdir: /" clone4/nested1/.git) &&
+	test -n $(grep "/^gitdir: /" clone4/nested1/nested2/.git) &&
+	test -n $(grep "/^gitdir: /" clone4/nested1/nested2/nested3/.git) &&
+	test -n $(grep "/^gitdir: /" clone4/nested1/nested2/nested3/submodule/.git)
 '
 
 test_expect_success 'test "update --recursive" with a flag with spaces' '
@@ -262,14 +262,14 @@ test_expect_success 'test "update --recursive" with a flag with spaces' '
 	git clone super clone5 &&
 	(
 		cd clone5 &&
-		test ! -d nested1/.git &&
+		test ! -f nested1/.git &&
 		git submodule update --init --recursive --reference="$(dirname "$PWD")/common objects" &&
-		test -d nested1/.git &&
-		test -d nested1/nested2/.git &&
-		test -d nested1/nested2/nested3/.git &&
-		test -f nested1/.git/objects/info/alternates &&
-		test -f nested1/nested2/.git/objects/info/alternates &&
-		test -f nested1/nested2/nested3/.git/objects/info/alternates
+		test -n $(grep "/^gitdir: /" nested1/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/nested2/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/nested2/nested3/.git) &&
+		test -f .git/modules/nested1/objects/info/alternates &&
+		test -f .git/modules/nested1/modules/nested2/objects/info/alternates &&
+		test -f .git/modules/nested1/modules/nested2/modules/nested3/objects/info/alternates
 	)
 '
 
@@ -277,18 +277,18 @@ test_expect_success 'use "update --recursive nested1" to checkout all submodules
 	git clone super clone6 &&
 	(
 		cd clone6 &&
-		test ! -d sub1/.git &&
-		test ! -d sub2/.git &&
-		test ! -d sub3/.git &&
-		test ! -d nested1/.git &&
+		test ! -f sub1/.git &&
+		test ! -f sub2/.git &&
+		test ! -f sub3/.git &&
+		test ! -f nested1/.git &&
 		git submodule update --init --recursive -- nested1 &&
-		test ! -d sub1/.git &&
-		test ! -d sub2/.git &&
-		test ! -d sub3/.git &&
-		test -d nested1/.git &&
-		test -d nested1/nested2/.git &&
-		test -d nested1/nested2/nested3/.git &&
-		test -d nested1/nested2/nested3/submodule/.git
+		test ! -f sub1/.git &&
+		test ! -f sub2/.git &&
+		test ! -f sub3/.git &&
+		test -n $(grep "/^gitdir: /" nested1/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/nested2/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/nested2/nested3/.git) &&
+		test -n $(grep "/^gitdir: /" nested1/nested2/nested3/submodule/.git)
 	)
 '
 
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index cc16d3f..ab37c36 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -43,7 +43,7 @@ git commit -m B-super-added'
 cd "$base_dir"
 
 test_expect_success 'after add: existence of info/alternates' \
-'test `wc -l <super/sub/.git/objects/info/alternates` = 1'
+'test `wc -l <super/.git/modules/sub/objects/info/alternates` = 1'
 
 cd "$base_dir"
 
@@ -66,7 +66,7 @@ test_expect_success 'update with reference' \
 cd "$base_dir"
 
 test_expect_success 'after update: existence of info/alternates' \
-'test `wc -l <super-clone/sub/.git/objects/info/alternates` = 1'
+'test `wc -l <super-clone/.git/modules/sub/objects/info/alternates` = 1'
 
 cd "$base_dir"
 
-- 
1.7.6.132.ga34b5.dirty
