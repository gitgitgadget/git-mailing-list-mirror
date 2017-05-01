Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A1CC1FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999540AbdEACb2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:28 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35866 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642325AbdEACak (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CE410280C8;
        Mon,  1 May 2017 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605808;
        bh=OvUP6T+NvI0TMInm4rhJxc4lzyRBWzs6ZyE4ptqQM24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z7K3cOIgLJwGzZR0TkU2ymnsRwML5Hne0IUB9pH/3NhOSO2IuG6b7S3bFB2VvecEc
         vcwT2ZseleVTxz3uTVwcVMFUWhEPGylL5sPcIbAJRwHNwFOXxkDNcW7rgjEsAVAyO/
         18x7ZtVelvepMys/YNYcP39565wOjQNJwdnG/BKNhHK7BKLfxgsUkPiFjQKrhPAae+
         jq3bJtVg/XBkwQtuzpUrHWlzjCLc3UTsNOjKjzY8zrRGYmYdiv0n7KJwnziKgEIfW2
         FQM0zQDHP3+xlMz69z9sO9SwBg8asgQrK/JZCuyoS6qjCTeifm+REVLuFcofNBkEgK
         OR+iAFc+rfFKnUVv9zlB0mMQMJ7VZuYQb6ToxUziQJByS9nxXtAOfBs/DPOaZJddv7
         xeIo+nCLQCEWJSevcGp5PmgAdAK+JQTau/vDyaunkYnRa2fKeTJWp3ftX5HN2Nq+cI
         YbbaNQCFaZIVHO45n8niBOBjEpHJIJ4u6gLCcgO+wPJPNUAesPJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 25/53] Convert lookup_commit* to struct object_id
Date:   Mon,  1 May 2017 02:29:18 +0000
Message-Id: <20170501022946.258735-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert lookup_commit, lookup_commit_or_die,
lookup_commit_reference, and lookup_commit_reference_gently to take
struct object_id arguments.

Introduce a temporary in parse_object buffer in order to convert this
function.  This is required since in order to convert parse_object and
parse_object_buffer, lookup_commit_reference_gently and
lookup_commit_or_die would need to be converted.  Not introducing a
temporary would therefore require that lookup_commit_or_die take a
struct object_id *, but lookup_commit would take unsigned char *,
leaving a confusing and hard-to-use interface.

parse_object_buffer will lose this temporary in a later patch.

This commit was created with manual changes to commit.c, commit.h, and
object.c, plus the following semantic patch:

@@
expression E1, E2;
@@
- lookup_commit_reference_gently(E1.hash, E2)
+ lookup_commit_reference_gently(&E1, E2)

@@
expression E1, E2;
@@
- lookup_commit_reference_gently(E1->hash, E2)
+ lookup_commit_reference_gently(E1, E2)

@@
expression E1;
@@
- lookup_commit_reference(E1.hash)
+ lookup_commit_reference(&E1)

@@
expression E1;
@@
- lookup_commit_reference(E1->hash)
+ lookup_commit_reference(E1)

@@
expression E1;
@@
- lookup_commit(E1.hash)
+ lookup_commit(&E1)

@@
expression E1;
@@
- lookup_commit(E1->hash)
+ lookup_commit(E1)

@@
expression E1, E2;
@@
- lookup_commit_or_die(E1.hash, E2)
+ lookup_commit_or_die(&E1, E2)

@@
expression E1, E2;
@@
- lookup_commit_or_die(E1->hash, E2)
+ lookup_commit_or_die(E1, E2)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive.c               |  2 +-
 bisect.c                |  2 +-
 branch.c                |  2 +-
 builtin/am.c            |  4 ++--
 builtin/blame.c         |  4 ++--
 builtin/branch.c        |  6 +++---
 builtin/checkout.c      |  6 +++---
 builtin/clone.c         |  2 +-
 builtin/commit-tree.c   |  2 +-
 builtin/commit.c        |  4 ++--
 builtin/describe.c      |  4 ++--
 builtin/diff-tree.c     |  4 ++--
 builtin/fast-export.c   |  2 +-
 builtin/fetch.c         |  7 ++++---
 builtin/fmt-merge-msg.c |  4 ++--
 builtin/log.c           |  8 ++++----
 builtin/merge-base.c    |  6 +++---
 builtin/merge.c         |  2 +-
 builtin/notes.c         |  2 +-
 builtin/pull.c          | 10 +++++-----
 builtin/reflog.c        |  8 ++++----
 builtin/replace.c       |  4 ++--
 builtin/reset.c         |  4 ++--
 builtin/rev-parse.c     |  6 +++---
 builtin/show-branch.c   |  4 ++--
 builtin/tag.c           |  2 +-
 builtin/verify-commit.c |  2 +-
 bundle.c                |  2 +-
 commit.c                | 30 +++++++++++++++---------------
 commit.h                | 12 ++++++------
 fast-import.c           |  4 ++--
 fetch-pack.c            |  2 +-
 http-push.c             |  5 +++--
 log-tree.c              |  2 +-
 notes-cache.c           |  2 +-
 notes-merge.c           |  4 ++--
 notes-utils.c           |  2 +-
 object.c                |  5 ++++-
 parse-options-cb.c      |  2 +-
 ref-filter.c            |  4 ++--
 remote.c                | 13 +++++++------
 revision.c              |  8 ++++----
 sequencer.c             |  8 ++++----
 sha1_name.c             | 10 +++++-----
 shallow.c               | 20 ++++++++++----------
 submodule.c             | 14 +++++++-------
 tag.c                   |  2 +-
 tree.c                  |  2 +-
 walker.c                |  2 +-
 wt-status.c             |  2 +-
 50 files changed, 138 insertions(+), 132 deletions(-)

