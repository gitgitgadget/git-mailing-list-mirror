From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH v2] patch-ids: cache patch IDs in a notes tree
Date: Sun, 12 May 2013 12:41:31 +0100
Message-ID: <20130512114131.GI2299@serenity.lan>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
 <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
 <20130511214900.GF2299@serenity.lan>
 <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
 <alpine.DEB.1.00.1305111846160.8213@s15462909.onlinehome-server.info>
 <20130512090850.GH2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 12 13:41:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbUez-0000Oy-Bd
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 13:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab3ELLlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 07:41:44 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:43221 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab3ELLln (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 07:41:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id BF180CDA60B;
	Sun, 12 May 2013 12:41:42 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZuDasDuoT9nN; Sun, 12 May 2013 12:41:41 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 37C86CDA607;
	Sun, 12 May 2013 12:41:41 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 1CB16161E418;
	Sun, 12 May 2013 12:41:41 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wdf5uOxOMFIe; Sun, 12 May 2013 12:41:40 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 0C117161E2DF;
	Sun, 12 May 2013 12:41:33 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130512090850.GH2299@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224034>

This adds a new configuration variable "patchid.cacheRef" which controls
whether (and where) patch IDs will be cached in a notes tree.  The cache
includes a hash of the diff options in place when the cache was
generated as well as the version of Git that generated it.

When the diff options hash changes we simply ignore that cache entry and
replace it with the new patch ID with the new diff options.  But if the
Git version changes we throw away the entire cache tree on the
assumption that the user is unlikely to be simply flipping between
different versions of Git.

Caching patch IDs in this way results in a performance improvement in
every case I have tried, for example if I run a script which checks
whether any of six local branches have been picked up upstream I get the
following results:

Without patchid.cacheRef enabled:

	$ time git integration --status jk/pu >/dev/null

	real    0m4.295s
	user    0m3.927s
	sys     0m0.270s

With patchid.cacheRef set but not yet initialised:

	$ time git integration --status jk/pu >/dev/null

	real    0m2.317s
	user    0m2.036s
	sys     0m0.187s

With patchid.cacheRef and cache primed:

	$ time git integration --status jk/pu >/dev/null

	real    0m1.565s
	user    0m1.310s
	sys     0m0.153s

The script basically does:

	git log --cherry pu...<branch>

for each of six branches in turn (with some additional commands around
that which are now the bottleneck).

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Sun, May 12, 2013 at 10:08:51AM +0100, John Keeping wrote:
> On Sat, May 11, 2013 at 06:57:02PM -0500, Johannes Schindelin wrote:
> > On Sat, 11 May 2013, Linus Torvalds wrote:
> > 
> > > [...] I really think caching patch ID's should be something people
> > > should be aware of is fundamentally wrong, even if it might work.
> > 
> > Given the incredible performance win, I would say it is still worth
> > looking into.
> > 
> > If you store also a hash of Git version and diff options (may even be the
> > hash of the raw bytes of the diff options if you do not plan to share the
> > ref between machines) with the patch ID, you can make it safe.
> > 
> > That hash would be generated at patch_id init time and
> > load_cached_patch_id() would check this hash in addition to the return
> > value of get_sha1() (and ignore the note if the version/diff options
> > differ).
> 
> I was thinking about this overnight, glad to see someone else had the
> same idea :-)
> 
> It's slightly annoying because the diff options can be customized after
> we return from init_patch_ids() so we either need a new
> setup_patch_ids() function to be run after init once diff options have
> been set or to set it lazily.  I'll try introducing a setup function.

This is what that looks like.  I think the way I'm hashing the diff
options is sensible but another pair of eyes would be useful there.

A cache entry looks like this:

	9e99e9dbf5c6a717ac60f7ee425c53e87ffd821a
	diffopts:f8ca35c3d9d57076338dff8abf91b07157bb6329
	1.8.3.rc1.45.gcb72da6.dirty

 Documentation/config.txt             |   7 ++
 builtin/log.c                        |   1 +
 patch-ids.c                          | 215 ++++++++++++++++++++++++++++++++++-
 patch-ids.h                          |   4 +
 revision.c                           |   1 +
 t/t6007-rev-list-cherry-pick-file.sh |  16 +++
 6 files changed, 243 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..e36585c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1798,6 +1798,13 @@ pager.<cmd>::
 	precedence over this option.  To disable pagination for all
 	commands, set `core.pager` or `GIT_PAGER` to `cat`.
 
