Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FC6B20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdJAWI4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:08:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54098 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751092AbdJAWIw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:08:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E72060DA1;
        Sun,  1 Oct 2017 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895731;
        bh=LxIOJ4SbmJFkikmDQt0LJ8JppNP/NK8QjVZjp/bBD3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5M0r0qPycqHc84GL00zwVE4HzOyBuANlhwWGMRtEA7HppHvIvZSEc69VSQ+jyJbs
         WBNWx36i96IH9JcwVMyzuibjGohWj5cBlRHul66uoPNAQZGUjBD1AgFYt2BNrU1hd4
         NHLQMERFs5AgkUOWuVu1rWFOaMS0M6f5QOrd0Ln+iaywTv3bITeuLPCqNOkbhWZcgd
         5UTxc4QBEF1TxqIUDpzfGE4H+N4DTR9E5LxXS/vDTyjPQyWwpRBx7jZCSKnGtG9QfK
         1FJ/Gyq8m7APvSW1Ndch5DjNlVnFENZz5p3CYwNpT++/dO6i075px2kHXQPtoTRikq
         drRjwhcZvD7P1OyQV6/uI79Pp8gRYfGQgLkZPnXGTbtgfJkxSLEZbVuetilQMo7jJl
         f1s6dRXJFPRapGbu5u2ID03RGHF1BhrGZnGc7LBt77fReKRUHwgLCz4FDRBQA89pE8
         WzR/hMjHnenNHlV09edA81HBGQOz3m/gEnOSw/aQMVzRO/Og1wf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 07/24] refs: convert resolve_refdup and refs_resolve_refdup to struct object_id
Date:   Sun,  1 Oct 2017 22:08:14 +0000
Message-Id: <20171001220831.214705-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the callers already pass the hash member of struct object_id, so
update them to pass a pointer to the struct directly,

This transformation was done with an update to declaration and
definition and the following semantic patch:

@@
expression E1, E2, E3, E4;
@@
- resolve_refdup(E1, E2, E3.hash, E4)
+ resolve_refdup(E1, E2, &E3, E4)

@@
expression E1, E2, E3, E4;
@@
- resolve_refdup(E1, E2, E3->hash, E4)
+ resolve_refdup(E1, E2, E3, E4)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c                | 2 +-
 builtin/branch.c            | 6 +++---
 builtin/checkout.c          | 4 ++--
 builtin/clone.c             | 2 +-
 builtin/fmt-merge-msg.c     | 2 +-
 builtin/merge.c             | 2 +-
 builtin/notes.c             | 2 +-
 builtin/receive-pack.c      | 2 +-
 builtin/show-branch.c       | 6 +++---
 builtin/submodule--helper.c | 2 +-
 ref-filter.c                | 4 ++--
 reflog-walk.c               | 4 ++--
 refs.c                      | 8 ++++----
 refs.h                      | 4 ++--
 refs/files-backend.c        | 2 +-
 submodule.c                 | 2 +-
 transport.c                 | 2 +-
 wt-status.c                 | 2 +-
 18 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 32120f42df..c9bb14a6c2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2135,7 +2135,7 @@ static void am_abort(struct am_state *state)
 
 	am_rerere_clear();
 
-	curr_branch = resolve_refdup("HEAD", 0, curr_head.hash, NULL);
+	curr_branch = resolve_refdup("HEAD", 0, &curr_head, NULL);
 	has_curr_head = curr_branch && !is_null_oid(&curr_head);
 	if (!has_curr_head)
 		hashcpy(curr_head.hash, EMPTY_TREE_SHA1_BIN);
diff --git a/builtin/branch.c b/builtin/branch.c
index 6031b74d68..75dadd3d93 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -124,7 +124,7 @@ static int branch_merged(int kind, const char *name,
 		if (upstream &&
 		    (reference_name = reference_name_to_free =
 		     resolve_refdup(upstream, RESOLVE_REF_READING,
-				    oid.hash, NULL)) != NULL)
+				    &oid, NULL)) != NULL)
 			reference_rev = lookup_commit_reference(&oid);
 	}
 	if (!reference_rev)
@@ -240,7 +240,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					RESOLVE_REF_READING
 					| RESOLVE_REF_NO_RECURSE
 					| RESOLVE_REF_ALLOW_BAD_NAME,
