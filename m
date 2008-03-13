From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 6/7] git-submodule: multi-level module definition
Date: Fri, 14 Mar 2008 01:56:40 +0800
Message-ID: <1205431001-18590-7-git-send-email-pkufranky@gmail.com>
References: <1205431001-18590-1-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-2-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-3-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-4-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-5-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-6-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 18:58:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrhD-0002de-Dy
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbYCMR44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 13:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbYCMR4z
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:56:55 -0400
Received: from mail.qikoo.org ([60.28.205.235]:43777 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757125AbYCMR4q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:56:46 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 5701F470B3; Fri, 14 Mar 2008 01:56:41 +0800 (CST)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e
In-Reply-To: <1205431001-18590-6-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77111>

This patch introduces multi-level module definition and '--module-name'
option to designate submodules by logical names instead of path filters.
Then the init/update/status/add subcommand is enhanced combined with
this option.

The multi-level module definition in .gitmodules was first suggested by
Linus and etc. in mails "Let .git/config specify the url for submodules"
(http://article.gmane.org/gmane.comp.version-control.git/48939).

Following shows an example of such a .gitmodules which finally comes
from the group notation of 'git remote' which is suggested by Johannes
Schindelin.

.gitmodules with multiple level of indirection
------------------------------------------------------
[submodules]
	service = crawler search
	crawler = util imcrawter
	search = util imsearch
[submodule "util"]
	url = git://xyzzy/util.git
[submodule "imsearch"]
	path = search/imsearch
	url = git://xyzzy/imsearch.git
[submodule "imcrawler"]
	path = crawler/imcrawter
	url = git://xyzzy/imcrawter.git
------------------------------------------------------

By adding the 'submodules' section, we can define multi-level modules
in an infinite levels of indirection.

The "-m|--module-name" option is introduced with which submodules are
designated by logical names instead of real paths as following shows.

Identical commands forms with/without "--module-name"
---------------------------------------------------
$ git submodule XXX util imcrawler              (1)
$ git submodule XXX -n crawler                  (2)
$ git submodule XXX util imcrawler imsearch     (3)
$ git submodule XXX -n service                  (4)
$ git submodule XXX -n crawler search           (5)
---------------------------------------------------
* XXX represents status, update or init, but not add
* (1) and (2) are identical conditionally (explained below)
* (3), (4) and (5) are identical conditionally

There are still minor difference between these two forms.

In the no "--module-name" form, the path parameter may be not the real
submodule path, and it just acts as the filter for real submodule paths.
While in the "--module-name" form, the name parameter must be the logical
name, and the real paths corresponding to the logical name may be neither
a submodule path nor even existent.

This patch handles such a path for different subcommands as follows.

 - status: Output 0{40} as the sha1. Doing this can remind the user to
   add the path as submodule or delete the path from .gitmodules.
 - update: Skip that path and issue a "Not a submodule" warning
 - init: Also init for that path

So in the example above, commands (1) and (2) are identical only when
util and imcrawler are already submodules.

The add subcommand is also enhanced.

The former workflow to add submodules is adding one by one with
"git submodule add url path" which then modifies .gitmodules. However,
sometimes it is more convenient to work in the reverse way: edit
.gitmodules first and then add submodules in batch.

Now "git submodule add --module-name modulename" can help us to do that.
It will find all submodules corresponding to the logical name and add them
in batch by using the paths and urls from .gitmodules. Of course, it will
skip the paths which have already been submodules.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index dacd99a..79fb30f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,7 +4,7 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE="[--quiet] [--cached] \
+USAGE="[--quiet] [--cached] [--module-name] \
 [add <repo> [-b branch]|status|init|update|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]"
 OPTIONS_SPEC=
@@ -15,6 +15,7 @@ command=
 branch=
 quiet=
 cached=
+use_module_name=
 
 #
 # print stuff on stdout unless -q was specified
@@ -97,12 +98,23 @@ module_name()
        echo "$name"
 }
 
+module_path() {
+	git config submodule.$1.path ||
+	GIT_CONFIG=.gitmodules git config submodule.$1.path ||
+	echo "$1"
+}
+
 module_url() {
 	git config submodule.$1.url ||
 	GIT_CONFIG=.gitmodules git config submodule.$1.url
 }
 
 module_info() {
+	if test -n "$use_module_name"
+	then
+		module_info_by_name "$@"
+		return
+	fi
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
@@ -118,6 +130,50 @@ module_info() {
 }
 
 #
+# List all submodule info line by line by given names as follows
+# sha1<tab>path<tab>name<tab>url
+#
+# Here we assume that module names and paths don't contain space
+# characters
+#
+# $@ = module names
+# When names is not given, list all module info
+#
+module_info_by_name() {
+	if test $# = 0
+	then
+		names=$(
+		{
+			git config --get-regexp 'submodule.*.url'
+			git config -f .gitmodules --get-regexp 'submodule.*.url'
+		} | sed 's/submodule.\(.*\).url .*$/\1/' 2>/dev/null
+		)
+	else
+		names=$(module_children_names "$@")
+	fi
+	for name in $names
+	do
+		url=$(module_url "$name") || continue
+		path=$(module_path "$name")
+		sha1=$(git ls-files --stage "$path" |
+			grep "$path$" | grep '^160000' | awk '{print $2}')
+		test -z "$sha1" && sha1=0000000000000000000000000000000000000000
+		echo "$sha1	$path	$name	$url"
+	done
+}
+
+module_children_names() {
+	for name
+	do
+		echo "$name"
+		module_children_names $(
+			git config "submodules.$name"
+			git config -f .gitmodules "submodules.$name"
+		)
+	done | sort -u
+}
+
+#
 # Clone a submodule
 #
 # Prior to calling, cmd_update checks that a possibly existing
@@ -233,7 +289,17 @@ cmd_add()
 		shift
 	done
 
-	module_add "$1" "$2"
+	if test -n "$use_module_name"
+	then
+		module_info "$@" |
+		while read sha1 path name url
+		do
+			module_add "$url" "$path"
+		done
+	else
+		module_add "$1" "$2"
+	fi
+
 }
 
 #
@@ -313,7 +379,11 @@ cmd_update()
 	while read sha1 path name url
 	do
 		test -n "$name" || exit
-		if test -z "$url"
+		if test $sha1 = 0000000000000000000000000000000000000000
+		then
+			say "Not a submodule: $name @ $path"
+			continue
+		elif test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
 			# path have been specified
@@ -558,12 +628,15 @@ cmd_status()
 		esac
 		shift
 	done
-
 	module_info "$@" |
 	while read sha1 path name url
 	do
 		test -n "$name" || exit
-		if test -z "$url" || ! test -d "$path"/.git
+		if test $sha1 = 0000000000000000000000000000000000000000
+		then
+			say "*$sha1 $path"
+			continue
+		elif test -z "$url" || ! test -d "$path"/.git
 		then
 			say "-$sha1 $path"
 			continue;
@@ -609,6 +682,9 @@ do
 	--cached)
 		cached="$1"
 		;;
+	-m|--module-name)
+		use_module_name=1
+		;;
 	--)
 		break
 		;;
-- 
1.5.4.4.653.g7cf1e
