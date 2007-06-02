From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: [PATCH] Add option -L to git-tag.
Date: Sat,  2 Jun 2007 15:10:48 +0200
Message-ID: <1180789848873-git-send-email-mmelchior@xs4all.nl>
Cc: git@vger.kernel.org, Matthijs Melchior <mmelchior@xs4all.nl>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 15:11:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuTNm-0005U8-Mh
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 15:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbXFBNKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 09:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756230AbXFBNKx
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 09:10:53 -0400
Received: from zwaan.xs4all.nl ([213.84.190.116]:56614 "EHLO zwaan.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756122AbXFBNKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 09:10:53 -0400
Received: from kayak.lan ([10.0.0.130]) by zwaan.xs4all.nl
	 with esmtp (ident Debian-exim using rfc1413) id m1HuTNZ-000BBvC
	(Debian Smail-3.2 1996-Jul-4 #2); Sat, 2 Jun 2007 15:10:49 +0200 (CEST)
Received: from matthijs by kayak.lan with local (Exim 4.63)
	(envelope-from <mmelchior@xs4all.nl>)
	id 1HuTNY-00075T-CQ; Sat, 02 Jun 2007 15:10:48 +0200
X-Mailer: git-send-email 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48928>

  This will list the selected tags and include annotations, if any.

Signed-off-by: Matthijs Melchior <mmelchior@xs4all.nl>
---

Version 2 of the git-tag -L patch.
  It implements better style,
   a new --pretty=n option and
   an interresting exit code.

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


>From f0123e2f1c4bd8a15e8d190dc1e0c2745db60278 Mon Sep 17 00:00:00 2001
From: Matthijs Melchior <mmelchior@xs4all.nl>
Date: Sat, 2 Jun 2007 15:04:46 +0200
Subject: [PATCH] git-tag -L, version 2
	style. --pretty=n and exit code
---
 git-tag.sh |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/git-tag.sh b/git-tag.sh
index 45c4253..dafa083 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -13,6 +13,7 @@ message=
 username=
 list=
 verify=
+LINES=3
 while case "$#" in 0) break ;; esac
 do
     case "$1" in
@@ -26,24 +27,33 @@ do
     -f)
 	force=1
 	;;
+    --pretty=*)
+	LINES=$(expr "$1" : '--pretty=\(.*\)')
+	;;
     -l|-L)
 	TAGSONLY=true
 	[ "$1" = -L ] && TAGSONLY=false
 	[ "$#" = 1 ] && set x .
 	shift
-	git rev-parse --symbolic --tags | grep "$@" |
+	[ "$LINES" -le 0 ] && LINES=999999
+	TAGLIST=$(git rev-parse --symbolic --tags | grep "$@")
+	RC=$?			# from grep
+	printf "%s" "$TAGLIST" |
 	    while read TAG
 	    do
 		echo "$TAG"
 		$TAGSONLY && continue
 		OBJTYPE=$(git cat-file -t "$TAG")
 		case $OBJTYPE in
-		    tag)    git cat-file $OBJTYPE "$TAG" |
-				sed '1,/^$/d;/^-----BEGIN PGP SIGNATURE-----$/Q;s/^/    /'
-			    ;;
+		tag)	git cat-file tag "$TAG" |
+			  sed -e '1,/^$/d' \
+			      -e '/^-----BEGIN PGP SIGNATURE-----$/Q' \
+			      -e 's/^/    /' |
+			  sed -e "${LINES}q"
+			;;
 		esac
 	    done
-	exit $?
+	exit $RC
 	;;
     -m)
     	annotate=1
-- 
1.5.2
