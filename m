From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 27/30] builtin-notes: Refactor handling of -F option to
 allow combining -m and -F
Date: Sat, 13 Feb 2010 22:28:35 +0100
Message-ID: <1266096518-2104-28-git-send-email-johan@herland.net>
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
	id 1NgPZJ-0001iD-9x
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758143Ab0BMVaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:30:12 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62668 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758114Ab0BMVaC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:30:02 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FL3UE05490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:30:00 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:30:00 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211825
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139851>

By moving the -F option handling into a separate function (parse_file_arg),
we can start allowing several -F options, and mixed usage of -m and -F
options. Each -m/-F given appends to the note message, in the order they are
given on the command-line.

The patch includes tests verifying correct behaviour of the new functionality.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-notes.c  |   94 +++++++++++++++++++++++++++++------------------------
 t/t3301-notes.sh |   23 ++++++++++++-
 2 files changed, 73 insertions(+), 44 deletions(-)

diff --git a/builtin-notes.c b/builtin-notes.c
index 572b477..190c46c 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -34,6 +34,11 @@ static const char note_template[] =
 	"# Write/edit the notes for the following object:\n"
 	"#\n";
 
+struct msg_arg {
+	int given;
+	struct strbuf buf;
+};
+
 static int list_each_note(const unsigned char *object_sha1,
 		const unsigned char *note_sha1, char *note_path,
 		void *cb_data)
@@ -93,15 +98,13 @@ static void write_commented_object(int fd, const unsigned char *object)
 		    sha1_to_hex(object));
 }
 
