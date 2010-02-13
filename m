From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 28/30] builtin-notes: Add -c/-C options for reusing notes
Date: Sat, 13 Feb 2010 22:28:36 +0100
Message-ID: <1266096518-2104-29-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZK-0001iD-Bi
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146Ab0BMVaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:30:15 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51565 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758136Ab0BMVaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:30:07 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EGZUE3VE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:30:03 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:30:03 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211825
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139852>

Inspired by the -c/-C options to "git commit", we teach these options to
"git notes add/append" to allow reuse of note objects.

With this patch in place, it is now easy to copy or move notes between
objects. For example, to copy object A's notes to object B:
	git notes add [-f] -C $(git notes list A) B
To move instead of copying, you simply remove the notes from the source
object afterwards, e.g.:
	git notes remove A

The patch includes tests verifying correct behaviour of the new functionality.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   12 ++++-
 builtin-notes.c             |   63 +++++++++++++++++++----
 t/t3301-notes.sh            |  116 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 53c5d90..15de4b3 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git notes' [list [<object>]]
-'git notes' add [-f] [-F <file> | -m <msg>] [<object>]
-'git notes' append [-F <file> | -m <msg>] [<object>]
+'git notes' add [-f] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' append [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [<object>]
 'git notes' show [<object>]
 'git notes' remove [<object>]
@@ -84,6 +84,14 @@ OPTIONS
 	Take the note message from the given file.  Use '-' to
 	read the note message from the standard input.
 
+-C <object>::
+--reuse-message=<object>::
+	Reuse the note message from the given note object.
+
+-c <object>::
+--reedit-message=<object>::
+	Like '-C', but with '-c' the editor is invoked, so that
+	the user can further edit the note message.
 
 Author
 ------