diff --git a/archive.c b/archive.c
index 60b889198..54701e8bb 100644
--- a/archive.c
+++ b/archive.c
@@ -360,7 +360,7 @@ static void parse_treeish_arg(const char **argv,
 	if (get_sha1(name, oid.hash))
 		die("Not a valid object name");
 
-	commit = lookup_commit_reference_gently(oid.hash, 1);
+	commit = lookup_commit_reference_gently(&oid, 1);
 	if (commit) {
 		commit_sha1 = commit->object.oid.hash;
 		archive_time = commit->date;
diff --git a/bisect.c b/bisect.c
index 08c9fb726..bb5af3ea3 100644
--- a/bisect.c
+++ b/bisect.c
@@ -705,7 +705,7 @@ static int bisect_checkout(const unsigned char *bisect_rev, int no_checkout)
 
 static struct commit *get_commit_reference(const struct object_id *oid)
 {
-	struct commit *r = lookup_commit_reference(oid->hash);
+	struct commit *r = lookup_commit_reference(oid);
 	if (!r)
 		die(_("Not a valid commit name %s"), oid_to_hex(oid));
 	return r;
diff --git a/branch.c b/branch.c
index 1758c9708..4899144f5 100644
--- a/branch.c
+++ b/branch.c
@@ -286,7 +286,7 @@ void create_branch(const char *name, const char *start_name,
 		break;
 	}
 
-	if ((commit = lookup_commit_reference(oid.hash)) == NULL)
+	if ((commit = lookup_commit_reference(&oid)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
 	oidcpy(&oid, &commit->object.oid);
 
diff --git a/builtin/am.c b/builtin/am.c
index a95dd8b4e..650269ac5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1488,7 +1488,7 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
 	if (get_mail_commit_oid(&commit_oid, mail) < 0)
 		die(_("could not parse %s"), mail);
 
-	commit = lookup_commit_or_die(commit_oid.hash, mail);
+	commit = lookup_commit_or_die(&commit_oid, mail);
 
 	get_commit_info(state, commit);
 
@@ -1683,7 +1683,7 @@ static void do_commit(const struct am_state *state)
 
 	if (!get_sha1_commit("HEAD", parent.hash)) {
 		old_oid = &parent;
-		commit_list_insert(lookup_commit(parent.hash), &parents);
+		commit_list_insert(lookup_commit(&parent), &parents);
 	} else {
 		old_oid = NULL;
 		say(state, stderr, _("applying to an empty history"));
diff --git a/builtin/blame.c b/builtin/blame.c
index 7d644d092..58bb274d0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2253,7 +2253,7 @@ static struct commit_list **append_parent(struct commit_list **tail, const struc
 {
 	struct commit *parent;
 
-	parent = lookup_commit_reference(oid->hash);
+	parent = lookup_commit_reference(oid);
 	if (!parent)
 		die("no such commit %s", oid_to_hex(oid));
 	return &commit_list_insert(parent, tail)->next;
@@ -2475,7 +2475,7 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 	/* Do we have HEAD? */
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
 		return NULL;
-	head_commit = lookup_commit_reference_gently(head_oid.hash, 1);
+	head_commit = lookup_commit_reference_gently(&head_oid, 1);
 	if (!head_commit)
 		return NULL;
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 48a513a84..83fcda43d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -124,7 +124,7 @@ static int branch_merged(int kind, const char *name,
 		    (reference_name = reference_name_to_free =
 		     resolve_refdup(upstream, RESOLVE_REF_READING,
 				    oid.hash, NULL)) != NULL)
-			reference_rev = lookup_commit_reference(oid.hash);
+			reference_rev = lookup_commit_reference(&oid);
 	}
 	if (!reference_rev)
 		reference_rev = head_rev;
@@ -157,7 +157,7 @@ static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
 			       int kinds, int force)
 {
-	struct commit *rev = lookup_commit_reference(oid->hash);
+	struct commit *rev = lookup_commit_reference(oid);
 	if (!rev) {
 		error(_("Couldn't look up commit object for '%s'"), refname);
 		return -1;
@@ -211,7 +211,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 
 	if (!force) {
-		head_rev = lookup_commit_reference(head_oid.hash);
+		head_rev = lookup_commit_reference(&head_oid);
 		if (!head_rev)
 			die(_("Couldn't look up commit object for HEAD"));
 	}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f3..afa99fb8a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -393,7 +393,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("unable to write new index file"));
 
 	read_ref_full("HEAD", 0, rev.hash, NULL);
-	head = lookup_commit_reference_gently(rev.hash, 1);
+	head = lookup_commit_reference_gently(&rev, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
 	return errs;
@@ -833,7 +833,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	int flag, writeout_error = 0;
 	memset(&old, 0, sizeof(old));
 	old.path = path_to_free = resolve_refdup("HEAD", 0, rev.hash, &flag);
-	old.commit = lookup_commit_reference_gently(rev.hash, 1);
+	old.commit = lookup_commit_reference_gently(&rev, 1);
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
 
@@ -1047,7 +1047,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	else
 		new->path = NULL; /* not an existing branch */
 
-	new->commit = lookup_commit_reference_gently(rev->hash, 1);
+	new->commit = lookup_commit_reference_gently(rev, 1);
 	if (!new->commit) {
 		/* not a commit */
 		*source_tree = parse_tree_indirect(rev->hash);
diff --git a/builtin/clone.c b/builtin/clone.c
index de85b8525..646f28792 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -682,7 +682,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
-		struct commit *c = lookup_commit_reference(our->old_oid.hash);
+		struct commit *c = lookup_commit_reference(&our->old_oid);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		update_ref(msg, "HEAD", c->object.oid.hash,
 			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 605017261..f39c2b273 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -58,7 +58,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			if (get_sha1_commit(argv[i], oid.hash))
 				die("Not a valid object name %s", argv[i]);
 			assert_sha1_type(oid.hash, OBJ_COMMIT);
-			new_parent(lookup_commit(oid.hash), &parents);
+			new_parent(lookup_commit(&oid), &parents);
 			continue;
 		}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 8685c888f..e69f466d5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1430,7 +1430,7 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
 
-	commit = lookup_commit(oid->hash);
+	commit = lookup_commit(oid);
 	if (!commit)
 		die(_("couldn't look up newly created commit"));
 	if (parse_commit(commit))
@@ -1654,7 +1654,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (get_sha1("HEAD", oid.hash))
 		current_head = NULL;
 	else {
-		current_head = lookup_commit_or_die(oid.hash, "HEAD");
+		current_head = lookup_commit_or_die(&oid, "HEAD");
 		if (parse_commit(current_head))
 			die(_("could not parse HEAD commit"));
 	}
diff --git a/builtin/describe.c b/builtin/describe.c
index a5cd8c513..f6032f593 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -281,7 +281,7 @@ static void describe(const char *arg, int last_one)
 
 	if (get_oid(arg, &oid))
 		die(_("Not a valid object name %s"), arg);
-	cmit = lookup_commit_reference(oid.hash);
+	cmit = lookup_commit_reference(&oid);
 	if (!cmit)
 		die(_("%s is not a valid '%s' object"), arg, commit_type);
 
@@ -309,7 +309,7 @@ static void describe(const char *arg, int last_one)
 		struct commit *c;
 		struct commit_name *n = hashmap_iter_first(&names, &iter);
 		for (; n; n = hashmap_iter_next(&iter)) {
-			c = lookup_commit_reference_gently(n->peeled.hash, 1);
+			c = lookup_commit_reference_gently(&n->peeled, 1);
 			if (c)
 				c->util = n;
 		}
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 326f88b65..e85a449df 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -9,7 +9,7 @@ static struct rev_info log_tree_opt;
 
 static int diff_tree_commit_sha1(const struct object_id *oid)
 {
-	struct commit *commit = lookup_commit_reference(oid->hash);
+	struct commit *commit = lookup_commit_reference(oid);
 	if (!commit)
 		return -1;
 	return log_tree_commit(&log_tree_opt, commit);
@@ -23,7 +23,7 @@ static int stdin_diff_commit(struct commit *commit, const char *p)
 
 	/* Graft the fake parents locally to the commit */
 	while (isspace(*p++) && !parse_oid_hex(p, &oid, &p)) {
-		struct commit *parent = lookup_commit(oid.hash);
+		struct commit *parent = lookup_commit(&oid);
 		if (!pptr) {
 			/* Free the real parent list */
 			free_commit_list(commit->parents);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e0220630d..b4521cb62 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -938,7 +938,7 @@ static void import_marks(char *input_file)
 			/* only commits */
 			continue;
 
-		commit = lookup_commit(oid.hash);
+		commit = lookup_commit(&oid);
 		if (!commit)
 			die("not a commit? can't happen: %s", oid_to_hex(&oid));
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f2c2ab23..d4d573b98 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -636,8 +636,8 @@ static int update_local_ref(struct ref *ref,
 		return r;
 	}
 
-	current = lookup_commit_reference_gently(ref->old_oid.hash, 1);
-	updated = lookup_commit_reference_gently(ref->new_oid.hash, 1);
+	current = lookup_commit_reference_gently(&ref->old_oid, 1);
+	updated = lookup_commit_reference_gently(&ref->new_oid, 1);
 	if (!current || !updated) {
 		const char *msg;
 		const char *what;
@@ -770,7 +770,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				continue;
 			}
 
-			commit = lookup_commit_reference_gently(rm->old_oid.hash, 1);
+			commit = lookup_commit_reference_gently(&rm->old_oid,
+								1);
 			if (!commit)
 				rm->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 6faa3c0d2..91dd753dd 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -566,7 +566,7 @@ static void find_merge_parents(struct merge_parents *result,
 		commit_list_insert(parent, &parents);
 		add_merge_parent(result, &obj->oid, &parent->object.oid);
 	}
-	head_commit = lookup_commit(head->hash);
+	head_commit = lookup_commit(head);
 	if (head_commit)
 		commit_list_insert(head_commit, &parents);
 	parents = reduce_heads(parents);
@@ -633,7 +633,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		struct commit *head;
 		struct rev_info rev;
 
-		head = lookup_commit_or_die(head_oid.hash, "HEAD");
+		head = lookup_commit_or_die(&head_oid, "HEAD");
 		init_revisions(&rev, NULL);
 		rev.commit_format = CMIT_FMT_ONELINE;
 		rev.ignore_merges = 1;
diff --git a/builtin/log.c b/builtin/log.c
index b3b10cc1e..d8b56ea41 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -878,8 +878,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	o2 = rev->pending.objects[1].item;
 	flags1 = o1->flags;
 	flags2 = o2->flags;
-	c1 = lookup_commit_reference(o1->oid.hash);
-	c2 = lookup_commit_reference(o2->oid.hash);
+	c1 = lookup_commit_reference(&o1->oid);
+	c2 = lookup_commit_reference(&o2->oid);
 
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
@@ -1263,7 +1263,7 @@ static struct commit *get_base_commit(const char *base_commit,
 
 			if (get_oid(upstream, &oid))
 				die(_("Failed to resolve '%s' as a valid ref."), upstream);
-			commit = lookup_commit_or_die(oid.hash, "upstream base");
+			commit = lookup_commit_or_die(&oid, "upstream base");
 			base_list = get_merge_bases_many(commit, total, list);
 			/* There should be one and only one merge base. */
 			if (!base_list || base_list->next)
@@ -1819,7 +1819,7 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 {
 	struct object_id oid;
 	if (get_oid(arg, &oid) == 0) {
-		struct commit *commit = lookup_commit_reference(oid.hash);
+		struct commit *commit = lookup_commit_reference(&oid);
 		if (commit) {
 			commit->object.flags |= flags;
 			add_pending_object(revs, &commit->object, arg);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index cfe2a796f..5c74ce249 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -41,7 +41,7 @@ static struct commit *get_commit_reference(const char *arg)
 
 	if (get_oid(arg, &revkey))
 		die("Not a valid object name %s", arg);
-	r = lookup_commit_reference(revkey.hash);
+	r = lookup_commit_reference(&revkey);
 	if (!r)
 		die("Not a valid commit name %s", arg);
 
@@ -120,7 +120,7 @@ static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 	if (is_null_oid(oid))
 		return;
 
-	commit = lookup_commit(oid->hash);
+	commit = lookup_commit(oid);
 	if (!commit ||
 	    (commit->object.flags & TMP_MARK) ||
 	    parse_commit(commit))
@@ -168,7 +168,7 @@ static int handle_fork_point(int argc, const char **argv)
 	if (get_oid(commitname, &oid))
 		die("Not a valid object name: '%s'", commitname);
 
-	derived = lookup_commit_reference(oid.hash);
+	derived = lookup_commit_reference(&oid);
 	memset(&revs, 0, sizeof(revs));
 	revs.initial = 1;
 	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
diff --git a/builtin/merge.c b/builtin/merge.c
index 703827f00..f11b5f3de 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1123,7 +1123,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!branch || is_null_oid(&head_oid))
 		head_commit = NULL;
 	else
-		head_commit = lookup_commit_or_die(head_oid.hash, "HEAD");
+		head_commit = lookup_commit_or_die(&head_oid, "HEAD");
 
 	init_diff_ui_defaults();
 	git_config(git_merge_config, NULL);
diff --git a/builtin/notes.c b/builtin/notes.c
index 7b891471c..f2847c41e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -706,7 +706,7 @@ static int merge_commit(struct notes_merge_options *o)
 
 	if (get_oid("NOTES_MERGE_PARTIAL", &oid))
 		die(_("failed to read ref NOTES_MERGE_PARTIAL"));
-	else if (!(partial = lookup_commit_reference(oid.hash)))
+	else if (!(partial = lookup_commit_reference(&oid)))
 		die(_("could not find commit from NOTES_MERGE_PARTIAL."));
 	else if (parse_commit(partial))
 		die(_("could not parse commit from NOTES_MERGE_PARTIAL."));
diff --git a/builtin/pull.c b/builtin/pull.c
index dd1a4a94e..2ffb6569a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -698,10 +698,10 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 {
 	struct commit_list *revs = NULL, *result;
 
-	commit_list_insert(lookup_commit_reference(curr_head->hash), &revs);
-	commit_list_insert(lookup_commit_reference(merge_head->hash), &revs);
+	commit_list_insert(lookup_commit_reference(curr_head), &revs);
+	commit_list_insert(lookup_commit_reference(merge_head), &revs);
 	if (!is_null_oid(fork_point))
-		commit_list_insert(lookup_commit_reference(fork_point->hash), &revs);
+		commit_list_insert(lookup_commit_reference(fork_point), &revs);
 
 	result = reduce_heads(get_octopus_merge_bases(revs));
 	free_commit_list(revs);
@@ -865,9 +865,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		struct commit_list *list = NULL;
 		struct commit *merge_head, *head;
 
-		head = lookup_commit_reference(orig_head.hash);
+		head = lookup_commit_reference(&orig_head);
 		commit_list_insert(head, &list);
-		merge_head = lookup_commit_reference(merge_heads.oid[0].hash);
+		merge_head = lookup_commit_reference(&merge_heads.oid[0]);
 		if (is_descendant_of(merge_head, list)) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
diff --git a/builtin/reflog.c b/builtin/reflog.c
index d6718d326..4831116ea 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -192,7 +192,7 @@ static int keep_entry(struct commit **it, struct object_id *oid)
 
 	if (is_null_oid(oid))
 		return 1;
-	commit = lookup_commit_reference_gently(oid->hash, 1);
+	commit = lookup_commit_reference_gently(oid, 1);
 	if (!commit)
 		return 0;
 
@@ -261,7 +261,7 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
 		if (is_null_oid(oid))
 			return 0;
 
-		commit = lookup_commit_reference_gently(oid->hash, 1);
+		commit = lookup_commit_reference_gently(oid, 1);
 
 		/* Not a commit -- keep it */
 		if (!commit)
@@ -318,7 +318,7 @@ static int push_tip_to_list(const char *refname, const struct object_id *oid,
 	struct commit *tip_commit;
 	if (flags & REF_ISSYMREF)
 		return 0;
-	tip_commit = lookup_commit_reference_gently(oid->hash, 1);
+	tip_commit = lookup_commit_reference_gently(oid, 1);
 	if (!tip_commit)
 		return 0;
 	commit_list_insert(tip_commit, list);
@@ -335,7 +335,7 @@ static void reflog_expiry_prepare(const char *refname,
 		cb->tip_commit = NULL;
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
-		cb->tip_commit = lookup_commit_reference_gently(oid->hash, 1);
+		cb->tip_commit = lookup_commit_reference_gently(oid, 1);
 		if (!cb->tip_commit)
 			cb->unreachable_expire_kind = UE_ALWAYS;
 		else
diff --git a/builtin/replace.c b/builtin/replace.c
index ab17668f4..3c44ef750 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -328,7 +328,7 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 		struct object_id oid;
 		if (get_oid(argv[i], &oid) < 0)
 			die(_("Not a valid object name: '%s'"), argv[i]);
-		lookup_commit_or_die(oid.hash, argv[i]);
+		lookup_commit_or_die(&oid, argv[i]);
 		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
 	}
 
@@ -394,7 +394,7 @@ static int create_graft(int argc, const char **argv, int force)
 
 	if (get_oid(old_ref, &old) < 0)
 		die(_("Not a valid object name: '%s'"), old_ref);
-	commit = lookup_commit_or_die(old.hash, old_ref);
+	commit = lookup_commit_or_die(&old, old_ref);
 
 	buffer = get_commit_buffer(commit, &size);
 	strbuf_add(&buf, buffer, size);
diff --git a/builtin/reset.c b/builtin/reset.c
index fc3b906c4..0be52fa36 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -303,7 +303,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		struct commit *commit;
 		if (get_sha1_committish(rev, oid.hash))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
-		commit = lookup_commit_reference(oid.hash);
+		commit = lookup_commit_reference(&oid);
 		if (!commit)
 			die(_("Could not parse object '%s'."), rev);
 		oidcpy(&oid, &commit->object.oid);
@@ -380,7 +380,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		update_ref_status = reset_refs(rev, &oid);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
-			print_new_head_line(lookup_commit_reference(oid.hash));
+			print_new_head_line(lookup_commit_reference(&oid));
 	}
 	if (!pathspec.nr)
 		remove_branch_state();
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 272bb13a0..01c67a1f1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -279,8 +279,8 @@ static int try_difference(const char *arg)
 		if (symmetric) {
 			struct commit_list *exclude;
 			struct commit *a, *b;
-			a = lookup_commit_reference(oid.hash);
-			b = lookup_commit_reference(end.hash);
+			a = lookup_commit_reference(&oid);
+			b = lookup_commit_reference(&end);
 			exclude = get_merge_bases(a, b);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
@@ -332,7 +332,7 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 	}
 
-	commit = lookup_commit_reference(oid.hash);
+	commit = lookup_commit_reference(&oid);
 	if (exclude_parent &&
 	    exclude_parent > commit_list_count(commit->parents)) {
 		*dotdot = '^';
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 19756595d..71b6f3c17 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -358,7 +358,7 @@ static void sort_ref_range(int bottom, int top)
 static int append_ref(const char *refname, const struct object_id *oid,
 		      int allow_dups)
 {
-	struct commit *commit = lookup_commit_reference_gently(oid->hash, 1);
+	struct commit *commit = lookup_commit_reference_gently(oid, 1);
 	int i;
 
 	if (!commit)
@@ -816,7 +816,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			       MAX_REVS), MAX_REVS);
 		if (get_sha1(ref_name[num_rev], revkey.hash))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
-		commit = lookup_commit_reference(revkey.hash);
+		commit = lookup_commit_reference(&revkey);
 		if (!commit)
 			die(_("cannot find commit %s (%s)"),
 			    ref_name[num_rev], oid_to_hex(&revkey));
diff --git a/builtin/tag.c b/builtin/tag.c
index 597c925e3..d0070b37c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -328,7 +328,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		}
 		free(buf);
 
-		if ((c = lookup_commit_reference(oid->hash)) != NULL)
+		if ((c = lookup_commit_reference(oid)) != NULL)
 			strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
 		break;
 	case OBJ_TREE:
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index a5db1c427..05b734e6d 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -25,7 +25,7 @@ static int run_gpg_verify(const struct object_id *oid, const char *buf, unsigned
 
 	memset(&signature_check, 0, sizeof(signature_check));
 
-	ret = check_commit_signature(lookup_commit(oid->hash), &signature_check);
+	ret = check_commit_signature(lookup_commit(oid), &signature_check);
 	print_signature_buffer(&signature_check, flags);
 
 	signature_check_clear(&signature_check);
diff --git a/bundle.c b/bundle.c
index 6e181bb3d..3386dba3b 100644
--- a/bundle.c
+++ b/bundle.c
@@ -367,7 +367,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 			 * in terms of a tag (e.g. v2.0 from the range
 			 * "v1.0..v2.0")?
 			 */
-			struct commit *one = lookup_commit_reference(oid.hash);
+			struct commit *one = lookup_commit_reference(&oid);
 			struct object *obj;
 
 			if (e->item == &(one->object)) {
diff --git a/commit.c b/commit.c
index ec41ba5e0..0f6c9b6bf 100644
--- a/commit.c
+++ b/commit.c
@@ -18,38 +18,38 @@ int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
 
-struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
+struct commit *lookup_commit_reference_gently(const struct object_id *oid,
 					      int quiet)
 {
-	struct object *obj = deref_tag(parse_object(sha1), NULL, 0);
+	struct object *obj = deref_tag(parse_object(oid->hash), NULL, 0);
 
 	if (!obj)
 		return NULL;
 	return object_as_type(obj, OBJ_COMMIT, quiet);
 }
 
-struct commit *lookup_commit_reference(const unsigned char *sha1)
+struct commit *lookup_commit_reference(const struct object_id *oid)
 {
-	return lookup_commit_reference_gently(sha1, 0);
+	return lookup_commit_reference_gently(oid, 0);
 }
 
-struct commit *lookup_commit_or_die(const unsigned char *sha1, const char *ref_name)
+struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name)
 {
-	struct commit *c = lookup_commit_reference(sha1);
+	struct commit *c = lookup_commit_reference(oid);
 	if (!c)
 		die(_("could not parse %s"), ref_name);
-	if (hashcmp(sha1, c->object.oid.hash)) {
+	if (oidcmp(oid, &c->object.oid)) {
 		warning(_("%s %s is not a commit!"),
-			ref_name, sha1_to_hex(sha1));
+			ref_name, oid_to_hex(oid));
 	}
 	return c;
 }
 
-struct commit *lookup_commit(const unsigned char *sha1)
+struct commit *lookup_commit(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(sha1);
+	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(sha1, alloc_commit_node());
+		return create_object(oid->hash, alloc_commit_node());
 	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
@@ -60,7 +60,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 
 	if (get_sha1_committish(name, oid.hash))
 		return NULL;
-	commit = lookup_commit_reference(oid.hash);
+	commit = lookup_commit_reference(&oid);
 	if (parse_commit(commit))
 		return NULL;
 	return commit;
@@ -350,7 +350,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		 */
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
-		new_parent = lookup_commit(parent.hash);
+		new_parent = lookup_commit(&parent);
 		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
@@ -358,7 +358,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
-			new_parent = lookup_commit(graft->parent[i].hash);
+			new_parent = lookup_commit(&graft->parent[i]);
 			if (!new_parent)
 				continue;
 			pptr = &commit_list_insert(new_parent, pptr)->next;
@@ -562,7 +562,7 @@ void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark)
 
 	for (i = 0; i < a->nr; i++) {
 		object = a->objects[i].item;
-		commit = lookup_commit_reference_gently(object->oid.hash, 1);
+		commit = lookup_commit_reference_gently(&object->oid, 1);
 		if (commit)
 			clear_commit_marks(commit, mark);
 	}
diff --git a/commit.h b/commit.h
index 884177b8f..3488a285b 100644
--- a/commit.h
+++ b/commit.h
@@ -45,18 +45,18 @@ enum decoration_type {
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
-struct commit *lookup_commit(const unsigned char *sha1);
-struct commit *lookup_commit_reference(const unsigned char *sha1);
-struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
+struct commit *lookup_commit(const struct object_id *oid);
+struct commit *lookup_commit_reference(const struct object_id *oid);
+struct commit *lookup_commit_reference_gently(const struct object_id *oid,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
 
 /*
- * Look up object named by "sha1", dereference tag as necessary,
- * get a commit and return it. If "sha1" does not dereference to
+ * Look up object named by "oid", dereference tag as necessary,
+ * get a commit and return it. If "oid" does not dereference to
  * a commit, use ref_name to report an error and die.
  */
-struct commit *lookup_commit_or_die(const unsigned char *sha1, const char *ref_name);
+struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
 int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
diff --git a/fast-import.c b/fast-import.c
index 2706eb2fe..d5de1545b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1761,8 +1761,8 @@ static int update_branch(struct branch *b)
 	if (!force_update && !is_null_oid(&old_oid)) {
 		struct commit *old_cmit, *new_cmit;
 
-		old_cmit = lookup_commit_reference_gently(old_oid.hash, 0);
-		new_cmit = lookup_commit_reference_gently(b->oid.hash, 0);
+		old_cmit = lookup_commit_reference_gently(&old_oid, 0);
+		new_cmit = lookup_commit_reference_gently(&b->oid, 0);
 		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
 
diff --git a/fetch-pack.c b/fetch-pack.c
index d455ef97a..7ec75f278 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -483,7 +483,7 @@ static int find_common(struct fetch_pack_args *args,
 				case ACK_ready:
 				case ACK_continue: {
 					struct commit *commit =
-						lookup_commit(result_oid->hash);
+						lookup_commit(result_oid);
 					if (!commit)
 						die(_("invalid commit %s"), oid_to_hex(result_oid));
 					if (args->stateless_rpc
diff --git a/http-push.c b/http-push.c
index f3dd0a560..04568e4fb 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1569,8 +1569,9 @@ static void fetch_symref(const char *path, char **symref, struct object_id *oid)
 
 static int verify_merge_base(struct object_id *head_oid, struct ref *remote)
 {
-	struct commit *head = lookup_commit_or_die(head_oid->hash, "HEAD");
-	struct commit *branch = lookup_commit_or_die(remote->old_oid.hash, remote->name);
+	struct commit *head = lookup_commit_or_die(head_oid, "HEAD");
+	struct commit *branch = lookup_commit_or_die(&remote->old_oid,
+						     remote->name);
 
 	return in_merge_bases(branch, head);
 }
diff --git a/log-tree.c b/log-tree.c
index 4618dd04c..7fb1a85d2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -140,7 +140,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 
 static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 {
-	struct commit *commit = lookup_commit(graft->oid.hash);
+	struct commit *commit = lookup_commit(&graft->oid);
 	if (!commit)
 		return 0;
 	add_name_decoration(DECORATION_GRAFTED, "grafted", &commit->object);
diff --git a/notes-cache.c b/notes-cache.c
index 1cdd4984a..2843e9857 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -14,7 +14,7 @@ static int notes_cache_match_validity(const char *ref, const char *validity)
 	if (read_ref(ref, oid.hash) < 0)
 		return 0;
 
-	commit = lookup_commit_reference_gently(oid.hash, 1);
+	commit = lookup_commit_reference_gently(&oid, 1);
 	if (!commit)
 		return 0;
 
diff --git a/notes-merge.c b/notes-merge.c
index 06d8be9cb..6244f6af9 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -554,7 +554,7 @@ int notes_merge(struct notes_merge_options *o,
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_oid(&local_oid))
 		local = NULL; /* local_sha1 == null_sha1 indicates unborn ref */
-	else if (!(local = lookup_commit_reference(local_oid.hash)))
+	else if (!(local = lookup_commit_reference(&local_oid)))
 		die("Could not parse local commit %s (%s)",
 		    oid_to_hex(&local_oid), o->local_ref);
 	trace_printf("\tlocal commit: %.7s\n", oid_to_hex(&local_oid));
@@ -572,7 +572,7 @@ int notes_merge(struct notes_merge_options *o,
 			die("Failed to resolve remote notes ref '%s'",
 			    o->remote_ref);
 		}
-	} else if (!(remote = lookup_commit_reference(remote_oid.hash))) {
+	} else if (!(remote = lookup_commit_reference(&remote_oid))) {
 		die("Could not parse remote commit %s (%s)",
 		    oid_to_hex(&remote_oid), o->remote_ref);
 	}
diff --git a/notes-utils.c b/notes-utils.c
index 36c1490aa..325ff3daa 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -18,7 +18,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		/* Deduce parent commit from t->ref */
 		struct object_id parent_oid;
 		if (!read_ref(t->ref, parent_oid.hash)) {
-			struct commit *parent = lookup_commit(parent_oid.hash);
+			struct commit *parent = lookup_commit(&parent_oid);
 			if (parse_commit(parent))
 				die("Failed to find/parse commit %s", t->ref);
 			commit_list_insert(parent, &parents);
diff --git a/object.c b/object.c
index e680d881a..fe2222356 100644
--- a/object.c
+++ b/object.c
@@ -182,9 +182,12 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 
 struct object *parse_object_buffer(const unsigned char *sha1, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
+	struct object_id oid;
 	struct object *obj;
 	*eaten_p = 0;
 
+	hashcpy(oid.hash, sha1);
+
 	obj = NULL;
 	if (type == OBJ_BLOB) {
 		struct blob *blob = lookup_blob(sha1);
@@ -206,7 +209,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 			}
 		}
 	} else if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(sha1);
+		struct commit *commit = lookup_commit(&oid);
 		if (commit) {
 			if (parse_commit_buffer(commit, buffer, size))
 				return NULL;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 35a941fdd..8dd57cf6e 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -87,7 +87,7 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 		return -1;
 	if (get_oid(arg, &oid))
 		return error("malformed object name %s", arg);
-	commit = lookup_commit_reference(oid.hash);
+	commit = lookup_commit_reference(&oid);
 	if (!commit)
 		return error("no such commit %s", arg);
 	commit_list_insert(commit, opt->value);
diff --git a/ref-filter.c b/ref-filter.c
index 47cce0a18..e1d18ac0d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1782,7 +1782,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * non-commits early. The actual filtering is done later.
 	 */
 	if (filter->merge_commit || filter->with_commit || filter->no_commit || filter->verbose) {
-		commit = lookup_commit_reference_gently(oid->hash, 1);
+		commit = lookup_commit_reference_gently(oid, 1);
 		if (!commit)
 			return 0;
 		/* We perform the filtering for the '--contains' option... */
@@ -2108,7 +2108,7 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 	if (get_oid(arg, &oid))
 		die(_("malformed object name %s"), arg);
 
-	rf->merge_commit = lookup_commit_reference_gently(oid.hash, 0);
+	rf->merge_commit = lookup_commit_reference_gently(&oid, 0);
 	if (!rf->merge_commit)
 		return opterror(opt, "must point to a commit", 0);
 
diff --git a/remote.c b/remote.c
index 801137c72..bf9a47d95 100644
--- a/remote.c
+++ b/remote.c
@@ -1296,7 +1296,7 @@ static void add_to_tips(struct tips *tips, const struct object_id *oid)
 
 	if (is_null_oid(oid))
 		return;
-	commit = lookup_commit_reference_gently(oid->hash, 1);
+	commit = lookup_commit_reference_gently(oid, 1);
 	if (!commit || (commit->object.flags & TMP_MARK))
 		return;
 	commit->object.flags |= TMP_MARK;
@@ -1358,7 +1358,8 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 
 			if (is_null_oid(&ref->new_oid))
 				continue;
-			commit = lookup_commit_reference_gently(ref->new_oid.hash, 1);
+			commit = lookup_commit_reference_gently(&ref->new_oid,
+								1);
 			if (!commit)
 				/* not pushing a commit, which is not an error */
 				continue;
@@ -1585,8 +1586,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
 			else if (!has_object_file(&ref->old_oid))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
-			else if (!lookup_commit_reference_gently(ref->old_oid.hash, 1) ||
-				 !lookup_commit_reference_gently(ref->new_oid.hash, 1))
+			else if (!lookup_commit_reference_gently(&ref->old_oid, 1) ||
+				 !lookup_commit_reference_gently(&ref->new_oid, 1))
 				reject_reason = REF_STATUS_REJECT_NEEDS_FORCE;
 			else if (!ref_newer(&ref->new_oid, &ref->old_oid))
 				reject_reason = REF_STATUS_REJECT_NONFASTFORWARD;
@@ -2009,13 +2010,13 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	/* Cannot stat if what we used to build on no longer exists */
 	if (read_ref(base, oid.hash))
 		return -1;
-	theirs = lookup_commit_reference(oid.hash);
+	theirs = lookup_commit_reference(&oid);
 	if (!theirs)
 		return -1;
 
 	if (read_ref(branch->refname, oid.hash))
 		return -1;
-	ours = lookup_commit_reference(oid.hash);
+	ours = lookup_commit_reference(&oid);
 	if (!ours)
 		return -1;
 
diff --git a/revision.c b/revision.c
index 945367034..f8e0dee6d 100644
--- a/revision.c
+++ b/revision.c
@@ -1395,10 +1395,10 @@ static void prepare_show_merge(struct rev_info *revs)
 
 	if (get_oid("HEAD", &oid))
 		die("--merge without HEAD?");
-	head = lookup_commit_or_die(oid.hash, "HEAD");
+	head = lookup_commit_or_die(&oid, "HEAD");
 	if (get_oid("MERGE_HEAD", &oid))
 		die("--merge without MERGE_HEAD?");
-	other = lookup_commit_or_die(oid.hash, "MERGE_HEAD");
+	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
 	bases = get_merge_bases(head, other);
@@ -1500,10 +1500,10 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 				a = (a_obj->type == OBJ_COMMIT
 				     ? (struct commit *)a_obj
-				     : lookup_commit_reference(a_obj->oid.hash));
+				     : lookup_commit_reference(&a_obj->oid));
 				b = (b_obj->type == OBJ_COMMIT
 				     ? (struct commit *)b_obj
-				     : lookup_commit_reference(b_obj->oid.hash));
+				     : lookup_commit_reference(&b_obj->oid));
 				if (!a || !b)
 					goto missing;
 				exclude = get_merge_bases(a, b);
diff --git a/sequencer.c b/sequencer.c
index e0d0e98a4..e98a896d7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -488,7 +488,7 @@ static int is_index_unchanged(void)
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
 		return error(_("could not resolve HEAD commit\n"));
 
-	head_commit = lookup_commit(head_oid.hash);
+	head_commit = lookup_commit(&head_oid);
 
 	/*
 	 * If head_commit is NULL, check_commit, called from
@@ -841,7 +841,7 @@ static int update_squash_messages(enum todo_command command,
 
 		if (get_oid("HEAD", &head))
 			return error(_("need a HEAD to fixup"));
-		if (!(head_commit = lookup_commit_reference(head.hash)))
+		if (!(head_commit = lookup_commit_reference(&head)))
 			return error(_("could not read HEAD"));
 		if (!(head_message = get_commit_buffer(head_commit, NULL)))
 			return error(_("could not read HEAD's commit message"));
@@ -1279,7 +1279,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	if (status < 0)
 		return -1;
 
-	item->commit = lookup_commit_reference(commit_oid.hash);
+	item->commit = lookup_commit_reference(&commit_oid);
 	return !item->commit;
 }
 
@@ -2275,7 +2275,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 			continue;
 
 		if (!get_oid(name, &oid)) {
-			if (!lookup_commit_reference_gently(oid.hash, 1)) {
+			if (!lookup_commit_reference_gently(&oid, 1)) {
 				enum object_type type = sha1_object_info(oid.hash, NULL);
 				return error(_("%s: can't cherry-pick a %s"),
 					name, typename(type));
diff --git a/sha1_name.c b/sha1_name.c
index 8889190a9..390a09c41 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -354,7 +354,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 
 	type = sha1_object_info(oid->hash, NULL);
 	if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(oid->hash);
+		struct commit *commit = lookup_commit(oid);
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
@@ -729,7 +729,7 @@ static int get_parent(const char *name, int len,
 
 	if (ret)
 		return ret;
-	commit = lookup_commit_reference(oid.hash);
+	commit = lookup_commit_reference(&oid);
 	if (parse_commit(commit))
 		return -1;
 	if (!idx) {
@@ -757,7 +757,7 @@ static int get_nth_ancestor(const char *name, int len,
 	ret = get_sha1_1(name, len, oid.hash, GET_SHA1_COMMITTISH);
 	if (ret)
 		return ret;
-	commit = lookup_commit_reference(oid.hash);
+	commit = lookup_commit_reference(&oid);
 	if (!commit)
 		return -1;
 
@@ -1136,13 +1136,13 @@ int get_oid_mb(const char *name, struct object_id *oid)
 	}
 	if (st)
 		return st;
-	one = lookup_commit_reference_gently(oid_tmp.hash, 0);
+	one = lookup_commit_reference_gently(&oid_tmp, 0);
 	if (!one)
 		return -1;
 
 	if (get_sha1_committish(dots[3] ? (dots + 3) : "HEAD", oid_tmp.hash))
 		return -1;
-	two = lookup_commit_reference_gently(oid_tmp.hash, 0);
+	two = lookup_commit_reference_gently(&oid_tmp, 0);
 	if (!two)
 		return -1;
 	mbs = get_merge_bases(one, two);
diff --git a/shallow.c b/shallow.c
index 1327ee16f..6950cc24f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -31,7 +31,7 @@ int register_shallow(const struct object_id *oid)
 {
 	struct commit_graft *graft =
 		xmalloc(sizeof(struct commit_graft));
-	struct commit *commit = lookup_commit(oid->hash);
+	struct commit *commit = lookup_commit(oid);
 
 	oidcpy(&graft->oid, oid);
 	graft->nr_parent = -1;
@@ -241,7 +241,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	if (graft->nr_parent != -1)
 		return 0;
 	if (data->flags & SEEN_ONLY) {
-		struct commit *c = lookup_commit(graft->oid.hash);
+		struct commit *c = lookup_commit(&graft->oid);
 		if (!c || !(c->object.flags & SEEN)) {
 			if (data->flags & VERBOSE)
 				printf("Removing %s from .git/shallow\n",
@@ -475,7 +475,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
 	uint32_t *tmp = xmalloc(bitmap_size); /* to be freed before return */
 	uint32_t *bitmap = paint_alloc(info);
-	struct commit *c = lookup_commit_reference_gently(oid->hash, 1);
+	struct commit *c = lookup_commit_reference_gently(oid, 1);
 	if (!c)
 		return;
 	memset(bitmap, 0, bitmap_size);
@@ -531,7 +531,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 static int mark_uninteresting(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(oid->hash, 1);
+	struct commit *commit = lookup_commit_reference_gently(oid, 1);
 	if (!commit)
 		return 0;
 	commit->object.flags |= UNINTERESTING;
@@ -599,7 +599,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 
 	/* Mark potential bottoms so we won't go out of bound */
 	for (i = 0; i < nr_shallow; i++) {
-		struct commit *c = lookup_commit(oid[shallow[i]].hash);
+		struct commit *c = lookup_commit(&oid[shallow[i]]);
 		c->object.flags |= BOTTOM;
 	}
 
@@ -610,7 +610,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 		int bitmap_size = ((pi.nr_bits + 31) / 32) * sizeof(uint32_t);
 		memset(used, 0, sizeof(*used) * info->shallow->nr);
 		for (i = 0; i < nr_shallow; i++) {
-			const struct commit *c = lookup_commit(oid[shallow[i]].hash);
+			const struct commit *c = lookup_commit(&oid[shallow[i]]);
 			uint32_t **map = ref_bitmap_at(&pi.ref_bitmap, c);
 			if (*map)
 				used[shallow[i]] = xmemdupz(*map, bitmap_size);
@@ -641,7 +641,7 @@ static int add_ref(const char *refname, const struct object_id *oid,
 {
 	struct commit_array *ca = cb_data;
 	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
-	ca->commits[ca->nr] = lookup_commit_reference_gently(oid->hash, 1);
+	ca->commits[ca->nr] = lookup_commit_reference_gently(oid, 1);
 	if (ca->commits[ca->nr])
 		ca->nr++;
 	return 0;
@@ -679,7 +679,7 @@ static void post_assign_shallow(struct shallow_info *info,
 	for (i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
-		c = lookup_commit(oid[info->theirs[i]].hash);
+		c = lookup_commit(&oid[info->theirs[i]]);
 		bitmap = ref_bitmap_at(ref_bitmap, c);
 		if (!*bitmap)
 			continue;
@@ -700,7 +700,7 @@ static void post_assign_shallow(struct shallow_info *info,
 	for (i = dst = 0; i < info->nr_ours; i++) {
 		if (i != dst)
 			info->ours[dst] = info->ours[i];
-		c = lookup_commit(oid[info->ours[i]].hash);
+		c = lookup_commit(&oid[info->ours[i]]);
 		bitmap = ref_bitmap_at(ref_bitmap, c);
 		if (!*bitmap)
 			continue;
@@ -722,7 +722,7 @@ static void post_assign_shallow(struct shallow_info *info,
 int delayed_reachability_test(struct shallow_info *si, int c)
 {
 	if (si->need_reachability_test[c]) {
-		struct commit *commit = lookup_commit(si->shallow->oid[c].hash);
+		struct commit *commit = lookup_commit(&si->shallow->oid[c]);
 
 		if (!si->commits) {
 			struct commit_array ca;
diff --git a/submodule.c b/submodule.c
index d5c28b9f1..ba5429be1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -447,8 +447,8 @@ static void show_submodule_header(FILE *f, const char *path,
 	 * Attempt to lookup the commit references, and determine if this is
 	 * a fast forward or fast backwards update.
 	 */
-	*left = lookup_commit_reference(one->hash);
-	*right = lookup_commit_reference(two->hash);
+	*left = lookup_commit_reference(one);
+	*right = lookup_commit_reference(two);
 
 	/*
 	 * Warn about missing commits in the submodule project, but only if
@@ -634,7 +634,7 @@ static int check_has_commit(const struct object_id *oid, void *data)
 {
 	int *has_commit = data;
 
-	if (!lookup_commit_reference(oid->hash))
+	if (!lookup_commit_reference(oid))
 		*has_commit = 0;
 
 	return 0;
@@ -899,7 +899,7 @@ int push_unpushed_submodules(struct oid_array *commits,
 static int is_submodule_commit_present(const char *path, struct object_id *oid)
 {
 	int is_present = 0;
-	if (!add_submodule_odb(path) && lookup_commit_reference(oid->hash)) {
+	if (!add_submodule_odb(path) && lookup_commit_reference(oid)) {
 		/* Even if the submodule is checked out and the commit is
 		 * present, make sure it is reachable from a ref. */
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -1592,9 +1592,9 @@ int merge_submodule(struct object_id *result, const char *path,
 		return 0;
 	}
 
-	if (!(commit_base = lookup_commit_reference(base->hash)) ||
-	    !(commit_a = lookup_commit_reference(a->hash)) ||
-	    !(commit_b = lookup_commit_reference(b->hash))) {
+	if (!(commit_base = lookup_commit_reference(base)) ||
+	    !(commit_a = lookup_commit_reference(a)) ||
+	    !(commit_b = lookup_commit_reference(b))) {
 		MERGE_WARNING(path, "commits not present");
 		return 0;
 	}
diff --git a/tag.c b/tag.c
index 625f5cd71..79b78d358 100644
--- a/tag.c
+++ b/tag.c
@@ -146,7 +146,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	} else if (!strcmp(type, tree_type)) {
 		item->tagged = &lookup_tree(oid.hash)->object;
 	} else if (!strcmp(type, commit_type)) {
-		item->tagged = &lookup_commit(oid.hash)->object;
+		item->tagged = &lookup_commit(&oid)->object;
 	} else if (!strcmp(type, tag_type)) {
 		item->tagged = &lookup_tag(oid.hash)->object;
 	} else {
diff --git a/tree.c b/tree.c
index ce345c551..33fa7ee71 100644
--- a/tree.c
+++ b/tree.c
@@ -91,7 +91,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		else if (S_ISGITLINK(entry.mode)) {
 			struct commit *commit;
 
-			commit = lookup_commit(entry.oid->hash);
+			commit = lookup_commit(entry.oid);
 			if (!commit)
 				die("Commit %s in submodule path %s%s not found",
 				    oid_to_hex(entry.oid),
diff --git a/walker.c b/walker.c
index 2c86e406f..b499fcb72 100644
--- a/walker.c
+++ b/walker.c
@@ -206,7 +206,7 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 static int mark_complete(const char *path, const struct object_id *oid,
 			 int flag, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(oid->hash, 1);
+	struct commit *commit = lookup_commit_reference_gently(oid, 1);
 
 	if (commit) {
 		commit->object.flags |= COMPLETE;
diff --git a/wt-status.c b/wt-status.c
index 037548496..e5854ba6f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1428,7 +1428,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	    /* sha1 is a commit? match without further lookup */
 	    (!oidcmp(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-	     ((commit = lookup_commit_reference_gently(oid.hash, 1)) != NULL &&
+	     ((commit = lookup_commit_reference_gently(&oid, 1)) != NULL &&
 	      !oidcmp(&cb.noid, &commit->object.oid)))) {
 		const char *from = ref;
 		if (!skip_prefix(from, "refs/tags/", &from))
