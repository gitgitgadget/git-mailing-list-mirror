Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E249520A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbdJAWJB (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54134 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751895AbdJAWIy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:08:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8EB6160DA5;
        Sun,  1 Oct 2017 22:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895733;
        bh=tYFUHQcPGhF+AbdmOf9BJZTSpxTrqMMq2Acg2nGF05Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXDCF9Szhkz4s+gK/P1W8S1/VFwgcQVvEXD0vqXkZmmckH/pGiYGuMogHzrnQat9o
         jpZIMcBcLgFJjQyLXNpGCgHhDRK9210tYX3wu8ChFC/eb1gHPi9TQ9hz8ngjxlPiXq
         r7g+WeZNm1ldKPaG6mLXaJaVSwucj+rh5+AUZ7UFCYmYkOgCfnH8nKeMZEOeW+PSMH
         K67vKUYgdzn8C4Gn1gbJu1IGgQuQ1NyFcnvfY1RwoZ5cnJQOEMIELMh+G1wQx3WFqR
         lWQHHis67BxDuk+NkbXZWv8Iimr4HpGo7ktD1MQt8405JdpeJ55dhBneLpcWolMzfN
         t5hf3GwkMKmWXNbkbn2imRwbPupGluBcmd+9ESxHWLVRn2RPwu2GoCz/SnSencV/QJ
         /k5xlAG7lhq9bffwMZB293XBUXaUqyLE11JwTSrBRsrD+2AM7dlhvH6iYwCkogexWK
         9ROjH1ZUnq6IlaTYIWs3B+c2/YL+OC8hxBHAtnTDJXq39XlYZm+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 08/24] refs: convert read_ref and read_ref_full to object_id
Date:   Sun,  1 Oct 2017 22:08:15 +0000
Message-Id: <20171001220831.214705-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All but two of the call sites already had parameters using the hash
parameter of struct object_id, so convert them to take a pointer to the
struct directly.  Also convert refs_read_refs_full, the underlying
implementation.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/checkout.c     |  6 +++---
 builtin/remote.c       |  2 +-
 builtin/replace.c      |  4 ++--
 builtin/show-ref.c     |  2 +-
 builtin/tag.c          |  4 ++--
 builtin/update-index.c |  6 +++---
 bundle.c               |  2 +-
 fast-import.c          |  2 +-
 notes-cache.c          |  2 +-
 notes-merge.c          |  2 +-
 notes-utils.c          |  2 +-
 notes.c                |  2 +-
 refs.c                 | 20 ++++++++++----------
 refs.h                 |  6 +++---
 refs/files-backend.c   | 16 ++++++++--------
 remote-testsvn.c       |  2 +-
 remote.c               |  6 +++---
 sequencer.c            |  2 +-
 transport-helper.c     |  5 ++---
 19 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b803425bc4..20d2bca007 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -379,7 +379,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	read_ref_full("HEAD", 0, rev.hash, NULL);
+	read_ref_full("HEAD", 0, &rev, NULL);
 	head = lookup_commit_reference_gently(&rev, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
@@ -1037,7 +1037,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	setup_branch_path(new);
 
 	if (!check_refname_format(new->path, 0) &&
-	    !read_ref(new->path, branch_rev.hash))
+	    !read_ref(new->path, &branch_rev))
 		oidcpy(rev, &branch_rev);
 	else
 		new->path = NULL; /* not an existing branch */
@@ -1136,7 +1136,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		struct object_id rev;
 		int flag;
 
