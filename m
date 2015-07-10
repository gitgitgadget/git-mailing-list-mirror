From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v4] notes: Allow treeish expressions as notes ref
Date: Fri, 10 Jul 2015 10:28:31 +0900
Message-ID: <1436491711-19056-1-git-send-email-mh@glandium.org>
References: <CALKQrgd_eB2ZUwUz54vW9OFOuZshvGGe9dx+suvd0=WA0OmOFQ@mail.gmail.com>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 03:28:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDN7M-0007Le-BK
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 03:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbbGJB2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 21:28:41 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:58814 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748AbbGJB2j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 21:28:39 -0400
Received: from glandium by zenigata with local (Exim 4.86_RC4)
	(envelope-from <glandium@glandium.org>)
	id 1ZDN79-0004y6-PR; Fri, 10 Jul 2015 10:28:31 +0900
X-Mailer: git-send-email 2.4.3.3.g2dde64c.dirty
In-Reply-To: <CALKQrgd_eB2ZUwUz54vW9OFOuZshvGGe9dx+suvd0=WA0OmOFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273796>

init_notes() is the main point of entry to the notes API. It is an arbitrary
restriction that all it allows as input is a strict ref name, when callers
may want to give an arbitrary treeish.

However, some operations that require updating the notes tree require a
strict ref name, because they wouldn't be able to update e.g. foo@{1}.

So we allow treeish expressions to be used in the case the notes tree is
going to be used without write "permissions", and to distinguish whether
the notes tree is intended to be used for reads only, or will be updated,
a flag is added.

This has the side effect of enabling the use of treeish as notes refs in
commands allowing them, e.g. git log --notes=foo@{1}.

Signed-off-by: Mike Hommey <mh@glandium.org>
Reviewed-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c | 29 ++++++++++++++++-------------
 notes-cache.c   | 11 ++++++-----
 notes-utils.c   |  6 +++---
 notes.c         | 11 +++++++----
 notes.h         | 10 +++++++++-
 5 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 63f95fc..0fc6e7a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -285,7 +285,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 		if (!c)
 			return 0;
 	} else {
-		init_notes(NULL, NULL, NULL, 0);
+		init_notes(NULL, NULL, NULL, NOTES_INIT_WRITABLE);
 		t = &default_notes_tree;
 	}
 
@@ -328,15 +328,18 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 	return ret;
 }
 
-static struct notes_tree *init_notes_check(const char *subcommand)
+static struct notes_tree *init_notes_check(const char *subcommand,
+					   int flags)
 {
 	struct notes_tree *t;
-	init_notes(NULL, NULL, NULL, 0);
+	const char *ref;
+	init_notes(NULL, NULL, NULL, flags);
 	t = &default_notes_tree;
 
-	if (!starts_with(t->ref, "refs/notes/"))
+	ref = (flags & NOTES_INIT_WRITABLE) ? t->update_ref : t->ref;
+	if (!starts_with(ref, "refs/notes/"))
 		die("Refusing to %s notes in %s (outside of refs/notes/)",
-		    subcommand, t->ref);
+		    subcommand, ref);
 	return t;
 }
 
@@ -359,7 +362,7 @@ static int list(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_list_usage, options);
 	}
 
