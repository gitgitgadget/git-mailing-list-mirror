From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Please pull mergetool.git
Date: Sun, 10 Jun 2007 12:03:33 -0400
Message-ID: <E1HxPt7-0007jV-6V@candygram.thunk.org>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 18:04:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxPtY-00076Y-Cy
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 18:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbXFJQDl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753576AbXFJQDl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 12:03:41 -0400
Received: from thunk.org ([69.25.196.29]:40069 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbXFJQDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 12:03:40 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HxQ0d-0001hK-C1; Sun, 10 Jun 2007 12:11:19 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HxPt7-0007jV-6V; Sun, 10 Jun 2007 12:03:33 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49747>

Hi Junio,

Please pull from the "mergetool" branch at:
	git://repo.or.cz/git/mergetool.git mergetool

It adds support for vimdiff/gvimdiff as a mergetool program, as well
Josh's suggestion of making the default merge-tool selection more
intelligent, although I've rewritten it somewhat take into account the
comments made by you and others on the git mailing list.

(Note that as of this writing, meld is a pretty sad/dificient tool, and
even GNOME users may very well prefer kdiff3 over meld --- which is my
default.  Still, it seems reasonable to default to using KDE tools in an
KDE login session, and GNOME tools in a GNOME login session, and people
who care differently should set their own preferences in ~/.gitconfig.)

						- Ted


Dan McGee (1):
      git-mergetool: Allow gvimdiff to be used as a mergetool

Theodore Ts'o (2):
      git-mergetool: Make default selection of merge-tool more intelligent
      Add git-applymbox, git-applypatch, and *~ to .gitignore

 b/.gitignore                      |    3 ++
 b/Documentation/config.txt        |    2 -
 b/Documentation/git-mergetool.txt |    2 -
 b/git-mergetool.sh                |   46 +++++++++++++++++++++++---------------
 git-mergetool.sh                  |   12 ++++++++-
 5 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/.gitignore b/.gitignore
index 27e5aeb..70a4a68 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,6 +7,8 @@ git-add--interactive
 git-am
 git-annotate
 git-apply
+git-applymbox
+git-applypatch
 git-archimport
 git-archive
 git-bisect
@@ -161,6 +163,7 @@ git-core.spec
 *.exe
 *.[ao]
 *.py[co]
+*~
 config.mak
 autom4te.cache
 config.cache
diff --git a/Documentation/config.txt b/Documentation/config.txt
index de408b6..a2057d9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -531,7 +531,7 @@ merge.summary::
 merge.tool::
 	Controls which merge resolution program is used by
 	gitlink:git-mergetool[l].  Valid values are: "kdiff3", "tkdiff",
-	"meld", "xxdiff", "emerge", "vimdiff", and "opendiff"
+	"meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and "opendiff".
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index b89c51c..6c32c6d 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -25,7 +25,7 @@ OPTIONS
 -t or --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, and opendiff
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, and opendiff
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable merge.tool.  If the
diff --git a/git-mergetool.sh b/git-mergetool.sh
index bb21b03..7b66309 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -215,6 +215,12 @@ merge_file () {
 	    check_unchanged
 	    save_backup
 	    ;;
+	gvimdiff)
+		touch "$BACKUP"
+		gvimdiff -f -- "$LOCAL" "$path" "$REMOTE"
+		check_unchanged
+		save_backup
+		;;
 	xxdiff)
 	    touch "$BACKUP"
 	    if base_present ; then
@@ -293,7 +299,7 @@ done
 if test -z "$merge_tool"; then
     merge_tool=`git-config merge.tool`
     case "$merge_tool" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | "")
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | "")
 	    ;; # happy
 	*)
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
@@ -304,28 +310,42 @@ if test -z "$merge_tool"; then
 fi
 
 if test -z "$merge_tool" ; then
-    if type kdiff3 >/dev/null 2>&1 && test -n "$DISPLAY"; then
-	merge_tool="kdiff3";
-    elif type tkdiff >/dev/null 2>&1 && test -n "$DISPLAY"; then
-	merge_tool=tkdiff
-    elif type xxdiff >/dev/null 2>&1 && test -n "$DISPLAY"; then
-	merge_tool=xxdiff
-    elif type meld >/dev/null 2>&1 && test -n "$DISPLAY"; then
-	merge_tool=meld
-    elif type opendiff >/dev/null 2>&1; then
-	merge_tool=opendiff
-    elif type emacs >/dev/null 2>&1; then
-	merge_tool=emerge
-    elif type vimdiff >/dev/null 2>&1; then
-	merge_tool=vimdiff
-    else
+    if test -n "$DISPLAY"; then
+        merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
+        if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
+            merge_tool_candidates="meld $merge_tool_candidates"
+        fi
+        if test "$KDE_FULL_SESSION" = "true"; then
+            merge_tool_candidates="kdiff3 $merge_tool_candidates"
+        fi
+    fi
+    if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
+        merge_tool_candidates="$merge_tool_candidates emerge"
+    fi
+    if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
+        merge_tool_candidates="$merge_tool_candidates vimdiff"
+    fi
+    merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
+    echo "merge tool candidates: $merge_tool_candidates"
+    for i in $merge_tool_candidates; do
+        if test $i = emerge ; then
+            cmd=emacs
+        else
+            cmd=$i
+        fi
+        if type $cmd > /dev/null 2>&1; then
+            merge_tool=$i
+            break
+        fi
+    done
+    if test -z "$merge_tool" ; then
 	echo "No available merge resolution programs available."
 	exit 1
     fi
 fi
 
 case "$merge_tool" in
-    kdiff3|tkdiff|meld|xxdiff|vimdiff|opendiff)
+    kdiff3|tkdiff|meld|xxdiff|vimdiff|gvimdiff|opendiff)
 	if ! type "$merge_tool" > /dev/null 2>&1; then
 	    echo "The merge tool $merge_tool is not available"
 	    exit 1
