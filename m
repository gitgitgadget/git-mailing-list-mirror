From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Move the pick_author code to git-sh-setup
Date: Sun, 24 Jun 2007 00:01:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706240000340.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 24 01:01:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2EbQ-0005Wk-Sw
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 01:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXFWXBL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 19:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbXFWXBL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 19:01:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:49414 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750938AbXFWXBK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 19:01:10 -0400
Received: (qmail invoked by alias); 23 Jun 2007 23:01:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 24 Jun 2007 01:01:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MI7FFo9pM63HTTyOIemuwGAWXgohwX+DsXDHmmJ
	zZGKmgXuMNwjz3
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50756>


At the moment, only git-commit uses that code, to pick the author name,
email and date from a given commit.

This code will be reused in git rebase --interactive.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-commit.sh   |   30 ++----------------------------
 git-sh-setup.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 5547a02..4bef375 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -483,34 +483,8 @@ fi >>"$GIT_DIR"/COMMIT_EDITMSG
 # Author
 if test '' != "$use_commit"
 then
-	pick_author_script='
-	/^author /{
-		s/'\''/'\''\\'\'\''/g
-		h
-		s/^author \([^<]*\) <[^>]*> .*$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_NAME='\''&'\''/p
-
-		g
-		s/^author [^<]* <\([^>]*\)> .*$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
-
-		g
-		s/^author [^<]* <[^>]*> \(.*\)$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
-
-		q
-	}
-	'
-	encoding=$(git config i18n.commitencoding || echo UTF-8)
-	set_author_env=`git show -s --pretty=raw --encoding="$encoding" "$use_commit" |
-	LANG=C LC_ALL=C sed -ne "$pick_author_script"`
-	eval "$set_author_env"
-	export GIT_AUTHOR_NAME
-	export GIT_AUTHOR_EMAIL
-	export GIT_AUTHOR_DATE
+	eval $(get_author_ident_from_commit "$use_commit")
+	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
 fi
 if test '' != "$force_author"
 then
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index f24c7f2..d861db3 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -53,6 +53,33 @@ require_work_tree () {
 	die "fatal: $0 cannot be used without a working tree."
 }
 
+get_author_ident_from_commit () {
+	pick_author_script='
+	/^author /{
+		s/'\''/'\''\\'\'\''/g
+		h
+		s/^author \([^<]*\) <[^>]*> .*$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_NAME='\''&'\''/p
+
+		g
+		s/^author [^<]* <\([^>]*\)> .*$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
+
+		g
+		s/^author [^<]* <[^>]*> \(.*\)$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
+
+		q
+	}
+	'
+	encoding=$(git config i18n.commitencoding || echo UTF-8)
+	git show -s --pretty=raw --encoding="$encoding" "$1" |
+	LANG=C LC_ALL=C sed -ne "$pick_author_script"
+}
+
 if [ -z "$LONG_USAGE" ]
 then
 	LONG_USAGE="Usage: $0 $USAGE"
-- 
1.5.2.2.279.g74fb3
