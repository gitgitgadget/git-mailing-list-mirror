From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH RFC] git-submodule: multi-level module support
Date: Sun,  2 Mar 2008 00:23:54 +0800
Message-ID: <1204388634-757-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 17:24:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVUVq-0006zV-LH
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 17:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763143AbYCAQYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 11:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763119AbYCAQYA
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 11:24:00 -0500
Received: from mail.qikoo.org ([60.28.205.235]:43092 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763099AbYCAQX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 11:23:59 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 81BDA470AE; Sun,  2 Mar 2008 00:23:54 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75683>

This patch allows multi-level modules in .gitmodules as linus
and Sven Verdoolaege etc. have suggested in mails
"Let .git/config specify the url for submodules"
(http://article.gmane.org/gmane.comp.version-control.git/48939).

Example multi-level .gitmodules
-----------------------------------------------
[submodule 'a']
	url = aurl
[submodule 'b']
	url = aurl
[submodule 'c']
	url = aurl
[submodule "all"]
	submodule = all1
	submodule = all2
[submodule "all1"]
	submodule = a
	submodule = b
[submodule "all2"]
	submodule = c
-----------------------------------------------

An option '-m|--module-name' is introduced to designate submodule
by logical module names instead of module paths. So follwoing
commands pairs (1,2), (3,4) will be equivalent.

--------------------------------------
$ git submodule a b c           (1)
$ git submodule -m all          (2)
$ git submodule init a b        (3)
$ git submodule -m init all1    (4)
--------------------------------------

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..4359e53 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -13,6 +13,7 @@ command=
 branch=
 quiet=
 cached=
+use_module_name=
 
 #
 # print stuff on stdout unless -q was specified
@@ -81,6 +82,44 @@ module_name()
 }
 
 #
+# Map submodule names to path(s)
+# $@ = module names
+#
+module_name2path() {
+	while test $# != 0
+	do
+		local name=$1
+		shift
+		local paths=$( GIT_CONFIG=.gitmodules \
+			git config --get-all submodule.$name.submodule |
+			while read name
+			do
+				module_name2path $name
+			done
+			git config --get-all submodule.$name.path
+		)
+		if test -z "$paths"
+		then
+			git config --get-all submodule.$name.url >/dev/null &&
+			echo $name
+		else
+			echo "$paths"
+		fi
+	done
+}
+
+module_path() {
+	if test -n "$use_module_name"
+	then
+		paths=$(module_name2path "$@")
+		test -z "$paths" && die "no path for modules: $@"
+	else
+		paths=$@
+	fi
+	echo $paths
+}
+
+#
 # Clone a submodule
 #
 # Prior to calling, cmd_update checks that a possibly existing
@@ -220,7 +259,9 @@ cmd_init()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	mpaths=$(module_path "$@") || exit
+
+	git ls-files --stage -- $mpaths | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
 		# Skip already registered paths
@@ -274,7 +315,9 @@ cmd_update()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	mpaths=$(module_path "$@") || exit
+
+	git ls-files --stage -- $mpaths | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
 		name=$(module_name "$path") || exit
@@ -357,7 +400,9 @@ cmd_status()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	mpaths=$(module_path "$@") || exit
+
+	git ls-files --stage -- $mpaths | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
 		name=$(module_name "$path") || exit
@@ -408,6 +453,9 @@ do
 	--cached)
 		cached=1
 		;;
+	-m|--module-name)
+		use_module_name=1
+		;;
 	--)
 		break
 		;;
-- 
1.5.4.3.347.g5314c

