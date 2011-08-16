From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v5 2/2] Move git-dir for submodules
Date: Tue, 16 Aug 2011 21:32:19 +0200
Message-ID: <1313523139-23244-3-git-send-email-iveqy@iveqy.com>
References: <1313523139-23244-1-git-send-email-iveqy@iveqy.com>
Cc: jens.lehmann@web.de, iveqy@iveqy.com, hvoigt@hvoigt.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 21:32:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtPNB-0008LV-Ms
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 21:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab1HPTcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 15:32:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54747 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab1HPTcS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 15:32:18 -0400
Received: by bke11 with SMTP id 11so178019bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pZCmoPXekkO+u5zKrSgMW5T379Npd+vZfjhAyJXfYFg=;
        b=DDR1EBBWf0wYgb1/DpgAkg6OmxQu6pmLKo/RJyUe95na/wizmTiYDc5mM4N95Ne3d/
         /g2uJfRr5OjlisJ2nbAThnlNJ1esRnAN8F3GoOCiVm5+tCzq4Jv26HSAImSrhOBFEaf6
         7wTNszSsYXAirOfV/eAbobv5WR2oGYjjhKjwo=
Received: by 10.204.170.1 with SMTP id b1mr31391bkz.310.1313523136520;
        Tue, 16 Aug 2011 12:32:16 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id a3sm129784bkd.2.2011.08.16.12.32.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 12:32:11 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QtPN6-000648-Mu; Tue, 16 Aug 2011 21:32:20 +0200
X-Mailer: git-send-email 1.7.6.398.g43b167
In-Reply-To: <1313523139-23244-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179472>

Move git-dir for submodules into $GIT_DIR/modules/[name_of_submodule] of
the superproject. This is a step towards being able to delete submodule
directories without loosing the information from their .git directory
as that is now stored outside the submodules work tree.

This is done relying on the already existent .git-file functionality.
When adding or updating a submodule whose git directory is found under
$GIT_DIR/modules/[name_of_submodule], don't clone it again but simply
point the .git-file to it and remove the now stale index file from it.
The index will be recreated by the following checkout.

This patch will not affect already cloned submodules at all.

Tests that rely on .git being a directory have been fixed.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-submodule.sh               |   45 +++++++++++++++--
 t/t7406-submodule-update.sh    |  107 ++++++++++++++++++++++++++++++++++++++++
 t/t7408-submodule-reference.sh |    4 +-
 3 files changed, 149 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bc1d3fa..7576d14 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -122,14 +122,49 @@ module_clone()
 	path=$1
 	url=$2
 	reference="$3"
+	gitdir=
+	gitdir_base=
+	name=$(module_name "$path")
+	base_path=$(dirname "$path")
 
-	if test -n "$reference"
+	gitdir=$(git rev-parse --git-dir)
+	gitdir_base="$gitdir/modules/$base_path"
+	gitdir="$gitdir/modules/$path"
+
+	case $gitdir in
+	/*)
+		a="$(cd_to_toplevel && pwd)/"
+		b=$gitdir
+		while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
+		do
+			a=${a#*/} b=${b#*/};
+		done
+
+		rel="$a$name"
+		rel=`echo $rel | sed -e 's|[^/]*|..|g'`
+		rel_gitdir="$rel/$b"
+		;;
+	*)
+		rel=`echo $name | sed -e 's|[^/]*|..|g'`
+		rel_gitdir="$rel/$gitdir"
+		;;
+	esac
+
+	if test -d "$gitdir"
 	then
-		git-clone "$reference" -n "$url" "$path"
+		mkdir -p "$path"
+		echo "gitdir: $rel_gitdir" >"$path/.git"
+		rm -f "$gitdir/index"
 	else
-		git-clone -n "$url" "$path"
-	fi ||
-	die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
+		mkdir -p "$gitdir_base"
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
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index c679f36..1ae6b4e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -408,6 +408,7 @@ test_expect_success 'submodule update exit immediately in case of merge conflict
 	 test_cmp expect actual
 	)
 '
+
 test_expect_success 'submodule update exit immediately after recursive rebase error' '
 	(cd super &&
 	 git checkout master &&
@@ -442,4 +443,110 @@ test_expect_success 'submodule update exit immediately after recursive rebase er
 	 test_cmp expect actual
 	)
 '
+
+test_expect_success 'add different submodules to the same path' '
+	(cd super &&
+	 git submodule add ../submodule s1 &&
+	 test_must_fail git submodule add ../merging s1
+	)
+'
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
 test_done
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
1.7.6.398.g43b167
