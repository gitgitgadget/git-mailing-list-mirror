From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Refactored merge options into separate merge-options.txt.
Date: Sun, 06 Nov 2005 23:30:56 -0600
Message-ID: <E1EYzaq-0003py-6f@jdl.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 06:32:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYzbj-0005Vz-Nn
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 06:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVKGFbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 00:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVKGFbD
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 00:31:03 -0500
Received: from colo.jdl.com ([66.118.10.122]:14784 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964775AbVKGFbC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 00:31:02 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EYzaq-0003py-6f
	for git@vger.kernel.org; Sun, 06 Nov 2005 23:30:58 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11256>


Refactored fetch options into separate fetch-options.txt.
Made git-merge use merge-options.
Made git-fetch use fetch-options.
Made git-pull use merge-options and fetch-options.
Added --help option to git-pull and git-format-patch scripts.
Rewrote Documentation/Makefile to dynamically determine
include dependencies.

Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 Documentation/Makefile            |   23 +++++++++++++----------
 Documentation/fetch-options.txt   |   14 ++++++++++++++
 Documentation/git-fetch.txt       |   16 ++++------------
 Documentation/git-merge.txt       |    2 +-
 Documentation/git-pull.txt        |   17 +++++++----------
 Documentation/merge-options.txt   |   16 ++++++++++++++++
 Documentation/merge-pull-opts.txt |   14 --------------
 git-format-patch.sh               |    4 ++++
 git-pull.sh                       |   12 +++++++++++-
 9 files changed, 70 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/fetch-options.txt
 create mode 100644 Documentation/merge-options.txt
 delete mode 100644 Documentation/merge-pull-opts.txt
 mode change 100755 => 100644 git-pull.sh

applies-to: ba0221fabc6d203e08fbe63442e816ed84193bb1
2cf02ee5ec5f3b5ecaec5a80399988661ea5117b
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 741f14c..b8f62cb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -49,22 +49,25 @@ install: man
 	$(INSTALL) $(DOC_MAN1) $(DESTDIR)/$(man1)
 	$(INSTALL) $(DOC_MAN7) $(DESTDIR)/$(man7)
 
-# 'include' dependencies
-$(patsubst %.txt,%.1,$(wildcard git-diff-*.txt)): \
-	diff-format.txt diff-options.txt
-$(patsubst %.txt,%.html,$(wildcard git-diff-*.txt)): \
-	diff-format.txt diff-options.txt
 
-$(patsubst %,%.1,git-fetch git-pull git-push): pull-fetch-param.txt
-$(patsubst %,%.html,git-fetch git-pull git-push): pull-fetch-param.txt
+#
+# Determine "include::" file references in asciidoc files.
+#
+TEXTFILES = $(wildcard *.txt)
+DEPFILES = $(TEXTFILES:%.txt=%.dep)
+
+%.dep : %.txt
+	@rm -rf $@
+	@$(foreach dep, $(shell grep include:: $< | sed -e 's/include::/ /' -e 's/\[\]//'), \
+		echo $(<:%.txt=%.html) $(<:%.txt=%.1) : $(dep) >> $@; )
 
-$(patsubst %,%.1,git-merge git-pull): merge-pull-opts.txt
-$(patsubst %,%.html,git-merge git-pull): merge-pull-opts.txt
+-include $(DEPFILES)
 
 git.7: ../README
 
+
 clean:
-	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html
+	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html *.dep
 
 %.html : %.txt
 	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
new file mode 100644
index 0000000..12d12b2
--- /dev/null
+++ b/Documentation/fetch-options.txt
@@ -0,0 +1,14 @@
+-a, \--append::
+	Append ref names and object names of fetched refs to the
+	existing contents of `.git/FETCH_HEAD`.  Without this
+	option old data in `.git/FETCH_HEAD` will be overwritten.
+
+-f, \--force::
+
+-t, \--tags::
+
+-u, \--update-head-ok::
+	By default `git-fetch` refuses to update the head which
+	corresponds to the current branch.  This flag disables the
+	check.  Note that fetching into the current branch will not
+	update the index and working directory, so use it with care.
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 73f8a99..438240c 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -8,7 +8,7 @@ git-fetch - Download objects and a head 
 
 SYNOPSIS
 --------
-'git-fetch' <repository> <refspec>...
+'git-fetch' <options> <repository> <refspec>...
 
 
 DESCRIPTION
@@ -17,24 +17,16 @@ Fetches named heads or tags from another
 the objects necessary to complete them.
 
 The ref names and their object names of fetched refs are stored
-in $GIT_DIR/FETCH_HEAD.  This information is left for a later merge
+in `.git/FETCH_HEAD`.  This information is left for a later merge
 operation done by "git resolve" or "git octopus".
 
 
 OPTIONS
 -------
+include::fetch-options.txt[]
+
 include::pull-fetch-param.txt[]
 
--a, \--append::
-	Append ref names and object names of fetched refs to the
-	existing contents of $GIT_DIR/FETCH_HEAD.  Without this
-	option old data in $GIT_DIR/FETCH_HEAD will be overwritten.
-
--u, \--update-head-ok::
-	By default 'git-fetch' refuses to update the head which
-	corresponds to the current branch.  This flag disables the
-	check.  Note that fetching into the current branch will not
-	update the index and working directory, so use it with care.
 
 
 SEE ALSO
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b3ef19b..904e2fc 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -19,7 +19,7 @@ which drives multiple merge strategy scr
 
 OPTIONS
 -------
-include::merge-pull-opts.txt[]
+include::merge-options.txt[]
 
 <msg>::
 	The commit message to be used for the merge commit (in case
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 7ebb08d..c65ca9a 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -20,21 +20,18 @@ Note that you can use `.` (current direc
 <repository> to pull from the local repository -- this is useful
 when merging local branches into the current branch.
 
+
 OPTIONS
 -------
-include::pull-fetch-param.txt[]
+include::merge-options.txt[]
 
--a, \--append::
-	Append ref names and object names of fetched refs to the
-	existing contents of `$GIT_DIR/FETCH_HEAD`.  Without this
-	option old data in `$GIT_DIR/FETCH_HEAD` will be overwritten.
+include::fetch-options.txt[]
 
-include::merge-pull-opts.txt[]
+include::pull-fetch-param.txt[]
 
 include::merge-strategies.txt[]
 
 
-
 EXAMPLES
 --------
 
@@ -72,7 +69,7 @@ $ git fetch origin master:origin +pu:pu 
 $ git pull . origin
 ------------------------------------------------
 +
-Here, a typical `$GIT_DIR/remotes/origin` file from a
+Here, a typical `.git/remotes/origin` file from a
 `git-clone` operation is used in combination with
 command line options to `git-fetch` to first update
 multiple branches of the local repository and then
@@ -85,7 +82,7 @@ known to have already obtained and made 
 all the necessary objects.
 
 
-Pull of multiple branches from one repository using `$GIT_DIR/remotes` file::
+Pull of multiple branches from one repository using `.git/remotes` file::
 +
 ------------------------------------------------
 $ cat .git/remotes/origin
@@ -98,7 +95,7 @@ $ git checkout master
 $ git pull origin
 ------------------------------------------------
 +
-Here, a typical `$GIT_DIR/remotes/origin` file from a
+Here, a typical `.git/remotes/origin` file from a
 `git-clone` operation has been hand-modified to include
 the branch-mapping of additional remote and local
 heads directly.  A single `git-pull` operation while
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
new file mode 100644
index 0000000..eebaf3a
--- /dev/null
+++ b/Documentation/merge-options.txt
@@ -0,0 +1,16 @@
+-n, \--no-summary::
+	Do not show diffstat at the end of the merge.
+
+--no-commit::
+	Perform the merge but pretend the merge failed and do
+	not autocommit, to give the user a chance to inspect and
+	further tweak the merge result before committing.
+
+
+-s <strategy>, \--strategy=<strategy>::
+	Use the given merge strategy; can be supplied more than
+	once to specify them in the order they should be tried.
+	If there is no `-s` option, a built-in list of strategies
+	is used instead (`git-merge-resolve` when merging a single
+	head, `git-merge-octopus` otherwise).
+
diff --git a/Documentation/merge-pull-opts.txt b/Documentation/merge-pull-opts.txt
deleted file mode 100644
index d9164a0..0000000
--- a/Documentation/merge-pull-opts.txt
+++ /dev/null
@@ -1,14 +0,0 @@
--n, --no-summary::
-	Do not show diffstat at the end of the merge.
-
---no-commit::
-	Perform the merge but pretend the merge failed and do
-	not autocommit, to give the user a chance to inspect and
-	further tweak the merge result before committing.
-
--s <strategy>::
-	use that merge strategy; can be given more than once to
-	specify them in the order they should be tried.  If
-	there is no `-s` option, built-in list of strategies is
-	used instead (`git-merge-resolve` when merging a single
-	head, `git-merge-octopus` otherwise).
diff --git a/git-format-patch.sh b/git-format-patch.sh
index b43ba39..548d2d5 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -8,6 +8,7 @@
 usage () {
     echo >&2 "usage: $0"' [-n] [-o dir | --stdout] [--keep-subject] [--mbox]
     [--check] [--signoff] [-<diff options>...]
+    [--help]
     ( from..to ... | upstream [ our-head ] )
 
 Prepare each commit with its patch since our-head forked from upstream,
@@ -63,6 +64,9 @@ do
     --output-directo|--output-director|--output-directory)
     case "$#" in 1) usage ;; esac; shift
     outdir="$1" ;;
+    -h|--h|--he|--hel|--help)
+        usage
+	;;
     -*' '* | -*"$LF"* | -*'	'*)
 	# Ignore diff option that has whitespace for now.
 	;;
diff --git a/git-pull.sh b/git-pull.sh
old mode 100755
new mode 100644
index e23d4f5..2358af6
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -7,7 +7,14 @@
 . git-sh-setup || die "Not a git archive"
 
 usage () {
-    die "git pull [-n] [--no-commit] [-s strategy]... <repo> <head>..."
+    echo >&2 "usage: $0"' [-n] [--no-commit] [--no-summary] [--help]
+    [-s strategy]...
+    [<fetch-options>]
+    <repo> <head>...
+
+Fetch one or more remote refs and merge it/them into the current HEAD.
+'
+    exit 1
 }
 
 strategy_args= no_summary= no_commit=
@@ -33,6 +40,9 @@ do
 		esac
 		strategy_args="${strategy_args}-s $strategy "
 		;;
+	-h|--h|--he|--hel|--help)
+		usage
+		;;
 	-*)
 		# Pass thru anything that is meant for fetch.
 		break
---
0.99.9.GIT
