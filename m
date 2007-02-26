From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Merge doc/ and Documentation/ directories.
Date: Mon, 26 Feb 2007 23:09:30 +0100
Message-ID: <20070226220929.12064.98992.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 26 23:10:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLo2n-00034h-As
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 23:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbXBZWJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 17:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161283AbXBZWJk
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 17:09:40 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:53331 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161280AbXBZWJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 17:09:38 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8433A5403E;
	Mon, 26 Feb 2007 23:09:36 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 658BB1F084;
	Mon, 26 Feb 2007 23:09:30 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40669>


This merges everything into Documentation, to match the GIT layout
("make doc" did not work anyway since "doc" was not marked phony).

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/.gitignore    |    5 +
 Documentation/Makefile      |   19 ++
 Documentation/tutorial.conf |    3 
 Documentation/tutorial.txt  |  413 +++++++++++++++++++++++++++++++++++++++++++
 Makefile                    |    6 -
 doc/.gitignore              |    2 
 doc/Makefile                |   17 --
 doc/asciidoc.conf           |    3 
 doc/tutorial.txt            |  413 -------------------------------------------
 9 files changed, 443 insertions(+), 438 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
new file mode 100644
index 0000000..6da6dc4
--- /dev/null
+++ b/Documentation/.gitignore
@@ -0,0 +1,5 @@
+*.html
+*.pdf
+*.7
+*.1
+doc.dep
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7f5520c..ea387e7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -3,6 +3,13 @@ MAN7_TXT=stg.txt
 
 DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
 
+ARTICLES = 
+# with their own formatting rules.
+SP_ARTICLES = tutorial
+
+DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
+DOC_PDF += $(patsubst %,%.pdf,$(ARTICLES) $(SP_ARTICLES))
+
 DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
 DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
 
@@ -28,6 +35,7 @@ INSTALL?=install
 all: html man
 
 html: $(DOC_HTML)
+pdf: $(DOC_PDF)
 
 $(DOC_HTML) $(DOC_MAN1) $(DOC_MAN7): asciidoc.conf
 
@@ -50,7 +58,7 @@ doc.dep : $(wildcard *.txt) build-docdep.perl
 -include doc.dep
 
 clean:
