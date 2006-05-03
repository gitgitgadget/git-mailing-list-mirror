From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add a conversion tool to migrate remote information into
 the config
Date: Wed, 3 May 2006 15:27:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605031526280.6975@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 03 15:28:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbHO6-0005C3-P8
	for gcvg-git@gmane.org; Wed, 03 May 2006 15:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWECN12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 09:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWECN12
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 09:27:28 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48079 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030202AbWECN11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 09:27:27 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id B53201613;
	Wed,  3 May 2006 15:27:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id A98871578;
	Wed,  3 May 2006 15:27:26 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 84559ED0;
	Wed,  3 May 2006 15:27:26 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19481>


Use this tool to rewrite the .git/remotes/* files into the config.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 contrib/remotes2config.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/contrib/remotes2config.sh b/contrib/remotes2config.sh
new file mode 100644
index 0000000..25901e2
--- /dev/null
+++ b/contrib/remotes2config.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+# Use this tool to rewrite your .git/remotes/ files into the config.
+
+. git-sh-setup
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
+			-e "s/^URL: \(.*\)$/remote.$name.url \1 ./p" \
+			-e "s/^Pull: \(.*\)$/remote.$name.fetch \1 ^$ /p" \
+			-e "s/^Push: \(.*\)$/remote.$name.push \1 ^$ /p" \
+			< "$f"
+		done
+		echo done
+	} | while read key value regex; do
+		case $key in
+		done)
+			if [ $error = 0 ]; then
+				mv "$GIT_DIR"/remotes "$GIT_DIR"/remotes.old
+			fi ;;
+		*)
+			echo "git-repo-config $key "$value" $regex"
+			git-repo-config $key "$value" $regex || error=1 ;;
+		esac
+	done
+fi
+
+
