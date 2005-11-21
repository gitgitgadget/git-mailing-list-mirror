From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC 1/2] Use remote information in .git/config
Date: Mon, 21 Nov 2005 14:54:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511211452470.13775@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 21 14:55:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeC8h-0004OF-KP
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 14:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVKUNyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 08:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVKUNyy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 08:54:54 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:61071 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932305AbVKUNyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 08:54:53 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 55907140509
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:54:52 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 374C1B5293
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:54:52 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 17BACB371C
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:54:52 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 085B2140509
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:54:52 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12441>


This patch allows to store shortcuts for fetch/pull into the config:

	[remote.junio]
		url = http://www.kernel.org/pub/scm/git/git.git
		pull = master:junio
		pull = todo:todo
		pull = +pu:pu

Note that there is only one pair per "pull" line, to allow for spaces
(urgh!) in the branch names.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	The different pull/push lines are identified by their branch name. 
	So, to update the pull line for "todo" to force fast forward, do

		git-config-set remote.junio.pull +todo:todo '^todo:'

 git-parse-remote.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

applies-to: 25c461c5c50b9d8c6cd836ca6a9df12f03f29621
b0542d077b7bf6ee8b45854e47dcba73170c1e9a
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index aea7b0e..cd976da 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -22,6 +22,9 @@ get_data_source () {
 		elif test -f "$GIT_DIR/branches/$1"
 		then
 			echo branches
+		elif test "$(git-config-set --get remote.$1.url)"
+		then
+			echo config
 		else
 			echo ''
 		fi ;;
@@ -46,6 +49,9 @@ get_remote_url () {
 		url=$(sed -e 's/#.*//' "$GIT_DIR/branches/$token")
 		echo "$url/$remainder"
 		;;
+	config)
+		git-config-set --get remote.$1.url
+		;;
 	*)
 		die "internal error: get-remote-url $1" ;;
 	esac
@@ -60,6 +66,8 @@ get_remote_default_refs_for_push () {
 		sed -ne '/^Push: */{
 			s///p
 		}' "$GIT_DIR/remotes/$1" ;;
+	config)
+		git-config-set --get-all remote.$1.push ;;
 	*)
 		die "internal error: get-remote-default-ref-for-push $1" ;;
 	esac
@@ -124,6 +132,8 @@ get_remote_default_refs_for_fetch () {
 						s///p
 					}' "$GIT_DIR/remotes/$1")
 		;;
+	config)
+		git-config-set --get-all remote.$1.pull ;;
 	*)
 		die "internal error: get-remote-default-ref-for-push $1" ;;
 	esac
---
0.99.9.GIT