-	rm -f *.xml *.html *.1 *.7 doc.dep
+	rm -f *.xml *.html *.pdf *.1 *.7 doc.dep
 
 %.html : %.txt
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $(ASCIIDOC_EXTRA) $<
@@ -60,3 +68,12 @@ clean:
 
 %.xml : %.txt
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf $<
+
+%.pdf: %.xml
+	xmlto pdf $<
+
+# special formatting rules
+tutorial.html : %.html : %.txt
+	$(ASCIIDOC) -b xhtml11 -d article -f tutorial.conf $(ASCIIDOC_EXTRA) $<
+tutorial.xml : %.xml : %.txt
+	$(ASCIIDOC) -b docbook -d article -f tutorial.conf $<
diff --git a/Documentation/tutorial.conf b/Documentation/tutorial.conf
new file mode 100644
index 0000000..5b8d95f
--- /dev/null
+++ b/Documentation/tutorial.conf
@@ -0,0 +1,3 @@
+[titles]
+underlines="##","==","--","~~","^^"
+
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
new file mode 100644
index 0000000..5899c38
--- /dev/null
+++ b/Documentation/tutorial.txt
@@ -0,0 +1,413 @@
+StGIT Tutorial
+##############
+
+
+StGIT is a Python application that provides functionality similar to
+quilt (i.e. pushing/popping patches to/from a stack) using GIT instead
+of 'diff' and 'patch'. StGIT stores its patches in a GIT repository as
+normal GIT commit objects.
+StGIT is not an SCM interface on top of GIT. For standard SCM
+operations, either use GIT's porcelain commands or the Cogito tool.
+StGIT is available for download at http://www.procode.org/stgit/ .
+This tutorial assumes you are already familiar with GIT. For more
+information on GIT, see the GIT_tutorial or git(7) .
+
+
+Basic Operation
+===============
+
+Help
+----
+
+For a full list of StGIT commands:
+
+  stg help
+
+For help on individual subcommands:
+
+  stg <cmd> (-h | --help)
+
+
+Repository initialisation
+-------------------------
+
+In stand-alone mode, StGIT is used in conjunction with a GIT repository
+that is already initialised (using 'git-init-db'). StGIT cannot be used
+outside of a GIT repository.
+Any branch in a GIT repository may be managed by StGIT. Each branch
+managed by StGIT contains an independent series of StGIT patches.
+To initialise an existing GIT branch to be managed by StGIT, cd into the
+top of your GIT repository, check out the branch you'd like to manage
+with StGIT, and type:
+
+  stg init
+
+Run the 'stg init' command for any pre-existing GIT branches intended to
+be used with StGIT.
+You can switch between GIT branches with:
+
+  stg branch [<branch name>]
+
+This checks out the named branch and places you at the topmost applied
+StGIT patch in that branch.
+Alternately, you can create branches using only StGIT commands, which
+will automatically prepare them for use with StGIT:
+
+  stg branch --create <new branch>
+
+
+Working with remote repositories
+--------------------------------
+
+With a single command, StGIT can create and initialize a GIT repository
+which mirrors a remote GIT repository. This is known as cloning. All GIT
+transports are supported.
+To clone a repository, use:
+
+  stg clone <repository> <local-dir>
+
+This creates a fresh local repository, initialises a GIT database in it,
+pulls the latest version of the remote, and creates and initialises a
+'master' branch for use with StGIT.
+At any time you can pull the latest changes from the remote repository.
+By default, StGIT pulls from the location stored in .git/branches/
+origin, and updates the base of the current branch.
+To pull the latest changes from a remote repository, use:
+
+  stg pull [<branch> or 'origin']
+
+This command removes all applied StGIT patches from the current branch,
+updates the branch's base commit, then attempts to re-apply the patches.
+Any merge conflicts will halt this process, allowing you to clean up the
+conflicts and continue (see below).
+If the maintainer of the remote repository includes one of your patches
+in the published repository that you pull from, StGIT can usually
+recognize that an incoming patch from the remote matches one of yours,
+and it turns your local version into an empty patch.
+To automatically delete empty patches after a pull, use:
+
+  stg clean
+
+As a convention, you should avoid working in the 'master' branch and use
+it only as a reference, since it reflects someone else's work. If you
+decide to publish your GIT repository, you'll want your own work
+separated into its own branch to make it convenient for others to pull
+just your patches.
+
+Getting started: creating a patch
+---------------------------------
+
+Changes to your working directory are saved in a patch. An StGIT patch
+is simply a saved set of modifications to your working directory, plus a
+saved description. To create an empty StGIT patch in the current branch:
+
+  stg new <name>
+
+To save the changes you've made (that is, to refresh a patch), use:
+
+  stg refresh
+
+To discard changes in your working directory, use:
+
+  git checkout -f
+
+This restores your working directory to the state it was in the last
+time the patch was refreshed.
+Modified files that haven't been saved via a refresh operation can be
+viewed with:
+
+  stg status
+
+You can view modified files that have already been saved into a patch:
+
+  stg files
+
+The 'stg refresh' command automatically notes changes to files that
+already exist in the working directory, but you have to tell StGIT
+explicitly if you add, remove, or rename files.
+To record the addition or deletion of files in your new patch:
+
+  stg add [<file>*]
+  stg rm [<file>*]
+
+To record the renaming of a file in your new patch, issue both of these
+commands:
+
+  stg rm <oldfilename>
+  stg add <newfilename>
+
+
+Stack manipulation: managing multiple patches
+---------------------------------------------
+
+StGIT can manage more than one patch at a time. A series of StGIT
+patches in a GIT branch are known collectively as a stack. The new patch
+you created above is now the topmost patch in your stack. You can always
+see the name of the topmost (current) patch with:
+
+  stg top
+
+The topmost patch is used as the default patch for most StGIT
+operations. It is the default target of the 'stg refresh' command, for
+example.
+Patches that are pushed onto the stack are referred to as applied, and
+patches that are popped off the stack are referred to as unapplied.
+To push/pop a patch to/from a stack:
+
+  stg push [--all | <name>]
+  stg pop [--all]
+
+The last patch you pushed is the topmost patch. This patch is always in
+the applied list; StGIT can't operate on an unapplied patch unless you
+apply it first.
+You can display the order of patches in a stack with one of these
+commands:
+
+  stg series
+  stg applied
+  stg unapplied
+
+By default the 'stg push' command applies the first patch in the
+unapplied list, but you can push any patch in the unapplied list by
+giving the name of the patch. This is useful if you want to reorder the
+patches in a stack.
+During a push operation, merge conflicts can occur (especially if you
+are changing the order of the patches in your stack). If the push causes
+merge conflicts, they need to be fixed and 'stg resolved' run (see
+below). A 'push' operation can also be reverted with 'stg push --undo'.
+A few more stack basics; to rename a patch:
+
+  stg rename <old-name> <new-name>
+
+To delete a patch:
+
+  stg delete <name>
+
+This permanently discards the named patch. In other words, the patch no
+longer appears in either the applied or unapplied lists, and cannot be
+reapplied to the series.
+You may want to make patches in your stack a permanent part of your GIT
+repository, for example if you are publishing your repository to others.
+To do this, use:
+
+  stg commit
+
+This merges all applied patches in your patch series into the GIT
+repository and removes them from your stack. Use this command only if
+you want to permanently store the applied patches and no longer manage
+them with StGIT.
+
+Converting between StGIT patches and text diffs
+-----------------------------------------------
+
+As mentioned in the introduction, StGIT stores modifications to your
+working tree in the form of GIT commits. This means if you want to apply
+your changes to a tree not managed by GIT, or send your changes to
+someone else in e-mail, you need to convert your StGIT patches into
+normal textual diffs that can be applied with the GNU 'patch' command.
+The 'stg diff' command is a powerful way to generate and view textual
+diffs of patches managed by StGIT.
+To view a diff of the topmost patch:
+
+  stg diff -r /
+
+Observe that this does not show any changes in the working directory
+that have not been saved by a 'refresh'. To view just the changes you've
+made since the last refresh, use:
+
+  stg diff -r /top
+
+If you want to see the changes made by the patch combined with any
+unsaved changes in the working directory, try:
+
+  stg diff -r /bottom
+
+You can also show the changes to any patch in your stack with:
+
+  stg diff -r <patch>/
+
+Use this command to view all the changes in your stack up through the
+current patch:
+
+  stg diff -r base
+
+The 'stg diff' command supports a number of other features that are very
+useful. Be sure to take a look at the help information for this command.
+To convert your StGIT patches into patch files:
+
+  stg export [--range=[<patch1>[:<patch2>]]] [<dir-name>]
+
+The 'export' command supports options to automatically number the
+patches (-n) or add the '.diff' extension (-d). If you don't tell "stg
+export" where to put the patches, it will create directory named "patch-
+branchname" in your current directory, and store the patches there.
+To e-mail a patch or range of patches:
+
+  stg mail [--to=...] (--all | --range=[<patch1>[:<patch2>]] | <patch>)
+
+"stg mail" has a lot of options, so read the output of "stg mail -h" for
+more information.
+You can also import an existing GNU diff patch file as a new StGIT patch
+with a single command. "stg import" will automatically parse through the
+patch file and extract a patch description. Use:
+
+  stg import [<file>]
+
+This is the equivalent of "stg new" followed by "patch -i <file>", then
+"stg refresh -e".
+Sometimes the patch file won't apply cleanly. In that case, "stg import"
+will leave you with an empty StGIT patch, to which you then apply the
+patch file by hand using "patch -i" and your favorite editor.
+To merge a GNU diff file (defaulting to the standard input) into the
+topmost patch:
+
+  stg fold [<file>]
+
+This command supports a '--threeway' option which applies the patch onto
+the bottom of the topmost one and performs a three-way merge.
+
+
+Advanced Usage
+==============
+
+Handling merge conflicts
+------------------------
+
+Pushing a patch on the stack can fail if the patch cannot be applied
+cleanly. This usually happens if there are overlapping changes in the
+tree, the patch depends on another patch which is not applied, or if a
+patch was not merged upstream in the exact form it was sent.
+The 'push' operation stops after the first patch with conflicts. The
+'status' command shows the conflict files by marking them with a 'C'. If
+the 'keeporig' options is set to 'yes' (the default), the original files
+involved in the merge operations are left in the tree as <file>.older,
+<file>.local and <file>.remote for better analysis of the conflict. If
+'diff3' is used as the merger (the default), markers are added to the
+conflicted files as well.
+Run the 'resolved' command to mark the conflicts resolved and remove the
+temporary merge files from the working tree. Then run the 'refresh'
+command to update the StGIT patch with the modifications you made to
+resolve the conflict.
+
+
+Configuration file
+------------------
+
+StGIT tries to read the configuration options from the following files:
+/etc/stgitrc, ~/.stgitrc and .git/stgitrc. The latter overrides the
+options in the former files. If no file is found, the defaults are used.
+An example configuration file with options description can be found in
+the examples/ directory. Most users would probably only define the
+'smtpserver' option used by the 'mail' command.
+The gitmergeonefile.py script does the three-way merging on individual
+files using the tool specified by the 'merger' option. The user can
+specify a smarter tool to be used.
+
+
+Templates
+---------
+
+The 'export' and 'mail' commands use templates for generating the patch
+files or e-mails. The default templates are installed under <prefix>/
+share/stgit/templates/ and, combined with the extra options available
+for the commands, should be enough for most users. The template format
+uses the standard Python string formatting rules. The variables
+available are shown in the the help message for the commands.
+The 'mail' command can also send an initial e-mail for which there is no
+default template. The <prefix>/share/stgit/examples/firstmail.tmpl file
+can be used as an example.
+A default description for new patches can be defined in the .git/
+patchdescr.tmpl file. This is useful for things like signed-off-by
+lines.
+
+
+Merging two patches into one
+----------------------------
+
+There is no command to do this directly at the moment but one can export
+the patch to be merged and use the 'stg fold' command on the generated
+diff file. Assuming that the merged patch was not already applied, the
+operation will succeed. Pushing the merged patch onto the stack will
+result in an empty patch (StGIT notifying the user) that can be safely
+deleted.
+
+
+Technical Information
+=====================
+
+A bit of StGIT patch theory
+---------------------------
+
+We assume that a patch is a diff between two nodes - bottom and top. A
+node is a commit SHA1 id or tree SHA1 id in the GIT terminology:
+
+  P - patch
+  N - node
+
+  P = diff(Nt, Nb)
+
+  	Nb - bottom (start) node
+  	Nt - top (end) node
+  	Nf - first node (for log generation)
+
+For an ordered stack of patches:
+
+  P1 = diff(N1, N0)
+  P2 = diff(N2, N1)
+  ...
+
+
+  Ps = P1 + P2 + P3 + ... = diff(Nst, Nsb)
+
+  	Ps  - the big patch of the whole stack
+  	Nsb - bottom stack node (= N0)
+  	Nst - top stack node (= Nn)
+
+Applying (pushing) a patch on the stack (Nst can differ from Nb) is done
+by diff3 merging. The new patch becomes:
+
+  P' = diff(Nt', Nb')
+  Nb' = Nst
+  Nt' = diff3(Nst, Nb, Nt)
+
+(note that the diff3 parameters order is: branch1, ancestor, branch2)
+The above operation allows easy patch re-ordering.
+Removing (popping) a patch from the stack is done by simply setting the
+Nst to Nb.
+
+
+Layout of the .git directory
+----------------------------
+
+  HEAD			-> refs/heads/<something>
+  objects/
+    ??/
+    ...
+  refs/
+    heads/
+      master		- the master commit id
+      ...
+    bases/
+      master		- the bottom id of the stack (to get a big diff)
+      ...
+    tags/
+      ...
+    branches/
+      ...
+    patches/
+      master/
+        applied		- list of applied patches
+        unapplied		- list of not-yet applied patches
+        current		- name of the topmost patch
+        patch1/
+          bottom		- the bottom id of the patch
+          top		- the top id of the patch
+  	description	- the patch description
+  	authname	- author's name
+  	authemail	- author's e-mail
+  	commname	- committer's name
+  	commemail	- committer's e-mail
+        patch2/
+          ...
+        ...
+      ...
diff --git a/Makefile b/Makefile
index df77d97..8cd5813 100644
--- a/Makefile
+++ b/Makefile
@@ -9,15 +9,17 @@ install:
 	$(PYTHON) setup.py install --prefix=$(PREFIX) --root=$(DESTDIR)
 
 doc:
