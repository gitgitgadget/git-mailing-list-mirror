From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v3] [submodule] Add --depth to submodule update/add
Date: Tue,  2 Jul 2013 03:39:27 +0200
Message-ID: <1372729167-23200-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, jens.lehmann@web.de, hvoigt@hvoigt.net,
	git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Tue Jul 02 03:39:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtpZB-00020E-Mw
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 03:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab3GBBjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 21:39:33 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:53797 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648Ab3GBBjc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 21:39:32 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so5056132lab.11
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 18:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=61QGRmcqKZetz66eJrM/1G8L3WzNP9+6ykSd4V91KuA=;
        b=x8EL8DgVhsxPBxt8rw262Q77GHpcUuxlXhiI/oaI1opy3BhD7oMiYY8IKdBxQonT/e
         OKj4gLhfrsZabV4H1XaowSI9cQTqsCdrn97lAcwPgZYI+Z/hvP5T8BD02qi6CfRja08z
         sWQIib7o5RKyDn0Isu396wNmdod2L2bLJjxc9rbv178OVPYsppF5HCKV0phjoUjhiktO
         LfkvOE1nqFXZa7/Yep52id1inZuXRJeG4qoa8xqRtWN/L3a9mxT/2P9BShyjkRUqfRwf
         Lv+Mc2+xi/ZLn3pkNEx3aR0KxAOyCJngZOs3620H3Mw5R3ThgR5G7SlcSlkngmFfkYiU
         Qkzg==
X-Received: by 10.152.87.15 with SMTP id t15mr12702955laz.85.1372729170419;
        Mon, 01 Jul 2013 18:39:30 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id b8sm8169022lah.0.2013.07.01.18.39.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jul 2013 18:39:29 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UtpZ7-00062m-Nu; Tue, 02 Jul 2013 03:39:33 +0200
X-Mailer: git-send-email 1.8.3.1.490.g39d9b24.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229354>

When a submodule is clone, clone it width the --depth flag. This is useful
when the submodule(s) are huge and you're not really interested in anything
but the latest commit.

Tests are added and to make --depth work the path for test "setup a submodule
tree" had to be modified. Also did some indent adjustments to conform to the
rest of the testfile on "submodule update can handle symbolic links in pwd".

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---

The previous iteration can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/229196/

This was actually a bit tricky. When I changed
git clone $depth
to
git clone "$depth"

git clone dies with the error "too many arguments". This was solved with changing
depth=$5
to
depth="$5"

which I don't understand since variable assignment doesn't expand $5 and therefore
"" should not be needed, AFAIK. Any comments on this?

An other note:
file:// accepts relative paths but don't handle them well at all. For example in the
test t7406-submodule-update.sh:
git clone file://cloned super3
will work, but submodules and push/fetch will be "broken", since the paths will
be wrong.

 Documentation/git-submodule.txt | 10 ++++++++--
 git-submodule.sh                | 24 +++++++++++++++++++++---
 t/t7400-submodule-basic.sh      | 15 +++++++++++++++
 t/t7406-submodule-update.sh     | 24 +++++++++++++++++-------
 4 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e576713..9876c7c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -10,12 +10,12 @@ SYNOPSIS
 --------
 [verse]
 'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
-	      [--reference <repository>] [--] <repository> [<path>]
+	      [--reference <repository>] [--clone-depth <depth>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [-f|--force] [--rebase] [--reference <repository>]
+	      [-f|--force] [--rebase] [--reference <repository>] [--clone-depth <depth>]
 	      [--merge] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
@@ -328,6 +328,12 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
 
+--clone-depth::
+	This option is valid for add and update commands. Create a 'shallow'
+	clone with a history truncated to the specified number of revisions.
+	See linkgit:git-clone[1]
+
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..1cfe2bf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -32,6 +32,7 @@ nofetch=
 update=
 prefix=
 custom_name=
+depth=
 
 # The function takes at most 2 arguments. The first argument is the
 # URL that navigates to the submodule origin repo. When relative, this URL
@@ -211,6 +212,7 @@ module_clone()
 	name=$2
 	url=$3
 	reference="$4"
+	depth="$5"
 	quiet=
 	if test -n "$GIT_QUIET"
 	then
@@ -233,7 +235,7 @@ module_clone()
 		mkdir -p "$gitdir_base"
 		(
 			clear_local_git_env
-			git clone $quiet -n ${reference:+"$reference"} \
+			git clone $quiet $depth -n ${reference:+"$reference"} \
 				--separate-git-dir "$gitdir" "$url" "$sm_path"
 		) ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
@@ -309,6 +311,14 @@ cmd_add()
 			custom_name=$2
 			shift
 			;;
+		--depth)
+			case "$2" in '') usage ;; esac
+			depth="--depth=$2"
+			shift
+			;;
+		--depth=*)
+			depth=$1
+			;;
 		--)
 			shift
 			break
@@ -405,7 +415,7 @@ Use -f if you really want to add it." >&2
 				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
 			fi
 		fi
-		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" || exit
+		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
 		(
 			clear_local_git_env
 			cd "$sm_path" &&
@@ -676,6 +686,14 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		--depth)
+			case "$2" in '') usage ;; esac
+			depth="--depth=$2"
+			shift
+			;;
+		--depth=*)
+			depth=$1
+			;;
 		--)
 			shift
 			break
@@ -735,7 +753,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" || exit
+			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index f47cc7b..bfd1ce9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -868,4 +868,19 @@ test_expect_success 'submodule deinit fails when submodule has a .git directory
 	test -n "$(git config --get-regexp "submodule\.example\.")"
 '
 
+test_expect_success 'submodule add clone shallow submodule' '
+	mkdir super &&
+	pwd=$(pwd)
+	(
+		cd super &&
+		git init &&
+		git submodule add --depth=1 file://"$pwd"/example2 submodule &&
+		(
+			cd submodule &&
+			test 1 = $(git log --oneline | wc -l)
+		)
+	)
+'
+
+
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index a4ffea0..e0a06e2 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -685,14 +685,24 @@ test_expect_success 'submodule update properly revives a moved submodule' '
 test_expect_success SYMLINKS 'submodule update can handle symbolic links in pwd' '
 	mkdir -p linked/dir &&
 	ln -s linked/dir linkto &&
-	(
-		cd linkto &&
-		git clone "$TRASH_DIRECTORY"/super_update_r2 super &&
-		(
-			cd super &&
-			git submodule update --init --recursive
-		)
+	(cd linkto &&
+	 git clone "$TRASH_DIRECTORY"/super_update_r2 super &&
+	 (cd super &&
+	  git submodule update --init --recursive
+	 )
 	)
 '
 
+test_expect_success 'submodule update clone shallow submodule' '
+	git clone cloned super3 &&
+	pwd=$(pwd)
+	(cd super3 &&
+	 sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
+	 mv -f .gitmodules.tmp .gitmodules &&
+	 git submodule update --init --depth=3
+	 (cd submodule &&
+	  test 1 = $(git log --oneline | wc -l)
+	 )
+	)
+'
 test_done
-- 
1.8.3.1.490.g39d9b24.dirty