-	t = init_notes_check("list");
+	t = init_notes_check("list", 0);
 	if (argc) {
 		if (get_sha1(argv[0], object))
 			die(_("Failed to resolve '%s' as a valid ref."), argv[0]);
@@ -419,7 +422,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	t = init_notes_check("add");
+	t = init_notes_check("add", NOTES_INIT_WRITABLE);
 	note = get_note(t, object);
 
 	if (note) {
@@ -510,7 +513,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	t = init_notes_check("copy");
+	t = init_notes_check("copy", NOTES_INIT_WRITABLE);
 	note = get_note(t, object);
 
 	if (note) {
@@ -588,7 +591,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	t = init_notes_check(argv[0]);
+	t = init_notes_check(argv[0], NOTES_INIT_WRITABLE);
 	note = get_note(t, object);
 
 	prepare_note_data(object, &d, edit ? note : NULL);
@@ -651,7 +654,7 @@ static int show(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	t = init_notes_check("show");
+	t = init_notes_check("show", 0);
 	note = get_note(t, object);
 
 	if (!note)
@@ -812,7 +815,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	t = init_notes_check("merge");
+	t = init_notes_check("merge", NOTES_INIT_WRITABLE);
 
 	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
 		    remote_ref.buf, default_notes_ref());
@@ -878,7 +881,7 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_notes_remove_usage, 0);
 
-	t = init_notes_check("remove");
+	t = init_notes_check("remove", NOTES_INIT_WRITABLE);
 
 	if (!argc && !from_stdin) {
 		retval = remove_one_note(t, "HEAD", flag);
@@ -920,7 +923,7 @@ static int prune(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_prune_usage, options);
 	}
 
-	t = init_notes_check("prune");
+	t = init_notes_check("prune", NOTES_INIT_WRITABLE);
 
 	prune_notes(t, (verbose ? NOTES_PRUNE_VERBOSE : 0) |
 		(show_only ? NOTES_PRUNE_VERBOSE|NOTES_PRUNE_DRYRUN : 0) );
diff --git a/notes-cache.c b/notes-cache.c
index c4e9bb7..5dfc5cb 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -32,14 +32,14 @@ void notes_cache_init(struct notes_cache *c, const char *name,
 		     const char *validity)
 {
 	struct strbuf ref = STRBUF_INIT;
-	int flags = 0;
+	int flags = NOTES_INIT_WRITABLE;
 
 	memset(c, 0, sizeof(*c));
 	c->validity = xstrdup(validity);
 
 	strbuf_addf(&ref, "refs/notes/%s", name);
 	if (!notes_cache_match_validity(ref.buf, validity))
-		flags = NOTES_INIT_EMPTY;
+		flags |= NOTES_INIT_EMPTY;
 	init_notes(&c->tree, ref.buf, combine_notes_overwrite, flags);
 	strbuf_release(&ref);
 }
@@ -49,7 +49,8 @@ int notes_cache_write(struct notes_cache *c)
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
 
-	if (!c || !c->tree.initialized || !c->tree.ref || !*c->tree.ref)
+	if (!c || !c->tree.initialized || !c->tree.update_ref ||
+	    !*c->tree.update_ref)
 		return -1;
 	if (!c->tree.dirty)
 		return 0;
@@ -59,8 +60,8 @@ int notes_cache_write(struct notes_cache *c)
 	if (commit_tree(c->validity, strlen(c->validity), tree_sha1, NULL,
 			commit_sha1, NULL, NULL) < 0)
 		return -1;
-	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
-		       0, UPDATE_REFS_QUIET_ON_ERR) < 0)
+	if (update_ref("update notes cache", c->tree.update_ref, commit_sha1,
+		       NULL, 0, UPDATE_REFS_QUIET_ON_ERR) < 0)
 		return -1;
 
 	return 0;
diff --git a/notes-utils.c b/notes-utils.c
index ccbf073..f65edba 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -37,7 +37,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 
 	if (!t)
 		t = &default_notes_tree;
-	if (!t->initialized || !t->ref || !*t->ref)
+	if (!t->initialized || !t->update_ref || !*t->update_ref)
 		die(_("Cannot commit uninitialized/unreferenced notes tree"));
 	if (!t->dirty)
 		return; /* don't have to commit an unchanged tree */
@@ -48,7 +48,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 
 	create_notes_commit(t, NULL, buf.buf, buf.len, commit_sha1);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
-	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0,
+	update_ref(buf.buf, t->update_ref, commit_sha1, NULL, 0,
 		   UPDATE_REFS_DIE_ON_ERR);
 
 	strbuf_release(&buf);
