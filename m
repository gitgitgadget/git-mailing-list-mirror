From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Wed, 15 Feb 2012 16:49:47 +0100
Message-ID: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 15 16:51:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxh7O-00043h-3K
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 16:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab2BOPuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 10:50:00 -0500
Received: from mx2.imag.fr ([129.88.30.17]:50034 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708Ab2BOPt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 10:49:59 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q1FFkUTC010550
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 Feb 2012 16:46:30 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Rxh7A-0006cE-AD; Wed, 15 Feb 2012 16:49:52 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Rxh7A-0003xt-5V; Wed, 15 Feb 2012 16:49:52 +0100
X-Mailer: git-send-email 1.7.9.111.gf3fb0.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 15 Feb 2012 16:46:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1FFkUTC010550
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1329925594.10395@jrZHstgkRn+7Jyf8d0IIbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190836>

git-latexdiff is a wrapper around latexdiff
(http://www.ctan.org/pkg/latexdiff) that allows using it to diff two
revisions of a LaTeX file.

git-latexdiff is made to work on documents split accross multiple .tex
files (plus possibly figures and other non-diffable files), hence could
not be implemented as a per-file diff driver.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

It seems at least one person is interested in my script, so it
probably deserves to be in contrib/ ;-).

 contrib/latex/Makefile      |   22 ++++
 contrib/latex/README        |   12 +++
 contrib/latex/git-latexdiff |  222 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+), 0 deletions(-)
 create mode 100644 contrib/latex/Makefile
 create mode 100644 contrib/latex/README
 create mode 100755 contrib/latex/git-latexdiff