+patchid.cacheRef::
+	The name of a notes ref in which to store patch IDs for commits.
+	The ref is taken to be in `refs/notes/` if it is not qualified.
++
+Note that the patch ID notes are never pruned automatically, so you may
+wish to periodically run `git notes --ref <ref> prune` against this ref.
+
 pretty.<name>::
 	Alias for a --pretty= format string, as specified in
 	linkgit:git-log[1]. Any aliases defined here can be used just
diff --git a/builtin/log.c b/builtin/log.c
index 6e56a50..dd6c24d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -758,6 +758,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 		die(_("Not a range."));
 
 	init_patch_ids(ids);
+	setup_patch_ids(ids);
 
 	/* given a range a..b get all patch ids for b..a */
 	init_revisions(&check_rev, rev->prefix);
diff --git a/patch-ids.c b/patch-ids.c
index bc8a28f..73b2aaf 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -1,8 +1,12 @@
 #include "cache.h"
+#include "blob.h"
 #include "diff.h"
 #include "commit.h"
+#include "notes.h"
+#include "refs.h"
 #include "sha1-lookup.h"
 #include "patch-ids.h"
+#include "version.h"
 
 static int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1)
@@ -34,6 +38,16 @@ struct patch_id_bucket {
 	struct patch_id bucket[BUCKET_SIZE];
 };
 
+static int patch_id_config(const char *var, const char *value, void *cb)
+{
+	const char **cacheref = cb;
+
+	if (!strcmp(var, "patchid.cacheref"))
+		return git_config_string(cacheref, var, value);
+
+	return 0;
+}
+
 int init_patch_ids(struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
@@ -43,6 +57,108 @@ int init_patch_ids(struct patch_ids *ids)
 	return 0;
 }
 
