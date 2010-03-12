From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v7 07/13] notes: implement 'git notes copy --stdin'
Date: Fri, 12 Mar 2010 18:04:31 +0100
Message-ID: <e0fbd6edc13d94a097e8e7e3649b9e669f9b4ee3.1268413246.git.trast@student.ethz.ch>
References: <cover.1268413246.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 18:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq8JQ-00018m-5i
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 18:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758628Ab0CLRFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 12:05:20 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:18753 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758620Ab0CLRFM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 12:05:12 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:02 +0100
Received: from localhost.localdomain (213.55.131.184) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:04:52 +0100
X-Mailer: git-send-email 1.7.0.2.417.gbc354
In-Reply-To: <cover.1268413246.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142053>

This implements a mass-copy command that takes a sequence of lines in
the format

  <from-sha1> SP <to-sha1> [ SP <rest> ] LF

on stdin, and copies each <from-sha1>'s notes to the <to-sha1>.  The
<rest> is ignored.  The intent, of course, is that this can read the
same input that the 'post-rewrite' hook gets.

The copy_note() function is exposed for everyone's and in particular
the next commit's use.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Johan Herland <johan@herland.net>
---


 Documentation/git-notes.txt |   12 ++++++++-
 builtin/notes.c             |   56 ++++++++++++++++++++++++++++++++++++++++++-
 notes.c                     |   18 +++++++++++++
 notes.h                     |    9 +++++++
 t/t3301-notes.sh            |   34 ++++++++++++++++++++++++++
 5 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 95b4bca..064758b 100644
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
@@ -56,6 +56,16 @@ copy::
 	object has none (use -f to overwrite existing notes to the
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
diff --git a/builtin/notes.c b/builtin/notes.c
index feb710a..576a989 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -269,6 +269,46 @@ int commit_notes(struct notes_tree *t, const char *msg)
 	return 0;
 }
 
+int notes_copy_from_stdin(int force)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct notes_tree *t;
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
@@ -278,7 +318,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	char logmsg[100];
 
 	int list = 0, add = 0, copy = 0, append = 0, edit = 0, show = 0,
-	    remove = 0, prune = 0, force = 0;
+	    remove = 0, prune = 0, force = 0, from_stdin = 0;
 	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	struct option options[] = {
@@ -297,6 +337,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg},
 		OPT_GROUP("Other options"),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
+		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
 		OPT_END()
 	};
 
@@ -345,8 +386,21 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
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
index 216ad24..66912a3 100644
--- a/notes.c
+++ b/notes.c
@@ -1186,3 +1186,21 @@ void format_display_notes(const unsigned char *object_sha1,
 		format_note(display_notes_trees[i], object_sha1, sb,
 			    output_encoding, flags);
 }
+
+int copy_note(struct notes_tree *t,
+	      const unsigned char *from_obj, const unsigned char *to_obj,
+	      int force, combine_notes_fn combine_fn)
+{
+	const unsigned char *note = get_note(t, from_obj);
+	const unsigned char *existing_note = get_note(t, to_obj);
+
+	if (!force && existing_note)
+		return 1;
+
+	if (note)
+		add_note(t, to_obj, note, combine_fn);
+	else if (existing_note)
+		add_note(t, to_obj, null_sha1, combine_fn);
+
+	return 0;
+}
diff --git a/notes.h b/notes.h
index 69e995d..6166927 100644
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
index f6cdb33..29ef0c6 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -777,4 +777,38 @@ test_expect_success 'cannot copy note from object without notes' '
 	test_must_fail git notes copy HEAD^ HEAD
 '
 
+cat > expect << EOF
+commit e5d4fb5698d564ab8c73551538ecaf2b0c666185
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:25:13 2005 -0700
+
+    13th
+
+Notes (other):
+    yet another note
+$whitespace
+    yet another note
+
+commit 7038787dfe22a14c3867ce816dbba39845359719
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:24:13 2005 -0700
+
+    12th
+
+Notes (other):
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
+	test_cmp expect output &&
+	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
+	test "$(git notes list HEAD^)" = "$(git notes list HEAD~3)"
+'
+
 test_done
-- 
1.7.0.2.417.gbc354
