From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v2] [submodule] Add --depth to submodule update/add
Date: Fri, 28 Jun 2013 15:22:26 +0200
Message-ID: <1372425746-11513-1-git-send-email-iveqy@iveqy.com>
Cc: hvoigt@hvoigt.net, jens.lehmann@web.de, gitster@pobox.com,
	git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Fri Jun 28 15:22:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsYde-0007ty-Lb
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 15:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab3F1NWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 09:22:54 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:37636 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab3F1NWy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 09:22:54 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so1040072lbc.31
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=wUpI5icONyOO7/WfefSFfJZTT1qvDQGxf+aTLkxrlzI=;
        b=Ry0IMSPwXvGX5JEixwJaODqlDP7RHkJA794PgJOLioVpyRjAwbO1B8qEkcnv2Hn8Rw
         /G8CT7+kTfB5Hu8tAt2MpA13YgvAaylZQh3xWKFSNKZMbqiJnuv209ajnCXr9B4mNPNZ
         Fbco4HqIppZR+9HAm+IoN61JEoeBVZkXPa60w+/NYmvjOgeLPDE3txpLRA796LsvFU+p
         B0JD7TcFCzoaLsBUZUqKsjJTdzts3zarmLGXQumUUq+iFVXDaM567rgnO7IW1QDaTmAu
         cSO4JC93RRueYEDPw5+BjpdEREBcS9YtW3f96xySfJLmAoC1LJakDPoC3sWFoQiPTYfw
         TGww==
X-Received: by 10.112.142.66 with SMTP id ru2mr6729539lbb.7.1372425772353;
        Fri, 28 Jun 2013 06:22:52 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id et10sm2683404lbc.6.2013.06.28.06.22.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 06:22:51 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UsYdC-00030H-2s; Fri, 28 Jun 2013 15:22:30 +0200
X-Mailer: git-send-email 1.8.3.1.489.gbc4ad7e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229196>

When a submodule is clone, clone it width the --depth flag. This is useful
when the submodule(s) are huge and you're not really interested in anything
but the latest commit.

Tests are added and to make --depth work the path for test "setup a submodule
tree" had to be modified. Also did some indent adjustments to conform to the
rest of the testfile on "submodule update can handle symbolic links in pwd".

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 Documentation/git-submodule.txt | 13 +++++++++++--
 git-submodule.sh                | 24 +++++++++++++++++++++---
 t/t7400-submodule-basic.sh      | 18 ++++++++++++++++++
 t/t7406-submodule-update.sh     | 28 ++++++++++++++++++++--------
 4 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e576713..b17001a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -10,12 +10,12 @@ SYNOPSIS
 --------
 [verse]
 'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
-	      [--reference <repository>] [--] <repository> [<path>]
+	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [-f|--force] [--rebase] [--reference <repository>]
+	      [-f|--force] [--rebase] [--reference <repository>] [--depth <depth>]
 	      [--merge] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
@@ -328,6 +328,15 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
 
+--depth::
+	This option is valid for add and update commands. Create a 'shallow'
+	clone with a history truncated to the specified number of revisions.
+	A shallow repository has a number of limitations (you cannot clone
+	or fetch from it, nor push from nor into it), but is adequate if
+	you are only interested in the recent history of a large project
+	with a long history.
+
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..c99bc7c 100755
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
+	depth=$5
 	quiet=
 	if test -n "$GIT_QUIET"
 	then
@@ -234,7 +236,7 @@ module_clone()
 		(
 			clear_local_git_env
 			git clone $quiet -n ${reference:+"$reference"} \
-				--separate-git-dir "$gitdir" "$url" "$sm_path"
+				--separate-git-dir "$gitdir" $depth "$url" "$sm_path"
 		) ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
 	fi
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
+			depth="$1"
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
+			depth="$1"
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
index f47cc7b..4502320 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -868,4 +868,22 @@ test_expect_success 'submodule deinit fails when submodule has a .git directory
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
+			if test $(git log --oneline | wc -l) != 1
+			then
+				exit 1
+			fi
+		)
+	)
+'
+
+
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index a4ffea0..b2d0f0e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -31,8 +31,9 @@ test_expect_success 'setup a submodule tree' '
 	git clone super rebasing &&
 	git clone super merging &&
 	git clone super none &&
+	pwd=$(pwd)
 	(cd super &&
-	 git submodule add ../submodule submodule &&
+	 git submodule add file:///"$pwd"/submodule submodule &&
 	 test_tick &&
 	 git commit -m "submodule" &&
 	 git submodule init submodule
@@ -685,14 +686,25 @@ test_expect_success 'submodule update properly revives a moved submodule' '
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
+	(cd super3 &&
+	 git submodule init &&
+	 git submodule update --depth=3 &&
+	 (cd submodule &&
+	  if test $(git log --oneline | wc -l) != 1
+	  then
+	   exit 1
+	  fi
+	 )
+	)
+'
 test_done
-- 
1.8.3.1.489.gbc4ad7e.dirty
