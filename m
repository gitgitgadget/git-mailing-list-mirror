From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 25/30] builtin-notes: Add "append" subcommand for appending
 to note objects
Date: Sat, 13 Feb 2010 22:28:33 +0100
Message-ID: <1266096518-2104-26-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:31:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPao-0002mJ-9q
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152Ab0BMVah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:30:37 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51507 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758069Ab0BMV35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:57 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EGPUDVVE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:55 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:55 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211825
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139854>

"git notes append" is equivalent to "git notes edit" except that instead
of editing existing notes contents, you can only append to it. This is
useful for quickly adding annotations like e.g.:
	git notes append -m "Acked-by: A U Thor <author@example.com>"

"git notes append" takes the same -m/-F options as "git notes add".

If there is no existing note to append to, "git notes append" is identical
to "git notes add" (i.e. it adds a new note).

The patch includes tests verifying correct behaviour of the new subcommand.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |    5 +++++
 builtin-notes.c             |   35 ++++++++++++++++++++++++++---------
 t/t3301-notes.sh            |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 94e12b5..35dd8fa 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git notes' [list [<object>]]
 'git notes' add [-f] [-F <file> | -m <msg>] [<object>]
+'git notes' append [-F <file> | -m <msg>] [<object>]
 'git notes' edit [-F <file> | -m <msg>] [<object>]
 'git notes' show [<object>]
 'git notes' remove [<object>]
@@ -47,6 +48,10 @@ add::
 	object already has notes, abort. (use `-f` to overwrite an
 	existing note).
 
+append::
+	Append to the notes of an existing object (defaults to HEAD).
+	Creates a new notes object if needed.
+
 edit::
 	Edit the notes for a given object (defaults to HEAD).
 
diff --git a/builtin-notes.c b/builtin-notes.c
index 006edf6..c88df00 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -20,6 +20,7 @@
 static const char * const git_notes_usage[] = {
 	"git notes [list [<object>]]",
 	"git notes add [-f] [-m <msg> | -F <file>] [<object>]",
+	"git notes append [-m <msg> | -F <file>] [<object>]",
 	"git notes edit [-m <msg> | -F <file>] [<object>]",
 	"git notes show [<object>]",
 	"git notes remove [<object>]",
@@ -94,7 +95,7 @@ static void write_commented_object(int fd, const unsigned char *object)
 
 static void create_note(const unsigned char *object,
 			struct strbuf *buf,
-			int skip_editor,
+			int skip_editor, int append_only,
 			const unsigned char *prev,
 			unsigned char *result)
 {
@@ -109,7 +110,7 @@ static void create_note(const unsigned char *object,
 		if (fd < 0)
 			die_errno("could not create file '%s'", path);
 
-		if (prev)
+		if (prev && !append_only)
 			write_note_data(fd, prev);
 		write_or_die(fd, note_template, strlen(note_template));
 
@@ -125,6 +126,20 @@ static void create_note(const unsigned char *object,
 
 	stripspace(buf, 1);
 
+	if (prev && append_only) {
+		/* Append buf to previous note contents */
+		unsigned long size;
+		enum object_type type;
+		char *prev_buf = read_sha1_file(prev, &type, &size);
+
+		strbuf_grow(buf, size + 1);
+		if (buf->len && prev_buf && size)
+			strbuf_insert(buf, 0, "\n", 1);
+		if (prev_buf && size)
+			strbuf_insert(buf, 0, prev_buf, size);
+		free(prev_buf);
+	}
+
 	if (!buf->len) {
 		fprintf(stderr, "Removing note for object %s\n",
 			sha1_to_hex(object));
@@ -212,8 +227,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	char logmsg[100];
 
-	int list = 0, add = 0, edit = 0, show = 0, remove = 0, prune = 0,
-	    force = 0;
+	int list = 0, add = 0, append = 0, edit = 0, show = 0, remove = 0,
+	    prune = 0, force = 0;
 	int given_object;
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
@@ -234,6 +249,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		list = 1;
 	else if (argc && !strcmp(argv[0], "add"))
 		add = 1;
+	else if (argc && !strcmp(argv[0], "append"))
+		append = 1;
 	else if (argc && !strcmp(argv[0], "edit"))
 		edit = 1;
 	else if (argc && !strcmp(argv[0], "show"))
@@ -245,10 +262,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	else if (!argc)
 		list = 1; /* Default to 'list' if no other subcommand given */
 
-	if (list + add + edit + show + remove + prune != 1)
+	if (list + add + append + edit + show + remove + prune != 1)
 		usage_with_options(git_notes_usage, options);
 
-	if ((msg.given || msgfile) && !(add || edit)) {
+	if ((msg.given || msgfile) && !(add || append || edit)) {
 		error("cannot use -m/-F options with %s subcommand.", argv[0]);
 		usage_with_options(git_notes_usage, options);
 	}
@@ -304,7 +321,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		return execv_git_cmd(show_args);
 	}
 
-	/* add/edit/remove/prune command */
+	/* add/append/edit/remove/prune command */
 
 	if (add && note) {
 		if (force)
@@ -334,8 +351,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		hashclr(new_note);
 		prune_notes(t);
 	} else {
-		create_note(object, &buf, msg.given || msgfile || remove, note,
-			    new_note);
+		create_note(object, &buf, msg.given || msgfile || remove,
+			    append, note, new_note);
 		if (is_null_sha1(new_note))
 			remove_note(t, object);
 		else
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index df458ca..290ed63 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -343,6 +343,42 @@ test_expect_success 'listing non-existing notes fails' '
 	test_cmp expect output
 '
 
+cat > expect << EOF
+Initial set of notes
+
+More notes appended with git notes append
+EOF
+
+test_expect_success 'append to existing note with "git notes append"' '
+	git notes add -m "Initial set of notes" &&
+	git notes append -m "More notes appended with git notes append" &&
+	git notes show > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'appending empty string does not change existing note' '
+	git notes append -m "" &&
+	git notes show > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'git notes append == add when there is no existing note' '
+	git notes remove HEAD &&
+	test_must_fail git notes list HEAD &&
+	git notes append -m "Initial set of notes
+
+More notes appended with git notes append" &&
+	git notes show > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'appending empty string to non-existing note does not create note' '
+	git notes remove HEAD &&
+	test_must_fail git notes list HEAD &&
+	git notes append -m "" &&
+	test_must_fail git notes list HEAD
+'
+
 test_expect_success 'create other note on a different notes ref (setup)' '
 	: > a6 &&
 	git add a6 &&
-- 
1.7.0.rc1.141.gd3fd
