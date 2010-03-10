From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6 02/13] Support showing notes from more than one notes tree
Date: Wed, 10 Mar 2010 15:03:39 +0100
Message-ID: <e69a916ca6afb53fb665951d499d7e6543007008.1268229087.git.trast@student.ethz.ch>
References: <cover.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 15:04:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpMWk-0003ux-Aw
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 15:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351Ab0CJOEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 09:04:22 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7878 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345Ab0CJOET (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 09:04:19 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:04:12 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:03:51 +0100
X-Mailer: git-send-email 1.7.0.2.407.g21ebda
In-Reply-To: <cover.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141892>

With this patch, you can set notes.displayRef to a glob that points at
your favourite notes refs, e.g.,

[notes]
	displayRef = refs/notes/*

Then git-log and friends will show notes from all trees.

Thanks to Junio C Hamano for lots of feedback, which greatly
influenced the design of the entire series and this commit in
particular.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Changes since v5
* make display_notes_{refs,trees} static
* foo() -> foo(void)
* assert() that init_display_notes() is only called once
* add invocation comments to the new functions in notes.h
* bring git-notes(1) up to date wrt. notes display

 Documentation/config.txt         |   23 +++++-
 Documentation/git-notes.txt      |   11 ++-
 Documentation/pretty-options.txt |   11 ++-
 builtin/log.c                    |    2 +
 cache.h                          |    1 +
 notes.c                          |  173 ++++++++++++++++++++++++++++++++++++--
 notes.h                          |   57 +++++++++++++
 pretty.c                         |    6 +-
 refs.c                           |    4 +-
 refs.h                           |    5 +
 revision.c                       |   21 +++++
 revision.h                       |    5 +
 t/t3301-notes.sh                 |  148 ++++++++++++++++++++++++++++++--
 t/test-lib.sh                    |    1 +
 14 files changed, 439 insertions(+), 29 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d9ee519..0d0aa9c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -519,10 +519,12 @@ check that makes sure that existing object files will not get overwritten.
 core.notesRef::
 	When showing commit messages, also show notes which are stored in
 	the given ref.  This ref is expected to contain files named
-	after the full SHA-1 of the commit they annotate.
+	after the full SHA-1 of the commit they annotate.  The ref
+	must be fully qualified.
 +
 If such a file exists in the given ref, the referenced blob is read, and
-appended to the commit message, separated by a "Notes:" line.  If the
+appended to the commit message, separated by a "Notes (<refname>):"
+line (shortened to "Notes:" in the case of "refs/notes/commits").  If the
 given ref itself does not exist, it is not an error, but means that no
 notes should be printed.
 +
@@ -1341,6 +1343,23 @@ mergetool.keepTemporaries::
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
 
+notes.displayRef::
+	The (fully qualified) refname from which to show notes when
+	showing commit messages.  The value of this variable can be set
+	to a glob, in which case notes from all matching refs will be
+	shown.  You may also specify this configuration variable
+	several times.  A warning will be issued for refs that do not
+	exist, but a glob that does not match any refs is silently
+	ignored.
++
+This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
+environment variable, which must be a colon separated list of refs or
+globs.
++
+The effective value of "core.notesRef" (possibly overridden by
+GIT_NOTES_REF) is also implicitly added to the list of refs to be
+displayed.
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index bef2f39..95b4bca 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -27,12 +27,13 @@ A typical use of notes is to extend a commit message without having
 to change the commit itself. Such commit notes can be shown by `git log`
 along with the original commit message. To discern these notes from the
 message stored in the commit object, the notes are indented like the
-message, after an unindented line saying "Notes:".
+message, after an unindented line saying "Notes (<refname>):" (or
+"Notes:" for the default setting).
 
-To disable notes, you have to set the config variable core.notesRef to
-the empty string.  Alternatively, you can set it to a different ref,
-something like "refs/notes/bugzilla".  This setting can be overridden
-by the environment variable "GIT_NOTES_REF".
+This command always manipulates the notes specified in "core.notesRef"
+(see linkgit:git-config[1]), which can be overridden by GIT_NOTES_REF.
+To change which notes are shown by 'git-log', see the
+"notes.displayRef" configuration.
 
 
 SUBCOMMANDS
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index aa96cae..1d56926 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -30,9 +30,18 @@ people using 80-column terminals.
 	defaults to UTF-8.
 
 --no-notes::
---show-notes::
+--show-notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
 	for `git log`, `git show` and `git whatchanged` commands when
 	there is no `--pretty`, `--format` nor `--oneline` option is
 	given on the command line.
++
+With an optional argument, add this ref to the list of notes.  The ref
+is taken to be in `refs/notes/` if it is not qualified.
+
+--[no-]standard-notes::
+	Enable or disable populating the notes ref list from the
+	'core.notesRef' and 'notes.displayRef' variables (or
+	corresponding environment overrides).  See
+	linkgit:git-config[1].
diff --git a/builtin/log.c b/builtin/log.c
index b70d0f7..68d636f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -77,6 +77,8 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 
 	if (!rev->show_notes_given && !rev->pretty_given)
 		rev->show_notes = 1;
+	if (rev->show_notes)
+		init_display_notes(&rev->notes_opt);
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
diff --git a/cache.h b/cache.h
index ded3090..b25d180 100644
--- a/cache.h
+++ b/cache.h
@@ -387,6 +387,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
+#define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
 
 /*
  * Repository-local GIT_* environment variables
diff --git a/notes.c b/notes.c
index a4f9926..0d4b892 100644
--- a/notes.c
+++ b/notes.c
@@ -5,6 +5,8 @@
 #include "utf8.h"
 #include "strbuf.h"
 #include "tree-walk.h"
+#include "string-list.h"
+#include "refs.h"
 
 /*
  * Use a non-balancing simple 16-tree structure with struct int_node as
@@ -68,6 +70,9 @@ struct non_note {
 
 struct notes_tree default_notes_tree;
 
+static struct string_list display_notes_refs;
+static struct notes_tree **display_notes_trees;
+
 static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		struct int_node *node, unsigned int n);
 
@@ -828,6 +833,76 @@ int combine_notes_ignore(unsigned char *cur_sha1,
 	return 0;
 }
 
+static int string_list_add_one_ref(const char *path, const unsigned char *sha1,
+				   int flag, void *cb)
+{
+	struct string_list *refs = cb;
+	if (!unsorted_string_list_has_string(refs, path))
+		string_list_append(path, refs);
+	return 0;
+}
+
+void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
+{
+	if (has_glob_specials(glob)) {
+		for_each_glob_ref(string_list_add_one_ref, glob, list);
+	} else {
+		unsigned char sha1[20];
+		if (get_sha1(glob, sha1))
+			warning("notes ref %s is invalid", glob);
+		if (!unsorted_string_list_has_string(list, glob))
+			string_list_append(glob, list);
+	}
+}
+
+void string_list_add_refs_from_colon_sep(struct string_list *list,
+					 const char *globs)
+{
+	struct strbuf globbuf = STRBUF_INIT;
+	struct strbuf **split;
+	int i;
+
+	strbuf_addstr(&globbuf, globs);
+	split = strbuf_split(&globbuf, ':');
+
+	for (i = 0; split[i]; i++) {
+		if (!split[i]->len)
+			continue;
+		if (split[i]->buf[split[i]->len-1] == ':')
+			strbuf_setlen(split[i], split[i]->len-1);
+		string_list_add_refs_by_glob(list, split[i]->buf);
+	}
+
+	strbuf_list_free(split);
+	strbuf_release(&globbuf);
+}
+
+static int notes_display_config(const char *k, const char *v, void *cb)
+{
+	int *load_refs = cb;
+
+	if (*load_refs && !strcmp(k, "notes.displayref")) {
+		if (!v)
+			config_error_nonbool(k);
+		string_list_add_refs_by_glob(&display_notes_refs, v);
+		return 0;
+	}
+
+	return 0;
+}
+
+static const char *default_notes_ref(void)
+{
+	const char *notes_ref = NULL;
+	if (!notes_ref)
+		notes_ref = getenv(GIT_NOTES_REF_ENVIRONMENT);
+	if (!notes_ref)
+		notes_ref = notes_ref_name; /* value of core.notesRef config */
+	if (!notes_ref)
+		notes_ref = GIT_NOTES_DEFAULT_REF;
+	return notes_ref;
+}
+
 void init_notes(struct notes_tree *t, const char *notes_ref,
 		combine_notes_fn combine_notes, int flags)
 {
@@ -840,11 +915,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	assert(!t->initialized);
 
 	if (!notes_ref)
-		notes_ref = getenv(GIT_NOTES_REF_ENVIRONMENT);
-	if (!notes_ref)
-		notes_ref = notes_ref_name; /* value of core.notesRef config */
-	if (!notes_ref)
-		notes_ref = GIT_NOTES_DEFAULT_REF;
+		notes_ref = default_notes_ref();
 
 	if (!combine_notes)
 		combine_notes = combine_notes_concatenate;
@@ -868,6 +939,73 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	load_subtree(t, &root_tree, t->root, 0);
 }
 
