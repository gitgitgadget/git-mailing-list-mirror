From: Johan Herland <johan@herland.net>
Subject: [PATCHv12 23/23] builtin-notes: Add "add" subcommand for appending to
 note objects
Date: Wed, 27 Jan 2010 12:52:00 +0100
Message-ID: <1264593120-4428-24-git-send-email-johan@herland.net>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 27 12:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Sf-0000gj-Pa
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab0A0LxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440Ab0A0LxE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:53:04 -0500
Received: from smtp.getmail.no ([84.208.15.66]:52954 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753543Ab0A0Lw4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:52:56 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00JEBMC62M00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:54 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00EZ7MAZN340@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:54 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.113919
X-Mailer: git-send-email 1.6.6.405.g80ed6
In-reply-to: <1264593120-4428-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138148>

"git notes add" is identical to "git notes edit" except that instead of
editing existing notes contents, you can only append to it. This is
useful for quickly adding annotations like e.g.:
	git notes add -m "Acked-by: A U Thor <author@example.com>"

If there is no existing note to append to, "git notes add" is identical
to "git notes edit" (i.e. it adds a new note).

The patch includes tests verifying correct behaviour of the new subcommand.

Suggested-by: Joey Hess <joey@kitenet.net>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |    5 ++++-
 builtin-notes.c             |   34 +++++++++++++++++++++++++---------
 t/t3301-notes.sh            |   29 +++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 4d29d5f..3fe73e8 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git notes' [list [<object>]]
-'git notes' edit [-F <file> | -m <msg>] [<object>]
+'git notes' (edit | add) [-F <file> | -m <msg>] [<object>]
 'git notes' show [<object>]
 'git notes' remove [<object>]
 'git notes' prune
@@ -44,6 +44,9 @@ list::
 edit::
 	Edit the notes for a given object (defaults to HEAD).
 
+add::
+	Append to the notes for a given object (defaults to HEAD).
+
 show::
 	Show the notes for a given object (defaults to HEAD).
 
diff --git a/builtin-notes.c b/builtin-notes.c
index a322642..4f570a4 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -18,7 +18,7 @@
 
 static const char * const git_notes_usage[] = {
 	"git notes [list [<object>]]",
-	"git notes edit [-m <msg> | -F <file>] [<object>]",
+	"git notes (edit | add) [-m <msg> | -F <file>] [<object>]",
 	"git notes show [<object>]",
 	"git notes remove [<object>]",
 	"git notes prune",
@@ -53,7 +53,7 @@ static void write_note_data(int fd, const unsigned char *sha1)
 
 static void create_note(const unsigned char *object,
 			struct strbuf *buf,
-			int skip_editor,
+			int skip_editor, int append_only,
 			const unsigned char *prev,
 			unsigned char *result)
 {
@@ -68,7 +68,7 @@ static void create_note(const unsigned char *object,
 		if (fd < 0)
 			die_errno("could not create file '%s'", path);
 
-		if (prev)
+		if (prev && !append_only)
 			write_note_data(fd, prev);
 		write_or_die(fd, note_template, strlen(note_template));
 
@@ -82,6 +82,20 @@ static void create_note(const unsigned char *object,
 
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
@@ -169,7 +183,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	char logmsg[100];
 
-	int list = 0, edit = 0, show = 0, remove = 0, prune = 0;
+	int list = 0, edit = 0, add = 0, show = 0, remove = 0, prune = 0;
 	int given_object;
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
@@ -189,6 +203,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		list = 1;
 	else if (argc && !strcmp(argv[0], "edit"))
 		edit = 1;
+	else if (argc && !strcmp(argv[0], "add"))
+		add = 1;
 	else if (argc && !strcmp(argv[0], "show"))
 		show = 1;
 	else if (argc && !strcmp(argv[0], "remove"))
@@ -198,10 +214,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	else if (!argc)
 		list = 1; /* Default to 'list' if no other subcommand given */
 
-	if (list + edit + show + remove + prune != 1)
+	if (list + edit + add + show + remove + prune != 1)
 		usage_with_options(git_notes_usage, options);
 
-	if ((msg.given || msgfile) && !edit) {
+	if ((msg.given || msgfile) && !(edit || add)) {
 		error("cannot use -m/-F options with %s subcommand.", argv[0]);
 		usage_with_options(git_notes_usage, options);
 	}
@@ -250,7 +266,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		return execv_git_cmd(show_args);
 	}
 
-	/* edit/remove/prune command */
+	/* edit/add/remove/prune command */
 
 	if (remove)
 		strbuf_reset(&buf);
@@ -268,8 +284,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		hashclr(new_note);
 		prune_notes(t);
 	} else {
-		create_note(object, &buf, msg.given || msgfile || remove, note,
-			    new_note);
+		create_note(object, &buf, msg.given || msgfile || remove, add,
+			    note, new_note);
 		if (is_null_sha1(new_note))
 			remove_note(t, object);
 		else
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 13f307a..b40e5a1 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -316,6 +316,35 @@ test_expect_success 'list specific note with "git notes list <object>"' '
 	test_cmp expect output
 '
 
+cat > expect << EOF
+Initial set of notes
+
+More notes added with git notes add
+EOF
+
+test_expect_success 'Append to existing note with "git notes add"' '
+	git notes edit -m "Initial set of notes" &&
+	git notes add -m "More notes added with git notes add" &&
+	git notes show > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'Appending empty string does not change existing note' '
+	git notes add -m "" &&
+	git notes show > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'git notes add == edit when there is no existing note' '
+	git notes remove HEAD &&
+	! git notes show &&
+	git notes add -m "Initial set of notes
+
+More notes added with git notes add" &&
+	git notes show > output &&
+	test_cmp expect output
+'
+
 test_expect_success 'create other note on a different notes ref (setup)' '
 	: > a6 &&
 	git add a6 &&
-- 
1.6.6.405.g80ed6
