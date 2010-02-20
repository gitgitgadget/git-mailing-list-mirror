From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 06/12] notes: implement 'git notes copy --stdin'
Date: Sat, 20 Feb 2010 23:16:27 +0100
Message-ID: <3559e59dd81bd3fb94196c399e1640681a323147.1266703765.git.trast@student.ethz.ch>
References: <cover.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 00:31:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nixe5-0006OX-Vq
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 23:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756889Ab0BTWRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 17:17:13 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:6942 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756869Ab0BTWRG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 17:17:06 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:57 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:38 +0100
X-Mailer: git-send-email 1.7.0.137.gfe3f1
In-Reply-To: <cover.1266703765.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140572>

This implements a mass-copy command that takes a sequence of lines in
the format

  <from-sha1> SP <to-sha1> [ SP <rest> ] LF

on stdin, and copies each <from-sha1>'s notes to the <to-sha1>.  The
<rest> is ignored.  The intent, of course, is that this can read the
same input that the 'post-rewrite' hook gets.

The copy_note() function is exposed for everyone's and in particular
the next commit's use.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-notes.txt |   12 ++++++++-
 builtin-notes.c             |   57 ++++++++++++++++++++++++++++++++++++++++++-
 notes.c                     |   21 ++++++++++++++++
 notes.h                     |    9 +++++++
 t/t3301-notes.sh            |   32 ++++++++++++++++++++++++
 5 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 14f73b9..f67cb6a 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git notes' [list [<object>]]
 'git notes' add [-f] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
-'git notes' copy [-f] <from-object> <to-object>
+'git notes' copy [-f] ( --stdin | <from-object> <to-object> )
 'git notes' append [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [<object>]
 'git notes' show [<object>]
@@ -55,6 +55,16 @@ copy::
 	objects has none. (use -f to overwrite existing notes to the
 	second object). This subcommand is equivalent to:
 	`git notes add [-f] -C $(git notes list <from-object>) <to-object>`
++
+In `\--stdin` mode, take lines in the format
++
+----------
+<from-object> SP <to-object> [ SP <rest> ] LF
+----------
++
+on standard input, and copy the notes from each <from-object> to its
+corresponding <to-object>.  (The optional `<rest>` is ignored so that
+the command can read the input given to the `post-rewrite` hook.)
 
 append::
 	Append to the notes of an existing object (defaults to HEAD).
diff --git a/builtin-notes.c b/builtin-notes.c
index 123ecad..62f6ceb 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -278,6 +278,47 @@ int commit_notes(struct notes_tree *t, const char *msg)
 	return 0;
 }
 
+int notes_copy_from_stdin(int force)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct notes_tree *t;
+	struct notes_rewrite_cfg *c = NULL;
+	int ret = 0;
+
+	init_notes(NULL, NULL, NULL, 0);
+	t = &default_notes_tree;
+
+	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		unsigned char from_obj[20], to_obj[20];
+		struct strbuf **split;
+		int err;
+
+		split = strbuf_split(&buf, ' ');
+		if (!split[0] || !split[1])
+			die("Malformed input line: '%s'.", buf.buf);
+		strbuf_rtrim(split[0]);
+		strbuf_rtrim(split[1]);
+		if (get_sha1(split[0]->buf, from_obj))
+			die("Failed to resolve '%s' as a valid ref.", split[0]->buf);
+		if (get_sha1(split[1]->buf, to_obj))
+			die("Failed to resolve '%s' as a valid ref.", split[1]->buf);
+
+		err = copy_note(t, from_obj, to_obj, force, combine_notes_overwrite);
+
+		if (err) {
+			error("Failed to copy notes from '%s' to '%s'",
+			      split[0]->buf, split[1]->buf);
+			ret = 1;
+		}
+
+		strbuf_list_free(split);
+	}
+
+	commit_notes(t, "Notes added by 'git notes copy'");
+	free_notes(t);
+	return ret;
+}
+
 int cmd_notes(int argc, const char **argv, const char *prefix)
 {
 	struct notes_tree *t;
@@ -287,7 +328,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	char logmsg[100];
 
 	int list = 0, add = 0, copy = 0, append = 0, edit = 0, show = 0,
-	    remove = 0, prune = 0, force = 0;
+	    remove = 0, prune = 0, force = 0, from_stdin = 0;
 	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	struct option options[] = {
@@ -301,6 +342,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('C', "reuse-message", &msg, "OBJECT",
 			   "reuse specified note object", parse_reuse_arg),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
+		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
 		OPT_END()
 	};
 
@@ -349,8 +391,21 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_usage, options);
 	}
 
+	if (!copy && from_stdin) {
+		error("cannot use --stdin with %s subcommand.", argv[0]);
+		usage_with_options(git_notes_usage, options);
+	}
+
 	if (copy) {
 		const char *from_ref;
+		if (from_stdin) {
+			if (argc > 1) {
+				error("too many parameters");
+				usage_with_options(git_notes_usage, options);
+			} else {
+				return notes_copy_from_stdin(force);
+			}
+		}
 		if (argc < 3) {
 			error("too few parameters");
 			usage_with_options(git_notes_usage, options);
diff --git a/notes.c b/notes.c
index d37178b..b194870 100644
--- a/notes.c
+++ b/notes.c
@@ -1122,3 +1122,24 @@ void format_display_notes(const unsigned char *object_sha1,
 		format_note(display_notes_trees[i], object_sha1, sb,
 			    output_encoding, flags);
 }
+
+int copy_note(struct notes_tree *t,
+	      const unsigned char *from_obj, const unsigned char *to_obj,
+	      int force, combine_notes_fn combine_fn)
+{
+	const unsigned char *note;
+
+	note = get_note(t, from_obj);
+	if (!force) {
+		const unsigned char *existing_note = get_note(t, to_obj);
+		if (existing_note)
+			return 1;
+	}
+
+	if (note)
+		add_note(t, to_obj, note, combine_fn);
+	else
+		remove_note(t, to_obj);
+
+	return 0;
+}
diff --git a/notes.h b/notes.h
index 32ae2f0..fb09537 100644
--- a/notes.h
+++ b/notes.h
@@ -100,6 +100,15 @@ void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 		const unsigned char *object_sha1);
 
 /*
+ * Copy a note from one object to another in the given notes_tree.
+ *
+ * Fails if the to_obj already has a note unless 'force' is true.
+ */
+int copy_note(struct notes_tree *t,
+	      const unsigned char *from_obj, const unsigned char *to_obj,
+	      int force, combine_notes_fn combine_fn);
+
+/*
  * Flags controlling behaviour of for_each_note()
  *
  * Default behaviour of for_each_note() is to traverse every single note object
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 0dfff82..634d213 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -683,4 +683,36 @@ test_expect_success 'cannot copy note from object without notes' '
 	test_must_fail git notes copy HEAD^ HEAD
 '
 
+cat > expect << EOF
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:25:13 2005 -0700
+
+    13th
+
+Notes from notes/other:
+    yet another note
+$whitespace
+    yet another note
+
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:24:13 2005 -0700
+
+    12th
+
+Notes from notes/other:
+    other note
+$whitespace
+    yet another note
+EOF
+
+test_expect_success 'git notes copy --stdin' '
+	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
+	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
+	git notes copy --stdin &&
+	git log -2 > output &&
+	strip_then_cmp expect output &&
+	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
+	test "$(git notes list HEAD^)" = "$(git notes list HEAD~3)"
+'
+
 test_done
-- 
1.7.0.59.g783f8
