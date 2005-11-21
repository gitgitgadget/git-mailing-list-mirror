From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC 2/2] Automatically transform .git/{branches,remotes} into
 .git/config
Date: Mon, 21 Nov 2005 14:56:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 21 14:58:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeCA1-000539-U5
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 14:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVKUN4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 08:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVKUN4n
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 08:56:43 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:39568 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932307AbVKUN4m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 08:56:42 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 7CE8B140509
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:56:41 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 5AB24B5293
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:56:41 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 38B75B371C
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:56:41 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2504F140509
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:56:41 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12443>


With this patch, git automatically extracts the information from 
.git/branches and .git/remotes, puts it into .git/config, and renames the 
directories to .git/branches.old and .git/remotes.old, respectively.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-parse-remote.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

applies-to: 239817500e3556e8541d3b2b8257802c10da85c2
69062e3473f9f3cafe33954d9b995da89f6d9898
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index cd976da..0d603ac 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -2,6 +2,59 @@
 
 . git-sh-setup
 
+if [ -d "$GIT_DIR"/branches ]; then
+	echo "Rewriting $GIT_DIR/branches" >&2
+	error=0
+	# rewrite into config
+	{
+		cd "$GIT_DIR"/branches
+		ls | while read f; do
+			name=$(echo -n "$f" | tr -c "A-Za-z0-9" ".")
+			sed \
+			-e "s/^/remote.$name.url /" \
+			-e "s/#\(.*\)$/\nremote.$name.pull \1/" \
+			< "$f"
+		done
+		echo done
+	} | while read key value; do
+		case $key in
+		done)
+			if [ $error = 0 ]; then
+				mv "$GIT_DIR"/branches "$GIT_DIR"/branches.old
+			fi ;;
+		*)
+			git-config-set $key "$value" || error=1 ;;
+		esac
+	done
+fi
+
+if [ -d "$GIT_DIR"/remotes ]; then
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
+			git-config-set $key "$value" $regex || error=1 ;;
+		esac
+	done
+fi
+
 get_data_source () {
 	case "$1" in
 	*/*)
---
0.99.9.GIT
