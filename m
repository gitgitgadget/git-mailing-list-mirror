Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE0F201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbdGCS4j (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:56:39 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53018 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753307AbdGCSzv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9B789280B8;
        Mon,  3 Jul 2017 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108148;
        bh=A90Xm3ehj6o7pf7cCBWA0K0ObAIyjE3JdmSJNsHLgG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNg8QkQx9sTYrNK74fUcRapyp12MNNfXuYvoC0Xep44yySQoHVRYNqWPsqn4zR1ts
         MqSd5ztProvva4MkTtlzS7GI4leJLNqnSV4H8ny/hUJ+oVxAIoEpaOQr13u7oRlQ5D
         rgRg32qDGg7eDBM9ZpV/wWiotzeLjx/2VMgIrIwmYQq+uZEQUe+KI89ds0/EuNvWN+
         QsmB5zFTyldoWeSlkjRLfxgdwCba5eyClTIsnGGfszB/bKcl0b96BvFutVxR5Rcy7v
         u9iyjupXS39Ue4DR6XPGrfSwpihqhE9mYM+ALHaLJjNzthXyDMn70ZNlabZI9ASZbd
         2vupt8SV+ctMsxy+aipSifB17JDVh7BEy63K7UhLfoovPddhemXHMsa1bdYJjMLmxG
         4BxIT5JkQ6FvH6YJJeJr++faWs/YEg+SeG9zfolg4TIoysSZRwDNwdSpa4BGUo8PDl
         r1+r98JmTIwvxFNl4wyCaMLRDs4gWVruzuvHG/Bl1eVmyV1zuu9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 11/12] sha1_name: convert get_sha1* to get_oid*
Date:   Mon,  3 Jul 2017 18:55:32 +0000
Message-Id: <20170703185533.51530-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that all the callers of get_sha1 directly or indirectly use struct
object_id, rename the functions starting with get_sha1 to start with
get_oid.  Convert the internals in sha1_name.c to use struct object_id
as well, and eliminate explicit length checks where possible.

Outside of sha1_name.c and cache.h, this transition was made with the
following semantic patch:

@@
expression E1, E2;
@@
- get_sha1(E1, E2.hash)
+ get_oid(E1, &E2)

@@
expression E1, E2;
@@
- get_sha1(E1, E2->hash)
+ get_oid(E1, E2)

@@
expression E1, E2;
@@
- get_sha1_committish(E1, E2.hash)
+ get_oid_committish(E1, &E2)

@@
expression E1, E2;
@@
- get_sha1_committish(E1, E2->hash)
+ get_oid_committish(E1, E2)

@@
expression E1, E2;
@@
- get_sha1_treeish(E1, E2.hash)
+ get_oid_treeish(E1, &E2)

@@
expression E1, E2;
@@
- get_sha1_treeish(E1, E2->hash)
+ get_oid_treeish(E1, E2)

@@
expression E1, E2;
@@
- get_sha1_commit(E1, E2.hash)
+ get_oid_commit(E1, &E2)

@@
expression E1, E2;
@@
- get_sha1_commit(E1, E2->hash)
+ get_oid_commit(E1, E2)

@@
expression E1, E2;
@@
- get_sha1_tree(E1, E2.hash)
+ get_oid_tree(E1, &E2)

@@
expression E1, E2;
@@
- get_sha1_tree(E1, E2->hash)
+ get_oid_tree(E1, E2)

@@
expression E1, E2;
@@
- get_sha1_blob(E1, E2.hash)
+ get_oid_blob(E1, &E2)

@@
expression E1, E2;
@@
- get_sha1_blob(E1, E2->hash)
+ get_oid_blob(E1, E2)

@@
expression E1, E2, E3, E4;
@@
- get_sha1_with_context(E1, E2, E3.hash, E4)
+ get_oid_with_context(E1, E2, &E3, E4)

@@
expression E1, E2, E3, E4;
@@
- get_sha1_with_context(E1, E2, E3->hash, E4)
+ get_oid_with_context(E1, E2, E3, E4)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 apply.c               |   4 +-
 archive.c             |   2 +-
 builtin/am.c          |   6 +-
 builtin/cat-file.c    |   6 +-
 builtin/commit-tree.c |   4 +-
 builtin/commit.c      |   8 +--
 builtin/grep.c        |   4 +-
 builtin/log.c         |   4 +-
 builtin/replace.c     |   4 +-
 builtin/reset.c       |  10 +--
 builtin/rev-parse.c   |   6 +-
 builtin/show-branch.c |   8 +--
 cache.h               |  17 +++--
 commit.c              |   4 +-
 notes.c               |   2 +-
 remote.c              |   2 +-
 revision.c            |  10 +--
 sequencer.c           |   6 +-
 sha1_name.c           | 190 ++++++++++++++++++++++++--------------------------
 transport-helper.c    |   2 +-
 20 files changed, 145 insertions(+), 154 deletions(-)

