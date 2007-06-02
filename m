From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: [PATCH] Add option -L to git-tag.
Date: Sat,  2 Jun 2007 10:37:45 +0200
Message-ID: <1180773465209-git-send-email-mmelchior@xs4all.nl>
Cc: git@vger.kernel.org, Matthijs Melchior <mmelchior@xs4all.nl>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 10:43:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuPCe-0007fG-Tp
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 10:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbXFBInG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 04:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754787AbXFBInG
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 04:43:06 -0400
Received: from zwaan.xs4all.nl ([213.84.190.116]:56158 "EHLO zwaan.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbXFBInE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 04:43:04 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jun 2007 04:43:03 EDT
Received: from kayak.lan ([10.0.0.130]) by zwaan.xs4all.nl
	 with esmtp (ident Debian-exim using rfc1413) id m1HuP7J-000BBvC
	(Debian Smail-3.2 1996-Jul-4 #2); Sat, 2 Jun 2007 10:37:45 +0200 (CEST)
Received: from matthijs by kayak.lan with local (Exim 4.63)
	(envelope-from <mmelchior@xs4all.nl>)
	id 1HuP7J-0002dB-Fl; Sat, 02 Jun 2007 10:37:45 +0200
X-Mailer: git-send-email 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48916>

  This will list the selected tags and include annotations, if any.

Signed-off-by: Matthijs Melchior <mmelchior@xs4all.nl>
---

This patch has been created to allow me to easily see the annotations with tags.
I have not found any other way to do this...

Some remarks on the new bit of code:
 - Sorting the tag names resulting from git-rev-parse is not nessecary since
   the list of tags is already deliverd in sorted order.
 - Using git-cat-file -t on every tag is expensive, but there is no alternative

  -Matthijs

 Documentation/git-tag.txt |    5 ++++-
 git-tag.sh                |   24 +++++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 4e3e027..441f361 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<head>]
 'git-tag' -d <name>...
-'git-tag' -l [<pattern>]
+'git-tag' [-l | -L] [<pattern>]
 'git-tag' -v <name>
 
 DESCRIPTION
@@ -41,6 +41,9 @@ GnuPG key for signing.
 `-l <pattern>` lists tags that match the given pattern (or all
 if no pattern is given).
 
+`-L <pattern>` lists tags, including their annotations, that match
+the given pattern (or all if no pattern is given).
+
 OPTIONS
 -------
 -a::
diff --git a/git-tag.sh b/git-tag.sh
index 6f0b7a7..45c4253 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2005 Linus Torvalds
 
-USAGE='-l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg>] <tagname> [<head>]'
+USAGE='[-l | -L] [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg>] <tagname> [<head>]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
@@ -26,13 +26,23 @@ do
     -f)
 	force=1
 	;;
-    -l)
-	case "$#" in
-	1)
-		set x . ;;
-	esac
+    -l|-L)
+	TAGSONLY=true
+	[ "$1" = -L ] && TAGSONLY=false
+	[ "$#" = 1 ] && set x .
 	shift
-	git rev-parse --symbolic --tags | sort | grep "$@"
+	git rev-parse --symbolic --tags | grep "$@" |
+	    while read TAG
+	    do
+		echo "$TAG"
+		$TAGSONLY && continue
+		OBJTYPE=$(git cat-file -t "$TAG")
+		case $OBJTYPE in
+		    tag)    git cat-file $OBJTYPE "$TAG" |
+				sed '1,/^$/d;/^-----BEGIN PGP SIGNATURE-----$/Q;s/^/    /'
+			    ;;
+		esac
+	    done
 	exit $?
 	;;
     -m)
-- 
1.5.2
