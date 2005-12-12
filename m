From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cg-clean: fix directory cleaning
Date: Mon, 12 Dec 2005 15:54:20 -0500
Message-ID: <1134420860.4695.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Dec 12 21:59:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EluiV-0004iJ-VO
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 21:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVLLU4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 15:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVLLU4N
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 15:56:13 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:37594 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751211AbVLLU4M
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 15:56:12 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Elufh-0002AE-IA
	for git@vger.kernel.org; Mon, 12 Dec 2005 15:54:10 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Eluge-00043k-Gl; Mon, 12 Dec 2005 15:54:20 -0500
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13539>

cg-clean is broken by commit 3cddede46dcd24bd7c36827ca564de23b2bb3517 -
it removes all subdirectories when run in the top level directory.

Although it's easy to make a one-line fix, I'd prefer a solution that
makes cg-clean potentially safer.  Since git-ls-files runs in
subdirectories now, it's no longer needed to run anything in the top
level directory and filter out the results.  cg-clean now changes to
$_git_relpath on startup and never uses $_git_relpath again.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-clean b/cg-clean
index 92fc48e..6909076 100755
--- a/cg-clean
+++ b/cg-clean
@@ -60,8 +60,6 @@ clean_dirs()
 	git-ls-files --cached |
 		sed -n 's|/[^/]*$||p' |
 		while IFS=$'\n' read dir; do
-			[ x"${dir#$_git_relpath}" = x"${dir}" ] && continue
-			dir="${dir#$_git_relpath}"
 			while true; do
 				echo "$dir"
 				updir="${dir%/*}"
@@ -74,32 +72,27 @@ clean_dirs()
 	save_IFS="$IFS"
 	IFS=$'\n'
 
-	fpath=${_git_relpath-./}
-	find "$fpath" -type d -print |
-		while read dir; do
-			echo "${dir#$fpath}"
-		done |
-		sed '/^$/d;/^\.git$/d;/^\.git\//d' |
+	find ./ -type d -print |
+		sed 's/^\.\///;/^$/d;/^\.git$/d;/^\.git\//d' |
 		cat - "$dirlist" | sort -u |
 		diff - "$dirlist" |
 		sed -n 's/< //p' |
-	while read file; do
-		path="${_git_relpath}$file"
-		if [ ! -d "$path" ]; then
+	while read dir; do
+		if [ ! -d "$dir" ]; then
 			# Perhaps directory was removed with its parent
 			continue
 		fi
 		if [ -z "$cleandir" ]; then
-			echo "Not removing $file/"
+			echo "Not removing $dir/"
 			continue
 		fi
-		[ "$quiet" ] || echo "Removing $file/"
+		[ "$quiet" ] || echo "Removing $dir/"
 		if [ "$cleandirhard" ]; then
-			chmod -R 700 "$path"
+			chmod -R 700 "$dir"
 		fi
-		$rm -rf "$path"
-		if [ -e "$path" -o -L "$path" ]; then
-			echo "Cannot remove $file/"
+		$rm -rf "$dir"
+		if [ -e "$dir" -o -L "$dir" ]; then
+			echo "Cannot remove $dir/"
 		fi
 	done
 
@@ -117,14 +110,13 @@ clean_files()
 
 	cg-status -n -s '?' "$xopt" -w |
 	while read file; do
-		path="${_git_relpath}$file"
-		if [ -d "$path" -a ! -L "$path" ]; then
+		if [ -d "$file" -a ! -L "$file" ]; then
 			# Sanity check, shouldn't happen
 			echo "FATAL: cg-status reports directories (internal error)" >&2
 			exit 1
-		elif [ -e "$path" -o -L "$path" ]; then
+		elif [ -e "$file" -o -L "$file" ]; then
 			[ "$quiet" ] || echo "Removing $file"
-			$rm -f "$path"
+			$rm -f "$file"
 			# rm would complain itself on failure
 		else
 			echo "File $file has disappeared!"
@@ -135,6 +127,8 @@ clean_files()
 }
 
 
+cd "${_git_relpath-.}"
+
 # Even if -d or -D is not specified, we want to tell user about
 # directories that are not removed
 if [ -z "$quiet" -o "$cleandir" ]; then


-- 
Regards,
Pavel Roskin