diff --git a/builtin-notes.c b/builtin-notes.c
index 190c46c..98de115 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -19,8 +19,8 @@
 
 static const char * const git_notes_usage[] = {
 	"git notes [list [<object>]]",
-	"git notes add [-f] [-m <msg> | -F <file>] [<object>]",
-	"git notes append [-m <msg> | -F <file>] [<object>]",
+	"git notes add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
+	"git notes append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
 	"git notes edit [<object>]",
 	"git notes show [<object>]",
 	"git notes remove [<object>]",
@@ -36,6 +36,7 @@ static const char note_template[] =
 
 struct msg_arg {
 	int given;
+	int use_editor;
 	struct strbuf buf;
 };
 
@@ -104,7 +105,7 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 {
 	char *path = NULL;
 
-	if (!msg->given) {
+	if (msg->use_editor || !msg->given) {
 		int fd;
 
 		/* write the template message before editing: */
@@ -113,13 +114,16 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 		if (fd < 0)
 			die_errno("could not create file '%s'", path);
 
-		if (prev && !append_only)
+		if (msg->given)
+			write_or_die(fd, msg->buf.buf, msg->buf.len);
+		else if (prev && !append_only)
 			write_note_data(fd, prev);
 		write_or_die(fd, note_template, strlen(note_template));
 
 		write_commented_object(fd, object);
 
 		close(fd);
+		strbuf_reset(&(msg->buf));
 
 		if (launch_editor(path, &(msg->buf), NULL)) {
 			die("Please supply the note contents using either -m" \
@@ -199,6 +203,40 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
+{
+	struct msg_arg *msg = opt->value;
+	char *buf;
+	unsigned char object[20];
+	enum object_type type;
+	unsigned long len;
+
+	if (!arg)
+		return -1;
+
+	if (msg->buf.len)
+		strbuf_addstr(&(msg->buf), "\n");
+
+	if (get_sha1(arg, object))
+		die("Failed to resolve '%s' as a valid ref.", arg);
+	if (!(buf = read_sha1_file(object, &type, &len)) || !len) {
+		free(buf);
+		die("Failed to read object '%s'.", arg);;
+	}
+	strbuf_add(&(msg->buf), buf, len);
+	free(buf);
+
+	msg->given = 1;
+	return 0;
+}
+
+static int parse_reedit_arg(const struct option *opt, const char *arg, int unset)
+{
+	struct msg_arg *msg = opt->value;
+	msg->use_editor = 1;
+	return parse_reuse_arg(opt, arg, unset);
+}
+
 int commit_notes(struct notes_tree *t, const char *msg)
 {
 	struct commit_list *parent;
@@ -250,13 +288,17 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	int list = 0, add = 0, append = 0, edit = 0, show = 0, remove = 0,
 	    prune = 0, force = 0;
 	int given_object;
-	struct msg_arg msg = { 0, STRBUF_INIT };
+	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	struct option options[] = {
 		OPT_GROUP("Notes options"),
 		OPT_CALLBACK('m', "message", &msg, "MSG",
 			     "note contents as a string", parse_msg_arg),
 		OPT_CALLBACK('F', "file", &msg, "FILE",
 			     "note contents in a file", parse_file_arg),
+		OPT_CALLBACK('c', "reedit-message", &msg, "OBJECT",
+			   "reuse and edit specified note object", parse_reedit_arg),
+		OPT_CALLBACK('C', "reuse-message", &msg, "OBJECT",
+			   "reuse specified note object", parse_reuse_arg),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
 		OPT_END()
 	};
@@ -286,17 +328,17 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_usage, options);
 
 	if (msg.given && !(add || append || edit)) {
-		error("cannot use -m/-F options with %s subcommand.", argv[0]);
+		error("cannot use -m/-F/-c/-C options with %s subcommand.",
+		      argv[0]);
 		usage_with_options(git_notes_usage, options);
 	}
 
 	if (msg.given && edit) {
-		fprintf(stderr, "The -m and -F options has been deprecated for"
-			" the 'edit' subcommand.\n"
-			"Please use 'git notes add -f -m/-F' instead.\n");
+		fprintf(stderr, "The -m/-F/-c/-C options have been deprecated "
+			"for the 'edit' subcommand.\n"
+			"Please use 'git notes add -f -m/-F/-c/-C' instead.\n");
 	}
 
-
 	if (force && !add) {
 		error("cannot use -f option with %s subcommand.", argv[0]);
 		usage_with_options(git_notes_usage, options);
@@ -359,6 +401,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	if (remove) {
 		msg.given = 1;
+		msg.use_editor = 0;
 		strbuf_reset(&(msg.buf));
 	}
 
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 07090e3..6447e5f 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -465,4 +465,120 @@ test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 	test_cmp expect actual
 '
 
+cat > expect << EOF
+commit 2ede89468182a62d0bde2583c736089bcf7d7e92
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:19:13 2005 -0700
+
+    7th
+
+Notes:
+    other note
+EOF
+
+test_expect_success 'create note from other note with "git notes add -C"' '
+	: > a7 &&
+	git add a7 &&
+	test_tick &&
+	git commit -m 7th &&
+	git notes add -C $(git notes list HEAD^) &&
+	git log -1 > actual &&
+	test_cmp expect actual &&
+	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
+'
+
+test_expect_success 'create note from non-existing note with "git notes add -C" fails' '
+	: > a8 &&
+	git add a8 &&
+	test_tick &&
+	git commit -m 8th &&
+	test_must_fail git notes add -C deadbeef &&
+	test_must_fail git notes list HEAD
+'
+
+cat > expect << EOF
+commit 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:21:13 2005 -0700
+
+    9th
+
+Notes:
+    yet another note
+EOF
+
+test_expect_success 'create note from other note with "git notes add -c"' '
+	: > a9 &&
+	git add a9 &&
+	test_tick &&
+	git commit -m 9th &&
+	MSG="yet another note" git notes add -c $(git notes list HEAD^^) &&
+	git log -1 > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create note from non-existing note with "git notes add -c" fails' '
+	: > a10 &&
+	git add a10 &&
+	test_tick &&
+	git commit -m 10th &&
+	test_must_fail MSG="yet another note" git notes add -c deadbeef &&
+	test_must_fail git notes list HEAD
+'
+
+cat > expect << EOF
+commit 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:21:13 2005 -0700
+
+    9th
+
+Notes:
+    yet another note
+$whitespace
+    yet another note
+EOF
+
+test_expect_success 'append to note from other note with "git notes append -C"' '
+	git notes append -C $(git notes list HEAD^) HEAD^ &&
+	git log -1 HEAD^ > actual &&
+	test_cmp expect actual
+'
+
+cat > expect << EOF
+commit ffed603236bfa3891c49644257a83598afe8ae5a
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:22:13 2005 -0700
+
+    10th
+
+Notes:
+    other note
+EOF
+
+test_expect_success 'create note from other note with "git notes append -c"' '
+	MSG="other note" git notes append -c $(git notes list HEAD^) &&
+	git log -1 > actual &&
+	test_cmp expect actual
+'
+
+cat > expect << EOF
+commit ffed603236bfa3891c49644257a83598afe8ae5a
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:22:13 2005 -0700
+
+    10th
+
+Notes:
+    other note
+$whitespace
+    yet another note
+EOF
+
+test_expect_success 'append to note from other note with "git notes append -c"' '
+	MSG="yet another note" git notes append -c $(git notes list HEAD) &&
+	git log -1 > actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.0.rc1.141.gd3fd
