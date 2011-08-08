From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v2 2/2] Move git-dir for submodules
Date: Mon,  8 Aug 2011 21:17:02 +0200
Message-ID: <1312831022-12868-3-git-send-email-iveqy@iveqy.com>
References: <1312831022-12868-1-git-send-email-iveqy@iveqy.com>
Cc: iveqy@iveqy.com, jens.lehmann@web.de, hvoigt@hvoigt.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 21:17:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqVJu-0002R5-Pe
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 21:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799Ab1HHTQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 15:16:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33875 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab1HHTQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 15:16:56 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so5667069fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HOZJtzKo/TxX/vS9VfunMQBLzd6uNXihCANYM6XSW10=;
        b=eWMBrGGZv7evmeqt7M6N6M0a7KFJalrWoaPSMlssIDMqNGLuKA4NDEYMGHQ5ZF1aGm
         LRm/SYFSniFv0B5mO7+Yd1Sc2sMXBY8OSHDFtVIiWosXxuRZI0KuLOz4gP0rNx7AASed
         2JplFbZopG59jPOBxlgOofUuUNGmBsCjswt9k=
Received: by 10.204.22.15 with SMTP id l15mr1613694bkb.408.1312831015923;
        Mon, 08 Aug 2011 12:16:55 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id x19sm1726228bkt.42.2011.08.08.12.16.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 12:16:51 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QqVJw-0003MD-KV; Mon, 08 Aug 2011 21:17:04 +0200
X-Mailer: git-send-email 1.7.6.398.g47bcd.dirty
In-Reply-To: <1312831022-12868-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178971>

Move git-dir for submodules into $GIT_DIR/modules/[name_of_submodule] of
the superproject. This is a step towards being able to delete submodule
directories without loosing the information from their .git directory
as that is now stored outside the submodules work tree.

This is done relying on the already existent .git-file functionality.
When adding or updating a submodule whose git directory is found under
$GIT_DIR/modules/[name_of_submodule], don't clone it again but simply
point the .git-file to it and remove the now stale index file from it.

Tests that rely on .git being a directory have been fixed.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-submodule.sh               |   49 ++++++++++++++++--
 t/t7406-submodule-update.sh    |  107 ++++++++++++++++++++++++++++++++++++++++
 t/t7407-submodule-foreach.sh   |    6 +-
 t/t7408-submodule-reference.sh |    4 +-
 4 files changed, 156 insertions(+), 10 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bc1d3fa..ace6c1d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -122,14 +122,53 @@ module_clone()
 	path=$1
 	url=$2
 	reference="$3"
+	gitdir=
+	gitdir_base=
+	name=$(module_name "$path")
+	if test -z "$name"
+	then
+		name="$path"
+	fi
+	base_path=$(dirname "$path")
+
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
 
-	if test -n "$reference"
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
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 1a974e2..e410bd4 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -270,9 +270,9 @@ test_expect_success 'test "update --recursive" with a flag with spaces' '
 		git rev-parse --is-well-formed-git-dir nested1/.git &&
 		git rev-parse --is-well-formed-git-dir nested1/nested2/.git &&
 		git rev-parse --is-well-formed-git-dir nested1/nested2/nested3/.git &&
-		test -f nested1/.git/objects/info/alternates &&
-		test -f nested1/nested2/.git/objects/info/alternates &&
-		test -f nested1/nested2/nested3/.git/objects/info/alternates
+		test -f .git/modules/nested1/objects/info/alternates &&
+		test -f .git/modules/nested1/modules/nested2/objects/info/alternates &&
+		test -f .git/modules/nested1/modules/nested2/modules/nested3/objects/info/alternates
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
1.7.6.398.g47bcd.dirty