-					oid.hash, &flags);
+					&oid, &flags);
 		if (!target) {
 			error(remote_branch
 			      ? _("remote-tracking branch '%s' not found.")
@@ -613,7 +613,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	track = git_branch_track;
 
-	head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD"))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index fd0dec401e..b803425bc4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -826,7 +826,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	struct object_id rev;
 	int flag, writeout_error = 0;
 	memset(&old, 0, sizeof(old));
-	old.path = path_to_free = resolve_refdup("HEAD", 0, rev.hash, &flag);
+	old.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old.path)
 		old.commit = lookup_commit_reference_gently(&rev, 1);
 	if (!(flag & REF_ISSYMREF))
@@ -1125,7 +1125,7 @@ static int checkout_branch(struct checkout_opts *opts,
 	    !opts->ignore_other_worktrees) {
 		struct object_id oid;
 		int flag;
-		char *head_ref = resolve_refdup("HEAD", 0, oid.hash, &flag);
+		char *head_ref = resolve_refdup("HEAD", 0, &oid, &flag);
 		if (head_ref &&
 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
 			die_if_checked_out(new->path, 1);
diff --git a/builtin/clone.c b/builtin/clone.c
index 5cd1b02d53..695bdd7046 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -715,7 +715,7 @@ static int checkout(int submodule_progress)
 	if (option_no_checkout)
 		return 0;
 
-	head = resolve_refdup("HEAD", RESOLVE_REF_READING, oid.hash, NULL);
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING, &oid, NULL);
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
 			  "unable to checkout.\n"));
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e99b5ddbf9..b69f7d3be2 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -603,7 +603,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 	/* get current branch */
 	current_branch = current_branch_to_free =
-		resolve_refdup("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL);
+		resolve_refdup("HEAD", RESOLVE_REF_READING, &head_oid, NULL);
 	if (!current_branch)
 		die("No current branch");
 	if (starts_with(current_branch, "refs/heads/"))
diff --git a/builtin/merge.c b/builtin/merge.c
index 99d4b873f0..99d2df965f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1142,7 +1142,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch = branch_to_free = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+	branch = branch_to_free = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (branch)
 		skip_prefix(branch, "refs/heads/", &branch);
 	if (!branch || is_null_oid(&head_oid))
diff --git a/builtin/notes.c b/builtin/notes.c
index 8276af419b..12afdf1907 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -724,7 +724,7 @@ static int merge_commit(struct notes_merge_options *o)
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
-		resolve_refdup("NOTES_MERGE_REF", 0, oid.hash, NULL);
+		resolve_refdup("NOTES_MERGE_REF", 0, &oid, NULL);
 	if (!o->local_ref)
 		die(_("failed to resolve NOTES_MERGE_REF"));
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 046b600b11..313b224fad 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1515,7 +1515,7 @@ static void execute_commands(struct command *commands,
 	check_aliased_updates(commands);
 
 	free(head_name_to_free);
-	head_name = head_name_to_free = resolve_refdup("HEAD", 0, oid.hash, NULL);
+	head_name = head_name_to_free = resolve_refdup("HEAD", 0, &oid, NULL);
 
 	if (use_atomic)
 		execute_commands_atomic(commands, si);
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 84547d6fba..0237be4975 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -705,8 +705,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			static const char *fake_av[2];
 
 			fake_av[0] = resolve_refdup("HEAD",
-						    RESOLVE_REF_READING,
-						    oid.hash, NULL);
+						    RESOLVE_REF_READING, &oid,
+						    NULL);
 			fake_av[1] = NULL;
 			av = fake_av;
 			ac = 1;
@@ -775,7 +775,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	}
 
 	head = resolve_refdup("HEAD", RESOLVE_REF_READING,
-			      head_oid.hash, NULL);
+			      &head_oid, NULL);
 
 	if (with_current_branch && head) {
 		int has_head = 0;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 06ed02f994..5946a7ca93 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1144,7 +1144,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	argv++;
 	argc--;
 	/* Get the submodule's head ref and determine if it is detached */
-	head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD"))
diff --git a/ref-filter.c b/ref-filter.c
index bc591f4f3d..24f3ca1ea3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -297,7 +297,7 @@ static void head_atom_parser(const struct ref_format *format, struct used_atom *
 {
 	struct object_id unused;
 
-	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, unused.hash, NULL);
+	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, &unused, NULL);
 }
 
 static struct {
@@ -1319,7 +1319,7 @@ static void populate_value(struct ref_array_item *ref)
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		struct object_id unused1;
 		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
-					     unused1.hash, NULL);
+					     &unused1, NULL);
 		if (!ref->symref)
 			ref->symref = "";
 	}