+struct load_notes_cb_data
+{
+	int counter;
+	struct notes_tree **trees;
+};
+
+static int load_one_display_note_ref(struct string_list_item *item,
+				     void *cb_data)
+{
+	struct load_notes_cb_data *c = cb_data;
+	struct notes_tree *t = xcalloc(1, sizeof(struct notes_tree));
+	init_notes(t, item->string, combine_notes_ignore, 0);
+	c->trees[c->counter++] = t;
+	return 0;
+}
+
+struct notes_tree **load_notes_trees(struct string_list *refs)
+{
+	struct notes_tree **trees;
+	struct load_notes_cb_data cb_data;
+	trees = xmalloc((refs->nr+1) * sizeof(struct notes_tree *));
+	cb_data.counter = 0;
+	cb_data.trees = trees;
+	for_each_string_list(load_one_display_note_ref, refs, &cb_data);
+	trees[cb_data.counter] = NULL;
+	return trees;
+}
+
+static int string_list_add_refs_from_list(struct string_list_item *item,
+					  void *cb)
+{
+	struct string_list *list = cb;
+	string_list_add_refs_by_glob(list, item->string);
+	return 0;
+}
+
+void init_display_notes(struct display_notes_opt *opt)
+{
+	char *display_ref_env;
+	int load_config_refs = 0;
+	display_notes_refs.strdup_strings = 1;
+
+	assert(!display_notes_trees);
+
+	if (!opt || !opt->suppress_default_notes) {
+		string_list_append(default_notes_ref(), &display_notes_refs);
+		display_ref_env = getenv(GIT_NOTES_DISPLAY_REF_ENVIRONMENT);
+		if (display_ref_env) {
+			string_list_add_refs_from_colon_sep(&display_notes_refs,
+							    display_ref_env);
+			load_config_refs = 0;
+		} else {
+			load_config_refs = 1;
+		}
+	}
+
+	git_config(notes_display_config, &load_config_refs);
+
+	if (opt && opt->extra_notes_refs)
+		for_each_string_list(string_list_add_refs_from_list,
+				     opt->extra_notes_refs,
+				     &display_notes_refs);
+
+	display_notes_trees = load_notes_trees(&display_notes_refs);
+	string_list_clear(&display_notes_refs, 0);
+}
+
 void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 		const unsigned char *note_sha1, combine_notes_fn combine_notes)
 {
@@ -1016,8 +1154,18 @@ void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (msglen && msg[msglen - 1] == '\n')
 		msglen--;
 
-	if (flags & NOTES_SHOW_HEADER)
-		strbuf_addstr(sb, "\nNotes:\n");
+	if (flags & NOTES_SHOW_HEADER) {
+		const char *ref = t->ref;
+		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
+			strbuf_addstr(sb, "\nNotes:\n");
+		} else {
+			if (!prefixcmp(ref, "refs/"))
+				ref += 5;
+			if (!prefixcmp(ref, "notes/"))
+				ref += 6;
+			strbuf_addf(sb, "\nNotes (%s):\n", ref);
+		}
+	}
 
 	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
 		linelen = strchrnul(msg_p, '\n') - msg_p;