@@ -130,7 +130,7 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 		free(c);
 		return NULL;
 	}
-	c->trees = load_notes_trees(c->refs);
+	c->trees = load_notes_trees(c->refs, NOTES_INIT_WRITABLE);
 	string_list_clear(c->refs, 0);
 	free(c->refs);
 	return c;
diff --git a/notes.c b/notes.c
index df08209..dc95ebb 100644
--- a/notes.c
+++ b/notes.c
@@ -1007,13 +1007,16 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->first_non_note = NULL;
 	t->prev_non_note = NULL;
 	t->ref = xstrdup_or_null(notes_ref);
+	t->update_ref = (flags & NOTES_INIT_WRITABLE) ? t->ref : NULL;
 	t->combine_notes = combine_notes;
 	t->initialized = 1;
 	t->dirty = 0;
 
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
-	    read_ref(notes_ref, object_sha1))
+	    get_sha1_treeish(notes_ref, object_sha1))
 		return;
+	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, object_sha1))
+		die("Cannot use notes ref %s", notes_ref);
 	if (get_tree_entry(object_sha1, "", sha1, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
 		    notes_ref, sha1_to_hex(object_sha1));
@@ -1023,7 +1026,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	load_subtree(t, &root_tree, t->root, 0);
 }
 
-struct notes_tree **load_notes_trees(struct string_list *refs)
+struct notes_tree **load_notes_trees(struct string_list *refs, int flags)
 {
 	struct string_list_item *item;
 	int counter = 0;
@@ -1031,7 +1034,7 @@ struct notes_tree **load_notes_trees(struct string_list *refs)
 	trees = xmalloc((refs->nr+1) * sizeof(struct notes_tree *));
 	for_each_string_list_item(item, refs) {
 		struct notes_tree *t = xcalloc(1, sizeof(struct notes_tree));
-		init_notes(t, item->string, combine_notes_ignore, 0);
+		init_notes(t, item->string, combine_notes_ignore, flags);
 		trees[counter++] = t;
 	}
 	trees[counter] = NULL;
@@ -1067,7 +1070,7 @@ void init_display_notes(struct display_notes_opt *opt)
 						     item->string);
 	}
 
-	display_notes_trees = load_notes_trees(&display_notes_refs);
+	display_notes_trees = load_notes_trees(&display_notes_refs, 0);
 	string_list_clear(&display_notes_refs, 0);
 }
 
diff --git a/notes.h b/notes.h
index 2a3f923..e5d67fd 100644
--- a/notes.h
+++ b/notes.h
@@ -44,6 +44,7 @@ extern struct notes_tree {
 	struct int_node *root;
 	struct non_note *first_non_note, *prev_non_note;
 	char *ref;
+	char *update_ref;
 	combine_notes_fn combine_notes;
 	int initialized;
 	int dirty;
@@ -72,6 +73,13 @@ const char *default_notes_ref(void);
 #define NOTES_INIT_EMPTY 1
 
 /*
+ * By default, the notes tree is only readable, and the notes ref can be
+ * any treeish. The notes tree can however be made writable with this flag,
+ * in which case only strict ref names can be used.
+ */
+#define NOTES_INIT_WRITABLE 2
+
+/*
  * Initialize the given notes_tree with the notes tree structure at the given
  * ref. If given ref is NULL, the value of the $GIT_NOTES_REF environment
  * variable is used, and if that is missing, the default notes ref is used
@@ -276,7 +284,7 @@ void format_display_notes(const unsigned char *object_sha1,
  * Load the notes tree from each ref listed in 'refs'.  The output is
  * an array of notes_tree*, terminated by a NULL.
  */
-struct notes_tree **load_notes_trees(struct string_list *refs);
+struct notes_tree **load_notes_trees(struct string_list *refs, int flags);
 
 /*
  * Add all refs that match 'glob' to the 'list'.
-- 
2.4.3.3.g2dde64c
