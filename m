From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: [PATCH] Teach git-tag about showing tag annotations.
Date: Sun,  3 Jun 2007 02:05:39 +0200
Message-ID: <11808291391915-git-send-email-mmelchior@xs4all.nl>
Cc: git@vger.kernel.org, Matthijs Melchior <mmelchior@xs4all.nl>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 02:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HudbS-0005eK-PE
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 02:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762470AbXFCAFp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 20:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762744AbXFCAFp
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 20:05:45 -0400
Received: from zwaan.xs4all.nl ([213.84.190.116]:58363 "EHLO zwaan.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762470AbXFCAFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 20:05:44 -0400
Received: from kayak.lan ([10.0.0.130]) by zwaan.xs4all.nl
	 with esmtp (ident Debian-exim using rfc1413) id m1HudbI-000BBvC
	(Debian Smail-3.2 1996-Jul-4 #2); Sun, 3 Jun 2007 02:05:40 +0200 (CEST)
Received: from matthijs by kayak.lan with local (Exim 4.63)
	(envelope-from <mmelchior@xs4all.nl>)
	id 1HudbH-0005Dd-O1; Sun, 03 Jun 2007 02:05:39 +0200
X-Mailer: git-send-email 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48962>

The <pattern> for -l is now a shell pattern, not a list of grep parameters.
Option -l may be repeated with another <pattern>.

The new -n [<num>] option specifies how many lines from
the annotation are to be printed.
Not specifieing -n or -n 0 will just produce the tag names
Just -n or -n 1 will show the first line of the annotation on
the tag line.
Other valuse for -n will show that number of lines from the annotation.

The exit code used to indicate if any tag was found.
This is changed due to a different implementation.

A good way to test a tag for existence is to use:
git show-ref --quiet --verify refs/tags/$TAGNAME

Signed-off-by: Matthijs Melchior <mmelchior@xs4all.nl>
---
 Documentation/git-tag.txt |   13 +++++++++----
 git-tag.sh                |   44 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 4e3e027..aee2c1b 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<head>]
 'git-tag' -d <name>...
-'git-tag' -l [<pattern>]
+'git-tag' [-n [<num>]] -l [<pattern>]
 'git-tag' -v <name>
 
 DESCRIPTION
@@ -38,8 +38,8 @@ GnuPG key for signing.
 
 `-v <tag>` verifies the gpg signature of the tag.
 
-`-l <pattern>` lists tags that match the given pattern (or all
-if no pattern is given).
+`-l <pattern>` lists tags with names that match the given pattern
+(or all if no pattern is given).
 
 OPTIONS
 -------
@@ -61,8 +61,13 @@ OPTIONS
 -v::
 	Verify the gpg signature of given the tag
 
+-n <num>::
+	<num> specifies how many lines from the annotation, if any,
+	are printed when using -l.
+	The default is not to print any annotation lines.
+
 -l <pattern>::
-	List tags that match the given pattern (or all if no pattern is given).
+	List tags with names that match the given pattern (or all if no pattern is given).
 
 -m <msg>::
 	Use the given tag message (instead of prompting)
diff --git a/git-tag.sh b/git-tag.sh
index 6f0b7a7..1563696 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2005 Linus Torvalds
 
-USAGE='-l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg>] <tagname> [<head>]'
+USAGE='[-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg>] <tagname> [<head>]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
@@ -13,6 +13,7 @@ message=
 username=
 list=
 verify=
+LINES=0
 while case "$#" in 0) break ;; esac
 do
     case "$1" in
@@ -26,14 +27,41 @@ do
     -f)
 	force=1
 	;;
-    -l)
-	case "$#" in
-	1)
-		set x . ;;
+    -n)
+        case $2 in
+	-*)	LINES=1 	# no argument
+		;;
+	*)	shift
+		LINES=$(expr "$1" : '\([0-9]*\)')
+		[ -z "$LINES" ] && LINES=1 # 1 line is default when -n is used
+		;;
 	esac
+	;;
+    -l)
+	list=1
 	shift
-	git rev-parse --symbolic --tags | sort | grep "$@"
-	exit $?
+	PATTERN="$1"	# select tags by shell pattern, not re
+	git rev-parse --symbolic --tags | sort |
+	    while read TAG
+	    do
+	        case "$TAG" in
+		*$PATTERN*) ;;
+		*)	    continue ;;
+		esac
+		[ "$LINES" -le 0 ] && { echo "$TAG"; continue ;}
+		OBJTYPE=$(git cat-file -t "$TAG")
+		case $OBJTYPE in
+		tag)	ANNOTATION=$(git cat-file tag "$TAG" |
+			    	       sed -e '1,/^$/d' \
+					   -e '/^-----BEGIN PGP SIGNATURE-----$/Q' )
+			printf "%-15s %s\n" "$TAG" "$ANNOTATION" |
+			  sed -e '2,$s/^/    /' \
+			      -e "${LINES}q"
+			;;
+		*)      echo "$TAG"
+			;;
+		esac
+	    done
 	;;
     -m)
     	annotate=1
@@ -97,6 +125,8 @@ do
     shift
 done
 
+[ -n "$list" ] && exit 0
+
 name="$1"
 [ "$name" ] || usage
 prev=0000000000000000000000000000000000000000
-- 
1.5.2
