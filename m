From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH RFC 4/4] notes: add per-ref configuration of merge strategy
Date: Sun,  2 Aug 2015 03:10:26 -0700
Message-ID: <1438510226-1163-5-git-send-email-jacob.e.keller@intel.com>
References: <1438510226-1163-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 12:10:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLqEC-0000Ps-Kw
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 12:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbbHBKKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 06:10:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:22472 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbbHBKKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 06:10:33 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP; 02 Aug 2015 03:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,594,1432623600"; 
   d="scan'208";a="534566120"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2015 03:10:31 -0700
X-Mailer: git-send-email 2.5.0.482.gfcd5645
In-Reply-To: <1438510226-1163-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275136>

From: Jacob Keller <jacob.keller@gmail.com>

Teach git-notes about a new configuration option
"notes.<localref>.merge" which selects the merge strategy for a
particular ref. This allows selection of merge strategy different for
each note reference, in addition to the default strategy for all
references.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Cc: Johan Herland <johan@herland.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>
Cc: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/config.txt            |   7 +++
 Documentation/git-notes.txt         |   6 ++
 builtin/notes.c                     | 115 +++++++++++++++++++++++++++++++++++-
 t/t3309-notes-merge-auto-resolve.sh |  50 ++++++++++++++++
 4 files changed, 176 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0fa88a29dd65..c53ec4538cd3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1918,6 +1918,13 @@ notes.merge::
 	STRATEGIES" section of linkgit:git-notes[1] for more information
 	on each strategy.
 
+notes.<localref>.merge::
+	Which merge strategy to choose if the local ref for a notes merge
+	matches <localref>. Is overridden by notes.merge and takes the same
+	values. <localref> may be fully qualified or just under refs/notes/.
+	See "NOTES MERGE STRATEGIES" section in linkgit:git-notes[1] for more
+	information on each strategy.
+
 notes.displayRef::
 	The (fully qualified) refname from which to show notes when
 	showing commit messages.  The value of this variable can be set
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 9c4f8536182f..1e001807f9d9 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -322,6 +322,12 @@ notes.merge::
 +
 This setting can be overridden by passing the `--strategy` option.
 
+notes.<localref>.merge::
+	Which strategy to choose when merging into <localref>. Uses the same
+	values as notes.merge. <localref> may be either a fully qualified ref
+	or the shortname under "refs/notes/". See "NOTES MERGE STRATEGIES"
+	section above for more information about each strategy.
+
 notes.displayRef::
 	Which ref (or refs, if a glob or specified more than once), in
 	addition to the default set by `core.notesRef` or
