From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 05/22] Teach "-m <msg>" and "-F <file>" to
 "git notes edit"
Date: Fri, 09 Oct 2009 12:22:01 +0200
Message-ID: <1255083738-23263-7-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClQ-0004PL-Qt
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760681AbZJIKXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760676AbZJIKXw
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:23:52 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54694 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760678AbZJIKXu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:23:50 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BOUSTP9320@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:37 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:37 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129784>

The "-m" and "-F" options are already the established method
(in both git-commit and git-tag) to specify a commit/tag message
without invoking the editor. This patch teaches "git notes edit"
to respect the same options for specifying a notes message without
invoking the editor.

Multiple "-m" and/or "-F" options are concatenated as separate
paragraphs.

The patch also updates the "git notes" documentation and adds
selftests for the new functionality. Unfortunately, the added
selftests include a couple of lines with trailing whitespace
(without these the test will fail). This may cause git to warn
about "whitespace errors".

This patch has been improved by the following contributions:
- Thomas Rast: fix trailing whitespace in t3301

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   16 ++++++++++-
 git-notes.sh                |   64 +++++++++++++++++++++++++++++++++++++-----
 t/t3301-notes.sh            |   36 ++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 7136016..94cceb1 100644
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
@@ -33,6 +33,20 @@ show::
 	Show the notes for a given commit (defaults to HEAD).
 
 
+OPTIONS
+-------
+-m <msg>::
+	Use the given note message (instead of prompting).
+	If multiple `-m` (or `-F`) options are given, their
+	values are concatenated as separate paragraphs.
+
+-F <file>::
+	Take the note message from the given file.  Use '-' to
+	read the note message from the standard input.
+	If multiple `-F` (or `-m`) options are given, their
+	values are concatenated as separate paragraphs.
+
+
 Author
 ------
 Written by Johannes Schindelin <johannes.schindelin@gmx.de>
diff --git a/git-notes.sh b/git-notes.sh
index f06c254..e642e47 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -1,16 +1,59 @@
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
+			if [ -z "$MESSAGE" ]; then
+				MESSAGE="$1"
+			else
+				MESSAGE="$MESSAGE
+
+$1"
+			fi
+			shift
+		fi
+		;;
+	-F)
+		test "$ACTION" = "edit" || usage
+		shift
+		if test "$#" = "0"; then
+			die "error: option -F needs an argument"
+		else
+			if [ -z "$MESSAGE" ]; then
+				MESSAGE="$(cat "$1")"
+			else
+				MESSAGE="$MESSAGE
+
+$(cat "$1")"
+			fi
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
 
@@ -29,19 +72,24 @@ edit)
 		test -f "$GIT_INDEX_FILE" && rm "$GIT_INDEX_FILE"
 	' 0
 
-	GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MSG_FILE"
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
+	if [ -z "$MESSAGE" ]; then
+		GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MSG_FILE"
+		if [ ! -z "$CURRENT_HEAD" ]; then
+			git cat-file blob :$COMMIT >> "$MSG_FILE" 2> /dev/null
+		fi
+		core_editor="$(git config core.editor)"
+		${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MSG_FILE"
+	else
+		echo "$MESSAGE" > "$MSG_FILE"
+	fi
 
 	grep -v ^# < "$MSG_FILE" | git stripspace > "$MSG_FILE".processed
 	mv "$MSG_FILE".processed "$MSG_FILE"
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 73e53be..1e34f48 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -110,5 +110,41 @@ test_expect_success 'show multi-line notes' '
 	git log -2 > output &&
 	test_cmp expect-multiline output
 '
+test_expect_success 'create -m and -F notes (setup)' '
+	: > a4 &&
+	git add a4 &&
+	test_tick &&
+	git commit -m 4th &&
+	echo "xyzzy" > note5 &&
+	git notes edit -m spam -F note5 -m "foo
+bar
+baz"
+'
+
+whitespace="    "
+cat > expect-m-and-F << EOF
+commit 15023535574ded8b1a89052b32673f84cf9582b8
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:16:13 2005 -0700
+
+    4th
+
+Notes:
+    spam
+$whitespace
+    xyzzy
+$whitespace
+    foo
+    bar
+    baz
+EOF
+
+printf "\n" >> expect-m-and-F
+cat expect-multiline >> expect-m-and-F
+
+test_expect_success 'show -m and -F notes' '
+	git log -3 > output &&
+	test_cmp expect-m-and-F output
+'
 
 test_done
-- 
1.6.4.304.g1365c.dirty
