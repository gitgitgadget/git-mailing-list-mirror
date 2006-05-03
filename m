From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fetch, pull: ask config for remote information
Date: Wed, 3 May 2006 15:20:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605031519100.6949@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 03 15:21:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbHHG-0003PP-DX
	for gcvg-git@gmane.org; Wed, 03 May 2006 15:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWECNUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 09:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWECNUX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 09:20:23 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3012 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030192AbWECNUW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 09:20:22 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 37620203F;
	Wed,  3 May 2006 15:20:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 2B844203B;
	Wed,  3 May 2006 15:20:21 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 1723E1D70;
	Wed,  3 May 2006 15:20:21 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19480>


Now you can say
    
    [remote.junio]
        url = git://git.kernel.org/pub/scm/git/git.git
        pull = next:next
    
    in your .git/config.
    
Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This is 5a223a0d434c874984a0251eca4520ef95718a6d redone.

	The conversion tool will follow in a few minutes, after
	a bit of testing.

 git-parse-remote.sh |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index c9b899e..187f088 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -10,7 +10,10 @@ get_data_source () {
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
@@ -18,7 +21,10 @@ get_data_source () {
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
@@ -35,6 +41,15 @@ get_remote_url () {
 	case "$data_source" in
 	'')
 		echo "$1" ;;
+	config-partial)
+		token=$(expr "z$1" : 'z\([^/]*\)/')
+		remainder=$(expr "z$1" : 'z[^/]*/\(.*\)')
+		url=$(git-repo-config --get "remote.$token.url")
+		echo "$url/$remainder"
+		;;
+	config)
+		git-repo-config --get "remote.$1.url"
+		;;
 	remotes)
 		sed -ne '/^URL: */{
 			s///p
@@ -56,8 +71,10 @@ get_remote_url () {
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
@@ -111,8 +128,11 @@ # Returns list of src: (no store), or sr
 get_remote_default_refs_for_fetch () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
-	'' | branches-partial)
+	'' | config-partial | branches-partial)
 		echo "HEAD:" ;;
+	config)
+		canon_refs_list_for_fetch \
+			$(git-repo-config --get-all "remote.$1.fetch") ;;
 	branches)
 		remote_branch=$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
 		case "$remote_branch" in '') remote_branch=master ;; esac
