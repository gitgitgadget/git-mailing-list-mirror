From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/2] Teach "-m <msg>" and "-F <file>" to "git notes edit"
Date: Tue, 21 Apr 2009 02:42:15 +0200
Message-ID: <200904210242.16050.johan@herland.net>
References: <200904210239.21974.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 02:43:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw45Z-0002qL-Nb
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 02:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbZDUAmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 20:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbZDUAmT
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 20:42:19 -0400
Received: from mx.getmail.no ([84.208.15.66]:32806 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752399AbZDUAmT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 20:42:19 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KIF0046CDYHF0C0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 21 Apr 2009 02:42:17 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KIF00M3NDYGZVC0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 21 Apr 2009 02:42:17 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.4.21.2822
User-Agent: KMail/1.11.2 (Linux/2.6.29-ARCH; KDE/4.2.2; x86_64; ; )
In-reply-to: <200904210239.21974.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117053>

The "-m" and "-F" options are already the established method
(in both git-commit and git-tag) to specify a commit/tag message
without invoking the editor. This patch teaches "git notes edit"
to respect the same options for specifying a notes message without
invoking the editor.

The patch also updates the "git notes" documentation and adds a
couple of selftests for the new functionality.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   12 ++++++++-
 git-notes.sh                |   52 +++++++++++++++++++++++++++++++++------
 t/t3301-notes.sh            |   57 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 7136016..55de7c0 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -8,7 +8,7 @@ git-notes - Add/inspect commit notes
 SYNOPSIS
 --------
 [verse]
-'git-notes' (edit | show) [commit]
+'git-notes' (edit [-F <file> | -m <msg>] | show) [commit]
 
 DESCRIPTION
 -----------
@@ -33,6 +33,16 @@ show::
 	Show the notes for a given commit (defaults to HEAD).
 
 
+OPTIONS
+-------
+-m <msg>::
+	Use the given note message (instead of prompting).
+
+-F <file>::
+	Take the note message from the given file.  Use '-' to
+	read the note message from the standard input.
+
+
 Author
 ------
 Written by Johannes Schindelin <johannes.schindelin@gmx.de>
diff --git a/git-notes.sh b/git-notes.sh
index 7c3b8b9..3911caa 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -1,16 +1,47 @@
 #!/bin/sh
 
-USAGE="(edit | show) [commit]"
+USAGE="(edit [-F <file> | -m <msg>] | show) [commit]"
 . git-sh-setup
 
-test -n "$3" && usage
-
 test -z "$1" && usage
 ACTION="$1"; shift
 
 test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="$(git config core.notesref)"
 test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="refs/notes/commits"
 
+MESSAGE=
+while test $# != 0
+do
+	case "$1" in
+	-m)
+		test "$ACTION" = "edit" || usage
+		shift
+		if test "$#" = "0"; then
+			die "error: option -m needs an argument"
+		else
+			MESSAGE="$1"
+			shift
+		fi
+		;;
+	-F)
+		test "$ACTION" = "edit" || usage
+		shift
+		if test "$#" = "0"; then
+			die "error: option -F needs an argument"
+		else
+			MESSAGE="$(cat "$1")"
+			shift
+		fi
+		;;
+	-*)
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
+done
+
 COMMIT=$(git rev-parse --verify --default HEAD "$@") ||
 die "Invalid commit: $@"
 
@@ -29,19 +60,24 @@ edit)
 		test -f "$GIT_INDEX_FILE" && rm "$GIT_INDEX_FILE"
 	' 0
 
-	git log -1 $COMMIT | sed "s/^/#/" > "$MSG_FILE"
-
 	CURRENT_HEAD=$(git show-ref "$GIT_NOTES_REF" | cut -f 1 -d ' ')
 	if [ -z "$CURRENT_HEAD" ]; then
 		PARENT=
 	else
 		PARENT="-p $CURRENT_HEAD"
 		git read-tree "$GIT_NOTES_REF" || die "Could not read index"
-		git cat-file blob :$COMMIT >> "$MSG_FILE" 2> /dev/null
 	fi
 
-	core_editor="$(git config core.editor)"
-	${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MSG_FILE"
+	if [ -n "$MESSAGE" ]; then
+		echo "$MESSAGE" > "$MSG_FILE"
+	else
+		git log -1 $COMMIT | sed "s/^/#/" > "$MSG_FILE"
+		if [ -n "$CURRENT_HEAD" ]; then
+			git cat-file blob :$COMMIT >> "$MSG_FILE" 2> /dev/null
+		fi
+		core_editor="$(git config core.editor)"
+		${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MSG_FILE"
+	fi
 
 	grep -v ^# < "$MSG_FILE" | git stripspace > "$MSG_FILE".processed
 	mv "$MSG_FILE".processed "$MSG_FILE"
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 73e53be..2ece75e 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -110,5 +110,62 @@ test_expect_success 'show multi-line notes' '
 	git log -2 > output &&
 	test_cmp expect-multiline output
 '
+test_expect_success 'create -m notes (setup)' '
+	: > a4 &&
+	git add a4 &&
+	test_tick &&
+	git commit -m 4th &&
+	git notes edit -m "foo
+bar
+baz"
+'
+
+cat > expect-m << EOF
+commit 15023535574ded8b1a89052b32673f84cf9582b8
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:16:13 2005 -0700
+
+    4th
+
+Notes:
+    foo
+    bar
+    baz
+EOF
+
+printf "\n" >> expect-m
+cat expect-multiline >> expect-m
+
+test_expect_success 'show -m notes' '
+	git log -3 > output &&
+	test_cmp expect-m output
+'
+test_expect_success 'create -F notes (setup)' '
+	: > a5 &&
+	git add a5 &&
+	test_tick &&
+	git commit -m 5th &&
+	echo "xyzzy" > note5 &&
+	git notes edit -F note5
+'
+
+cat > expect-F << EOF
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+
+Notes:
+    xyzzy
+EOF
+
+printf "\n" >> expect-F
+cat expect-m >> expect-F
+
+test_expect_success 'show -F notes' '
+	git log -4 > output &&
+	test_cmp expect-F output
+'
 
 test_done
-- 
1.6.3.rc0.1.gf800
