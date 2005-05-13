From: David Greaves <david@dgreaves.com>
Subject: [PATCH 1/2] update cg-Xignore
Date: Fri, 13 May 2005 23:31:52 +0100
Message-ID: <E1DWihE-000790-Ub@ash.dgreaves.com>
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 00:33:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWiio-0002rr-Cx
	for gcvg-git@gmane.org; Sat, 14 May 2005 00:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVEMWdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVEMWdQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 18:33:16 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:26071 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262598AbVEMWcC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 18:32:02 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id A14C0E6E41; Fri, 13 May 2005 23:30:28 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09785-16; Fri, 13 May 2005 23:30:28 +0100 (BST)
Received: from oak.dgreaves.com (modem-1435.lemur.dialup.pol.co.uk [217.135.133.155])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 48FA3E6E39; Fri, 13 May 2005 23:30:27 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWihF-0006uT-5j; Fri, 13 May 2005 23:31:53 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1DWihE-000790-Ub; Fri, 13 May 2005 23:31:52 +0100
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update Documentation to Jonas' style
Add -0 to allow null terminated lines (slightly buggy)
Add -t to cope with git-ls-files -t output

Signed-off-by: David Greaves <david@dgreaves.com>

---
commit 2fca920e6d3ccb92e9782bcf02f860b8333e23d9
tree d2490ad0bc8b38647c6baff9da3e72c0f25e9f35
parent fbb4054b80189c58f0b289dc34320f2b2de56d24
author David Greaves <david@dgreaves.com> Fri, 13 May 2005 23:17:18 +0100
committer David Greaves <david@ash.(none)> Fri, 13 May 2005 23:17:18 +0100

 cg-Xignore |   57 +++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 41 insertions(+), 16 deletions(-)

Index: cg-Xignore
===================================================================
--- 9a39ca9b1e7dd28ddb4a1908ccb59787f432d752/cg-Xignore  (mode:100755)
+++ d2490ad0bc8b38647c6baff9da3e72c0f25e9f35/cg-Xignore  (mode:100755)
@@ -1,14 +1,20 @@
 #!/usr/bin/env bash
 #
-# Takes a list of files on stdin and only passes valid ones agording to .git/ignore
+# Takes a list of files on stdin and only passes valid ones according to .git/ignore
 # Copyright (c) David Greaves, 2005
 #
+# DESCRIPTION
+# -----------
 # This filter implements cogito ignore rules and should typically be used in find pipelines
 #
-# Synopsis
-# cg-Xignore [-debug] [-f] [-h] [-d] < file-list >useful-file-list
 #
-# Options
+# OPTIONS
+# -------
+# -0::
+#     processes null terminated lines
+#     this is buggy and uses \n internally so any files with a \n
+#     in will break it. Tough - don't use shell scripts.
+#
 # -debug::
 #     produce helpful debug output
 #
@@ -24,18 +30,26 @@
 # -h::
 #     passes symbolic links
 #
-# The default is to pass all file types that are not ignored.
+# -t::
+#     cope with files preceded by a 'tag'. eg from git-ls-files -t
+#
+# The default is to pass all file types.
 #
 # Note that the .git/ignore file contains multiple expressions, 1 per line
 # Lines beginning with a '#' are ignored (allowing comments)
 # These are 'bash regular expressions' not glob patterns
 # This allows ignore rules to take the directory into account
-# Suggested contents:
+#
+# Example .git/ignore
+# -------------------
+#
 #   # bash regexps (not globs)
 #   ^\.[^/]
 #   /\.
 #   /$
 #   .*\.o$
+#
+USAGE="cg-Xignore [-0] [-debug] [-q] [-f] [-h] [-d] [-t] < file-list >useful-file-list"
 
 
 # This doesn't allow the -h which is the [ arg for symlinks...
@@ -44,19 +58,22 @@
 
 IGNORE_FILE="$_git/ignore"
 
-if [ "$1" = "-0" ]; then
-    # doesn't work :(
-    zerosep=$'-d "\0"'
-    shift
-fi
 
 # Defaults
 pass_files=0
 pass_dirs=0
 pass_links=0
 pass_all=1
+stripzero='cat'
+rezero='cat'
 while [ $# -gt 0 ]; do
     case $1 in
+	"-0")
+            # doesn't work :(
+	    #zerosep=$'-d \0'
+	    stripzero='tr "\000" "\n"'
+	    rezero='tr "\n" "\000"'
+	    ;;
 	"-f")
 	    pass_all=0
 	    pass_files=1
@@ -75,6 +92,9 @@
 	"-debug")
 	    debug=1
 	    ;;
+	"-t")
+	    tagged=1
+	    ;;
 	esac
     shift
 done
@@ -92,10 +112,15 @@
     exec 4>/dev/null
 fi
 
-
 # Strip out the common leading ./ allowing "find ."
-sed 's:^./::' | \
+$stripzero | sed "s:^./::" | \
 while read $zerosep file; do
+    tag=""
+    if [ $tagged ]; then
+	tag=${file% *}
+	fname=${file#* }
+	file=$fname
+    fi
     echo "consider file: $file" >&4
     ignore=0
     if [ -f $IGNORE_FILE ]; then
@@ -112,7 +137,6 @@
 	    fi
 	done
     fi
-    echo "passing file: $file" >&4
     
     if [ $ignore != "1" \
 	-a \( $pass_all -eq 1 \
@@ -121,6 +145,7 @@
 	   -o \( $pass_links -eq 1 -a -h "$file" \) \
 	   \) \
 	]; then
-	echo "$file"
+	echo "passing file: $file" >&4
+	echo "$tag$file"
     fi
-done
+done | $rezero
