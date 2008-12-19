From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/4] Add a script to edit/inspect notes
Date: Sat, 20 Dec 2008 00:35:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812200035180.30769@pacific.mpi-cbg.de>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 00:29:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDomH-0005Kg-7l
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbYLSX1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbYLSX13
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:27:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:57984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755450AbYLSX12 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 18:27:28 -0500
Received: (qmail invoked by alias); 19 Dec 2008 23:27:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 20 Dec 2008 00:27:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193LH4VIOF3UAHz58VjnorcRzMWqyIUiEJ3cdqgyM
	hJc08F0UT6L0cW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103602>


The script 'git notes' allows you to edit and show commit notes, by
calling either

	git notes show <commit>

or

	git notes edit <commit>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                  |    1 +
 Documentation/git-notes.txt |   46 ++++++++++++++++++++++++++++++
 Makefile                    |    1 +
 command-list.txt            |    1 +
 git-notes.sh                |   65 +++++++++++++++++++++++++++++++++++++++++++
 t/t3301-notes.sh            |   65 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100755 t/t3301-notes.sh

diff --git a/.gitignore b/.gitignore
index 90bbb2a..8b90af1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -83,6 +83,7 @@ git-mktag
 git-mktree
 git-name-rev
 git-mv
+git-notes
 git-pack-redundant
 git-pack-objects
 git-pack-refs
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
new file mode 100644
index 0000000..3d93625
--- /dev/null
+++ b/Documentation/git-notes.txt
@@ -0,0 +1,46 @@
+git-notes(1)
+============
+
+NAME
+----
+git-notes - Add/inspect commit notes
+
+SYNOPSIS
+--------
+[verse]
+'git-notes' (edit | show) [commit]
+
+DESCRIPTION
+-----------
+This command allows you to add notes to commit messages, without
+changing the commit.  To discern these notes from the message stored
+in the commit object, the notes are indented like the message, after
+an unindented line saying "Notes:".
+
+To disable commit notes, you have to set the config variable
+core.notesRef to the empty string.  Alternatively, you can set it
+to a different ref, something like "refs/notes/bugzilla".  This setting
+can be overridden by the environment variable "GIT_NOTES_REF".
+
+
+SUBCOMMANDS
+-----------
+
+edit::
+	Edit the notes for a given commit (defaults to HEAD).
+
+show::
+	Show the notes for a given commit (defaults to HEAD).
+
+
+Author
+------
+Written by Johannes Schindelin <johannes.schindelin@gmx.de>
+
+Documentation
+-------------
+Documentation by Johannes Schindelin
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 7871f52..4bdc86e 100644
--- a/Makefile
+++ b/Makefile
@@ -259,6 +259,7 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
+SCRIPT_SH += git-notes.sh
 SCRIPT_SH += git-parse-remote.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
diff --git a/command-list.txt b/command-list.txt
index 3583a33..2dc2c33 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -73,6 +73,7 @@ git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain common
 git-name-rev                            plumbinginterrogators
+git-notes                               mainporcelain
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
diff --git a/git-notes.sh b/git-notes.sh
new file mode 100755
index 0000000..bfdbaa8
--- /dev/null
+++ b/git-notes.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+USAGE="(edit | show) [commit]"
+. git-sh-setup
+
+test -n "$3" && usage
+
+test -z "$1" && usage
+ACTION="$1"; shift
+
+test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="$(git config core.notesref)"
+test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="refs/notes/commits"
+
+COMMIT=$(git rev-parse --verify --default HEAD "$@") ||
+die "Invalid commit: $@"
+
+MESSAGE="$GIT_DIR"/new-notes-$COMMIT
+trap '
+	test -f "$MESSAGE" && rm "$MESSAGE"
+' 0
+
+case "$ACTION" in
+edit)
+	GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"
+
+	GIT_INDEX_FILE="$MESSAGE".idx
+	export GIT_INDEX_FILE
+
+	CURRENT_HEAD=$(git show-ref "$GIT_NOTES_REF" | cut -f 1 -d ' ')
+	if [ -z "$CURRENT_HEAD" ]; then
+		PARENT=
+	else
+		PARENT="-p $CURRENT_HEAD"
+		git read-tree "$GIT_NOTES_REF" || die "Could not read index"
+		git cat-file blob :$COMMIT >> "$MESSAGE" 2> /dev/null
+	fi
+
+	${VISUAL:-${EDITOR:-vi}} "$MESSAGE"
+
+	grep -v ^# < "$MESSAGE" | git stripspace > "$MESSAGE".processed
+	mv "$MESSAGE".processed "$MESSAGE"
+	if [ -s "$MESSAGE" ]; then
+		BLOB=$(git hash-object -w "$MESSAGE") ||
+			die "Could not write into object database"
+		git update-index --add --cacheinfo 0644 $BLOB $COMMIT ||
+			die "Could not write index"
+	else
+		test -z "$CURRENT_HEAD" &&
+			die "Will not initialise with empty tree"
+		git update-index --force-remove $COMMIT ||
+			die "Could not update index"
+	fi
+
+	TREE=$(git write-tree) || die "Could not write tree"
+	NEW_HEAD=$(echo Annotate $COMMIT | git commit-tree $TREE $PARENT) ||
+		die "Could not annotate"
+	git update-ref -m "Annotate $COMMIT" \
+		"$GIT_NOTES_REF" $NEW_HEAD $CURRENT_HEAD
+;;
+show)
+	git show "$GIT_NOTES_REF":$COMMIT
+;;
+*)
+	usage
+esac
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
new file mode 100755
index 0000000..ba42c45
--- /dev/null
+++ b/t/t3301-notes.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='Test commit notes'
+
+. ./test-lib.sh
+
+cat > fake_editor.sh << \EOF
+echo "$MSG" > "$1"
+echo "$MSG" >& 2
+EOF
+chmod a+x fake_editor.sh
+VISUAL=./fake_editor.sh
+export VISUAL
+
+test_expect_success 'cannot annotate non-existing HEAD' '
+	! MSG=3 git notes edit
+'
+
+test_expect_success setup '
+	: > a1 &&
+	git add a1 &&
+	test_tick &&
+	git commit -m 1st &&
+	: > a2 &&
+	git add a2 &&
+	test_tick &&
+	git commit -m 2nd
+'
+
+test_expect_success 'need valid notes ref' '
+	! MSG=1 GIT_NOTES_REF='/' git notes edit &&
+	! MSG=2 GIT_NOTES_REF='/' git notes show
+'
+
+test_expect_success 'create notes' '
+	git config core.notesRef refs/notes/commits &&
+	MSG=b1 git notes edit &&
+	test ! -f .git/new-notes &&
+	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
+	test b1 = $(git notes show) &&
+	git show HEAD^ &&
+	! git notes show HEAD^
+'
+
+cat > expect << EOF
+commit 268048bfb8a1fb38e703baceb8ab235421bf80c5
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    2nd
+
+Notes:
+    b1
+EOF
+
+test_expect_success 'show notes' '
+	! (git cat-file commit HEAD | grep b1) &&
+	git log -1 > output &&
+	git diff expect output
+'
+
+test_done
-- 
1.6.1.rc3.368.g63acc