diff --git a/builtin/notes.c b/builtin/notes.c
index de0caa00df1b..b0174d1024dc 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -92,6 +92,10 @@ static const char * const git_notes_get_ref_usage[] = {
 static const char note_template[] =
 	"\nWrite/edit the notes for the following object:\n";
 
+static struct note_ref **note_refs;
+static int note_refs_alloc;
+static int note_refs_nr;
+static struct hashmap note_refs_hash;
 static enum notes_merge_strategy merge_strategy;
 
 struct note_data {
@@ -757,12 +761,87 @@ static int parse_notes_strategy(const char *arg, enum notes_merge_strategy *stra
 	return 0;
 }
 
+struct note_refs_hash_key {
+	const char *str;
+	int len;
+};
+
+struct note_ref {
+	struct hashmap_entry ent; /* must be first */
+
+	const char *name;
+	enum notes_merge_strategy merge_strategy;
+};
+
+static int note_refs_hash_cmp(const struct note_ref *a, const struct note_ref *b, const struct note_refs_hash_key *key)
+{
+	if (key)
+		return strncmp(a->name, key->str, key->len) || a->name[key->len];
+	else
+		return strcmp(a->name, b->name);
+}
+
+static inline void init_note_refs_hash(void)
+{
+	if (!note_refs_hash.cmpfn)
+		hashmap_init(&note_refs_hash, (hashmap_cmp_fn)note_refs_hash_cmp, 0);
+}
+
+static struct note_ref *make_note_ref(const char *name, int len)
+{
+	struct note_ref *ret, *replaced;
+	struct note_refs_hash_key lookup;
+	struct hashmap_entry lookup_entry;
+
+	if (!len)
+		len = strlen(name);
+
+	init_note_refs_hash();
+	lookup.str = name;
+	lookup.len = len;
+	hashmap_entry_init(&lookup_entry, memhash(name, len));
+
+	if ((ret = hashmap_get(&note_refs_hash, &lookup_entry, &lookup)) != NULL)
+		return ret;
+
+	ret = xcalloc(1, sizeof(struct note_ref));
+	ALLOC_GROW(note_refs, note_refs_nr + 1, note_refs_alloc);
+	note_refs[note_refs_nr++] = ret;
+	ret->name = xstrndup(name, len);
+
+	hashmap_entry_init(ret, lookup_entry.hash);
+	replaced = hashmap_put(&note_refs_hash, ret);
+	assert(replaced == NULL);  /* no previous entry overwritten */
+	return ret;
+}
+
+static void set_strategy_for_ref(const char *ref)
+{
+	const char *name = ref;
+	struct note_refs_hash_key lookup;
+	struct hashmap_entry lookup_entry;
+	struct note_ref *note;
+
+	skip_prefix(ref, "refs/notes/", &name);
+
+	init_note_refs_hash();
+	lookup.str = name;
+	lookup.len = strlen(name);
+
+	hashmap_entry_init(&lookup_entry, memhash(name, lookup.len));
+
+	note = hashmap_get(&note_refs_hash, &lookup_entry, &lookup);
+	if (note != NULL)
+		merge_strategy = note->merge_strategy;
+}
+
 static int merge(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
 	unsigned char result_sha1[20];
 	struct notes_tree *t;
 	struct notes_merge_options o;
+	struct note_ref;
 	int do_merge = 0, do_commit = 0, do_abort = 0;
 	int verbosity = 0, result;
 	const char *strategy = NULL;
@@ -815,6 +894,8 @@ static int merge(int argc, const char **argv, const char *prefix)
 	expand_notes_ref(&remote_ref);
 	o.remote_ref = remote_ref.buf;
 
+	set_strategy_for_ref(o.local_ref);
+
 	if (strategy && parse_notes_strategy(strategy, &merge_strategy)) {
 		error("Unknown -s/--strategy: %s", strategy);
 		usage_with_options(git_notes_merge_usage, options);
@@ -957,7 +1038,16 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 
 static int git_notes_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "notes.merge")) {
+	const char *ref;
+	const char *subkey;
+	struct note_ref *note;
+
+	if (!starts_with(var, "notes."))
+		return git_default_config(var, value, cb);
+	ref = var + 6;
+
+	/* Handle notes.* variables */
+	if (!strcmp(ref, "merge")) {
 		if (!value)
 			return config_error_nonbool(var);
 		if (parse_notes_strategy(value, &merge_strategy))
@@ -966,7 +1056,28 @@ static int git_notes_config(const char *var, const char *value, void *cb)
 			return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	if (*ref == '/') {
+		warning("Config notes ref cannot begin with '/': %s", ref);
+		return 0;
+	}
+	subkey = strrchr(ref, '.');
+	if (!subkey)
+		return 0;
+
+	/* skip refs/notes prefix if provided */
+	skip_prefix(ref, "refs/notes/", &ref);
+
+	note = make_note_ref(ref, subkey - ref);
+	if (!strcmp(subkey, ".merge")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (parse_notes_strategy(value, &note->merge_strategy))
+			return error("Unknown notes merge strategy: %s", value);
+		else
+			return 0;
+	}
+
+	return 0;
 }
 
 int cmd_notes(int argc, const char **argv, const char *prefix)
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index a773b01b73db..15dd539cd141 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -383,6 +383,28 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "ours" per-ref configuration option => Non-conflicting 3-way merge' '
+	git -c notes.y.merge="ours" notes merge z &&
+	verify_notes y ours
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
+test_expect_success 'merge z into y with "ours" per-ref configuration option prefixed with "refs/notes" => Non-conflicting 3-way merge' '
+	git -c notes.refs/notes/y.merge="ours" notes merge z &&
+	verify_notes y ours
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
 cat <<EOF | sort >expect_notes_theirs
 9b4b2c61f0615412da3c10f98ff85b57c04ec765 $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
@@ -534,6 +556,34 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "union" strategy overriding per-ref configuration => Non-conflicting 3-way merge' '
+	git -c notes.refs/notes/y.merge="theirs" notes merge --strategy=union z &&
+	verify_notes y union
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
+test_expect_success 'merge z into y with "union" per-ref overriding general configuration => Non-conflicting 3-way merge' '
+	git -c notes.refs/notes/y.merge="union" -c notes.merge="theirs" notes merge z &&
+	verify_notes y union
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
+test_expect_success 'merge z into y with "manual" per-ref only checks specific ref configuration => Conflicting 3-way merge' '
+	test_must_fail git -c notes.refs/notes/z.merge="union" notes merge z &&
+	git notes merge --abort &&
+	verify_notes y y
+'
+
 cat <<EOF | sort >expect_notes_union2
 d682107b8bf7a7aea1e537a8d5cb6a12b60135f1 $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-- 
2.5.0.482.gfcd5645