-static void create_note(const unsigned char *object,
-			struct strbuf *buf,
-			int skip_editor, int append_only,
-			const unsigned char *prev,
+static void create_note(const unsigned char *object, struct msg_arg *msg,
+			int append_only, const unsigned char *prev,
 			unsigned char *result)
 {
 	char *path = NULL;
 
-	if (!skip_editor) {
+	if (!msg->given) {
 		int fd;
 
 		/* write the template message before editing: */
@@ -118,34 +121,33 @@ static void create_note(const unsigned char *object,
 
 		close(fd);
 
-		if (launch_editor(path, buf, NULL)) {
+		if (launch_editor(path, &(msg->buf), NULL)) {
 			die("Please supply the note contents using either -m" \
 			    " or -F option");
 		}
+		stripspace(&(msg->buf), 1);
 	}
 
-	stripspace(buf, 1);
-
 	if (prev && append_only) {
 		/* Append buf to previous note contents */
 		unsigned long size;
 		enum object_type type;
 		char *prev_buf = read_sha1_file(prev, &type, &size);
 
-		strbuf_grow(buf, size + 1);
-		if (buf->len && prev_buf && size)
-			strbuf_insert(buf, 0, "\n", 1);
+		strbuf_grow(&(msg->buf), size + 1);
+		if (msg->buf.len && prev_buf && size)
+			strbuf_insert(&(msg->buf), 0, "\n", 1);
 		if (prev_buf && size)
-			strbuf_insert(buf, 0, prev_buf, size);
+			strbuf_insert(&(msg->buf), 0, prev_buf, size);
 		free(prev_buf);
 	}
 
-	if (!buf->len) {
+	if (!msg->buf.len) {
 		fprintf(stderr, "Removing note for object %s\n",
 			sha1_to_hex(object));
 		hashclr(result);
 	} else {
-		if (write_sha1_file(buf->buf, buf->len, blob_type, result)) {
+		if (write_sha1_file(msg->buf.buf, msg->buf.len, blob_type, result)) {
 			error("unable to write note object");
 			if (path)
 				error("The note contents has been left in %s",
@@ -160,20 +162,39 @@ static void create_note(const unsigned char *object,
 	}
 }
 
-struct msg_arg {
-	int given;
-	struct strbuf buf;
-};
-
 static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct msg_arg *msg = opt->value;
 
 	if (!arg)
 		return -1;
+
+	strbuf_grow(&(msg->buf), strlen(arg) + 2);
 	if (msg->buf.len)
-		strbuf_addstr(&(msg->buf), "\n\n");
+		strbuf_addstr(&(msg->buf), "\n");
 	strbuf_addstr(&(msg->buf), arg);
+	stripspace(&(msg->buf), 0);
+
+	msg->given = 1;
+	return 0;
+}
+
+static int parse_file_arg(const struct option *opt, const char *arg, int unset)
+{
+	struct msg_arg *msg = opt->value;
+
+	if (!arg)
+		return -1;
+
+	if (msg->buf.len)
+		strbuf_addstr(&(msg->buf), "\n");
+	if (!strcmp(arg, "-")) {
+		if (strbuf_read(&(msg->buf), 0, 1024) < 0)
+			die_errno("cannot read '%s'", arg);
+	} else if (strbuf_read_file(&(msg->buf), arg, 1024) < 0)
+		die_errno("could not open or read '%s'", arg);
+	stripspace(&(msg->buf), 0);
+
 	msg->given = 1;
 	return 0;
 }
@@ -220,7 +241,6 @@ int commit_notes(struct notes_tree *t, const char *msg)
 
 int cmd_notes(int argc, const char **argv, const char *prefix)
 {
-	struct strbuf buf = STRBUF_INIT;
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
 	const unsigned char *note;
@@ -230,13 +250,13 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	int list = 0, add = 0, append = 0, edit = 0, show = 0, remove = 0,
 	    prune = 0, force = 0;
 	int given_object;
-	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct option options[] = {
 		OPT_GROUP("Notes options"),
-		OPT_CALLBACK('m', "message", &msg, "msg",
+		OPT_CALLBACK('m', "message", &msg, "MSG",
 			     "note contents as a string", parse_msg_arg),
-		OPT_FILENAME('F', "file", &msgfile, "note contents in a file"),
+		OPT_CALLBACK('F', "file", &msg, "FILE",
+			     "note contents in a file", parse_file_arg),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
 		OPT_END()
 	};
@@ -265,21 +285,17 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	if (list + add + append + edit + show + remove + prune != 1)
 		usage_with_options(git_notes_usage, options);
 
-	if ((msg.given || msgfile) && !(add || append || edit)) {
+	if (msg.given && !(add || append || edit)) {
 		error("cannot use -m/-F options with %s subcommand.", argv[0]);
 		usage_with_options(git_notes_usage, options);
 	}
 
-	if ((msg.given || msgfile) && edit) {
+	if (msg.given && edit) {
 		fprintf(stderr, "The -m and -F options has been deprecated for"
 			" the 'edit' subcommand.\n"
 			"Please use 'git notes add -f -m/-F' instead.\n");
 	}
 
-	if (msg.given && msgfile) {
-		error("mixing -m and -F options is not allowed.");
-		usage_with_options(git_notes_usage, options);
-	}
 
 	if (force && !add) {
 		error("cannot use -f option with %s subcommand.", argv[0]);
@@ -341,24 +357,16 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (remove)
-		strbuf_reset(&buf);
-	else if (msg.given)
-		strbuf_addbuf(&buf, &(msg.buf));
-	else if (msgfile) {
-		if (!strcmp(msgfile, "-")) {
-			if (strbuf_read(&buf, 0, 1024) < 0)
-				die_errno("cannot read '%s'", msgfile);
-		} else if (strbuf_read_file(&buf, msgfile, 1024) < 0)
-			die_errno("could not open or read '%s'", msgfile);
+	if (remove) {
+		msg.given = 1;
+		strbuf_reset(&(msg.buf));
 	}
 
 	if (prune) {
 		hashclr(new_note);
 		prune_notes(t);
 	} else {
-		create_note(object, &buf, msg.given || msgfile || remove,
-			    append, note, new_note);
+		create_note(object, &msg, append, note, new_note);
 		if (is_null_sha1(new_note))
 			remove_note(t, object);
 		else
@@ -369,6 +377,6 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	commit_notes(t, logmsg);
 
 	free_notes(t);
-	strbuf_release(&buf);
+	strbuf_release(&(msg.buf));
 	return 0;
 }
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 290ed63..07090e3 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -284,8 +284,29 @@ test_expect_success 'verify non-creation of note with -m ""' '
 	! git notes show
 '
 
+cat > expect-combine_m_and_F << EOF
+foo
+
+xyzzy
+
+bar
+
+zyxxy
+
+baz
+EOF
+
+test_expect_success 'create note with combination of -m and -F' '
+	echo "xyzzy" > note_a &&
+	echo "zyxxy" > note_b &&
+	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" &&
+	git notes show > output &&
+	test_cmp expect-combine_m_and_F output
+'
+
 test_expect_success 'remove note with "git notes remove" (setup)' '
-	git notes remove HEAD^
+	git notes remove HEAD^ &&
+	git notes remove
 '
 
 cat > expect-rm-remove << EOF
-- 
1.7.0.rc1.141.gd3fd