diff --git a/apply.c b/apply.c
index c442b8932..58d7d5dc5 100644
--- a/apply.c
+++ b/apply.c
@@ -3553,7 +3553,7 @@ static int try_threeway(struct apply_state *state,
 	/* Preimage the patch was prepared for */
 	if (patch->is_new)
 		write_sha1_file("", 0, blob_type, pre_oid.hash);
-	else if (get_sha1(patch->old_sha1_prefix, pre_oid.hash) ||
+	else if (get_oid(patch->old_sha1_prefix, &pre_oid) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
 		return error(_("repository lacks the necessary blob to fall back on 3-way merge."));
 
@@ -4077,7 +4077,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			else
 				return error(_("sha1 information is lacking or "
 					       "useless for submodule %s"), name);
-		} else if (!get_sha1_blob(patch->old_sha1_prefix, oid.hash)) {
+		} else if (!get_oid_blob(patch->old_sha1_prefix, &oid)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
diff --git a/archive.c b/archive.c
index 60b3035a7..557dd2db8 100644
--- a/archive.c
+++ b/archive.c
@@ -358,7 +358,7 @@ static void parse_treeish_arg(const char **argv,
 		free(ref);
 	}
 
-	if (get_sha1(name, oid.hash))
+	if (get_oid(name, &oid))
 		die("Not a valid object name");
 
 	commit = lookup_commit_reference_gently(&oid, 1);
diff --git a/builtin/am.c b/builtin/am.c
index c973bd96d..40cc6d6fe 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1131,7 +1131,7 @@ static int index_has_changes(struct strbuf *sb)
 	struct object_id head;
 	int i;
 
-	if (!get_sha1_tree("HEAD", head.hash)) {
+	if (!get_oid_tree("HEAD", &head)) {
 		struct diff_options opt;
 
 		diff_setup(&opt);
@@ -1432,7 +1432,7 @@ static void write_index_patch(const struct am_state *state)
 	struct rev_info rev_info;
 	FILE *fp;
 
-	if (!get_sha1_tree("HEAD", head.hash))
+	if (!get_oid_tree("HEAD", &head))
 		tree = lookup_tree(&head);
 	else
 		tree = lookup_tree(&empty_tree_oid);
@@ -1661,7 +1661,7 @@ static void do_commit(const struct am_state *state)
 	if (write_cache_as_tree(tree.hash, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
-	if (!get_sha1_commit("HEAD", parent.hash)) {
+	if (!get_oid_commit("HEAD", &parent)) {
 		old_oid = &parent;
 		commit_list_insert(lookup_commit(&parent), &parents);
 	} else {
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7efbc4019..695168a98 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -63,8 +63,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	if (unknown_type)
 		flags |= LOOKUP_UNKNOWN_OBJECT;
 
-	if (get_sha1_with_context(obj_name, GET_SHA1_RECORD_PATH,
-				  oid.hash, &obj_context))
+	if (get_oid_with_context(obj_name, GET_SHA1_RECORD_PATH,
+				 &oid, &obj_context))
 		die("Not a valid object name %s", obj_name);
 
 	if (!path)
@@ -363,7 +363,7 @@ static void batch_one_object(const char *obj_name, struct batch_options *opt,
 	int flags = opt->follow_symlinks ? GET_SHA1_FOLLOW_SYMLINKS : 0;
 	enum follow_symlinks_result result;
 
-	result = get_sha1_with_context(obj_name, flags, data->oid.hash, &ctx);
+	result = get_oid_with_context(obj_name, flags, &data->oid, &ctx);
 	if (result != FOUND) {
 		switch (result) {
 		case MISSING_OBJECT:
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index a4a923d7c..19e898fa4 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -56,7 +56,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			struct object_id oid;
 			if (argc <= ++i)
 				usage(commit_tree_usage);
-			if (get_sha1_commit(argv[i], oid.hash))
+			if (get_oid_commit(argv[i], &oid))
 				die("Not a valid object name %s", argv[i]);
 			assert_sha1_type(oid.hash, OBJ_COMMIT);
 			new_parent(lookup_commit(&oid), &parents);
@@ -106,7 +106,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (get_sha1_tree(arg, tree_oid.hash))
+		if (get_oid_tree(arg, &tree_oid))
 			die("Not a valid object name %s", arg);
 		if (got_tree)
 			die("Cannot give more than one trees");
diff --git a/builtin/commit.c b/builtin/commit.c
index 03b97c644..3bbff350f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -511,7 +511,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->index_file = index_file;
 	s->fp = fp;
 	s->nowarn = nowarn;
-	s->is_initial = get_sha1(s->reference, oid.hash) ? 1 : 0;
+	s->is_initial = get_oid(s->reference, &oid) ? 1 : 0;
 	if (!s->is_initial)
 		hashcpy(s->sha1_commit, oid.hash);
 	s->status_format = status_format;
@@ -896,7 +896,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (amend)
 			parent = "HEAD^1";
 
-		if (get_sha1(parent, oid.hash)) {
+		if (get_oid(parent, &oid)) {
 			int i, ita_nr = 0;
 
 			for (i = 0; i < active_nr; i++)
@@ -1394,7 +1394,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	fd = hold_locked_index(&index_lock, 0);
 
-	s.is_initial = get_sha1(s.reference, oid.hash) ? 1 : 0;
+	s.is_initial = get_oid(s.reference, &oid) ? 1 : 0;
 	if (!s.is_initial)
 		hashcpy(s.sha1_commit, oid.hash);
 
@@ -1664,7 +1664,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
-	if (get_sha1("HEAD", oid.hash))
+	if (get_oid("HEAD", &oid))
 		current_head = NULL;
 	else {
 		current_head = lookup_commit_or_die(&oid, "HEAD");
diff --git a/builtin/grep.c b/builtin/grep.c
index 397b5f049..a309ab7c2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1206,8 +1206,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
-		if (get_sha1_with_context(arg, GET_SHA1_RECORD_PATH,
-					  oid.hash, &oc)) {
+		if (get_oid_with_context(arg, GET_SHA1_RECORD_PATH,
+					 &oid, &oc)) {
 			if (seen_dashdash)
 				die(_("unable to resolve revision: %s"), arg);
 			break;
diff --git a/builtin/log.c b/builtin/log.c
index 8ca1de989..60fac9d4d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -484,8 +484,8 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
 		return stream_blob_to_fd(1, oid, NULL, 0);
 
-	if (get_sha1_with_context(obj_name, GET_SHA1_RECORD_PATH,
-				  oidc.hash, &obj_context))
+	if (get_oid_with_context(obj_name, GET_SHA1_RECORD_PATH,
+				 &oidc, &obj_context))
 		die(_("Not a valid object name %s"), obj_name);
 	if (!obj_context.path ||
 	    !textconv_object(obj_context.path, obj_context.mode, &oidc, 1, &buf, &size)) {
diff --git a/builtin/replace.c b/builtin/replace.c
index 80a15cf35..210d930c8 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -50,7 +50,7 @@ static int show_reference(const char *refname, const struct object_id *oid,
 			struct object_id object;
 			enum object_type obj_type, repl_type;
 
-			if (get_sha1(refname, object.hash))
+			if (get_oid(refname, &object))
 				return error("Failed to resolve '%s' as a valid ref.", refname);
 
 			obj_type = sha1_object_info(object.hash, NULL);
@@ -365,7 +365,7 @@ static void check_one_mergetag(struct commit *commit,
 	/* iterate over new parents */
 	for (i = 1; i < mergetag_data->argc; i++) {
 		struct object_id oid;
-		if (get_sha1(mergetag_data->argv[i], oid.hash) < 0)
+		if (get_oid(mergetag_data->argv[i], &oid) < 0)
 			die(_("Not a valid object name: '%s'"), mergetag_data->argv[i]);
 		if (!oidcmp(&tag->tagged->oid, &oid))
 			return; /* found */
diff --git a/builtin/reset.c b/builtin/reset.c
index 7aeaea273..046403ed6 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -219,8 +219,8 @@ static void parse_args(struct pathspec *pathspec,
 		 * has to be unambiguous. If there is a single argument, it
 		 * can not be a tree
 		 */
-		else if ((!argv[1] && !get_sha1_committish(argv[0], unused.hash)) ||
-			 (argv[1] && !get_sha1_treeish(argv[0], unused.hash))) {
+		else if ((!argv[1] && !get_oid_committish(argv[0], &unused)) ||
+			 (argv[1] && !get_oid_treeish(argv[0], &unused))) {
 			/*
 			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
@@ -310,13 +310,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	load_submodule_cache();
 
-	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", oid.hash);
+	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
 		hashcpy(oid.hash, EMPTY_TREE_SHA1_BIN);
 	} else if (!pathspec.nr) {
 		struct commit *commit;
-		if (get_sha1_committish(rev, oid.hash))
+		if (get_oid_committish(rev, &oid))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
 		commit = lookup_commit_reference(&oid);
 		if (!commit)
@@ -324,7 +324,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		oidcpy(&oid, &commit->object.oid);
 	} else {
 		struct tree *tree;
-		if (get_sha1_treeish(rev, oid.hash))
+		if (get_oid_treeish(rev, &oid))
 			die(_("Failed to resolve '%s' as a valid tree."), rev);
 		tree = parse_tree_indirect(&oid);
 		if (!tree)
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c78b7b33d..041b7898c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -274,7 +274,7 @@ static int try_difference(const char *arg)
 		return 0;
 	}
 
-	if (!get_sha1_committish(this, oid.hash) && !get_sha1_committish(next, end.hash)) {
+	if (!get_oid_committish(this, &oid) && !get_oid_committish(next, &end)) {
 		show_rev(NORMAL, &end, next);
 		show_rev(symmetric ? NORMAL : REVERSED, &oid, this);
 		if (symmetric) {
@@ -328,7 +328,7 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 
 	*dotdot = 0;
-	if (get_sha1_committish(arg, oid.hash)) {
+	if (get_oid_committish(arg, &oid)) {
 		*dotdot = '^';
 		return 0;
 	}
@@ -911,7 +911,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			name++;
 			type = REVERSED;
 		}
-		if (!get_sha1_with_context(name, flags, oid.hash, &unused)) {
+		if (!get_oid_with_context(name, flags, &oid, &unused)) {
 			if (verify)
 				revs_count++;
 			else
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 527f69e28..c2a399985 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -393,7 +393,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_sha1(refname + ofs, tmp.hash) || oidcmp(&tmp, oid))
+	if (get_oid(refname + ofs, &tmp) || oidcmp(&tmp, oid))
 		ofs = 5;
 	return append_ref(refname + ofs, oid, 0);
 }
@@ -408,7 +408,7 @@ static int append_remote_ref(const char *refname, const struct object_id *oid,
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_sha1(refname + ofs, tmp.hash) || oidcmp(&tmp, oid))
+	if (get_oid(refname + ofs, &tmp) || oidcmp(&tmp, oid))
 		ofs = 5;
 	return append_ref(refname + ofs, oid, 0);
 }
@@ -514,7 +514,7 @@ static int show_independent(struct commit **rev,
 static void append_one_rev(const char *av)
 {
 	struct object_id revkey;
-	if (!get_sha1(av, revkey.hash)) {
+	if (!get_oid(av, &revkey)) {
 		append_ref(av, &revkey, 0);
 		return;
 	}
@@ -808,7 +808,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			die(Q_("cannot handle more than %d rev.",
 			       "cannot handle more than %d revs.",
 			       MAX_REVS), MAX_REVS);
-		if (get_sha1(ref_name[num_rev], revkey.hash))
+		if (get_oid(ref_name[num_rev], &revkey))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
 		commit = lookup_commit_reference(&revkey);
 		if (!commit)
diff --git a/cache.h b/cache.h
index 96055c222..c68f44e10 100644
--- a/cache.h
+++ b/cache.h
@@ -1373,16 +1373,15 @@ struct object_context {
 	GET_SHA1_TREE | GET_SHA1_TREEISH | \
 	GET_SHA1_BLOB)
 
-extern int get_sha1(const char *str, unsigned char *sha1);
-extern int get_sha1_commit(const char *str, unsigned char *sha1);
-extern int get_sha1_committish(const char *str, unsigned char *sha1);
-extern int get_sha1_tree(const char *str, unsigned char *sha1);
-extern int get_sha1_treeish(const char *str, unsigned char *sha1);
-extern int get_sha1_blob(const char *str, unsigned char *sha1);
-extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
-extern int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *oc);
-
 extern int get_oid(const char *str, struct object_id *oid);
+extern int get_oid_commit(const char *str, struct object_id *oid);
+extern int get_oid_committish(const char *str, struct object_id *oid);
+extern int get_oid_tree(const char *str, struct object_id *oid);
+extern int get_oid_treeish(const char *str, struct object_id *oid);
+extern int get_oid_blob(const char *str, struct object_id *oid);
+extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
+extern int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc);
+
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
 extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
diff --git a/commit.c b/commit.c
index cbfd68993..d29c997e7 100644
--- a/commit.c
+++ b/commit.c
@@ -59,7 +59,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	struct object_id oid;
 	struct commit *commit;
 
-	if (get_sha1_committish(name, oid.hash))
+	if (get_oid_committish(name, &oid))
 		return NULL;
 	commit = lookup_commit_reference(&oid);
 	if (parse_commit(commit))
@@ -1587,7 +1587,7 @@ struct commit *get_merge_parent(const char *name)
 	struct object *obj;
 	struct commit *commit;
 	struct object_id oid;
-	if (get_sha1(name, oid.hash))
+	if (get_oid(name, &oid))
 		return NULL;
 	obj = parse_object(&oid);
 	commit = (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
diff --git a/notes.c b/notes.c
index 8f47c202c..503754d79 100644
--- a/notes.c
+++ b/notes.c
@@ -1026,7 +1026,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->dirty = 0;
 
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
-	    get_sha1_treeish(notes_ref, object_oid.hash))
+	    get_oid_treeish(notes_ref, &object_oid))
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, object_oid.hash))
 		die("Cannot use notes ref %s", notes_ref);
diff --git a/remote.c b/remote.c
index 9da9040bf..2fb0895e4 100644
--- a/remote.c
+++ b/remote.c
@@ -1078,7 +1078,7 @@ static int try_explicit_object_name(const char *name,
 		return 0;
 	}
 
-	if (get_sha1(name, oid.hash))
+	if (get_oid(name, &oid))
 		return -1;
 
 	if (match) {
diff --git a/revision.c b/revision.c
index e181ad1b7..4813d8f0a 100644
--- a/revision.c
+++ b/revision.c
@@ -1303,7 +1303,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 		flags ^= UNINTERESTING | BOTTOM;
 		arg++;
 	}
-	if (get_sha1_committish(arg, oid.hash))
+	if (get_oid_committish(arg, &oid))
 		return 0;
 	while (1) {
 		it = get_reference(revs, arg, &oid, 0);
@@ -1467,8 +1467,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	if (!*b_name)
 		b_name = "HEAD";
 
-	if (get_sha1_with_context(a_name, oc_flags, a_oid.hash, a_oc) ||
-	    get_sha1_with_context(b_name, oc_flags, b_oid.hash, b_oc))
+	if (get_oid_with_context(a_name, oc_flags, &a_oid, a_oc) ||
+	    get_oid_with_context(b_name, oc_flags, &b_oid, b_oc))
 		return -1;
 
 	if (!cant_be_filename) {
@@ -1602,7 +1602,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags |= GET_SHA1_COMMITTISH;
 
-	if (get_sha1_with_context(arg, get_sha1_flags, oid.hash, &oc))
+	if (get_oid_with_context(arg, get_sha1_flags, &oid, &oc))
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
@@ -2321,7 +2321,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		struct object_id oid;
 		struct object *object;
 		struct object_context oc;
-		if (get_sha1_with_context(revs->def, 0, oid.hash, &oc))
+		if (get_oid_with_context(revs->def, 0, &oid, &oc))
 			diagnose_missing_default(revs->def);
 		object = get_reference(revs, revs->def, &oid, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
diff --git a/sequencer.c b/sequencer.c
index 16d48a4fb..f5e85a398 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2130,8 +2130,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			log_tree_opt.disable_stdin = 1;
 
 			if (read_oneliner(&buf, rebase_path_orig_head(), 0) &&
-			    !get_sha1(buf.buf, orig.hash) &&
-			    !get_sha1("HEAD", head.hash)) {
+			    !get_oid(buf.buf, &orig) &&
+			    !get_oid("HEAD", &head)) {
 				diff_tree_oid(&orig, &head, "",
 					      &log_tree_opt.diffopt);
 				log_tree_diff_flush(&log_tree_opt);
@@ -2267,7 +2267,7 @@ int sequencer_continue(struct replay_opts *opts)
 		struct object_id oid;
 
 		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
-		    !get_sha1_committish(buf.buf, oid.hash))
+		    !get_oid_committish(buf.buf, &oid))
 			record_in_rewritten(&oid, peek_command(&todo_list, 0));
 		strbuf_release(&buf);
 	}
diff --git a/sha1_name.c b/sha1_name.c
index d2d732c19..ec8dd9a8d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -10,7 +10,7 @@
 #include "dir.h"
 #include "sha1-array.h"
 
-static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
+static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
 typedef int (*disambiguate_hint_fn)(const struct object_id *, void *);
 
@@ -191,7 +191,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 #define SHORT_NAME_AMBIGUOUS (-2)
 
 static int finish_object_disambiguation(struct disambiguate_state *ds,
-					unsigned char *sha1)
+					struct object_id *oid)
 {
 	if (ds->ambiguous)
 		return SHORT_NAME_AMBIGUOUS;
@@ -220,7 +220,7 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	if (!ds->candidate_ok)
 		return SHORT_NAME_AMBIGUOUS;
 
-	hashcpy(sha1, ds->candidate.hash);
+	oidcpy(oid, &ds->candidate);
 	return 0;
 }
 
@@ -376,7 +376,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	return 0;
 }
 
-static int get_short_sha1(const char *name, int len, unsigned char *sha1,
+static int get_short_oid(const char *name, int len, struct object_id *oid,
 			  unsigned flags)
 {
 	int status;
@@ -387,7 +387,7 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 		return -1;
 
 	if (HAS_MULTI_BITS(flags & GET_SHA1_DISAMBIGUATORS))
-		die("BUG: multiple get_short_sha1 disambiguator flags");
+		die("BUG: multiple get_short_oid disambiguator flags");
 
 	if (flags & GET_SHA1_COMMIT)
 		ds.fn = disambiguate_commit_only;
@@ -404,7 +404,7 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
-	status = finish_object_disambiguation(&ds, sha1);
+	status = finish_object_disambiguation(&ds, oid);
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
@@ -496,8 +496,8 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 		return 40;
 	exists = has_sha1_file(sha1);
 	while (len < 40) {
-		unsigned char sha1_ret[20];
-		status = get_short_sha1(hex, len, sha1_ret, GET_SHA1_QUIETLY);
+		struct object_id oid_ret;
+		status = get_short_oid(hex, len, &oid_ret, GET_SHA1_QUIETLY);
 		if (exists
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
@@ -570,10 +570,10 @@ static inline int push_mark(const char *string, int len)
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
+static int get_oid_1(const char *name, int len, struct object_id *oid, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(const char *name, int namelen, struct strbuf *buf);
 
-static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
+static int get_oid_basic(const char *str, int len, struct object_id *oid,
 			  unsigned int flags)
 {
 	static const char *warn_msg = "refname '%.*s' is ambiguous.";
@@ -587,14 +587,14 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 	"where \"$br\" is somehow empty and a 40-hex ref is created. Please\n"
 	"examine these refs and maybe delete them. Turn this message off by\n"
 	"running \"git config advice.objectNameWarning false\"");
-	unsigned char tmp_sha1[20];
+	struct object_id tmp_oid;
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len, nth_prior = 0;
 
-	if (len == 40 && !get_sha1_hex(str, sha1)) {
+	if (len == GIT_SHA1_HEXSZ && !get_oid_hex(str, oid)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
-			refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
+			refs_found = dwim_ref(str, len, tmp_oid.hash, &real_ref);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
@@ -636,7 +636,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 		int detached;
 
 		if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
-			detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
+			detached = (!get_oid_hex(buf.buf, oid));
 			strbuf_release(&buf);
 			if (detached)
 				return 0;
@@ -645,18 +645,18 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 
 	if (!len && reflog_len)
 		/* allow "@{...}" to mean the current branch reflog */
-		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
+		refs_found = dwim_ref("HEAD", 4, oid->hash, &real_ref);
 	else if (reflog_len)
-		refs_found = dwim_log(str, len, sha1, &real_ref);
+		refs_found = dwim_log(str, len, oid->hash, &real_ref);
 	else
-		refs_found = dwim_ref(str, len, sha1, &real_ref);
+		refs_found = dwim_ref(str, len, oid->hash, &real_ref);
 
 	if (!refs_found)
 		return -1;
 
 	if (warn_ambiguous_refs && !(flags & GET_SHA1_QUIETLY) &&
 	    (refs_found > 1 ||
-	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
+	     !get_short_oid(str, len, &tmp_oid, GET_SHA1_QUIETLY)))
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
@@ -688,7 +688,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 				return -1;
 			}
 		}
-		if (read_ref_at(real_ref, flags, at_time, nth, sha1, NULL,
+		if (read_ref_at(real_ref, flags, at_time, nth, oid->hash, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
 				if (starts_with(real_ref, "refs/heads/")) {
@@ -721,10 +721,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 }
 
 static int get_parent(const char *name, int len,
-		      unsigned char *result, int idx)
+		      struct object_id *result, int idx)
 {
 	struct object_id oid;
-	int ret = get_sha1_1(name, len, oid.hash, GET_SHA1_COMMITTISH);
+	int ret = get_oid_1(name, len, &oid, GET_SHA1_COMMITTISH);
 	struct commit *commit;
 	struct commit_list *p;
 
@@ -734,13 +734,13 @@ static int get_parent(const char *name, int len,
 	if (parse_commit(commit))
 		return -1;
 	if (!idx) {
-		hashcpy(result, commit->object.oid.hash);
+		oidcpy(result, &commit->object.oid);
 		return 0;
 	}
 	p = commit->parents;
 	while (p) {
 		if (!--idx) {
-			hashcpy(result, p->item->object.oid.hash);
+			oidcpy(result, &p->item->object.oid);
 			return 0;
 		}
 		p = p->next;
@@ -749,13 +749,13 @@ static int get_parent(const char *name, int len,
 }
 
 static int get_nth_ancestor(const char *name, int len,
-			    unsigned char *result, int generation)
+			    struct object_id *result, int generation)
 {
 	struct object_id oid;
 	struct commit *commit;
 	int ret;
 
-	ret = get_sha1_1(name, len, oid.hash, GET_SHA1_COMMITTISH);
+	ret = get_oid_1(name, len, &oid, GET_SHA1_COMMITTISH);
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(&oid);
@@ -767,7 +767,7 @@ static int get_nth_ancestor(const char *name, int len,
 			return -1;
 		commit = commit->parents->item;
 	}
-	hashcpy(result, commit->object.oid.hash);
+	oidcpy(result, &commit->object.oid);
 	return 0;
 }
 
@@ -796,7 +796,7 @@ struct object *peel_to_type(const char *name, int namelen,
 	}
 }
 
-static int peel_onion(const char *name, int len, unsigned char *sha1,
+static int peel_onion(const char *name, int len, struct object_id *oid,
 		      unsigned lookup_flags)
 {
 	struct object_id outer;
@@ -847,7 +847,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1,
 	else if (expected_type == OBJ_TREE)
 		lookup_flags |= GET_SHA1_TREEISH;
 
-	if (get_sha1_1(name, sp - name - 2, outer.hash, lookup_flags))
+	if (get_oid_1(name, sp - name - 2, &outer, lookup_flags))
 		return -1;
 
 	o = parse_object(&outer);
@@ -857,7 +857,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1,
 		o = deref_tag(o, name, sp - name - 2);
 		if (!o || (!o->parsed && !parse_object(&o->oid)))
 			return -1;
-		hashcpy(sha1, o->oid.hash);
+		oidcpy(oid, &o->oid);
 		return 0;
 	}
 
@@ -870,7 +870,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1,
 	if (!o)
 		return -1;
 
-	hashcpy(sha1, o->oid.hash);
+	oidcpy(oid, &o->oid);
 	if (sp[0] == '/') {
 		/* "$commit^{/foo}" */
 		char *prefix;
@@ -886,14 +886,14 @@ static int peel_onion(const char *name, int len, unsigned char *sha1,
 
 		prefix = xstrndup(sp + 1, name + len - 1 - (sp + 1));
 		commit_list_insert((struct commit *)o, &list);
-		ret = get_sha1_oneline(prefix, sha1, list);
+		ret = get_oid_oneline(prefix, oid, list);
 		free(prefix);
 		return ret;
 	}
 	return 0;
 }
 
-static int get_describe_name(const char *name, int len, unsigned char *sha1)
+static int get_describe_name(const char *name, int len, struct object_id *oid)
 {
 	const char *cp;
 	unsigned flags = GET_SHA1_QUIETLY | GET_SHA1_COMMIT;
@@ -907,14 +907,14 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_sha1(cp, len, sha1, flags);
+				return get_short_oid(cp, len, oid, flags);
 			}
 		}
 	}
 	return -1;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags)
+static int get_oid_1(const char *name, int len, struct object_id *oid, unsigned lookup_flags)
 {
 	int ret, has_suffix;
 	const char *cp;
@@ -941,25 +941,25 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
 		if (!num && len1 == len - 1)
 			num = 1;
 		if (has_suffix == '^')
-			return get_parent(name, len1, sha1, num);
+			return get_parent(name, len1, oid, num);
 		/* else if (has_suffix == '~') -- goes without saying */
-		return get_nth_ancestor(name, len1, sha1, num);
+		return get_nth_ancestor(name, len1, oid, num);
 	}
 
-	ret = peel_onion(name, len, sha1, lookup_flags);
+	ret = peel_onion(name, len, oid, lookup_flags);
 	if (!ret)
 		return 0;
 
-	ret = get_sha1_basic(name, len, sha1, lookup_flags);
+	ret = get_oid_basic(name, len, oid, lookup_flags);
 	if (!ret)
 		return 0;
 
 	/* It could be describe output that is "SOMETHING-gXXXX" */
-	ret = get_describe_name(name, len, sha1);
+	ret = get_describe_name(name, len, oid);
 	if (!ret)
 		return 0;
 
-	return get_short_sha1(name, len, sha1, lookup_flags);
+	return get_short_oid(name, len, oid, lookup_flags);
 }
 
 /*
@@ -996,7 +996,7 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 	return 0;
 }
 
-static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
+static int get_oid_oneline(const char *prefix, struct object_id *oid,
 			    struct commit_list *list)
 {
 	struct commit_list *backup = NULL, *l;
@@ -1036,7 +1036,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 		unuse_commit_buffer(commit, buf);
 
 		if (matches) {
-			hashcpy(sha1, commit->object.oid.hash);
+			oidcpy(oid, &commit->object.oid);
 			found = 1;
 			break;
 		}
@@ -1132,7 +1132,7 @@ int get_oid_mb(const char *name, struct object_id *oid)
 		struct strbuf sb;
 		strbuf_init(&sb, dots - name);
 		strbuf_add(&sb, name, dots - name);
-		st = get_sha1_committish(sb.buf, oid_tmp.hash);
+		st = get_oid_committish(sb.buf, &oid_tmp);
 		strbuf_release(&sb);
 	}
 	if (st)
@@ -1141,7 +1141,7 @@ int get_oid_mb(const char *name, struct object_id *oid)
 	if (!one)
 		return -1;
 
-	if (get_sha1_committish(dots[3] ? (dots + 3) : "HEAD", oid_tmp.hash))
+	if (get_oid_committish(dots[3] ? (dots + 3) : "HEAD", &oid_tmp))
 		return -1;
 	two = lookup_commit_reference_gently(&oid_tmp, 0);
 	if (!two)
@@ -1330,21 +1330,13 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 }
 
 /*
- * This is like "get_sha1_basic()", except it allows "sha1 expressions",
+ * This is like "get_oid_basic()", except it allows "object ID expressions",
  * notably "xyz^" for "parent of xyz"
  */
-int get_sha1(const char *name, unsigned char *sha1)
-{
-	struct object_context unused;
-	return get_sha1_with_context(name, 0, sha1, &unused);
-}
-
-/*
- * This is like "get_sha1()", but for struct object_id.
- */
 int get_oid(const char *name, struct object_id *oid)
 {
-	return get_sha1(name, oid->hash);
+	struct object_context unused;
+	return get_oid_with_context(name, 0, oid, &unused);
 }
 
 
@@ -1358,49 +1350,49 @@ int get_oid(const char *name, struct object_id *oid)
  * commit-ish. It is merely to give a hint to the disambiguation
  * machinery.
  */
-int get_sha1_committish(const char *name, unsigned char *sha1)
+int get_oid_committish(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_sha1_with_context(name, GET_SHA1_COMMITTISH,
-				     sha1, &unused);
+	return get_oid_with_context(name, GET_SHA1_COMMITTISH,
+				    oid, &unused);
 }
 
-int get_sha1_treeish(const char *name, unsigned char *sha1)
+int get_oid_treeish(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_sha1_with_context(name, GET_SHA1_TREEISH,
-				     sha1, &unused);
+	return get_oid_with_context(name, GET_SHA1_TREEISH,
+				    oid, &unused);
 }
 
-int get_sha1_commit(const char *name, unsigned char *sha1)
+int get_oid_commit(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_sha1_with_context(name, GET_SHA1_COMMIT,
-				     sha1, &unused);
+	return get_oid_with_context(name, GET_SHA1_COMMIT,
+				    oid, &unused);
 }
 
-int get_sha1_tree(const char *name, unsigned char *sha1)
+int get_oid_tree(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_sha1_with_context(name, GET_SHA1_TREE,
-				     sha1, &unused);
+	return get_oid_with_context(name, GET_SHA1_TREE,
+				    oid, &unused);
 }
 
-int get_sha1_blob(const char *name, unsigned char *sha1)
+int get_oid_blob(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_sha1_with_context(name, GET_SHA1_BLOB,
-				     sha1, &unused);
+	return get_oid_with_context(name, GET_SHA1_BLOB,
+				    oid, &unused);
 }
 
 /* Must be called only when object_name:filename doesn't exist. */
-static void diagnose_invalid_sha1_path(const char *prefix,
-				       const char *filename,
-				       const unsigned char *tree_sha1,
-				       const char *object_name,
-				       int object_name_len)
+static void diagnose_invalid_oid_path(const char *prefix,
+				      const char *filename,
+				      const struct object_id *tree_oid,
+				      const char *object_name,
+				      int object_name_len)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	unsigned mode;
 
 	if (!prefix)
@@ -1412,8 +1404,8 @@ static void diagnose_invalid_sha1_path(const char *prefix,
 	if (is_missing_file_error(errno)) {
 		char *fullname = xstrfmt("%s%s", prefix, filename);
 
-		if (!get_tree_entry(tree_sha1, fullname,
-				    sha1, &mode)) {
+		if (!get_tree_entry(tree_oid->hash, fullname,
+				    oid.hash, &mode)) {
 			die("Path '%s' exists, but not '%s'.\n"
 			    "Did you mean '%.*s:%s' aka '%.*s:./%s'?",
 			    fullname,
@@ -1496,11 +1488,11 @@ static char *resolve_relative_path(const char *rel)
 			   rel);
 }
 
-static int get_sha1_with_context_1(const char *name,
-				   unsigned flags,
-				   const char *prefix,
-				   unsigned char *sha1,
-				   struct object_context *oc)
+static int get_oid_with_context_1(const char *name,
+				  unsigned flags,
+				  const char *prefix,
+				  struct object_id *oid,
+				  struct object_context *oc)
 {
 	int ret, bracket_depth;
 	int namelen = strlen(name);
@@ -1513,7 +1505,7 @@ static int get_sha1_with_context_1(const char *name,
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
 	strbuf_init(&oc->symlink_path, 0);
-	ret = get_sha1_1(name, namelen, sha1, flags);
+	ret = get_oid_1(name, namelen, oid, flags);
 	if (!ret)
 		return ret;
 	/*
@@ -1533,7 +1525,7 @@ static int get_sha1_with_context_1(const char *name,
 
 			for_each_ref(handle_one_ref, &list);
 			commit_list_sort_by_date(&list);
-			return get_sha1_oneline(name + 2, sha1, list);
+			return get_oid_oneline(name + 2, oid, list);
 		}
 		if (namelen < 3 ||
 		    name[2] != ':' ||
@@ -1565,7 +1557,7 @@ static int get_sha1_with_context_1(const char *name,
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
-				hashcpy(sha1, ce->oid.hash);
+				oidcpy(oid, &ce->oid);
 				oc->mode = ce->ce_mode;
 				free(new_path);
 				return 0;
@@ -1586,14 +1578,14 @@ static int get_sha1_with_context_1(const char *name,
 			break;
 	}
 	if (*cp == ':') {
-		unsigned char tree_sha1[20];
+		struct object_id tree_oid;
 		int len = cp - name;
 		unsigned sub_flags = flags;
 
 		sub_flags &= ~GET_SHA1_DISAMBIGUATORS;
 		sub_flags |= GET_SHA1_TREEISH;
 
-		if (!get_sha1_1(name, len, tree_sha1, sub_flags)) {
+		if (!get_oid_1(name, len, &tree_oid, sub_flags)) {
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
@@ -1601,20 +1593,20 @@ static int get_sha1_with_context_1(const char *name,
 			if (new_filename)
 				filename = new_filename;
 			if (flags & GET_SHA1_FOLLOW_SYMLINKS) {
-				ret = get_tree_entry_follow_symlinks(tree_sha1,
-					filename, sha1, &oc->symlink_path,
+				ret = get_tree_entry_follow_symlinks(tree_oid.hash,
+					filename, oid->hash, &oc->symlink_path,
 					&oc->mode);
 			} else {
-				ret = get_tree_entry(tree_sha1, filename,
-						     sha1, &oc->mode);
+				ret = get_tree_entry(tree_oid.hash, filename,
+						     oid->hash, &oc->mode);
 				if (ret && only_to_die) {
-					diagnose_invalid_sha1_path(prefix,
+					diagnose_invalid_oid_path(prefix,
 								   filename,
-								   tree_sha1,
+								   &tree_oid,
 								   name, len);
 				}
 			}
-			hashcpy(oc->tree, tree_sha1);
+			hashcpy(oc->tree, tree_oid.hash);
 			if (flags & GET_SHA1_RECORD_PATH)
 				oc->path = xstrdup(filename);
 
@@ -1638,13 +1630,13 @@ static int get_sha1_with_context_1(const char *name,
 void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 {
 	struct object_context oc;
-	unsigned char sha1[20];
-	get_sha1_with_context_1(name, GET_SHA1_ONLY_TO_DIE, prefix, sha1, &oc);
+	struct object_id oid;
+	get_oid_with_context_1(name, GET_SHA1_ONLY_TO_DIE, prefix, &oid, &oc);
 }
 
-int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *oc)
+int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc)
 {
 	if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
 		die("BUG: incompatible flags for get_sha1_with_context");
-	return get_sha1_with_context_1(str, flags, NULL, sha1, oc);
+	return get_oid_with_context_1(str, flags, NULL, oid, oc);
 }
diff --git a/transport-helper.c b/transport-helper.c
index 33cff38cc..8f68d69a8 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -927,7 +927,7 @@ static int push_refs_with_export(struct transport *transport,
 		struct object_id oid;
 
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
-		if (private && !get_sha1(private, oid.hash)) {
+		if (private && !get_oid(private, &oid)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
 			oidcpy(&ref->old_oid, &oid);
