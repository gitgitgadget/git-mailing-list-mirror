From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v4] [submodule] Add --depth to submodule update/add
Date: Tue,  2 Jul 2013 20:08:50 +0200
Message-ID: <1372788530-19760-1-git-send-email-iveqy@iveqy.com>
References: <51D311F2.1030009@web.de>
Cc: jens.lehmann@web.de, hvoigt@hvoigt.net, gitster@pobox.com,
	git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Tue Jul 02 20:08:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu50W-0004a5-2K
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 20:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab3GBSIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 14:08:47 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:44046 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab3GBSIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 14:08:46 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so5927795lab.4
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5Rmbywt9O7STpnXhMkrd4dQICOr4/IMtC7bIXdMVgjU=;
        b=nuhmlNO0/l8Nzl5kw4qlzvMW1dYX3Dece6X7aCS9DtAZoF5G6UlN/ho/Wt4AtRaPWv
         4k389NwWnSiE0BT5kj4Dqf++km73STGgeIYnHUlv0LAoXjVnRmRPfPg5Y+W53reTczuk
         yWsaBrSt9i/IpfkRsSTUmSUKIlllTRS7TE7LNN0qEPTGOdLkoE5fUpbI7LgbXQmjoMuQ
         lKOGJhI92iR2CBPAQMyATO4iT+c/OCTWUFyH1DnAZv5bnHSdWXvHa5FDxPvWJwVEMhF9
         gmKtcAheoZsvk7r13OUCCS1rEwjIvWu1brfd0KTutagpDB1kJpHue9niT8BA4p2ZhUeP
         HkPw==
X-Received: by 10.112.211.167 with SMTP id nd7mr14553025lbc.59.1372788524733;
        Tue, 02 Jul 2013 11:08:44 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id t15sm9228416lbh.16.2013.07.02.11.08.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jul 2013 11:08:44 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Uu50V-00059I-JO; Tue, 02 Jul 2013 20:08:51 +0200
X-Mailer: git-send-email 1.8.3.1.490.g39d9b24.dirty
In-Reply-To: <51D311F2.1030009@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229412>

Add the --depth option to the add and update commands of "git submodule",
which is then passed on to the clone command. This is useful when the
submodule(s) are huge and you're not really interested in anything but
the latest commit.

Tests are added and to make --depth work the path for test "setup a submodule
tree" had to be modified. Also did some indent adjustments to conform to the
rest of the testfile on "submodule update can handle symbolic links in pwd".

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---

> The first line of the commit message still sounds strange to me, please see
> my answer in the thread you quoted.
>
> Also the documentation still talks about --clone-depth.

Sorry about that, it's fixed in this patch

> The assignment to reference right above that is quoted like that too. I wonder
> if we should also use ${depth:+"$depth"} as argument to clone.

I don't have any opinion about this. I guess it works the way it is, I just don't
understand it according to the shell-syntax I know.

If we should fix it, perhaps fix it in an other patch together with $reference?

 Documentation/git-submodule.txt | 10 ++++++++--
 git-submodule.sh                | 24 +++++++++++++++++++++---
 t/t7400-submodule-basic.sh      | 15 +++++++++++++++
 t/t7406-submodule-update.sh     | 24 +++++++++++++++++-------
 4 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e576713..77a052a 100644
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
 
+--depth::
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
