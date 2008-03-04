From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Wed,  5 Mar 2008 00:04:21 +0800
Message-ID: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 17:06:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZdy-0005qi-Rn
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760964AbYCDQE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760309AbYCDQE0
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:04:26 -0500
Received: from mail.qikoo.org ([60.28.205.235]:49665 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759506AbYCDQEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:04:25 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id D25B6470AF; Wed,  5 Mar 2008 00:04:21 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76108>

This patch allows multi-level module definition in .gitmodules as
Linus and Sven Verdoolaege etc. have suggested in mails
"Let .git/config specify the url for submodules"
(http://article.gmane.org/gmane.comp.version-control.git/48939).

Following shows an example of such a .gitmodules.

.gitmodules with with multiple level of indirection
------------------------------------------------------
[submodule "service"]
   submodule = crawler
   submodule = search
[submodule "crawler"]
   submodule = util
   submodule = imcrawter
[submodule "search"]
   submodule = util
   submodule = imsearch
[submodule "util"]
   url = git://xyzzy/util.git
[submodule "imsearch"]
   path = search/imsearch
   url = git://xyzzy/imsearch.git
[submodule "imcrawler"]
   path = crawler/imcrawter
   url = git://xyzzy/imcrawter.git
------------------------------------------------------

To simplify the case, submodule sections with submodule attribute should
have neither path attribute nor url attribute (if have, should be ignored).

An option '-m|--module-name' is introduced to designate submodules
by logical module names instead of module paths. So follwoing
commands pairs (1,2), (3,4) will be equivalent.

--------------------------------------
$ git submodule a b c           (1)
$ git submodule -m all          (2)
$ git submodule init a b        (3)
$ git submodule -m init all1    (4)
--------------------------------------

"-m|--module-name" options is introduced with which modules are designated
 by logical names instead of real paths as following example shows.

Identical commands forms with/without "--module-name"
---------------------------------------------------
$ git submodule XXX util imcrawler              (1)
$ git submodule XXX -n crawler                  (2)
$ git submodule XXX util imcrawler imsearch     (3)
$ git submodule XXX -n service                  (4)
$ git submodule XXX -n crawler search           (5)

* XXX represents status, update or init, but not add
* (1) and (2) are idetical conditionally (explained below)
* (3), (4) and (5) are identical conditionally
---------------------------------------------------

There are still minor difference between these two forms.

In the no "--module-name" form, the path parameter may be not the real submodule
path, and it just acts as the filter for real submodule paths. While In the
 "--module-name" form, name parameter must be the logical name, and the real
paths corresponding to the logical name may be neither a submodule path nor
even existent.

How to handle such a path depends on the subcommand.
 - status: Output 0{40} as the sha1. Doing this can remind the user to
   add the path as submodule or delete the path from .gitmodules.
 - update: Skip that path and issue a "Not a submodule" warning
 - init: Also init for that path

So in the example above, commands (1) and (2) are identical only when util and
imcrawler are already submodules.

With "--module-name" option, now we can add submodules in batch.

The former workflow to add submodules is adding one by one with
"git submodule add url path" which then modifies .gitmodules. However,
sometimes it may be more convenient to work in the reverse way: edit
.gitmodules first and then add submodules in batch.

Now "git submodule add --module-name modulename" can help us to do that.
It will find all submodules corresponding to the logical name and add them
in batch by using the path and url from .gitmodules. Of course, it will skip
those paths which have already been submodules.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |  131 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 114 insertions(+), 17 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..13517b2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -13,6 +13,7 @@ command=
 branch=
 quiet=
 cached=
+use_module_name=
 
 #
 # print stuff on stdout unless -q was specified
@@ -81,6 +82,75 @@ module_name()
 }
 
 #
+# List all submodule info line by line by given names (path\tname\turl)
+# $@ = module names
+#
+module_info_by_name() {
+	(
+	export GIT_CONFIG=.gitmodules
+	# When names is not given, list all module info
+	if test $# = 0
+	then
+		names=$(git config --get-regexp 'submodule.*.url' |
+			sed 's/submodule.\(.*\).url .*$/\1/' 2>/dev/null
+			)
+		for name in $names
+		do
+			if git config submodule.$name.submodule >/dev/null 2>&1
+			then
+				continue
+			fi
+			url=$(git config submodule.$name.url)
+			path=$(git config submodule.$name.path) || path="$name"
+			sha1=$(git ls-files --stage $path | grep -e '^160000' |
+				awk '{print $2}')
+			test -z "$sha1" && sha1=0000000000000000000000000000000000000000
+			echo "$sha1	$path	$name	$url"
+		done
+		exit
+	fi
+
+	for name
+	do
+		local names=$(git config --get-all submodule.$name.submodule)
+		if test -n "$names"
+		then
+			module_info_by_name $names
+		else
+			url=$(git config submodule.$name.url)
+			test -z "$url" && continue
+			path=$(git config submodule.$name.path) || path="$name"
+			sha1=$(git ls-files --stage $path | grep -e '^160000' |
+				awk '{print $2}')
+			test -z "$sha1" && sha1=0000000000000000000000000000000000000000
+			echo "$sha1	$path	$name	$url"
+		fi
+	done
+	) | LC_ALL=C sort -u
+}
+
+module_info() {
+	if test -n "$use_module_name"
+	then
+		module_info_by_name "$@"
+	else
+		git ls-files --stage -- "$@" | grep -e '^160000 ' |
+		while read mode sha1 stage path
+		do
+			name=$(module_name "$path")
+			if test -n "$name"
+			then
+				url=$(git config submodule."$name".url)
+				echo "$sha1	$path	$name	$url"
+			else
+				echo "$sha1	$path		"
+			fi
+		done | LC_ALL=C sort -u
+	fi
+
+}
+
+#
 # Clone a submodule
 #
 # Prior to calling, cmd_update checks that a possibly existing
@@ -146,6 +216,17 @@ cmd_add()
 		shift
 	done
 
+	if test -n "$use_module_name"
+	then
+		module_info "$@" |
+		while read sha1 path name url
+		do
+			use_module_name=
+			cmd_add "$url" "$path"
+		done
+		return
+	fi
+
 	repo=$1
 	path=$2
 
@@ -220,15 +301,16 @@ cmd_init()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
-	while read mode sha1 stage path
+	module_info "$@" |
+	while read sha1 path name url
 	do
+		test -z "$name" &&
+		say "No submodule mapping found in .gitmodules for path '$path'" &&
+		continue
 		# Skip already registered paths
-		name=$(module_name "$path") || exit
-		url=$(git config submodule."$name".url)
-		test -z "$url" || continue
+		git config submodule."$name".url >/dev/null 2>&1 &&
+		continue
 
-		url=$(GIT_CONFIG=.gitmodules git config submodule."$name".url)
 		test -z "$url" &&
 		die "No url found for submodule path '$path' in .gitmodules"
 
@@ -274,12 +356,18 @@ cmd_update()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
-	while read mode sha1 stage path
+	module_info "$@" |
+	while read sha1 path name url
 	do
-		name=$(module_name "$path") || exit
-		url=$(git config submodule."$name".url)
-		if test -z "$url"
+		if test $sha1 = 0000000000000000000000000000000000000000
+		then
+			say "Not a submodule: $name @ $path"
+			continue
+		elif test -z "$name"
+		then
+			say "No submodule mapping found in .gitmodules for path '$path'"
+			continue
+		elif test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
 			# path have been specified
@@ -357,15 +445,21 @@ cmd_status()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
-	while read mode sha1 stage path
+	module_info "$@" |
+	while read sha1 path name url
 	do
-		name=$(module_name "$path") || exit
-		url=$(git config submodule."$name".url)
-		if test -z "url" || ! test -d "$path"/.git
+		if test $sha1 = 0000000000000000000000000000000000000000
+		then
+			say "*$sha1 $path"
+			continue
+		elif test -z "$name"
+		then
+			say "No submodule mapping found in .gitmodules for path '$path'"
+			continue
+		elif test -z "$url" || ! test -d "$path"/.git
 		then
 			say "-$sha1 $path"
-			continue;
+			continue
 		fi
 		set_name_rev "$path" "$sha1"
 		if git diff-files --quiet -- "$path"
@@ -408,6 +502,9 @@ do
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

