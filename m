From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] format-patch: fix skipping of blank-lines
Date: Fri, 08 Jul 2005 17:46:27 -0700
Message-ID: <7vu0j44xi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 03:23:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr43S-0007dx-FL
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 03:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbVGIBS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 21:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVGIAqn
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 20:46:43 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:60547 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S263053AbVGIAqc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 20:46:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050709004628.IGDI550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 8 Jul 2005 20:46:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If it is fed a commit with more than one leading blank lines,
the sed scripts git-format-patch-script used looped forever.
This patch fixes it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-format-patch-script |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

58a3c79b488a28897cd5556dab0dd599b4ed9f0c
diff --git a/git-format-patch-script b/git-format-patch-script
--- a/git-format-patch-script
+++ b/git-format-patch-script
@@ -66,9 +66,13 @@ trap 'rm -f $tmp-*' 0 1 2 3 15
 series=$tmp-series
 
 titleScript='
-	1,/^$/d
+	/./d
 	: loop
-	/^$/b loop
+	/^$/{
+		n
+		b loop
+	}
+	s/^\[PATCH[^]]*\] *//
 	s/[^-a-z.A-Z_0-9]/-/g
         s/\.\.\.*/\./g
 	s/\.*$//
@@ -76,6 +80,7 @@ titleScript='
 	s/^-//
 	s/-$//
 	s/$/./
+	p
 	q
 '
 
@@ -88,7 +93,7 @@ total=`wc -l <$series`
 i=$total
 while read commit
 do
-    title=`git-cat-file commit "$commit" | sed -e "$titleScript"`
+    title=`git-cat-file commit "$commit" | sed -ne "$titleScript"`
     case "$numbered" in
     '') num= ;;
     *)
@@ -102,9 +107,12 @@ do
     echo "$file"
     {
 	mailScript='
-	1,/^$/d
+	/./d
 	: loop
-	/^$/b loop
+	/^$/{
+		n
+		b loop
+	}
 	s|^|[PATCH'"$num"'] |
 	: body
 	p
