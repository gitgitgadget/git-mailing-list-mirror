From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] mergetool: added support for kdiff3 on windows
Date: Sat, 11 Aug 2007 01:56:01 +0200
Message-ID: <11867901621009-git-send-email-prohaska@zib.de>
References: <11867901612954-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, torgil.svensson@gmail.com,
	Johannes.Schindelin@gmx.de, tytso@mit.edu
X-From: git-owner@vger.kernel.org Sat Aug 11 01:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJeL2-0003jZ-RR
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 01:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbXHJX4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 19:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754640AbXHJX4K
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 19:56:10 -0400
Received: from mailer.zib.de ([130.73.108.11]:62212 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926AbXHJX4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 19:56:08 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7ANu2Mo007589;
	Sat, 11 Aug 2007 01:56:02 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7ANu1eN023484;
	Sat, 11 Aug 2007 01:56:02 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11867901612954-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55578>

kdiff3's homepage is http://kdiff3.sourceforge.net/.

kdiff3 is automatically added to the available
mergetools if its path is found in the Windows
Registry. Be sure to set

    git config core.autocrlf true

kdiff3 seems to follow Windows crlf convention.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-mergetool.sh |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)


This patch was developed against msysgit, and is add
functionality specific to Windows. It should also apply
against git.git's master and shouldn't do any harm
to the handling of mergetools on platforms other than
Windows

It was tested on a Windows with german localization. I'd
be interested if the lookup of kdiff3 works on other
localizations, too.

Handling mergetools that needs an absolute path is a bit
hacky. merge_tool is mostly used as an alias but also as
the name of an executable. A level of indirection would
be nice for handling absolute paths.

kdiff3 on Windows doesn't accept '--' on it's commandline.
Is '--' really needed on other platforms? I replaced it by
the variable KDIFF3SEPARATOR.

	Steffen


diff --git a/git-mergetool.sh b/git-mergetool.sh
index 90a69b3..9f64e7c 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -14,6 +14,7 @@ SUBDIRECTORY_OK=Yes
 require_work_tree
 
 KDIFF3=kdiff3
+KDIFF3SEPARATOR=--
 
 # Returns true if the mode reflects a symlink
 is_symlink () {
@@ -194,10 +195,10 @@ merge_file () {
 	kdiff3)
 	    if base_present ; then
 		("$KDIFF3" --auto --L1 "$path (Base)" -L2 "$path (Local)" --L3 "$path (Remote)" \
-		    -o "$path" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		    -o "$path" $KDIFF3SEPERATOR "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    else
 		("$KDIFF3" --auto -L1 "$path (Local)" --L2 "$path (Remote)" \
-		    -o "$path" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		    -o "$path" $KDIFF3SEPERATOR "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    fi
 	    status=$?
 	    remove_backup
@@ -321,6 +322,11 @@ if test -z "$merge_tool" ; then
             merge_tool_candidates="kdiff3 $merge_tool_candidates"
         fi
     fi
+    regentry="$(REG QUERY 'HKEY_LOCAL_MACHINE\SOFTWARE\KDiff3\diff-ext' 2>/dev/null)" && {
+        KDIFF3=$(echo "$regentry" | grep diffcommand | cut -f 3)
+        KDIFF3SEPARATOR=
+        merge_tool_candidates="$merge_tool_candidates kdiff3"
+    } 
     if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
         merge_tool_candidates="$merge_tool_candidates emerge"
     fi
@@ -332,10 +338,12 @@ if test -z "$merge_tool" ; then
     for i in $merge_tool_candidates; do
         if test $i = emerge ; then
             cmd=emacs
+        elif test $i = kdiff3 ; then
+            cmd="$KDIFF3"
         else
             cmd=$i
         fi
-        if type $cmd > /dev/null 2>&1; then
+        if type "$cmd" > /dev/null 2>&1; then
             merge_tool=$i
             break
         fi
@@ -347,7 +355,13 @@ if test -z "$merge_tool" ; then
 fi
 
 case "$merge_tool" in
-    kdiff3|tkdiff|meld|xxdiff|vimdiff|gvimdiff|opendiff)
+    kdiff3)
+	if ! type "$KDIFF3" > /dev/null 2>&1; then
+	    echo "The merge tool $merge_tool is not available"
+	    exit 1
+	fi
+	;;
+    tkdiff|meld|xxdiff|vimdiff|gvimdiff|opendiff)
 	if ! type "$merge_tool" > /dev/null 2>&1; then
 	    echo "The merge tool $merge_tool is not available"
 	    exit 1
-- 
1.5.3.rc4.744.g68381