-		if (!read_ref_full("HEAD", 0, rev.hash, &flag) &&
+		if (!read_ref_full("HEAD", 0, &rev, &flag) &&
 		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
 			return switch_unborn_to_new_branch(opts);
 	}
diff --git a/builtin/remote.c b/builtin/remote.c
index 4f5cac96b0..0fddc64461 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -690,7 +690,7 @@ static int mv(int argc, const char **argv)
 		int flag = 0;
 		struct object_id oid;
 
-		read_ref_full(item->string, RESOLVE_REF_READING, oid.hash, &flag);
+		read_ref_full(item->string, RESOLVE_REF_READING, &oid, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(NULL, item->string, NULL, REF_NODEREF))
diff --git a/builtin/replace.c b/builtin/replace.c
index 3099e55307..10078ae371 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -113,7 +113,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 		strbuf_addstr(&ref, oid_to_hex(&oid));
 		full_hex = ref.buf + base_len;
 
-		if (read_ref(ref.buf, oid.hash)) {
+		if (read_ref(ref.buf, &oid)) {
 			error("replace ref '%s' not found.", full_hex);
 			had_error = 1;
 			continue;
@@ -144,7 +144,7 @@ static void check_ref_valid(struct object_id *object,
 	if (check_refname_format(ref->buf, 0))
 		die("'%s' is not a valid ref name.", ref->buf);
 
-	if (read_ref(ref->buf, prev->hash))
+	if (read_ref(ref->buf, prev))
 		oidclr(prev);
 	else if (!force)
 		die("replace ref '%s' already exists", ref->buf);
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 013d241abc..cbb8cfc7d2 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -197,7 +197,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 			struct object_id oid;
 
 			if ((starts_with(*pattern, "refs/") || !strcmp(*pattern, "HEAD")) &&
-			    !read_ref(*pattern, oid.hash)) {
+			    !read_ref(*pattern, &oid)) {
 				show_one(*pattern, &oid);
 			}
 			else if (!quiet)
diff --git a/builtin/tag.c b/builtin/tag.c
index 2ededc3fb1..c36d2f115c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -82,7 +82,7 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 	for (p = argv; *p; p++) {
 		strbuf_reset(&ref);
 		strbuf_addf(&ref, "refs/tags/%s", *p);
-		if (read_ref(ref.buf, oid.hash)) {
+		if (read_ref(ref.buf, &oid)) {
 			error(_("tag '%s' not found."), *p);
 			had_error = 1;
 			continue;
@@ -517,7 +517,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (strbuf_check_tag_ref(&ref, tag))
 		die(_("'%s' is not a valid tag name."), tag);
 
-	if (read_ref(ref.buf, prev.hash))
+	if (read_ref(ref.buf, &prev))
 		oidclr(&prev);
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index bf7420b808..24f4b28951 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -679,9 +679,9 @@ static int unresolve_one(const char *path)
 
 static void read_head_pointers(void)
 {
-	if (read_ref("HEAD", head_oid.hash))
+	if (read_ref("HEAD", &head_oid))
 		die("No HEAD -- no initial commit yet?");
-	if (read_ref("MERGE_HEAD", merge_head_oid.hash)) {
+	if (read_ref("MERGE_HEAD", &merge_head_oid)) {
 		fprintf(stderr, "Not in the middle of a merge.\n");
 		exit(0);
 	}
@@ -721,7 +721,7 @@ static int do_reupdate(int ac, const char **av,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, av + 1);
 
-	if (read_ref("HEAD", head_oid.hash))
+	if (read_ref("HEAD", &head_oid))
 		/* If there is no HEAD, that means it is an initial
 		 * commit.  Update everything in the index.
 		 */
diff --git a/bundle.c b/bundle.c
index c092d5d68f..12658c5c9f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -340,7 +340,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 			continue;
 		if (dwim_ref(e->name, strlen(e->name), oid.hash, &ref) != 1)
 			goto skip_write_ref;
-		if (read_ref_full(e->name, RESOLVE_REF_READING, oid.hash, &flag))
+		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flag))
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
diff --git a/fast-import.c b/fast-import.c
index 2d2d0d98f0..479e300aa3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1758,7 +1758,7 @@ static int update_branch(struct branch *b)
 			delete_ref(NULL, b->name, NULL, 0);
 		return 0;
 	}
-	if (read_ref(b->name, old_oid.hash))
+	if (read_ref(b->name, &old_oid))
 		oidclr(&old_oid);
 	if (!force_update && !is_null_oid(&old_oid)) {
 		struct commit *old_cmit, *new_cmit;
diff --git a/notes-cache.c b/notes-cache.c
index 927b6645db..4e3c94631b 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -11,7 +11,7 @@ static int notes_cache_match_validity(const char *ref, const char *validity)
 	struct strbuf msg = STRBUF_INIT;
 	int ret;
 
-	if (read_ref(ref, oid.hash) < 0)
+	if (read_ref(ref, &oid) < 0)
 		return 0;
 
 	commit = lookup_commit_reference_gently(&oid, 1);
diff --git a/notes-merge.c b/notes-merge.c
index 597d43f65c..edc6acdd92 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -549,7 +549,7 @@ int notes_merge(struct notes_merge_options *o,
 	       o->local_ref, o->remote_ref);
 
 	/* Dereference o->local_ref into local_sha1 */
-	if (read_ref_full(o->local_ref, 0, local_oid.hash, NULL))
+	if (read_ref_full(o->local_ref, 0, &local_oid, NULL))
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_oid(&local_oid))
diff --git a/notes-utils.c b/notes-utils.c
index 3a7008948c..5c8e70c98f 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -18,7 +18,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 	if (!parents) {
 		/* Deduce parent commit from t->ref */
 		struct object_id parent_oid;
-		if (!read_ref(t->ref, parent_oid.hash)) {
+		if (!read_ref(t->ref, &parent_oid)) {
 			struct commit *parent = lookup_commit(&parent_oid);
 			if (parse_commit(parent))
 				die("Failed to find/parse commit %s", t->ref);
diff --git a/notes.c b/notes.c
index 5c62862574..d273822b28 100644
--- a/notes.c
+++ b/notes.c
@@ -1027,7 +1027,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
 	    get_oid_treeish(notes_ref, &object_oid))
 		return;
-	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, object_oid.hash))
+	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
 	if (get_tree_entry(object_oid.hash, "", oid.hash, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
diff --git a/refs.c b/refs.c
index a86dbf9ec1..d6f8587b57 100644
--- a/refs.c
+++ b/refs.c
@@ -219,22 +219,22 @@ struct ref_filter {
 };
 
 int refs_read_ref_full(struct ref_store *refs, const char *refname,
-		       int resolve_flags, unsigned char *sha1, int *flags)
+		       int resolve_flags, struct object_id *oid, int *flags)
 {
-	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags, sha1, flags))
+	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid->hash, flags))
 		return 0;
 	return -1;
 }
 
-int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
+int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid, int *flags)
 {
 	return refs_read_ref_full(get_main_ref_store(), refname,
-				  resolve_flags, sha1, flags);
+				  resolve_flags, oid, flags);
 }
 
-int read_ref(const char *refname, unsigned char *sha1)
+int read_ref(const char *refname, struct object_id *oid)
 {
-	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
+	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
 int ref_exists(const char *refname)
@@ -362,7 +362,7 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	int flag;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, oid.hash, &flag))
+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flag))
 		ret = fn(buf.buf, &oid, flag, cb_data);
 	strbuf_release(&buf);
 
