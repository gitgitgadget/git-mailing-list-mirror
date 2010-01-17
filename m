From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 12/20] Builtin-ify git-notes
Date: Sun, 17 Jan 2010 22:04:29 +0100
Message-ID: <1263762277-31419-13-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:06:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcKP-0007dl-6B
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab0AQVGJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jan 2010 16:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628Ab0AQVGA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:06:00 -0500
Received: from smtp.getmail.no ([84.208.15.66]:56386 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754779Ab0AQVFS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:18 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002KET8TY850@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:17 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:17 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137334>

The builtin-ification includes some minor behavioural changes to the
command-line interface: It is no longer allowed to mix the -m and -F
arguments, and it is not allowed to use multiple -F options.

As part of the builtin-ification, we add the commit_notes() function
to the builtin API. This function (together with the notes.h API) can
be easily used from other builtins to manipulate the notes tree.

Also includes needed changes to t3301.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt                   |    6 +-
 Makefile                                      |    2 +-
 builtin-notes.c                               |  240 +++++++++++++++++=
++++++++
 builtin.h                                     |    3 +
 git-notes.sh =3D> contrib/examples/git-notes.sh |    0
 git.c                                         |    1 +
 t/t3301-notes.sh                              |   84 ++++++---
 7 files changed, 306 insertions(+), 30 deletions(-)
 create mode 100644 builtin-notes.c
 rename git-notes.sh =3D> contrib/examples/git-notes.sh (100%)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 94cceb1..bb73b02 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -37,14 +37,12 @@ OPTIONS
 -------
 -m <msg>::
 	Use the given note message (instead of prompting).
-	If multiple `-m` (or `-F`) options are given, their
-	values are concatenated as separate paragraphs.
+	If multiple `-m` options are given, their values
+	are concatenated as separate paragraphs.
=20
 -F <file>::
 	Take the note message from the given file.  Use '-' to
 	read the note message from the standard input.
-	If multiple `-F` (or `-m`) options are given, their
-	values are concatenated as separate paragraphs.
=20
=20
 Author
diff --git a/Makefile b/Makefile
index 4a1e5bc..b3f0c0c 100644
--- a/Makefile
+++ b/Makefile
@@ -354,7 +354,6 @@ SCRIPT_SH +=3D git-merge-one-file.sh
 SCRIPT_SH +=3D git-merge-resolve.sh
 SCRIPT_SH +=3D git-mergetool.sh
 SCRIPT_SH +=3D git-mergetool--lib.sh
-SCRIPT_SH +=3D git-notes.sh
 SCRIPT_SH +=3D git-parse-remote.sh
 SCRIPT_SH +=3D git-pull.sh
 SCRIPT_SH +=3D git-quiltimport.sh
@@ -658,6 +657,7 @@ BUILTIN_OBJS +=3D builtin-merge-recursive.o
 BUILTIN_OBJS +=3D builtin-mktree.o
 BUILTIN_OBJS +=3D builtin-mv.o
 BUILTIN_OBJS +=3D builtin-name-rev.o
+BUILTIN_OBJS +=3D builtin-notes.o
 BUILTIN_OBJS +=3D builtin-pack-objects.o
 BUILTIN_OBJS +=3D builtin-pack-refs.o
 BUILTIN_OBJS +=3D builtin-prune-packed.o
diff --git a/builtin-notes.c b/builtin-notes.c
new file mode 100644
index 0000000..a534ece
--- /dev/null
+++ b/builtin-notes.c
@@ -0,0 +1,240 @@
+/*
+ * Builtin "git notes"
+ *
+ * Copyright (c) 2010 Johan Herland <johan@herland.net>
+ *
+ * Based on git-notes.sh by Johannes Schindelin,
+ * and builtin-tag.c by Kristian H=C3=B8gsberg and Carlos Rica.
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "notes.h"
+#include "blob.h"
+#include "commit.h"
+#include "refs.h"
+#include "exec_cmd.h"
+#include "parse-options.h"
+
+static const char * const git_notes_usage[] =3D {
+	"git notes edit [-m <msg>|-F <file>] [<object>]",
+	"git notes show [<object>]",
+	NULL
+};
+
+static const char note_template[] =3D
+	"\n"
+	"#\n"
+	"# Write/edit the note contents\n"
+	"#\n";
+
+static void write_note_data(int fd, const unsigned char *sha1)
+{
+	unsigned long size;
+	enum object_type type;
+	char *buf =3D read_sha1_file(sha1, &type, &size);
+	if (buf) {
+		if (size)
+			write_or_die(fd, buf, size);
+		free(buf);
+	}
+}
+
+static void create_note(const unsigned char *object,
+			struct strbuf *buf,
+			int skip_editor,
+			const unsigned char *prev,
+			unsigned char *result)
+{
+	char *path =3D NULL;
+
+	if (!skip_editor) {
+		int fd;
+
+		/* write the template message before editing: */
+		path =3D git_pathdup("NOTES_EDITMSG");
+		fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		if (fd < 0)
+			die_errno("could not create file '%s'", path);
+
+		if (prev)
+			write_note_data(fd, prev);
+		write_or_die(fd, note_template, strlen(note_template));
+
+		close(fd);
+
+		if (launch_editor(path, buf, NULL)) {
+			fprintf(stderr, "Please supply the note contents using"
+				" either -m or -F option.\n");
+			exit(1);
+		}
+	}
+
+	stripspace(buf, 1);
+
+	if (!skip_editor && !buf->len) {
+		fprintf(stderr, "Removing note for object %s\n",
+			sha1_to_hex(object));
+		hashclr(result);
+	}
+	else {
+		if (write_sha1_file(buf->buf, buf->len, blob_type, result)) {
+			error("unable to write note object");
+			if (path)
+				error("The note contents has been left in %s",
+				      path);
+			exit(128);
+		}
+	}
+
+	if (path) {
+		unlink_or_warn(path);
+		free(path);
+	}
+}
+
+struct msg_arg {
+	int given;
+	struct strbuf buf;
+};
+
+static int parse_msg_arg(const struct option *opt, const char *arg, in=
t unset)
+{
+	struct msg_arg *msg =3D opt->value;
+
+	if (!arg)
+		return -1;
+	if (msg->buf.len)
+		strbuf_addstr(&(msg->buf), "\n\n");
+	strbuf_addstr(&(msg->buf), arg);
+	msg->given =3D 1;
+	return 0;
+}
+
+int commit_notes(struct notes_tree *t, const char *msg)
+{
+	struct commit_list *parent;
+	unsigned char tree_sha1[20], prev_commit[20], new_commit[20];
+	struct strbuf buf =3D STRBUF_INIT;
+
+	if (!t)
+		t =3D &default_notes_tree;
+	if (!t->initialized || !t->ref || !*t->ref)
+		die("Cannot commit uninitialized/unreferenced notes tree");
+
+	/* Prepare commit message and reflog message */
+	strbuf_addstr(&buf, "notes: "); /* commit message starts at index 7 *=
/
+	strbuf_addstr(&buf, msg);
+	if (buf.buf[buf.len - 1] !=3D '\n')
+		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */
+
+	/* Convert notes tree to tree object */
+	if (write_notes_tree(t, tree_sha1))
+		die("Failed to write current notes tree to database");
+
+	/* Create new commit for the tree object */
+	if (!read_ref(t->ref, prev_commit)) { /* retrieve parent commit */
+		parent =3D xmalloc(sizeof(*parent));
+		parent->item =3D lookup_commit(prev_commit);
+		parent->next =3DNULL;
+	} else {
+		hashclr(prev_commit);
+		parent =3D NULL;
+	}
+	if (commit_tree(buf.buf + 7, tree_sha1, parent, new_commit, NULL))
+		die("Failed to commit notes tree to database");
+
+	/* Update notes ref with new commit */
+	update_ref(buf.buf, t->ref, new_commit, prev_commit, 0, DIE_ON_ERR);
+
+	strbuf_release(&buf);
+	return 0;
+}
+
+int cmd_notes(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	struct notes_tree *t;
+	unsigned char object[20], new_note[20];
+	const unsigned char *note;
+	const char *object_ref;
+	int edit =3D 0, show =3D 0;
+	const char *msgfile =3D NULL;
+	struct msg_arg msg =3D { 0, STRBUF_INIT };
+	struct option options[] =3D {
+		OPT_GROUP("Notes edit options"),
+		OPT_CALLBACK('m', NULL, &msg, "msg",
+			     "note contents as a string", parse_msg_arg),
+		OPT_FILENAME('F', NULL, &msgfile, "note contents in a file"),
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	argc =3D parse_options(argc, argv, prefix, options, git_notes_usage, =
0);
+
+	if (argc && !strcmp(argv[0], "edit"))
+		edit =3D 1;
+	else if (argc && !strcmp(argv[0], "show"))
+		show =3D 1;
+
+	if (edit + show !=3D 1)
+		usage_with_options(git_notes_usage, options);
+
+	object_ref =3D argc =3D=3D 2 ? argv[1] : "HEAD";
+	if (argc > 2) {
+		error("too many parameters");
+		usage_with_options(git_notes_usage, options);
+	}
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+
+	init_notes(NULL, NULL, NULL, 0);
+	t =3D &default_notes_tree;
+
+	if (prefixcmp(t->ref, "refs/notes/"))
+		die("Refusing to %s notes in %s (outside of refs/notes/)",
+		    edit ? "edit" : "show", t->ref);
+
+	note =3D get_note(t, object);
+
+	/* show command */
+
+	if (show && !note) {
+		error("No note found for object %s.", sha1_to_hex(object));
+		return 1;
+	} else if (show) {
+		const char *show_args[3] =3D {"show", sha1_to_hex(note), NULL};
+		return execv_git_cmd(show_args);
+	}
+
+	/* edit command */
+
+	if (msg.given || msgfile) {
+		if (msg.given && msgfile) {
+			error("mixing -m and -F options is not allowed.");
+			usage_with_options(git_notes_usage, options);
+		}
+		if (msg.given)
+			strbuf_addbuf(&buf, &(msg.buf));
+		else {
+			if (!strcmp(msgfile, "-")) {
+				if (strbuf_read(&buf, 0, 1024) < 0)
+					die_errno("cannot read '%s'", msgfile);
+			} else {
+				if (strbuf_read_file(&buf, msgfile, 1024) < 0)
+					die_errno("could not open or read '%s'",
+						msgfile);
+			}
+		}
+	}
+
+	create_note(object, &buf, msg.given || msgfile, note, new_note);
+	add_note(t, object, new_note, combine_notes_overwrite);
+	commit_notes(t, "Note added by 'git notes edit'");
+
+	free_notes(t);
+	strbuf_release(&buf);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index c3f83c0..67e30a2 100644
--- a/builtin.h
+++ b/builtin.h
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 #include "cache.h"
 #include "commit.h"
+#include "notes.h"
=20
 extern const char git_version_string[];
 extern const char git_usage_string[];
@@ -18,6 +19,7 @@ extern int fmt_merge_msg(int merge_summary, struct st=
rbuf *in,
 extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
+extern int commit_notes(struct notes_tree *t, const char *msg);
 extern int check_pager_config(const char *cmd);
=20
 extern int cmd_add(int argc, const char **argv, const char *prefix);
@@ -73,6 +75,7 @@ extern int cmd_merge_recursive(int argc, const char *=
*argv, const char *prefix);
 extern int cmd_mktree(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefi=
x);
+extern int cmd_notes(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *p=
refix);
 extern int cmd_pickaxe(int argc, const char **argv, const char *prefix=
);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
diff --git a/git-notes.sh b/contrib/examples/git-notes.sh
similarity index 100%
rename from git-notes.sh
rename to contrib/examples/git-notes.sh
diff --git a/git.c b/git.c
index 11544cd..b4b118e 100644
--- a/git.c
+++ b/git.c
@@ -336,6 +336,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "mktree", cmd_mktree, RUN_SETUP },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
+		{ "notes", cmd_notes, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 		{ "peek-remote", cmd_ls_remote },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 3985d2a..c6031b1 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -12,8 +12,8 @@ echo "$MSG" > "$1"
 echo "$MSG" >& 2
 EOF
 chmod a+x fake_editor.sh
-VISUAL=3D./fake_editor.sh
-export VISUAL
+GIT_EDITOR=3D./fake_editor.sh
+export GIT_EDITOR
=20
 test_expect_success 'cannot annotate non-existing HEAD' '
 	(MSG=3D3 && export MSG && test_must_fail git notes edit)
@@ -56,8 +56,17 @@ test_expect_success 'handle empty notes gracefully' =
'
=20
 test_expect_success 'create notes' '
 	git config core.notesRef refs/notes/commits &&
+	MSG=3Db0 git notes edit &&
+	test ! -f .git/NOTES_EDITMSG &&
+	test 1 =3D $(git ls-tree refs/notes/commits | wc -l) &&
+	test b0 =3D $(git notes show) &&
+	git show HEAD^ &&
+	test_must_fail git notes show HEAD^
+'
+
+test_expect_success 'edit existing notes' '
 	MSG=3Db1 git notes edit &&
-	test ! -f .git/new-notes &&
+	test ! -f .git/NOTES_EDITMSG &&
 	test 1 =3D $(git ls-tree refs/notes/commits | wc -l) &&
 	test b1 =3D $(git notes show) &&
 	git show HEAD^ &&
@@ -110,19 +119,16 @@ test_expect_success 'show multi-line notes' '
 	git log -2 > output &&
 	test_cmp expect-multiline output
 '
-test_expect_success 'create -m and -F notes (setup)' '
+test_expect_success 'create -F notes (setup)' '
 	: > a4 &&
 	git add a4 &&
 	test_tick &&
 	git commit -m 4th &&
 	echo "xyzzy" > note5 &&
-	git notes edit -m spam -F note5 -m "foo
-bar
-baz"
+	git notes edit -F note5
 '
=20
-whitespace=3D"    "
-cat > expect-m-and-F << EOF
+cat > expect-F << EOF
 commit 15023535574ded8b1a89052b32673f84cf9582b8
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:16:13 2005 -0700
@@ -130,32 +136,29 @@ Date:   Thu Apr 7 15:16:13 2005 -0700
     4th
=20
 Notes:
-    spam
-$whitespace
     xyzzy
-$whitespace
-    foo
-    bar
-    baz
 EOF
=20
-printf "\n" >> expect-m-and-F
-cat expect-multiline >> expect-m-and-F
+printf "\n" >> expect-F
+cat expect-multiline >> expect-F
=20
-test_expect_success 'show -m and -F notes' '
+test_expect_success 'show -F notes' '
 	git log -3 > output &&
-	test_cmp expect-m-and-F output
+	test_cmp expect-F output
 '
=20
-test_expect_success 'create other note on a different notes ref (setup=
)' '
+test_expect_success 'create -m notes (setup)' '
 	: > a5 &&
 	git add a5 &&
 	test_tick &&
 	git commit -m 5th &&
-	GIT_NOTES_REF=3D"refs/notes/other" git notes edit -m "other note"
+	git notes edit -m spam -m "foo
+bar
+baz"
 '
=20
-cat > expect-other << EOF
+whitespace=3D"    "
+cat > expect-m << EOF
 commit bd1753200303d0a0344be813e504253b3d98e74d
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:17:13 2005 -0700
@@ -163,15 +166,46 @@ Date:   Thu Apr 7 15:17:13 2005 -0700
     5th
=20
 Notes:
+    spam
+$whitespace
+    foo
+    bar
+    baz
+EOF
+
+printf "\n" >> expect-m
+cat expect-F >> expect-m
+
+test_expect_success 'show -m notes' '
+	git log -4 > output &&
+	test_cmp expect-m output
+'
+
+test_expect_success 'create other note on a different notes ref (setup=
)' '
+	: > a6 &&
+	git add a6 &&
+	test_tick &&
+	git commit -m 6th &&
+	GIT_NOTES_REF=3D"refs/notes/other" git notes edit -m "other note"
+'
+
+cat > expect-other << EOF
+commit 387a89921c73d7ed72cd94d179c1c7048ca47756
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:18:13 2005 -0700
+
+    6th
+
+Notes:
     other note
 EOF
=20
 cat > expect-not-other << EOF
-commit bd1753200303d0a0344be813e504253b3d98e74d
+commit 387a89921c73d7ed72cd94d179c1c7048ca47756
 Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:17:13 2005 -0700
+Date:   Thu Apr 7 15:18:13 2005 -0700
=20
-    5th
+    6th
 EOF
=20
 test_expect_success 'Do not show note on other ref by default' '
--=20
1.6.6.rc1.321.g0496e