-	cd doc && $(MAKE) all
+	cd Documentation && $(MAKE) all
 
 test:
 	cd t && $(MAKE) all
 
 clean:
-	for dir in doc t; do \
+	for dir in Documentation t; do \
 		(cd $$dir && $(MAKE) clean); \
 	done
 	rm -rf build
 	rm -f stgit/*.pyc
 	rm -f stgit/commands/*.pyc
+
+.PHONY: all install doc test clean
diff --git a/doc/.gitignore b/doc/.gitignore
deleted file mode 100644
index 15ba6af..0000000
--- a/doc/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-tutorial.html
-tutorial.pdf
diff --git a/doc/Makefile b/doc/Makefile
deleted file mode 100644
index 07704b8..0000000
--- a/doc/Makefile
+++ /dev/null
@@ -1,17 +0,0 @@
-DOCS = tutorial.txt
-DOCS_HTML = $(DOCS:.txt=.html)
-DOCS_PDF = $(DOCS:.txt=.pdf)
-
-all: $(DOCS_HTML) $(DOCS_PDF)
-
-%.html: %.txt
-	asciidoc $<
-
-%.xml: %.txt
-	asciidoc --backend=docbook $<
-
-%.pdf: %.xml
-	xmlto pdf $<
-
-clean:
-	rm -f *.xml *.html *.pdf
diff --git a/doc/asciidoc.conf b/doc/asciidoc.conf
deleted file mode 100644
index 5b8d95f..0000000
--- a/doc/asciidoc.conf
+++ /dev/null
@@ -1,3 +0,0 @@
-[titles]
-underlines="##","==","--","~~","^^"
-
diff --git a/doc/tutorial.txt b/doc/tutorial.txt
deleted file mode 100644
index 5899c38..0000000
--- a/doc/tutorial.txt
+++ /dev/null
@@ -1,413 +0,0 @@
-StGIT Tutorial
-##############
-
-
-StGIT is a Python application that provides functionality similar to
-quilt (i.e. pushing/popping patches to/from a stack) using GIT instead
-of 'diff' and 'patch'. StGIT stores its patches in a GIT repository as
-normal GIT commit objects.
-StGIT is not an SCM interface on top of GIT. For standard SCM
-operations, either use GIT's porcelain commands or the Cogito tool.
-StGIT is available for download at http://www.procode.org/stgit/ .
-This tutorial assumes you are already familiar with GIT. For more
-information on GIT, see the GIT_tutorial or git(7) .
-
-
-Basic Operation
-===============
-
-Help
-----
-
-For a full list of StGIT commands:
-
-  stg help
-
-For help on individual subcommands:
-
-  stg <cmd> (-h | --help)
-
-
-Repository initialisation
--------------------------
-
-In stand-alone mode, StGIT is used in conjunction with a GIT repository
-that is already initialised (using 'git-init-db'). StGIT cannot be used
-outside of a GIT repository.
-Any branch in a GIT repository may be managed by StGIT. Each branch
-managed by StGIT contains an independent series of StGIT patches.
-To initialise an existing GIT branch to be managed by StGIT, cd into the
-top of your GIT repository, check out the branch you'd like to manage
-with StGIT, and type:
-
-  stg init
-
-Run the 'stg init' command for any pre-existing GIT branches intended to
-be used with StGIT.
-You can switch between GIT branches with:
-
-  stg branch [<branch name>]
-
-This checks out the named branch and places you at the topmost applied
-StGIT patch in that branch.
-Alternately, you can create branches using only StGIT commands, which
-will automatically prepare them for use with StGIT:
-
-  stg branch --create <new branch>
-
-
-Working with remote repositories
---------------------------------
-
-With a single command, StGIT can create and initialize a GIT repository
-which mirrors a remote GIT repository. This is known as cloning. All GIT
-transports are supported.
-To clone a repository, use:
-
-  stg clone <repository> <local-dir>
-
-This creates a fresh local repository, initialises a GIT database in it,
-pulls the latest version of the remote, and creates and initialises a
-'master' branch for use with StGIT.
-At any time you can pull the latest changes from the remote repository.
-By default, StGIT pulls from the location stored in .git/branches/
-origin, and updates the base of the current branch.
-To pull the latest changes from a remote repository, use:
-
-  stg pull [<branch> or 'origin']
-
-This command removes all applied StGIT patches from the current branch,
-updates the branch's base commit, then attempts to re-apply the patches.
-Any merge conflicts will halt this process, allowing you to clean up the
-conflicts and continue (see below).
-If the maintainer of the remote repository includes one of your patches
-in the published repository that you pull from, StGIT can usually
-recognize that an incoming patch from the remote matches one of yours,
-and it turns your local version into an empty patch.
-To automatically delete empty patches after a pull, use:
-
-  stg clean
-
-As a convention, you should avoid working in the 'master' branch and use
-it only as a reference, since it reflects someone else's work. If you
-decide to publish your GIT repository, you'll want your own work
-separated into its own branch to make it convenient for others to pull
-just your patches.
-
-Getting started: creating a patch
----------------------------------
-
-Changes to your working directory are saved in a patch. An StGIT patch
-is simply a saved set of modifications to your working directory, plus a
-saved description. To create an empty StGIT patch in the current branch:
-
-  stg new <name>
-
-To save the changes you've made (that is, to refresh a patch), use:
-
-  stg refresh
-
-To discard changes in your working directory, use:
-
-  git checkout -f
-
-This restores your working directory to the state it was in the last
-time the patch was refreshed.
-Modified files that haven't been saved via a refresh operation can be
-viewed with:
-
-  stg status
-
-You can view modified files that have already been saved into a patch:
-
-  stg files
-
-The 'stg refresh' command automatically notes changes to files that
-already exist in the working directory, but you have to tell StGIT
-explicitly if you add, remove, or rename files.
-To record the addition or deletion of files in your new patch:
-
-  stg add [<file>*]
-  stg rm [<file>*]
-
-To record the renaming of a file in your new patch, issue both of these
-commands:
-
-  stg rm <oldfilename>
-  stg add <newfilename>
-
-
-Stack manipulation: managing multiple patches
----------------------------------------------
-
-StGIT can manage more than one patch at a time. A series of StGIT
-patches in a GIT branch are known collectively as a stack. The new patch
-you created above is now the topmost patch in your stack. You can always
-see the name of the topmost (current) patch with:
-
-  stg top
-
-The topmost patch is used as the default patch for most StGIT
-operations. It is the default target of the 'stg refresh' command, for
-example.
-Patches that are pushed onto the stack are referred to as applied, and
-patches that are popped off the stack are referred to as unapplied.
-To push/pop a patch to/from a stack:
-
-  stg push [--all | <name>]
-  stg pop [--all]
-
-The last patch you pushed is the topmost patch. This patch is always in
-the applied list; StGIT can't operate on an unapplied patch unless you
-apply it first.
-You can display the order of patches in a stack with one of these
-commands:
-
-  stg series
-  stg applied
-  stg unapplied
-
-By default the 'stg push' command applies the first patch in the
-unapplied list, but you can push any patch in the unapplied list by
-giving the name of the patch. This is useful if you want to reorder the
-patches in a stack.
-During a push operation, merge conflicts can occur (especially if you
-are changing the order of the patches in your stack). If the push causes
-merge conflicts, they need to be fixed and 'stg resolved' run (see
-below). A 'push' operation can also be reverted with 'stg push --undo'.
-A few more stack basics; to rename a patch:
-
-  stg rename <old-name> <new-name>
-
-To delete a patch:
-
-  stg delete <name>
-
-This permanently discards the named patch. In other words, the patch no
-longer appears in either the applied or unapplied lists, and cannot be
-reapplied to the series.
-You may want to make patches in your stack a permanent part of your GIT
-repository, for example if you are publishing your repository to others.
-To do this, use:
-
-  stg commit
-
-This merges all applied patches in your patch series into the GIT
-repository and removes them from your stack. Use this command only if
-you want to permanently store the applied patches and no longer manage
-them with StGIT.
-
-Converting between StGIT patches and text diffs
------------------------------------------------
-
-As mentioned in the introduction, StGIT stores modifications to your
-working tree in the form of GIT commits. This means if you want to apply
-your changes to a tree not managed by GIT, or send your changes to
-someone else in e-mail, you need to convert your StGIT patches into
-normal textual diffs that can be applied with the GNU 'patch' command.
-The 'stg diff' command is a powerful way to generate and view textual
-diffs of patches managed by StGIT.
-To view a diff of the topmost patch:
-
-  stg diff -r /
-
-Observe that this does not show any changes in the working directory
-that have not been saved by a 'refresh'. To view just the changes you've
-made since the last refresh, use:
-
-  stg diff -r /top
-
-If you want to see the changes made by the patch combined with any
-unsaved changes in the working directory, try:
-
-  stg diff -r /bottom
-
-You can also show the changes to any patch in your stack with:
-
-  stg diff -r <patch>/
-
-Use this command to view all the changes in your stack up through the
-current patch:
-
-  stg diff -r base
-
-The 'stg diff' command supports a number of other features that are very
-useful. Be sure to take a look at the help information for this command.
-To convert your StGIT patches into patch files:
-
-  stg export [--range=[<patch1>[:<patch2>]]] [<dir-name>]
-
-The 'export' command supports options to automatically number the
-patches (-n) or add the '.diff' extension (-d). If you don't tell "stg
-export" where to put the patches, it will create directory named "patch-
-branchname" in your current directory, and store the patches there.
-To e-mail a patch or range of patches:
-
-  stg mail [--to=...] (--all | --range=[<patch1>[:<patch2>]] | <patch>)
-
-"stg mail" has a lot of options, so read the output of "stg mail -h" for
-more information.
-You can also import an existing GNU diff patch file as a new StGIT patch
-with a single command. "stg import" will automatically parse through the
-patch file and extract a patch description. Use:
-
-  stg import [<file>]
-
-This is the equivalent of "stg new" followed by "patch -i <file>", then
-"stg refresh -e".
-Sometimes the patch file won't apply cleanly. In that case, "stg import"
-will leave you with an empty StGIT patch, to which you then apply the
-patch file by hand using "patch -i" and your favorite editor.
-To merge a GNU diff file (defaulting to the standard input) into the
-topmost patch:
-
-  stg fold [<file>]
-
-This command supports a '--threeway' option which applies the patch onto
-the bottom of the topmost one and performs a three-way merge.
-
-
-Advanced Usage
-==============
-
-Handling merge conflicts
-------------------------
-
-Pushing a patch on the stack can fail if the patch cannot be applied
-cleanly. This usually happens if there are overlapping changes in the
-tree, the patch depends on another patch which is not applied, or if a
-patch was not merged upstream in the exact form it was sent.
-The 'push' operation stops after the first patch with conflicts. The
-'status' command shows the conflict files by marking them with a 'C'. If
-the 'keeporig' options is set to 'yes' (the default), the original files
-involved in the merge operations are left in the tree as <file>.older,
-<file>.local and <file>.remote for better analysis of the conflict. If
-'diff3' is used as the merger (the default), markers are added to the
-conflicted files as well.
-Run the 'resolved' command to mark the conflicts resolved and remove the
-temporary merge files from the working tree. Then run the 'refresh'
-command to update the StGIT patch with the modifications you made to
-resolve the conflict.
-
-
-Configuration file
-------------------
-
-StGIT tries to read the configuration options from the following files:
-/etc/stgitrc, ~/.stgitrc and .git/stgitrc. The latter overrides the
-options in the former files. If no file is found, the defaults are used.
-An example configuration file with options description can be found in
-the examples/ directory. Most users would probably only define the
-'smtpserver' option used by the 'mail' command.
-The gitmergeonefile.py script does the three-way merging on individual
-files using the tool specified by the 'merger' option. The user can
-specify a smarter tool to be used.
-
-
-Templates
----------
-
-The 'export' and 'mail' commands use templates for generating the patch
-files or e-mails. The default templates are installed under <prefix>/
-share/stgit/templates/ and, combined with the extra options available
-for the commands, should be enough for most users. The template format
-uses the standard Python string formatting rules. The variables
-available are shown in the the help message for the commands.
-The 'mail' command can also send an initial e-mail for which there is no
-default template. The <prefix>/share/stgit/examples/firstmail.tmpl file
-can be used as an example.
-A default description for new patches can be defined in the .git/
-patchdescr.tmpl file. This is useful for things like signed-off-by
-lines.
-
-
-Merging two patches into one
-----------------------------
-
-There is no command to do this directly at the moment but one can export
-the patch to be merged and use the 'stg fold' command on the generated
-diff file. Assuming that the merged patch was not already applied, the
-operation will succeed. Pushing the merged patch onto the stack will
-result in an empty patch (StGIT notifying the user) that can be safely
-deleted.
-
-
-Technical Information
-=====================
-
-A bit of StGIT patch theory
----------------------------
-
-We assume that a patch is a diff between two nodes - bottom and top. A
-node is a commit SHA1 id or tree SHA1 id in the GIT terminology:
-
-  P - patch
-  N - node
-
-  P = diff(Nt, Nb)
-
-  	Nb - bottom (start) node
-  	Nt - top (end) node
-  	Nf - first node (for log generation)
-
-For an ordered stack of patches:
-
-  P1 = diff(N1, N0)
-  P2 = diff(N2, N1)
-  ...
-
-
-  Ps = P1 + P2 + P3 + ... = diff(Nst, Nsb)
-
-  	Ps  - the big patch of the whole stack
-  	Nsb - bottom stack node (= N0)
-  	Nst - top stack node (= Nn)
-
-Applying (pushing) a patch on the stack (Nst can differ from Nb) is done
-by diff3 merging. The new patch becomes:
-
-  P' = diff(Nt', Nb')
-  Nb' = Nst
-  Nt' = diff3(Nst, Nb, Nt)
-
-(note that the diff3 parameters order is: branch1, ancestor, branch2)
-The above operation allows easy patch re-ordering.
-Removing (popping) a patch from the stack is done by simply setting the
-Nst to Nb.
-
-
-Layout of the .git directory
-----------------------------
-
-  HEAD			-> refs/heads/<something>
-  objects/
-    ??/
-    ...
-  refs/
-    heads/
-      master		- the master commit id
-      ...
-    bases/
-      master		- the bottom id of the stack (to get a big diff)
-      ...
-    tags/
-      ...
-    branches/
-      ...
-    patches/
-      master/
-        applied		- list of applied patches
-        unapplied		- list of not-yet applied patches
-        current		- name of the topmost patch
-        patch1/
-          bottom		- the bottom id of the patch
-          top		- the top id of the patch
-  	description	- the patch description
-  	authname	- author's name
-  	authemail	- author's e-mail
-  	commname	- committer's name
-  	commemail	- committer's e-mail
-        patch2/
-          ...
-        ...
-      ...