@@ -1030,3 +1178,14 @@ void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 
 	free(msg);
 }
+
+void format_display_notes(const unsigned char *object_sha1,
+			  struct strbuf *sb, const char *output_encoding, int flags)
+{
+	int i;
+	if (!display_notes_trees)
+		init_display_notes(NULL);
+	for (i = 0; display_notes_trees[i]; i++)
+		format_note(display_notes_trees[i], object_sha1, sb,
+			    output_encoding, flags);
+}
diff --git a/notes.h b/notes.h
index bad03cc..db47b67 100644
--- a/notes.h
+++ b/notes.h
@@ -198,4 +198,61 @@ int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
 void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 		struct strbuf *sb, const char *output_encoding, int flags);
 
+
+struct string_list;
+
+struct display_notes_opt
+{
+	int suppress_default_notes : 1;
+	struct string_list *extra_notes_refs;
+};
+
+/*
+ * Load the notes machinery for displaying several notes trees.
+ *
+ * If 'opt' is not NULL, then it specifies additional settings for the
+ * displaying:
+ *
+ * - suppress_default_notes indicates that the notes from
+ *   core.notesRef and notes.displayRef should not be loaded.
+ *
+ * - extra_notes_refs may contain a list of globs (in the same style
+ *   as notes.displayRef) where notes should be loaded from.
+ */
+void init_display_notes(struct display_notes_opt *opt);
+
+/*
+ * Append notes for the given 'object_sha1' from all trees set up by
+ * init_display_notes() to 'sb'.  The 'flags' are a bitwise
+ * combination of
+ *
+ * - NOTES_SHOW_HEADER: add a 'Notes (refname):' header
+ *
+ * - NOTES_INDENT: indent the notes by 4 places
+ *
+ * init_display_notes() is called implicitly for you if you haven't
+ * already.
+ */
+void format_display_notes(const unsigned char *object_sha1,
+			  struct strbuf *sb, const char *output_encoding, int flags);
+
+/*
+ * Load the notes tree from each ref listed in 'refs'.  The output is
+ * an array of notes_tree*, terminated by a NULL.
+ */
+struct notes_tree **load_notes_trees(struct string_list *refs);
+
+/*
+ * Add all refs that match 'glob' to the 'list'.
+ */
+void string_list_add_refs_by_glob(struct string_list *list, const char *glob);
+
+/*
+ * Add all refs from a colon-separated glob list 'globs' to the end of
+ * 'list'.  Empty components are ignored.  This helper is used to
+ * parse GIT_NOTES_DISPLAY_REF style environment variables.
+ */
+void string_list_add_refs_from_colon_sep(struct string_list *list,
+					 const char *globs);
+
 #endif
