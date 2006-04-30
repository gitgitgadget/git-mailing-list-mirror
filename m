From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] fetch, pull: ask config for remote information
Date: Sun, 30 Apr 2006 15:24:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604301523500.2646@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 30 15:24:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaBuG-0002iW-1Y
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 15:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWD3NYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 09:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWD3NYF
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 09:24:05 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15760 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751115AbWD3NYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 09:24:04 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 772C11BEE
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 15:24:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6B45A1BDC
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 15:24:03 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 584B41319
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 15:24:03 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19336>


Now you can say

[remote.junio]
	url = git://git.kernel.org/pub/scm/git/git.git
	pull = next:next

in your .git/config.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-parse-remote.sh |   55 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 51 insertions(+), 4 deletions(-)

5a1cf349639823183fce287be9f809d797f2cd84
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index c9b899e..8ce57c8 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -4,13 +4,43 @@ # git-ls-remote could be called from out
 # this would fail in that case and would issue an error message.
 GIT_DIR=$(git-rev-parse --git-dir 2>/dev/null) || :;
 
+if [ -d "$GIT_DIR"/remotes -a "$GIT_REWRITE_REMOTES" = true ]; then
+	echo "Rewriting $GIT_DIR/remotes" >&2
+	error=0
+	# rewrite into config
+	{
+		cd "$GIT_DIR"/remotes
+		ls | while read f; do
+			name=$(echo -n "$f" | tr -c "A-Za-z0-9" ".")
+			sed -n \
+			-e "s/^URL: /remote.$name.url . /p" \
+			-e "s/^Pull: /remote.$name.pull ^$ /p" \
+			-e "s/^Push: /remote.$name.push ^$ /p" \
+			< "$f"
+		done
+		echo done
+	} | while read key regex value; do
+		case $key in
+		done)
+			if [ $error = 0 ]; then
+				mv "$GIT_DIR"/remotes "$GIT_DIR"/remotes.old
+			fi ;;
+		*)
+			git-repo-config $key "$value" $regex || error=1 ;;
+		esac
+	done
+fi
+
 get_data_source () {
 	case "$1" in
 	*/*)
 		# Not so fast.	This could be the partial URL shorthand...
 		token=$(expr "z$1" : 'z\([^/]*\)/')
 		remainder=$(expr "z$1" : 'z[^/]*/\(.*\)')
-		if test -f "$GIT_DIR/branches/$token"
+		if test "$(git-repo-config --get "remote.$token.url")"
+		then
+			echo config-partial
+		elif test -f "$GIT_DIR/branches/$token"
 		then
 			echo branches-partial
 		else
@@ -18,7 +48,10 @@ get_data_source () {
 		fi
 		;;
 	*)
-		if test -f "$GIT_DIR/remotes/$1"
+		if test "$(git-repo-config --get "remote.$1.url")"
+		then
+			echo config
+		elif test -f "$GIT_DIR/remotes/$1"
 		then
 			echo remotes
 		elif test -f "$GIT_DIR/branches/$1"
@@ -35,6 +68,15 @@ get_remote_url () {
 	case "$data_source" in
 	'')
 		echo "$1" ;;
+	config-partial)
+		token=$(expr "z$1" : '\([^/]*\)/')
+		remainder=$(expr "z$1" : '[^/]*/\(.*\)')
+		url=$(git-repo-config --get "remote.$token.url")
+		echo "$url/$remainder"
+		;;
+	config)
+		git-repo-config --get "remote.$1.url"
+		;;
 	remotes)
 		sed -ne '/^URL: */{
 			s///p
@@ -56,8 +98,10 @@ get_remote_url () {
 get_remote_default_refs_for_push () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
-	'' | branches | branches-partial)
+	'' | config-partial | branches | branches-partial)
 		;; # no default push mapping, just send matching refs.
+	config)
+		git-repo-config --get-all "remote.$1.push" ;;
 	remotes)
 		sed -ne '/^Push: */{
 			s///p
@@ -111,8 +155,11 @@ # Returns list of src: (no store), or sr
 get_remote_default_refs_for_fetch () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
-	'' | branches-partial)
+	'' | config-partial | branches-partial)
 		echo "HEAD:" ;;
+	config)
+		canon_refs_list_for_fetch \
+			$(git-repo-config --get-all "remote.$1.pull") ;;
 	branches)
 		remote_branch=$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
 		case "$remote_branch" in '') remote_branch=master ;; esac
-- 
1.3.1.g38c00-dirty
