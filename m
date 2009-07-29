From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 2/8] Add a script to edit/inspect notes
Date: Wed, 29 Jul 2009 04:25:20 +0200
Message-ID: <1248834326-31488-3-git-send-email-johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 29 04:27:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVysz-0007uS-Dw
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 04:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbZG2C1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jul 2009 22:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756115AbZG2C1J
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 22:27:09 -0400
Received: from mx.getmail.no ([84.208.15.66]:38292 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752460AbZG2C1H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 22:27:07 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNI00GOTUT6X1B0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Jul 2009 04:27:06 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNI004NXUQPO310@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Jul 2009 04:27:06 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.29.21516
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248834326-31488-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124296>

=46rom: Johannes Schindelin <Johannes.Schindelin@gmx.de>

The script 'git notes' allows you to edit and show commit notes, by
calling either

	git notes show <commit>

or

	git notes edit <commit>

This patch has been improved by the following contributions:
- Tor Arne Vestb=C3=B8: fix printing of multi-line notes
- Michael J Gruber: test and handle empty notes gracefully
- Thomas Rast:
  - only clean up message file when editing
  - use GIT_EDITOR and core.editor over VISUAL/EDITOR
  - t3301: fix confusing quoting in test for valid notes ref
  - t3301: use test_must_fail instead of !
  - refuse to edit notes outside refs/notes/
- Junio C Hamano: tests: fix "export var=3Dval"
- Christian Couder: documentation: fix 'linkgit' macro in "git-notes.tx=
t"
- Johan Herland: minor cleanup and bugfixing in git-notes.sh (v2)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Tor Arne Vestb=C3=B8 <tavestbo@trolltech.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Johan Herland <johan@herland.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                  |    1 +
 Documentation/git-notes.txt |   46 +++++++++++++++++
 Makefile                    |    1 +
 command-list.txt            |    1 +
 git-notes.sh                |   73 +++++++++++++++++++++++++++
 t/t3301-notes.sh            |  114 +++++++++++++++++++++++++++++++++++=
++++++++
 6 files changed, 236 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100755 t/t3301-notes.sh

diff --git a/.gitignore b/.gitignore
index 10808e3..04926fc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -86,6 +86,7 @@ git-mktag
 git-mktree
 git-name-rev
 git-mv
+git-notes
 git-pack-redundant
 git-pack-objects
 git-pack-refs
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
new file mode 100644
index 0000000..7136016
--- /dev/null
+++ b/Documentation/git-notes.txt
@@ -0,0 +1,46 @@
+git-notes(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
+to a different ref, something like "refs/notes/bugzilla".  This settin=
g
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
+Part of the linkgit:git[7] suite
diff --git a/Makefile b/Makefile
index cc188ca..c9003d7 100644
--- a/Makefile
+++ b/Makefile
@@ -319,6 +319,7 @@ SCRIPT_SH +=3D git-merge-one-file.sh
 SCRIPT_SH +=3D git-merge-resolve.sh
 SCRIPT_SH +=3D git-mergetool.sh
 SCRIPT_SH +=3D git-mergetool--lib.sh
+SCRIPT_SH +=3D git-notes.sh
 SCRIPT_SH +=3D git-parse-remote.sh
 SCRIPT_SH +=3D git-pull.sh
 SCRIPT_SH +=3D git-quiltimport.sh
diff --git a/command-list.txt b/command-list.txt
index fb03a2e..4296941 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -74,6 +74,7 @@ git-mktag                               plumbingmanip=
ulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain common
 git-name-rev                            plumbinginterrogators
+git-notes                               mainporcelain
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
diff --git a/git-notes.sh b/git-notes.sh
new file mode 100755
index 0000000..f06c254
--- /dev/null
+++ b/git-notes.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+USAGE=3D"(edit | show) [commit]"
+. git-sh-setup
+
+test -n "$3" && usage
+
+test -z "$1" && usage
+ACTION=3D"$1"; shift
+
+test -z "$GIT_NOTES_REF" && GIT_NOTES_REF=3D"$(git config core.notesre=
f)"
+test -z "$GIT_NOTES_REF" && GIT_NOTES_REF=3D"refs/notes/commits"
+
+COMMIT=3D$(git rev-parse --verify --default HEAD "$@") ||
+die "Invalid commit: $@"
+
+case "$ACTION" in
+edit)
+	if [ "${GIT_NOTES_REF#refs/notes/}" =3D "$GIT_NOTES_REF" ]; then
+		die "Refusing to edit notes in $GIT_NOTES_REF (outside of refs/notes=
/)"
+	fi
+
+	MSG_FILE=3D"$GIT_DIR/new-notes-$COMMIT"
+	GIT_INDEX_FILE=3D"$MSG_FILE.idx"
+	export GIT_INDEX_FILE
+
+	trap '
+		test -f "$MSG_FILE" && rm "$MSG_FILE"
+		test -f "$GIT_INDEX_FILE" && rm "$GIT_INDEX_FILE"
+	' 0
+
+	GIT_NOTES_REF=3D git log -1 $COMMIT | sed "s/^/#/" > "$MSG_FILE"
+
+	CURRENT_HEAD=3D$(git show-ref "$GIT_NOTES_REF" | cut -f 1 -d ' ')
+	if [ -z "$CURRENT_HEAD" ]; then
+		PARENT=3D
+	else
+		PARENT=3D"-p $CURRENT_HEAD"
+		git read-tree "$GIT_NOTES_REF" || die "Could not read index"
+		git cat-file blob :$COMMIT >> "$MSG_FILE" 2> /dev/null
+	fi
+
+	core_editor=3D"$(git config core.editor)"
+	${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MSG_FILE"
+
+	grep -v ^# < "$MSG_FILE" | git stripspace > "$MSG_FILE".processed
+	mv "$MSG_FILE".processed "$MSG_FILE"
+	if [ -s "$MSG_FILE" ]; then
+		BLOB=3D$(git hash-object -w "$MSG_FILE") ||
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
+	TREE=3D$(git write-tree) || die "Could not write tree"
+	NEW_HEAD=3D$(echo Annotate $COMMIT | git commit-tree $TREE $PARENT) |=
|
+		die "Could not annotate"
+	git update-ref -m "Annotate $COMMIT" \
+		"$GIT_NOTES_REF" $NEW_HEAD $CURRENT_HEAD
+;;
+show)
+	git rev-parse -q --verify "$GIT_NOTES_REF":$COMMIT > /dev/null ||
+		die "No note for commit $COMMIT."
+	git show "$GIT_NOTES_REF":$COMMIT
+;;
+*)
+	usage
+esac
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
new file mode 100755
index 0000000..73e53be
--- /dev/null
+++ b/t/t3301-notes.sh
@@ -0,0 +1,114 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description=3D'Test commit notes'
+
+. ./test-lib.sh
+
+cat > fake_editor.sh << \EOF
+echo "$MSG" > "$1"
+echo "$MSG" >& 2
+EOF
+chmod a+x fake_editor.sh
+VISUAL=3D./fake_editor.sh
+export VISUAL
+
+test_expect_success 'cannot annotate non-existing HEAD' '
+	(MSG=3D3 && export MSG && test_must_fail git notes edit)
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
+	(MSG=3D1 GIT_NOTES_REF=3D/ && export MSG GIT_NOTES_REF &&
+	 test_must_fail git notes edit) &&
+	(MSG=3D2 GIT_NOTES_REF=3D/ && export MSG GIT_NOTES_REF &&
+	 test_must_fail git notes show)
+'
+
+test_expect_success 'refusing to edit in refs/heads/' '
+	(MSG=3D1 GIT_NOTES_REF=3Drefs/heads/bogus &&
+	 export MSG GIT_NOTES_REF &&
+	 test_must_fail git notes edit)
+'
+
+test_expect_success 'refusing to edit in refs/remotes/' '
+	(MSG=3D1 GIT_NOTES_REF=3Drefs/remotes/bogus &&
+	 export MSG GIT_NOTES_REF &&
+	 test_must_fail git notes edit)
+'
+
+# 1 indicates caught gracefully by die, 128 means git-show barked
+test_expect_success 'handle empty notes gracefully' '
+	git notes show ; test 1 =3D $?
+'
+
+test_expect_success 'create notes' '
+	git config core.notesRef refs/notes/commits &&
+	MSG=3Db1 git notes edit &&
+	test ! -f .git/new-notes &&
+	test 1 =3D $(git ls-tree refs/notes/commits | wc -l) &&
+	test b1 =3D $(git notes show) &&
+	git show HEAD^ &&
+	test_must_fail git notes show HEAD^
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
+	test_cmp expect output
+'
+test_expect_success 'create multi-line notes (setup)' '
+	: > a3 &&
+	git add a3 &&
+	test_tick &&
+	git commit -m 3rd &&
+	MSG=3D"b3
+c3c3c3c3
+d3d3d3" git notes edit
+'
+
+cat > expect-multiline << EOF
+commit 1584215f1d29c65e99c6c6848626553fdd07fd75
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3rd
+
+Notes:
+    b3
+    c3c3c3c3
+    d3d3d3
+EOF
+
+printf "\n" >> expect-multiline
+cat expect >> expect-multiline
+
+test_expect_success 'show multi-line notes' '
+	git log -2 > output &&
+	test_cmp expect-multiline output
+'
+
+test_done
--=20
1.6.4.rc3.138.ga6b98.dirty