diff --git a/pretty.c b/pretty.c
index f999485..6ba3da8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -775,7 +775,7 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
-		format_note(NULL, commit->object.sha1, sb,
+		format_display_notes(commit->object.sha1, sb,
 			    git_log_output_encoding ? git_log_output_encoding
 						    : git_commit_encoding, 0);
 		return 1;
@@ -1096,8 +1096,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		strbuf_addch(sb, '\n');
 
 	if (context->show_notes)
-		format_note(NULL, commit->object.sha1, sb, encoding,
-			    NOTES_SHOW_HEADER | NOTES_INDENT);
+		format_display_notes(commit->object.sha1, sb, encoding,
+				     NOTES_SHOW_HEADER | NOTES_INDENT);
 
 	free(reencoded);
 }
diff --git a/refs.c b/refs.c
index f3fcbe0..5a860c4 100644
--- a/refs.c
+++ b/refs.c
@@ -695,7 +695,6 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 {
 	struct strbuf real_pattern = STRBUF_INIT;
 	struct ref_filter filter;
-	const char *has_glob_specials;
 	int ret;
 
 	if (!prefix && prefixcmp(pattern, "refs/"))
@@ -704,8 +703,7 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 		strbuf_addstr(&real_pattern, prefix);
 	strbuf_addstr(&real_pattern, pattern);
 
-	has_glob_specials = strpbrk(pattern, "?*[");
-	if (!has_glob_specials) {
+	if (!has_glob_specials(pattern)) {
 		/* Append implied '/' '*' if not present. */
 		if (real_pattern.buf[real_pattern.len - 1] != '/')
 			strbuf_addch(&real_pattern, '/');
diff --git a/refs.h b/refs.h
index f7648b9..4a18b08 100644
--- a/refs.h
+++ b/refs.h
@@ -28,6 +28,11 @@ struct ref_lock {
 extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
 extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
 
+static inline const char *has_glob_specials(const char *pattern)
+{
+	return strpbrk(pattern, "?*[");
+}
+
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
 
diff --git a/revision.c b/revision.c
index 29721ec..d6e842e 100644
--- a/revision.c
+++ b/revision.c
@@ -12,6 +12,7 @@
 #include "patch-ids.h"
 #include "decorate.h"
 #include "log-tree.h"
+#include "string-list.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1191,9 +1192,29 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--show-notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
+	} else if (!prefixcmp(arg, "--show-notes=")) {
+		struct strbuf buf = STRBUF_INIT;
+		revs->show_notes = 1;
+		revs->show_notes_given = 1;
+		if (!revs->notes_opt.extra_notes_refs)
+			revs->notes_opt.extra_notes_refs = xcalloc(1, sizeof(struct string_list));
+		if (!prefixcmp(arg+13, "refs/"))
+			/* happy */;
+		else if (!prefixcmp(arg+13, "notes/"))
+			strbuf_addstr(&buf, "refs/");
+		else
+			strbuf_addstr(&buf, "refs/notes/");
+		strbuf_addstr(&buf, arg+13);
+		string_list_append(strbuf_detach(&buf, NULL),
+				   revs->notes_opt.extra_notes_refs);
 	} else if (!strcmp(arg, "--no-notes")) {
 		revs->show_notes = 0;
 		revs->show_notes_given = 1;
+	} else if (!strcmp(arg, "--standard-notes")) {
+		revs->show_notes_given = 1;
+		revs->notes_opt.suppress_default_notes = 0;
+	} else if (!strcmp(arg, "--no-standard-notes")) {
+		revs->notes_opt.suppress_default_notes = 1;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header = 1;
 		get_commit_format("oneline", revs);
diff --git a/revision.h b/revision.h
index a14deef..580f6ec 100644
--- a/revision.h
+++ b/revision.h
@@ -3,6 +3,7 @@
 
 #include "parse-options.h"
 #include "grep.h"
+#include "notes.h"
 
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
@@ -20,6 +21,7 @@
 
 struct rev_info;
 struct log_info;
+struct string_list;
 
 struct rev_info {
 	/* Starting list */
@@ -126,6 +128,9 @@ struct rev_info {
 	struct reflog_walk_info *reflog_info;
 	struct decoration children;
 	struct decoration merge_simplification;
+
+	/* notes-specific options: which refs to show */
+	struct display_notes_opt notes_opt;
 };
 
 #define REV_TREE_SAME		0
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 37b9687..f6cdb33 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -416,7 +416,7 @@ Date:   Thu Apr 7 15:18:13 2005 -0700
 
     6th
 
-Notes:
+Notes (other):
     other note
 EOF
 
@@ -449,7 +449,139 @@ test_expect_success 'Do not show note when core.notesRef is overridden' '
 	test_cmp expect-not-other output
 '
 
+cat > expect-both << EOF
+commit 387a89921c73d7ed72cd94d179c1c7048ca47756
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:18:13 2005 -0700
+
+    6th
+
+Notes:
+    order test
+
+Notes (other):
+    other note
+
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+
+Notes:
+    replacement for deleted note
+EOF
+
+test_expect_success 'Show all notes when notes.displayRef=refs/notes/*' '
+	GIT_NOTES_REF=refs/notes/commits git notes add \
+		-m"replacement for deleted note" HEAD^ &&
+	GIT_NOTES_REF=refs/notes/commits git notes add -m"order test" &&
+	git config --unset core.notesRef &&
+	git config notes.displayRef "refs/notes/*" &&
+	git log -2 > output &&
+	test_cmp expect-both output
+'
+
+test_expect_success 'core.notesRef is implicitly in notes.displayRef' '
+	git config core.notesRef refs/notes/commits &&
+	git config notes.displayRef refs/notes/other &&
+	git log -2 > output &&
+	test_cmp expect-both output
+'
+
+test_expect_success 'notes.displayRef can be given more than once' '
+	git config --unset core.notesRef &&
+	git config notes.displayRef refs/notes/commits &&
+	git config --add notes.displayRef refs/notes/other &&
+	git log -2 > output &&
+	test_cmp expect-both output
+'
+
+cat > expect-both-reversed << EOF
+commit 387a89921c73d7ed72cd94d179c1c7048ca47756
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:18:13 2005 -0700
+
+    6th
+
+Notes (other):
+    other note
+
+Notes:
+    order test
+EOF
+
+test_expect_success 'notes.displayRef respects order' '
+	git config core.notesRef refs/notes/other &&
+	git config --unset-all notes.displayRef &&
+	git config notes.displayRef refs/notes/commits &&
+	git log -1 > output &&
+	test_cmp expect-both-reversed output
+'
+
+test_expect_success 'GIT_NOTES_DISPLAY_REF works' '
+	git config --unset-all core.notesRef &&
+	git config --unset-all notes.displayRef &&
+	GIT_NOTES_DISPLAY_REF=refs/notes/commits:refs/notes/other \
+		git log -2 > output &&
+	test_cmp expect-both output
+'
+
+cat > expect-none << EOF
+commit 387a89921c73d7ed72cd94d179c1c7048ca47756
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:18:13 2005 -0700
+
+    6th
+
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+EOF
+
+test_expect_success 'GIT_NOTES_DISPLAY_REF overrides config' '
+	git config notes.displayRef "refs/notes/*" &&
+	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log -2 > output &&
+	test_cmp expect-none output
+'
+
+test_expect_success '--show-notes=* adds to GIT_NOTES_DISPLAY_REF' '
+	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log --show-notes=* -2 > output &&
+	test_cmp expect-both output
+'
+
+cat > expect-commits << EOF
+commit 387a89921c73d7ed72cd94d179c1c7048ca47756
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:18:13 2005 -0700
+
+    6th
+
+Notes:
+    order test
+EOF
+
+test_expect_success '--no-standard-notes' '
+	git log --no-standard-notes --show-notes=commits -1 > output &&
+	test_cmp expect-commits output
+'
+
+test_expect_success '--standard-notes' '
+	git log --no-standard-notes --show-notes=commits \
+		--standard-notes -2 > output &&
+	test_cmp expect-both output
+'
+
+test_expect_success '--show-notes=ref accumulates' '
+	git log --show-notes=other --show-notes=commits \
+		 --no-standard-notes -1 > output &&
+	test_cmp expect-both-reversed output
+'
+
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
+	git config core.notesRef refs/notes/other &&
 	echo "Note on a tree" > expect
 	git notes add -m "Note on a tree" HEAD: &&
 	git notes show HEAD: > actual &&
@@ -473,7 +605,7 @@ Date:   Thu Apr 7 15:19:13 2005 -0700
 
     7th
 
-Notes:
+Notes (other):
     other note
 EOF
 
@@ -504,7 +636,7 @@ Date:   Thu Apr 7 15:21:13 2005 -0700
 
     9th
 
-Notes:
+Notes (other):
     yet another note
 EOF
 
@@ -534,7 +666,7 @@ Date:   Thu Apr 7 15:21:13 2005 -0700
 
     9th
 
-Notes:
+Notes (other):
     yet another note
 $whitespace
     yet another note
@@ -553,7 +685,7 @@ Date:   Thu Apr 7 15:22:13 2005 -0700
 
     10th
 
-Notes:
+Notes (other):
     other note
 EOF
 
@@ -570,7 +702,7 @@ Date:   Thu Apr 7 15:22:13 2005 -0700
 
     10th
 
-Notes:
+Notes (other):
     other note
 $whitespace
     yet another note
@@ -589,7 +721,7 @@ Date:   Thu Apr 7 15:23:13 2005 -0700
 
     11th
 
-Notes:
+Notes (other):
     other note
 $whitespace
     yet another note
@@ -620,7 +752,7 @@ Date:   Thu Apr 7 15:23:13 2005 -0700
 
     11th
 
-Notes:
+Notes (other):
     yet another note
 $whitespace
     yet another note
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 400bc6b..3d026b4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -55,6 +55,7 @@ unset GIT_CEILING_DIRECTORIES
 unset SHA1_FILE_DIRECTORIES
 unset SHA1_FILE_DIRECTORY
 unset GIT_NOTES_REF
+unset GIT_NOTES_DISPLAY_REF
 GIT_MERGE_VERBOSITY=5
 export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
-- 
1.7.0.2.407.g21ebda