diff --git a/reflog-walk.c b/reflog-walk.c
index 74ebe5148f..1a602a214d 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -65,7 +65,7 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 		const char *name;
 		void *name_to_free;
 		name = name_to_free = resolve_refdup(ref, RESOLVE_REF_READING,
-						     oid.hash, NULL);
+						     &oid, NULL);
 		if (name) {
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
 			free(name_to_free);
@@ -153,7 +153,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		if (*branch == '\0') {
 			struct object_id oid;
 			free(branch);
-			branch = resolve_refdup("HEAD", 0, oid.hash, NULL);
+			branch = resolve_refdup("HEAD", 0, &oid, NULL);
 			if (!branch)
 				die ("No current branch");
 
diff --git a/refs.c b/refs.c
index 90c2f9ccca..a86dbf9ec1 100644
--- a/refs.c
+++ b/refs.c
@@ -194,21 +194,21 @@ int ref_resolves_to_object(const char *refname,
 
 char *refs_resolve_refdup(struct ref_store *refs,
 			  const char *refname, int resolve_flags,
-			  unsigned char *sha1, int *flags)
+			  struct object_id *oid, int *flags)
 {
 	const char *result;
 
 	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-					 sha1, flags);
+					 oid->hash, flags);
 	return xstrdup_or_null(result);
 }
 
 char *resolve_refdup(const char *refname, int resolve_flags,
-		     unsigned char *sha1, int *flags)
+		     struct object_id *oid, int *flags)
 {
 	return refs_resolve_refdup(get_main_ref_store(),
 				   refname, resolve_flags,
-				   sha1, flags);
+				   oid, flags);
 }
 
 /* The argument to filter_refs */
diff --git a/refs.h b/refs.h
index 543dcc5956..9a573a4092 100644
--- a/refs.h
+++ b/refs.h
@@ -69,9 +69,9 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 
 char *refs_resolve_refdup(struct ref_store *refs,
 			  const char *refname, int resolve_flags,
-			  unsigned char *sha1, int *flags);
+			  struct object_id *oid, int *flags);
 char *resolve_refdup(const char *refname, int resolve_flags,
-		     unsigned char *sha1, int *flags);
+		     struct object_id *oid, int *flags);
 
 int refs_read_ref_full(struct ref_store *refs, const char *refname,
 		       int resolve_flags, unsigned char *sha1, int *flags);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 46dbcda6a6..1ab91fd346 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2556,7 +2556,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 */
 	head_ref = refs_resolve_refdup(ref_store, "HEAD",
 				       RESOLVE_REF_NO_RECURSE,
-				       head_oid.hash, &head_type);
+				       &head_oid, &head_type);
 
 	if (head_ref && !(head_type & REF_ISSYMREF)) {
 		FREE_AND_NULL(head_ref);
diff --git a/submodule.c b/submodule.c
index f2f30bb488..c4af15c148 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1016,7 +1016,7 @@ int push_unpushed_submodules(struct oid_array *commits,
 		char *head;
 		struct object_id head_oid;
 
-		head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+		head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 		if (!head)
 			die(_("Failed to resolve HEAD as a valid ref."));
 
diff --git a/transport.c b/transport.c
index 09bd06e6e5..093d334e96 100644
--- a/transport.c
+++ b/transport.c
@@ -475,7 +475,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	char *head;
 	int summary_width = transport_summary_width(refs);
 
-	head = resolve_refdup("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL);
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING, &head_oid, NULL);
 
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
diff --git a/wt-status.c b/wt-status.c
index 6f730ee8f2..6d7d675a5b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -129,7 +129,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color = -1;
 	s->relative_paths = 1;
-	s->branch = resolve_refdup("HEAD", 0, oid.hash, NULL);
+	s->branch = resolve_refdup("HEAD", 0, &oid, NULL);
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
-- 
2.14.2.822.g60be5d43e6

