From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 24/30] builtin-notes: Add "add" subcommand for adding notes
 to objects
Date: Sat, 13 Feb 2010 22:28:32 +0100
Message-ID: <1266096518-2104-25-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:31:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPao-0002mJ-Qt
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758154Ab0BMVar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:30:47 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62509 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758118Ab0BMV3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:54 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FKTUDR5490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:51 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:51 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139862>

"git notes add" is identical to "git notes edit" except that instead of
editing existing notes for a given object, you can only add notes to an
object that currently has none. If "git notes add" finds existing notes
for the given object, the addition is aborted. However, if the new
-f/--force option is used, "git notes add" will _overwrite_ the existing
notes with the new notes contents.

If there is no existing notes for the given object. "git notes add" is
identical to "git notes edit" (i.e. it adds a new note).

The patch includes tests verifying correct behaviour of the new subcommand.

Suggested-by: Joey Hess <joey@kitenet.net>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   11 ++++++++
 builtin-notes.c             |   30 ++++++++++++++++++++---
 t/t3301-notes.sh            |   55 +++++++++++++++++++++++++++++--------------
 3 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 8969f6f..94e12b5 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git notes' [list [<object>]]
+'git notes' add [-f] [-F <file> | -m <msg>] [<object>]
 'git notes' edit [-F <file> | -m <msg>] [<object>]
 'git notes' show [<object>]
 'git notes' remove [<object>]
@@ -41,6 +42,11 @@ list::
 	annotate (in the format "<note object> <annotated object>").
 	This is the default subcommand if no subcommand is given.
 
+add::
+	Add notes for a given object (defaults to HEAD). Abort if the
+	object already has notes, abort. (use `-f` to overwrite an
+	existing note).
+
 edit::
 	Edit the notes for a given object (defaults to HEAD).
 
@@ -57,6 +63,11 @@ prune::
 
 OPTIONS
 -------
+-f::
+--force::
+	When adding notes to an object that already has notes,
+	overwrite the existing notes (instead of aborting).
+
 -m <msg>::
 --message=<msg>::
 	Use the given note message (instead of prompting).
diff --git a/builtin-notes.c b/builtin-notes.c
index ec959bc..006edf6 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -19,6 +19,7 @@
 
 static const char * const git_notes_usage[] = {
 	"git notes [list [<object>]]",
+	"git notes add [-f] [-m <msg> | -F <file>] [<object>]",
 	"git notes edit [-m <msg> | -F <file>] [<object>]",
 	"git notes show [<object>]",
 	"git notes remove [<object>]",
@@ -211,7 +212,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	char logmsg[100];
 
-	int list = 0, edit = 0, show = 0, remove = 0, prune = 0;
+	int list = 0, add = 0, edit = 0, show = 0, remove = 0, prune = 0,
+	    force = 0;
 	int given_object;
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
@@ -220,6 +222,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('m', "message", &msg, "msg",
 			     "note contents as a string", parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, "note contents in a file"),
+		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
 		OPT_END()
 	};
 
@@ -229,6 +232,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	if (argc && !strcmp(argv[0], "list"))
 		list = 1;
+	else if (argc && !strcmp(argv[0], "add"))
+		add = 1;
 	else if (argc && !strcmp(argv[0], "edit"))
 		edit = 1;
 	else if (argc && !strcmp(argv[0], "show"))
@@ -240,10 +245,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	else if (!argc)
 		list = 1; /* Default to 'list' if no other subcommand given */
 
-	if (list + edit + show + remove + prune != 1)
+	if (list + add + edit + show + remove + prune != 1)
 		usage_with_options(git_notes_usage, options);
 
-	if ((msg.given || msgfile) && !edit) {
+	if ((msg.given || msgfile) && !(add || edit)) {
 		error("cannot use -m/-F options with %s subcommand.", argv[0]);
 		usage_with_options(git_notes_usage, options);
 	}
@@ -253,6 +258,11 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_usage, options);
 	}
 
+	if (force && !add) {
+		error("cannot use -f option with %s subcommand.", argv[0]);
+		usage_with_options(git_notes_usage, options);
+	}
+
 	given_object = argc == 2;
 	object_ref = given_object ? argv[1] : "HEAD";
 	if (argc > 2 || (prune && argc > 1)) {
@@ -294,7 +304,19 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		return execv_git_cmd(show_args);
 	}
 
-	/* edit/remove/prune command */
+	/* add/edit/remove/prune command */
+
+	if (add && note) {
+		if (force)
+			fprintf(stderr, "Overwriting existing notes for object %s\n",
+				sha1_to_hex(object));
+		else {
+			error("Cannot add notes. Found existing notes for object %s. "
+			      "Use '-f' to overwrite existing notes",
+			      sha1_to_hex(object));
+			return 1;
+		}
+	}
 
 	if (remove)
 		strbuf_reset(&buf);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 768a1cb..df458ca 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -16,7 +16,7 @@ GIT_EDITOR=./fake_editor.sh
 export GIT_EDITOR
 
 test_expect_success 'cannot annotate non-existing HEAD' '
-	(MSG=3 && export MSG && test_must_fail git notes edit)
+	(MSG=3 && export MSG && test_must_fail git notes add)
 '
 
 test_expect_success setup '
@@ -32,18 +32,18 @@ test_expect_success setup '
 
 test_expect_success 'need valid notes ref' '
 	(MSG=1 GIT_NOTES_REF=/ && export MSG GIT_NOTES_REF &&
-	 test_must_fail git notes edit) &&
+	 test_must_fail git notes add) &&
 	(MSG=2 GIT_NOTES_REF=/ && export MSG GIT_NOTES_REF &&
 	 test_must_fail git notes show)
 '
 