+static void sha1_update_str(git_SHA_CTX *ctx, const char *s)
+{
+	size_t len = s ? strlen(s) + 1 : 0;
+	long nl = htonl((long) len);
+	git_SHA1_Update(ctx, &nl, sizeof(nl));
+	git_SHA1_Update(ctx, s, len);
+}
+
+static void sha1_update_int(git_SHA_CTX *ctx, int v)
+{
+	long nv = htonl((long) v);
+	git_SHA1_Update(ctx, &nv, sizeof(nv));
+}
+
+static void sha1_update_pathspec(git_SHA_CTX *ctx, struct pathspec *pathspec)
+{
+	int i;
+	/*
+	 * Pathspecs are uniquely identified by their number and match string
+	 * providing that we take limit_pathspec_to_literal into account.
+	 */
+	sha1_update_int(ctx, limit_pathspec_to_literal());
+	sha1_update_int(ctx, pathspec->nr);
+	for (i = 0; i < pathspec->nr; i++)
+		sha1_update_str(ctx, pathspec->items[i].match);
+}
+
+static void hash_diff_options(struct diff_options *options, unsigned char *sha1)
+{
+	git_SHA_CTX ctx;
+	git_SHA1_Init(&ctx);
+
+	sha1_update_str(&ctx, options->filter);
+	/* ignore options->orderfile (see setup_patch_ids) */
+	sha1_update_str(&ctx, options->pickaxe);
+	sha1_update_str(&ctx, options->single_follow);
+	/* a_prefix and b_prefix aren't used for patch IDs */
+
+	sha1_update_int(&ctx, options->flags);
+	/* use_color isn't used for patch IDs */
+	sha1_update_int(&ctx, options->context);
+	sha1_update_int(&ctx, options->interhunkcontext);
+	sha1_update_int(&ctx, options->break_opt);
+	sha1_update_int(&ctx, options->detect_rename);
+	sha1_update_int(&ctx, options->irreversible_delete);
+	sha1_update_int(&ctx, options->skip_stat_unmatch);
+	/* line_termination isn't used for patch IDs */
+	/* output_format isn't used for patch IDs */
+	sha1_update_int(&ctx, options->pickaxe_opts);
+	sha1_update_int(&ctx, options->rename_score);
+	sha1_update_int(&ctx, options->rename_limit);
+	/* needed_rename_limit is set while diffing */
+	/* degraded_cc_to_c is set while diffing */
+	/* show_rename_progress isn't used for patch IDs */
+	/* dirstat_permille isn't used for patch IDs */
+	/* setup isn't used for patch IDs */
+	/* abbrev isn't used for patch IDs */
+	/* prefix and prefix_length aren't used for patch IDs */
+	/* stat_sep isn't used for patch IDs */
+	sha1_update_int(&ctx, options->xdl_opts);
+
+	/* stat arguments aren't used for patch IDs */
+	sha1_update_str(&ctx, options->word_regex);
+	sha1_update_int(&ctx, options->word_diff);
+
+	sha1_update_pathspec(&ctx, &options->pathspec);
+
+	git_SHA1_Final(sha1, &ctx);
+}
+
+int setup_patch_ids(struct patch_ids *ids)
+{
+	char *cacheref = NULL;
+
+	/*
+	 * Make extra sure we aren't using an orderfile as it is unnecessary
+	 * and will break caching.
+	 */
+	ids->diffopts.orderfile = NULL;
+
+	git_config(patch_id_config, &cacheref);
+	if (cacheref) {
+		unsigned char diffopts_raw_hash[20];
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, cacheref);
+		expand_notes_ref(&sb);
+
+		ids->cache = xcalloc(1, sizeof(*ids->cache));
+		init_notes(ids->cache, sb.buf, combine_notes_overwrite, 0);
+
+		hash_diff_options(&ids->diffopts, diffopts_raw_hash);
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "diffopts:%s\n", sha1_to_hex(diffopts_raw_hash));
+		ids->diffopts_hash_len = sb.len;
+		ids->diffopts_hash = strbuf_detach(&sb, NULL);
+
+		free(cacheref);
+	}
+
+	return 0;
+}
+
 int free_patch_ids(struct patch_ids *ids)
 {
 	struct patch_id_bucket *next, *patches;
@@ -52,9 +168,104 @@ int free_patch_ids(struct patch_ids *ids)
 		next = patches->next;
 		free(patches);
 	}
+
+	if (ids->cache) {
+		unsigned char notes_sha1[20];
+		if (write_notes_tree(ids->cache, notes_sha1) ||
+		    update_ref("patch-id: update cache", ids->cache->ref,
+				notes_sha1, NULL, 0, QUIET_ON_ERR))
+			error(_("failed to write patch ID cache"));
+
+		free_notes(ids->cache);
+		ids->cache = NULL;
+
+		free(ids->diffopts_hash);
+		ids->diffopts_hash = NULL;
+	}
+
 	return 0;
 }
 
