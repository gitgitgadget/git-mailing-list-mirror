From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Avoid using dc in git-count-objects
Date: Wed, 26 Oct 2005 01:22:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 26 01:26:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUY7U-0004H3-C0
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVJYXWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVJYXWN
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:22:13 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8082 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932474AbVJYXWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:22:12 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A9C8013F0B6; Wed, 26 Oct 2005 01:22:11 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 91A7F9ABA5; Wed, 26 Oct 2005 01:22:11 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7B6749AB53; Wed, 26 Oct 2005 01:22:11 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 585E113F0B6; Wed, 26 Oct 2005 01:22:11 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10629>

Using dc is not really necessary, since expr understands summing 32 bit 
signed integers. Which means that git-count-objects will now fail when 2 
GB of unpacked objects have accumulated.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This is (again) something I found on a default cygwin setup:
	dc is not installed. I do not even know if you can install
	dc on cygwin without compiling it yourself.

	FYI: I use git-count-objects in t5500-fetch-pack to find out
	if the correct number of objects was fetched.

 git-count-objects.sh |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-count-objects.sh b/git-count-objects.sh
index 843d2fd..7f9d8e5 100755
--- a/git-count-objects.sh
+++ b/git-count-objects.sh
@@ -2,12 +2,18 @@
 
 . git-sh-setup
 
+function sum () {
+	local result=0
+	while read line; do
+		result=$(expr $result + $line)
+	done
+	echo $result
+}
+
 echo $(find "$GIT_DIR/objects"/?? -type f -print 2>/dev/null | wc -l) objects, \
 $({
-    echo 0
     # "no-such" is to help Darwin folks by not using xargs -r.
     find "$GIT_DIR/objects"/?? -type f -print 2>/dev/null |
     xargs du -k "$GIT_DIR/objects/no-such" 2>/dev/null |
-    sed -e 's/[ 	].*/ +/'
-    echo p
-} | dc) kilobytes
+    sed -e 's/[ 	].*//'
+} | sum) kilobytes