-test_expect_success 'refusing to edit in refs/heads/' '
+test_expect_success 'refusing to add notes in refs/heads/' '
 	(MSG=1 GIT_NOTES_REF=refs/heads/bogus &&
 	 export MSG GIT_NOTES_REF &&
-	 test_must_fail git notes edit)
+	 test_must_fail git notes add)
 '
 
-test_expect_success 'refusing to edit in refs/remotes/' '
+test_expect_success 'refusing to edit notes in refs/remotes/' '
 	(MSG=1 GIT_NOTES_REF=refs/remotes/bogus &&
 	 export MSG GIT_NOTES_REF &&
 	 test_must_fail git notes edit)
@@ -56,16 +56,34 @@ test_expect_success 'handle empty notes gracefully' '
 
 test_expect_success 'create notes' '
 	git config core.notesRef refs/notes/commits &&
-	MSG=b0 git notes edit &&
+	MSG=b4 git notes add &&
 	test ! -f .git/NOTES_EDITMSG &&
 	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
-	test b0 = $(git notes show) &&
+	test b4 = $(git notes show) &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
 
 test_expect_success 'edit existing notes' '
-	MSG=b1 git notes edit &&
+	MSG=b3 git notes edit &&
+	test ! -f .git/NOTES_EDITMSG &&
+	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
+	test b3 = $(git notes show) &&
+	git show HEAD^ &&
+	test_must_fail git notes show HEAD^
+'
+
+test_expect_success 'cannot add note where one exists' '
+	! MSG=b2 git notes add &&
+	test ! -f .git/NOTES_EDITMSG &&
+	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
+	test b3 = $(git notes show) &&
+	git show HEAD^ &&
+	test_must_fail git notes show HEAD^
+'
+
+test_expect_success 'can overwrite existing note with "git notes add -f"' '
+	MSG=b1 git notes add -f &&
 	test ! -f .git/NOTES_EDITMSG &&
 	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
 	test b1 = $(git notes show) &&
@@ -89,6 +107,7 @@ test_expect_success 'show notes' '
 	git log -1 > output &&
 	test_cmp expect output
 '
+
 test_expect_success 'create multi-line notes (setup)' '
 	: > a3 &&
 	git add a3 &&
@@ -96,7 +115,7 @@ test_expect_success 'create multi-line notes (setup)' '
 	git commit -m 3rd &&
 	MSG="b3
 c3c3c3c3
-d3d3d3" git notes edit
+d3d3d3" git notes add
 '
 
 cat > expect-multiline << EOF
@@ -125,7 +144,7 @@ test_expect_success 'create -F notes (setup)' '
 	test_tick &&
 	git commit -m 4th &&
 	echo "xyzzy" > note5 &&
-	git notes edit -F note5
+	git notes add -F note5
 '
 
 cat > expect-F << EOF
@@ -205,7 +224,7 @@ test_expect_success 'create -m notes (setup)' '
 	git add a5 &&
 	test_tick &&
 	git commit -m 5th &&
-	git notes edit -m spam -m "foo
+	git notes add -m spam -m "foo
 bar
 baz"
 '
@@ -234,8 +253,8 @@ test_expect_success 'show -m notes' '
 	test_cmp expect-m output
 '
 
-test_expect_success 'remove note with -F /dev/null (setup)' '
-	git notes edit -F /dev/null
+test_expect_success 'remove note with add -f -F /dev/null (setup)' '
+	git notes add -f -F /dev/null
 '
 
 cat > expect-rm-F << EOF
@@ -256,7 +275,7 @@ test_expect_success 'verify note removal with -F /dev/null' '
 '
 
 test_expect_success 'do not create empty note with -m "" (setup)' '
-	git notes edit -m ""
+	git notes add -m ""
 '
 
 test_expect_success 'verify non-creation of note with -m ""' '
@@ -329,7 +348,7 @@ test_expect_success 'create other note on a different notes ref (setup)' '
 	git add a6 &&
 	test_tick &&
 	git commit -m 6th &&
-	GIT_NOTES_REF="refs/notes/other" git notes edit -m "other note"
+	GIT_NOTES_REF="refs/notes/other" git notes add -m "other note"
 '
 
 cat > expect-other << EOF
@@ -374,17 +393,17 @@ test_expect_success 'Do not show note when core.notesRef is overridden' '
 
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 	echo "Note on a tree" > expect
-	git notes edit -m "Note on a tree" HEAD: &&
+	git notes add -m "Note on a tree" HEAD: &&
 	git notes show HEAD: > actual &&
 	test_cmp expect actual &&
 	echo "Note on a blob" > expect
 	filename=$(git ls-tree --name-only HEAD | head -n1) &&
-	git notes edit -m "Note on a blob" HEAD:$filename &&
+	git notes add -m "Note on a blob" HEAD:$filename &&
 	git notes show HEAD:$filename > actual &&
 	test_cmp expect actual &&
 	echo "Note on a tag" > expect
 	git tag -a -m "This is an annotated tag" foobar HEAD^ &&
-	git notes edit -m "Note on a tag" foobar &&
+	git notes add -m "Note on a tag" foobar &&
 	git notes show foobar > actual &&
 	test_cmp expect actual
 '
-- 
1.7.0.rc1.141.gd3fd