+static int load_cached_patch_id(struct commit *commit,
+		struct patch_ids *ids, unsigned char *sha1)
+{
+	const unsigned char *note_sha1;
+	char *orig_note;
+	char *note;
+	enum object_type type;
+	unsigned long notelen;
+	int result = 1;
+
+	if (!ids->cache)
+		return 1;
+
+	note_sha1 = get_note(ids->cache, commit->object.sha1);
+	if (!note_sha1)
+		return 1;
+
+	if (!(orig_note = read_sha1_file(note_sha1, &type, &notelen)) ||
+			!notelen || type != OBJ_BLOB)
+		goto out;
+
+	note = orig_note;
+	if (get_sha1_hex(note, sha1))
+		goto out;
+
+	/* Advance past the patch ID */
+	note += 41;
+	/* Was the cached patch ID generated with the same diffopts? */
+	if (strncmp(note, ids->diffopts_hash, ids->diffopts_hash_len)) {
+		goto out;
+	}
+
+	note += ids->diffopts_hash_len;
+	if (note[strlen(note) - 1] == '\n')
+		note[strlen(note) - 1] = '\0';
+	if (strcmp(note, git_version_string)) {
+		struct notes_tree *new_cache;
+		/*
+		 * If the Git version has changed, throw away the entire
+		 * caching notes tree on the assumption that the user will
+		 * not return to the previous version.  We can bail out of
+		 * this function sooner next time round if we don't find a
+		 * note for the commit at all.
+		 */
+		new_cache = xcalloc(1, sizeof(*new_cache));
+		init_notes(new_cache, ids->cache->ref,
+			ids->cache->combine_notes, NOTES_INIT_EMPTY);
+		free_notes(ids->cache);
+		free(ids->cache);
+		ids->cache = new_cache;
+		goto out;
+	}
+
+	result = 0;
+out:
+	free(orig_note);
+	return result;
+}
+
+static void save_cached_patch_id(struct commit *commit,
+		struct patch_ids *ids, unsigned char *sha1)
+{
+	unsigned char note_sha1[20];
+	struct strbuf sb = STRBUF_INIT;
+	if (!ids->cache)
+		return;
+
+	strbuf_addstr(&sb, sha1_to_hex(sha1));
+	strbuf_addch(&sb, '\n');
+	strbuf_add(&sb, ids->diffopts_hash, ids->diffopts_hash_len);
+	strbuf_addstr(&sb, git_version_string);
+	strbuf_addch(&sb, '\n');
+
+	if (write_sha1_file(sb.buf, sb.len, blob_type, note_sha1) ||
+	    add_note(ids->cache, commit->object.sha1, note_sha1, NULL))
+		error(_("unable to save patch ID in cache"));
+
+	strbuf_release(&sb);
+}
+
 static struct patch_id *add_commit(struct commit *commit,
 				   struct patch_ids *ids,
 				   int no_add)
@@ -64,11 +275,13 @@ static struct patch_id *add_commit(struct commit *commit,
 	unsigned char sha1[20];
 	int pos;
 
-	if (commit_patch_id(commit, &ids->diffopts, sha1))
+	if (load_cached_patch_id(commit, ids, sha1) &&
+	    commit_patch_id(commit, &ids->diffopts, sha1))
 		return NULL;
 	pos = patch_pos(ids->table, ids->nr, sha1);
 	if (0 <= pos)
 		return ids->table[pos];
+	save_cached_patch_id(commit, ids, sha1);
 	if (no_add)
 		return NULL;
 
diff --git a/patch-ids.h b/patch-ids.h
index c8c7ca1..08d4dd3 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -8,12 +8,16 @@ struct patch_id {
 
 struct patch_ids {
 	struct diff_options diffopts;
+	struct notes_tree *cache;
+	char *diffopts_hash;
+	size_t diffopts_hash_len;
 	int nr, alloc;
 	struct patch_id **table;
 	struct patch_id_bucket *patches;
 };
 
 int init_patch_ids(struct patch_ids *);
+int setup_patch_ids(struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
 struct patch_id *has_commit_patch_id(struct commit *, struct patch_ids *);
diff --git a/revision.c b/revision.c
index a67b615..0de4168 100644
--- a/revision.c
+++ b/revision.c
@@ -632,6 +632,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	left_first = left_count < right_count;
 	init_patch_ids(&ids);
 	ids.diffopts.pathspec = revs->diffopt.pathspec;
+	setup_patch_ids(&ids);
 
 	/* Compute patch-ids for one side */
 	for (p = list; p; p = p->next) {
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 28d4f6b..378cf3e 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -207,4 +207,20 @@ test_expect_success '--count --left-right' '
 	test_cmp expect actual
 '
 
+cat >expect <<EOF
+3	2	0
+EOF
+
+test_expect_success 'rev-list --cherry-mark caches patch ids' '
+	test_config patchid.cacheref patchids &&
+	git rev-list --cherry-mark --left-right --count F...E >actual &&
+	test_cmp expect actual &&
+	git notes --ref patchids show master >cached_master &&
+	git log -p -1 master | git patch-id | sed -e "s/ .*//" >patch-id_master &&
+	test_cmp patch-id_master cached_master &&
+	# Get the patch IDs again, now they should be cached
+	git rev-list --cherry-mark --left-right --count F...E >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.3.rc1.45.gcb72da6.dirty