@@ -598,7 +598,7 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 	if (old_oid) {
 		struct object_id actual_old_oid;
 
-		if (read_ref(pseudoref, actual_old_oid.hash))
+		if (read_ref(pseudoref, &actual_old_oid))
 			die("could not read ref '%s'", pseudoref);
 		if (oidcmp(&actual_old_oid, old_oid)) {
 			strbuf_addf(err, "unexpected sha1 when writing '%s'", pseudoref);
@@ -636,7 +636,7 @@ static int delete_pseudoref(const char *pseudoref, const struct object_id *old_o
 				get_files_ref_lock_timeout_ms());
 		if (fd < 0)
 			die_errno(_("Could not open '%s' for writing"), filename);
-		if (read_ref(pseudoref, actual_old_oid.hash))
+		if (read_ref(pseudoref, &actual_old_oid))
 			die("could not read ref '%s'", pseudoref);
 		if (oidcmp(&actual_old_oid, old_oid)) {
 			warning("Unexpected sha1 when deleting %s", pseudoref);
@@ -1246,7 +1246,7 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	int flag;
 
 	if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
-				oid.hash, &flag))
+				&oid, &flag))
 		return fn("HEAD", &oid, flag, cb_data);
 
 	return 0;
diff --git a/refs.h b/refs.h
index 9a573a4092..a2032b8397 100644
--- a/refs.h
+++ b/refs.h
@@ -74,10 +74,10 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 		     struct object_id *oid, int *flags);
 
 int refs_read_ref_full(struct ref_store *refs, const char *refname,
-		       int resolve_flags, unsigned char *sha1, int *flags);
+		       int resolve_flags, struct object_id *oid, int *flags);
 int read_ref_full(const char *refname, int resolve_flags,
-		  unsigned char *sha1, int *flags);
-int read_ref(const char *refname, unsigned char *sha1);
+		  struct object_id *oid, int *flags);
+int read_ref(const char *refname, struct object_id *oid);
 
 /*
  * Return 0 if a reference named refname could be created without
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1ab91fd346..148b98490f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -648,7 +648,7 @@ static int files_peel_ref(struct ref_store *ref_store,
 		files_downcast(ref_store, REF_STORE_READ | REF_STORE_ODB,
 			       "peel_ref");
 	int flag;
-	unsigned char base[20];
+	struct object_id base;
 
 	if (current_ref_iter && current_ref_iter->refname == refname) {
 		struct object_id peeled;
@@ -660,7 +660,7 @@ static int files_peel_ref(struct ref_store *ref_store,
 	}
 
 	if (refs_read_ref_full(ref_store, refname,
-			       RESOLVE_REF_READING, base, &flag))
+			       RESOLVE_REF_READING, &base, &flag))
 		return -1;
 
 	/*
@@ -675,7 +675,7 @@ static int files_peel_ref(struct ref_store *ref_store,
 	    !refs_peel_ref(refs->packed_ref_store, refname, sha1))
 		return 0;
 
-	return peel_object(base, sha1);
+	return peel_object(base.hash, sha1);
 }
 
 struct files_ref_iterator {
@@ -817,7 +817,7 @@ static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 
 	if (refs_read_ref_full(ref_store, lock->ref_name,
 			       mustexist ? RESOLVE_REF_READING : 0,
-			       lock->old_oid.hash, NULL)) {
+			       &lock->old_oid, NULL)) {
 		if (old_sha1) {
 			int save_errno = errno;
 			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
@@ -1322,7 +1322,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	 */
 	if (!refs_read_ref_full(&refs->base, newrefname,
 				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				oid.hash, NULL) &&
+				&oid, NULL) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
 			    NULL, REF_NODEREF)) {
 		if (errno == EISDIR) {
@@ -1727,7 +1727,7 @@ static void update_symref_reflog(struct files_ref_store *refs,
 	struct object_id new_oid;
 	if (logmsg &&
 	    !refs_read_ref_full(&refs->base, target,
-				RESOLVE_REF_READING, new_oid.hash, NULL) &&
+				RESOLVE_REF_READING, &new_oid, NULL) &&
 	    files_log_ref_write(refs, refname, &lock->old_oid,
 				&new_oid, logmsg, 0, &err)) {
 		error("%s", err.buf);
@@ -2016,7 +2016,7 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (refs_read_ref_full(iter->ref_store,
 				       diter->relative_path, 0,
-				       iter->oid.hash, &flags)) {
+				       &iter->oid, &flags)) {
 			error("bad ref for %s", diter->path.buf);
 			continue;
 		}
@@ -2352,7 +2352,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 */
 			if (refs_read_ref_full(&refs->base,
 					       referent.buf, 0,
-					       lock->old_oid.hash, NULL)) {
+					       &lock->old_oid, NULL)) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 0ff4a31262..bcebb4c789 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -174,7 +174,7 @@ static int cmd_import(const char *line)
 	struct child_process svndump_proc = CHILD_PROCESS_INIT;
 	const char *command = "svnrdump";
 
-	if (read_ref(private_ref, head_oid.hash))
+	if (read_ref(private_ref, &head_oid))
 		startrev = 0;
 	else {
 		note_msg = read_ref_note(&head_oid);
diff --git a/remote.c b/remote.c
index b220f0dfc6..698a890a83 100644
--- a/remote.c
+++ b/remote.c
@@ -2002,13 +2002,13 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		return -1;
 
 	/* Cannot stat if what we used to build on no longer exists */
-	if (read_ref(base, oid.hash))
+	if (read_ref(base, &oid))
 		return -1;
 	theirs = lookup_commit_reference(&oid);
 	if (!theirs)
 		return -1;
 
-	if (read_ref(branch->refname, oid.hash))
+	if (read_ref(branch->refname, &oid))
 		return -1;
 	ours = lookup_commit_reference(&oid);
 	if (!ours)
@@ -2327,7 +2327,7 @@ static int remote_tracking(struct remote *remote, const char *refname,
 	dst = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
-	if (read_ref(dst, oid->hash))
+	if (read_ref(dst, oid))
 		return -1; /* we know what the tracking ref is but we cannot read it */
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index 43a6f14eb3..f1f895774a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1627,7 +1627,7 @@ static int rollback_single_pick(void)
 	if (!file_exists(git_path_cherry_pick_head()) &&
 	    !file_exists(git_path_revert_head()))
 		return error(_("no cherry-pick or revert in progress"));
-	if (read_ref_full("HEAD", 0, head_oid.hash, NULL))
+	if (read_ref_full("HEAD", 0, &head_oid, NULL))
 		return error(_("cannot resolve HEAD"));
 	if (is_null_oid(&head_oid))
 		return error(_("cannot abort from a branch yet to be born"));
diff --git a/transport-helper.c b/transport-helper.c
index f183601261..640ce5a492 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -535,7 +535,7 @@ static int fetch_with_import(struct transport *transport,
 		else
 			private = xstrdup(name);
 		if (private) {
-			if (read_ref(private, posn->old_oid.hash) < 0)
+			if (read_ref(private, &posn->old_oid) < 0)
 				die("Could not read ref %s", private);
 			free(private);
 		}
@@ -1067,8 +1067,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 		if (eon) {
 			if (has_attribute(eon + 1, "unchanged")) {
 				(*tail)->status |= REF_STATUS_UPTODATE;
-				if (read_ref((*tail)->name,
-					     (*tail)->old_oid.hash) < 0)
+				if (read_ref((*tail)->name, &(*tail)->old_oid) < 0)
 					die(_("Could not read ref %s"),
 					    (*tail)->name);
 			}
-- 
2.14.2.822.g60be5d43e6

