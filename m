From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/2] cg-clean shouldn't clean untracked directories without -d
Date: Tue, 14 Feb 2006 13:05:20 -0500
Message-ID: <20060214180520.13766.78172.stgit@dv.roinet.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 19:06:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F94Z2-0006cf-0Y
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 19:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422742AbWBNSFw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 13:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbWBNSFw
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 13:05:52 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:27577 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1422740AbWBNSFu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 13:05:50 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F94Yc-0006Ib-OL
	for git@vger.kernel.org; Tue, 14 Feb 2006 13:05:47 -0500
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1F94YC-0003aH-AU; Tue, 14 Feb 2006 13:05:20 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16147>

Use the new squashdirs argument in list_untracked_files() to treat
untracked directories and their contents as a whole.  Remove a separate
pass to find untracked directories.  Adjust the testsuite accordingly.

Don't change IFS - it's no longer needed.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cg-clean         |   99 ++++++++++--------------------------------------------
 t/t9400-clean.sh |    3 +-
 2 files changed, 20 insertions(+), 82 deletions(-)

diff --git a/cg-clean b/cg-clean
index b40b41b..5c27a26 100755
--- a/cg-clean
+++ b/cg-clean
@@ -53,88 +53,27 @@ done
 
 [ ${#ARGS[*]} = 0 ] || usage
 
-
-clean_dirs()
-{
-	dirlist="$(mktemp -t gitlsfiles.XXXXXX)"
-	git-ls-files --cached |
-		sed -n 's|/[^/]*$||p' |
-		while IFS=$'\n' read -r dir; do
-			while true; do
-				echo "$dir"
-				updir="${dir%/*}"
-				[ "$dir" = "$updir" ] && break
-				dir="$updir"
-			done
-		done |
-		sort -u >"$dirlist"
-
-	save_IFS="$IFS"
-	IFS=$'\n'
-
-	find ./ -type d -print |
-		sed 's/^\.\///;/^$/d;/^\.git$/d;/^\.git\//d' |
-		cat - "$dirlist" | sort -u |
-		diff - "$dirlist" |
-		sed -n 's/< //p' |
-	while read -r dir; do
-		if [ ! -d "$dir" ]; then
-			# Perhaps directory was removed with its parent
-			continue
-		fi
+cd "${_git_relpath-.}"
+list_untracked_files "$noexclude" squashdirs | tr '\0' '\n' |
+while read -r file; do
+	if [ -d "$file" -a ! -L "$file" ]; then
 		if [ -z "$cleandir" ]; then
-			echo "Not removing $dir/"
+			echo "Not removing $file"
 			continue
 		fi
-		[ "$quiet" ] || echo "Removing $dir/"
+		[ "$quiet" ] || echo "Removing $file"
 		if [ "$cleandirhard" ]; then
-			chmod -R 700 "$dir"
+			chmod -R 700 "$file"
 		fi
-		$rm -rf "$dir"
-		if [ -e "$dir" -o -L "$dir" ]; then
-			echo "Cannot remove $dir/"
-		fi
-	done
-
-	IFS="$save_IFS"
-	rm "$dirlist"
-}
-
-clean_files()
-{
-	save_IFS="$IFS"
-	IFS=$'\n'
-
-	list_untracked_files "$noexclude" nosquashdirs | tr '\0' '\n' |
-	(cd "${_git_relpath-.}" &&
-	while read -r file; do
-		if [ -z "$_git_relpath" ] || [ x"${file#$_git_relpath}" != x"$file" ]; then
-			file="${file#$_git_relpath}"
-		else
-			continue
-		fi
-
-		if [ -d "$file" -a ! -L "$file" ]; then
-			# Sanity check, shouldn't happen
-			echo "FATAL: cg-status reports directories (internal error)" >&2
-			exit 1
-		elif [ -e "$file" -o -L "$file" ]; then
-			[ "$quiet" ] || echo "Removing $file"
-			"$rm" -f "$file"
-			# rm would complain itself on failure
-		else
-			echo "File $file has disappeared!"
-		fi
-	done)
-
-	IFS="$save_IFS"
-}
-
-
-# Even if -d or -D is not specified, we want to tell user about
-# directories that are not removed
-if [ -z "$quiet" -o "$cleandir" ]; then
-	( cd "${_git_relpath-.}" && clean_dirs )
-fi
-
-clean_files
+		$rm -rf "$file"
+		if [ -e "$file" -o -L "$file" ]; then
+			echo "Cannot remove $file"
+		fi
+	elif [ -e "$file" -o -L "$file" ]; then
+		[ "$quiet" ] || echo "Removing $file"
+		"$rm" -f "$file"
+		# rm would complain itself on failure
+	else
+		echo "File $file has disappeared!"
+	fi
+done
diff --git a/t/t9400-clean.sh b/t/t9400-clean.sh
index 47ae0dc..98801c5 100755
--- a/t/t9400-clean.sh
+++ b/t/t9400-clean.sh
@@ -84,10 +84,8 @@ echo "ign file 3" >"repo dir/ign file 3.
 echo "ign file 4" >"repo dir/ign file 4.ign1"
 mklist init
 
-# FIXME: cg-clean shouldn't clean unknown directories without "-d"
 loss='extra file 1
 ign file 2.ign1
-extra dir 1/extra file 3
 repo dir/extra file 2'
 test_expect_success 'cg-clean in top-level dir' \
 	"(cg-clean && check_loss)"
@@ -99,6 +97,7 @@ test_expect_success 'cg-clean -x in top-
 	"(cg-clean -x && check_loss)"
 
 loss='extra dir 1
+extra dir 1/extra file 3
 repo dir/extra dir 2'
 test_expect_success 'cg-clean -d in top-level dir' \
 	"(cg-clean -d && check_loss)"