diff --git a/contrib/latex/Makefile b/contrib/latex/Makefile
new file mode 100644
index 0000000..4617906
--- /dev/null
+++ b/contrib/latex/Makefile
@@ -0,0 +1,22 @@
+-include ../../config.mak
+-include ../../config.mak.autogen
+
+ifndef SHELL_PATH
+	SHELL_PATH = /bin/sh
+endif
+
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
+
+SCRIPT=git-latexdiff
+
+.PHONY: install help
+help:
+	@echo 'This is the help target of the Makefile. Current configuration:'
+	@echo '  gitexecdir = $(gitexecdir_SQ)'
+	@echo '  SHELL_PATH = $(SHELL_PATH_SQ)'
+	@echo 'Run "$(MAKE) install" to install $(SCRIPT) in gitexecdir.'
+
+install:
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' $(SCRIPT) > '$(gitexecdir_SQ)/$(SCRIPT)'
+	chmod 755 '$(gitexecdir)/$(SCRIPT)'
diff --git a/contrib/latex/README b/contrib/latex/README
new file mode 100644
index 0000000..2d7fdd6
--- /dev/null
+++ b/contrib/latex/README
@@ -0,0 +1,12 @@
+git-latexdiff is a wrapper around latexdiff
+(http://www.ctan.org/pkg/latexdiff) that allows using it to diff two
+revisions of a LaTeX file.
+
+The script internally checks out the full tree for the specified
+revisions, and calls latexdiff with the --flatten option, hence this
+works if the document is split into multiple .tex files.
+
+Try "git latexdiff -h" for more information.
+
+To install, either drop git-latexdiff in your $PATH, or run "make
+install".
diff --git a/contrib/latex/git-latexdiff b/contrib/latex/git-latexdiff
new file mode 100755
index 0000000..13aeb9a
--- /dev/null
+++ b/contrib/latex/git-latexdiff
@@ -0,0 +1,222 @@
+#! /bin/sh
+
+# Author: Matthieu Moy <Matthieu.Moy@imag.fr> (2012)
+
+# Missing features (patches welcome ;-) :
+# - diff the index or the current worktree 
+# - checkout only a subdirectory of the repo
+# - hardlink temporary checkouts as much as possible
+
+usage () {
+            cat << EOF
+Usage: $(basename $0) [options] OLD [NEW]
+Call latexdiff on two Git revisions of a file.
+
+OLD and NEW are Git revision identifiers. NEW defaults to HEAD.
+
+Options:
+	--help		This help message
+	--main FILE.tex	Name of the main LaTeX file
+	--no-view	Don't display the resulting PDF file
+	--view		View the resulting PDF file
+			(default if -o is not used)
+	--no-cleanup	Don't cleanup temp dir after running
+	-o FILE, --output FILE
+			Copy resulting PDF into FILE
+			(usually ending with .pdf)
+EOF
+}
+
+die () {
+    echo "fatal: $@"
+    exit 1
+}
+
+verbose () {
+    if [ "$verbose" = 1 ]; then
+	printf "%s ..." "$@"
+    fi
+}
+
+verbose_progress () {
+    if [ "$verbose" = 1 ]; then
+	printf "." "$@"
+    fi
+}
+
+verbose_done () {
+    if [ "$verbose" = 1 ]; then
+	echo " done."
+    fi
+}
+
+old=
+new=
+main=
+view=maybe
+cleanup=1
+verbose=0
+output=
+initial_dir=$PWD
+
+while test $# -ne 0; do
+    case "$1" in
+        "--help"|"-h")
+            usage
+            exit 0
+            ;;
+	"--main")
+	    shift
+	    main=$1
+	    ;;
+	"--no-view")
+	    view=0
+	    ;;
+	"--view")
+	    view=1
+	    ;;
+	"--no-cleanup")
+	    cleanup=0
+	    ;;
+	"-o"|"--output")
+	    shift
+	    output=$1
+	    ;;
+	"--verbose"|"-v")
+	    verbose=1
+	    ;;
+        *)
+	    if [ "$1" = "" ]; then
+		echo "Empty string not allowed as argument"
+		usage
+		exit 1
+	    elif [ "$old" = "" ]; then
+		old=$1
+	    elif [ "$new" = "" ]; then
+		new=$1
+	    else
+		echo "Bad argument $1"
+		usage
+		exit 1
+	    fi
+            ;;
+    esac
+    shift
+done
+
+if [ "$new" = "" ]; then
+    new=HEAD
+fi
+
+if [ "$old" = "" ]; then
+    echo "fatal: Please, provide at least one revision to diff with."
+    usage
+    exit 1
+fi
+
+if [ "$main" = "" ]; then
+    printf "%s" "No --main provided, trying to guess ... "
+    main=$(git grep -l '^[ \t]*\\documentclass')
+    # May return multiple results, but if so the result won't be a file.
+    if [ -r "$main" ]; then
+	echo "Using $main as the main file."
+    else
+	if [ "$main" = "" ]; then
+	    echo "No candidate for main file."
+	else
+	    echo "Multiple candidates for main file:"
+	    printf "%s\n" "$main" | sed 's/^/\t/'
+	fi
+	die "Please, provide a main file with --main FILE.tex."
+    fi
+fi
+
+if [ ! -r "$main" ]; then
+    die "Cannot read $main."
+fi
+
+verbose "Creating temporary directories"
+
+git_prefix=$(git rev-parse --show-prefix)
+cd "$(git rev-parse --show-cdup)" || die "Can't cd back to repository root"
+git_dir="$(git rev-parse --git-dir)" || die "Not a git repository?"
+git_dir=$(cd "$git_dir"; pwd)
+
+main=$git_prefix/$main
+
+tmpdir=$initial_dir/git-latexdiff.$$
+mkdir "$tmpdir" || die "Cannot create temporary directory."
+
+cd "$tmpdir" || die "Cannot cd to $tmpdir"
+
+mkdir old new diff || die "Cannot create old, new and diff directories."
+
+verbose_done
+verbose "Checking out old and new version"
+
+cd old || die "Cannot cd to old/"
+git --git-dir="$git_dir" --work-tree=. checkout "$old" -- . || die "checkout failed for old/"
+verbose_progress
+cd ../new || die "Cannot cd to new/"
+git --git-dir="$git_dir" --work-tree=. checkout "$new" -- . || die "checkout failed for new/"
+verbose_progress
+cd ..
+
+verbose_done
+verbose "Running latexdiff --flatten old/$main new/$main > $main"
+
+latexdiff --flatten old/"$main" new/"$main" > diff.tex || die "latexdiff failed"
+
+mv -f diff.tex new/"$main"
+
+verbose_done
+
+mainbase=$(basename "$main" .tex)
+maindir=$(dirname "$main")
+
+verbose "Compiling result"
+
+compile_error=0
+cd new/"$maindir" || die "Can't cd to new/$maindir"
+if [ -f Makefile ]; then
+    make || compile_error=1
+else
+    pdflatex --interaction errorstopmode "$mainbase" || compile_error=1
+fi
+
+verbose_done
+
+pdffile="$mainbase".pdf
+if [ ! -r "$pdffile" ]; then
+    echo "No PDF file generated."
+    compile_error=1
+fi
+
+if [ ! -s "$pdffile" ]; then
+    echo "PDF file generated is empty."
+    compile_error=1
+fi
+
+if [ "$compile_error" = "1" ]; then
+    echo "Error during compilation. Please examine and cleanup if needed:"
+    echo "Directory: $tmpdir/new/$maindir/"
+    echo "     File: $mainbase.tex"
+    # Don't clean up to let the user diagnose.
+    exit 1
+fi
+
+if [ "$output" != "" ]; then
+    abs_pdffile="$PWD/$pdffile"
+    (cd "$initial_dir" && cp "$abs_pdffile" "$output")
+    echo "Output written on $output"
+fi
+
+if [ "$view" = 1 ] || [ "$view" = maybe ] && [ "$output" = "" ]; then
+    xpdf "$pdffile"
+fi
+
+if [ "$cleanup" = 1 ]; then
+    verbose "Cleaning-up result"
+    rm -fr "$tmpdir"
+    verbose_done
+fi
-- 
1.7.9.111.gf3fb0.dirty
