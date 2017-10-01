Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625DC20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbdJAWJa (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54184 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752154AbdJAWJJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D136460DBC;
        Sun,  1 Oct 2017 22:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895748;
        bh=qD/qymJkEhPt/zDpVovq74FzZtcLJEisSoA0kb6lIjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHWQXaWIjztC6Yc7yH70rvTmBeq65PYclsiYvWLBjRVzFDkcZSY39Jnt2hCm7IlvD
         lpCWb8S8xnLBgPTrD3IF4GHZVDBvMtxc8cZW/u7BRvvRGXYRRihrEKv4+x4s/F2nDe
         +GyOzHAkU3XlL86Sk+FXSNnI0zsvDodAlw196+vaEG89TTGExir4wST8nrPILnmTuX
         NrkUuJbV5QSY8/4DeUMxcTXEczMkiAszmkB1FdwlgyUnodmUA6lScU6oOMq+xJhv4/
         HC+hI+r7MNjRHrDhDemnjAl76+/IBtP+F/L+x1kFrQe1kVayr9FyvPeeBvTAD4r7h+
         cSaWE+w5TPUbefDz8aX487H237+sdyWTtWwVjFU1YYp3jBnZlqsBSc0aYoLGD1P6SM
         eOiG4VwBlSPSYXm8ciUphjzeO9IJp63yxwqTCqrtTohoVIsSWz+f4uo4l2OF93aSAc
         3xsuKq0NHLd9xTfHvXGSi9Tjf0zdoQmWrtcrQpT0RWjdkybxbmc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 21/24] refs: convert resolve_ref_unsafe to struct object_id
Date:   Sun,  1 Oct 2017 22:08:28 +0000
Message-Id: <20171001220831.214705-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert resolve_ref_unsafe to take a pointer to struct object_id by
converting one remaining caller to use struct object_id, converting the
declaration and definition, and applying the following semantic patch:

@@
expression E1, E2, E3, E4;
@@
- resolve_ref_unsafe(E1, E2, E3.hash, E4)
+ resolve_ref_unsafe(E1, E2, &E3, E4)

@@
expression E1, E2, E3, E4;
@@
- resolve_ref_unsafe(E1, E2, E3->hash, E4)
+ resolve_ref_unsafe(E1, E2, E3, E4)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 blame.c                   |  4 ++--
 builtin/fsck.c            |  2 +-
 refs.c                    | 28 ++++++++++++++--------------
 refs.h                    |  4 ++--
 refs/files-backend.c      |  8 ++++----
 sequencer.c               |  2 +-
 t/helper/test-ref-store.c |  6 +++---
 transport-helper.c        |  7 +++----
 worktree.c                |  2 +-
 9 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/blame.c b/blame.c
index f575e9cbf4..c3060de2f8 100644
--- a/blame.c
+++ b/blame.c
@@ -166,7 +166,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	commit->date = now;
 	parent_tail = &commit->parents;
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		die("no such ref: HEAD");
 
 	parent_tail = append_parent(parent_tail, &head_oid);
@@ -1689,7 +1689,7 @@ static struct commit *dwim_reverse_initial(struct rev_info *revs,
 		return NULL;
 
 	/* Do we have HEAD? */
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		return NULL;
 	head_commit = lookup_commit_reference_gently(&head_oid, 1);
 	if (!head_commit)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 56afe405b8..5f91116d73 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -555,7 +555,7 @@ static int fsck_head_link(void)
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid.hash, NULL);
+	head_points_at = resolve_ref_unsafe("HEAD", 0, &head_oid, NULL);
 	if (!head_points_at) {
 		errors_found |= ERROR_REFS;
 		return error("Invalid HEAD");
diff --git a/refs.c b/refs.c
index 3329d47d16..751c49772e 100644
--- a/refs.c
+++ b/refs.c
@@ -199,7 +199,7 @@ char *refs_resolve_refdup(struct ref_store *refs,
 	const char *result;
 
 	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-					 oid->hash, flags);
+					 oid, flags);
 	return xstrdup_or_null(result);
 }
 
@@ -221,7 +221,7 @@ struct ref_filter {
 int refs_read_ref_full(struct ref_store *refs, const char *refname,
 		       int resolve_flags, struct object_id *oid, int *flags)
 {
-	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid->hash, flags))
+	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid, flags))
 		return 0;
 	return -1;
 }
@@ -480,7 +480,7 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
 		r = resolve_ref_unsafe(fullref.buf, RESOLVE_REF_READING,
-				       this_result->hash, &flag);
+				       this_result, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
@@ -511,7 +511,7 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
 		ref = resolve_ref_unsafe(path.buf, RESOLVE_REF_READING,
-					 hash.hash, NULL);
+					 &hash, NULL);
 		if (!ref)
 			continue;
 		if (reflog_exists(path.buf))
@@ -1385,15 +1385,15 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
-				    unsigned char *sha1, int *flags)
+				    struct object_id *oid, int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
 	int unused_flags;
 	int symref_count;
 
-	if (!sha1)
-		sha1 = unused_oid.hash;
+	if (!oid)
+		oid = &unused_oid;
 	if (!flags)
 		flags = &unused_flags;
 
@@ -1421,11 +1421,11 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		unsigned int read_flags = 0;
 
 		if (refs_read_raw_ref(refs, refname,
-				      sha1, &sb_refname, &read_flags)) {
+				      oid->hash, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
-			hashclr(sha1);
+			oidclr(oid);
 			if (*flags & REF_BAD_NAME)
 				*flags |= REF_ISBROKEN;
 			return refname;
@@ -1435,7 +1435,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 
 		if (!(read_flags & REF_ISSYMREF)) {
 			if (*flags & REF_BAD_NAME) {
-				hashclr(sha1);
+				oidclr(oid);
 				*flags |= REF_ISBROKEN;
 			}
 			return refname;
@@ -1443,7 +1443,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 
 		refname = sb_refname.buf;
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
-			hashclr(sha1);
+			oidclr(oid);
 			return refname;
 		}
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
@@ -1470,10 +1470,10 @@ int refs_init_db(struct strbuf *err)
 }
 
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
+			       struct object_id *oid, int *flags)
 {
 	return refs_resolve_ref_unsafe(get_main_ref_store(), refname,
-				       resolve_flags, sha1, flags);
+				       resolve_flags, oid, flags);
 }
 
 int resolve_gitlink_ref(const char *submodule, const char *refname,
@@ -1487,7 +1487,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid->hash, &flags) ||
+	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
 	    is_null_oid(oid))
 		return -1;
 	return 0;
diff --git a/refs.h b/refs.h
index bb0dcd97af..4eedc880c6 100644
--- a/refs.h
+++ b/refs.h
@@ -62,10 +62,10 @@ struct worktree;
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
-				    unsigned char *sha1,
+				    struct object_id *oid,
 				    int *flags);
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags);
+			       struct object_id *oid, int *flags);
 
 char *refs_resolve_refdup(struct ref_store *refs,
 			  const char *refname, int resolve_flags,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4400e18eee..61f3690299 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -189,7 +189,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 			if (!refs_resolve_ref_unsafe(&refs->base,
 						     refname.buf,
 						     RESOLVE_REF_READING,
-						     oid.hash, &flag)) {
+						     &oid, &flag)) {
 				oidclr(&oid);
 				flag |= REF_ISBROKEN;
 			} else if (is_null_oid(&oid)) {
@@ -890,7 +890,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	files_ref_path(refs, &ref_file, refname);
 	resolved = !!refs_resolve_ref_unsafe(&refs->base,
 					     refname, resolve_flags,
-					     lock->old_oid.hash, type);
+					     &lock->old_oid, type);
 	if (!resolved && errno == EISDIR) {
 		/*
 		 * we are trying to lock foo but we used to
@@ -909,7 +909,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 		}
 		resolved = !!refs_resolve_ref_unsafe(&refs->base,
 						     refname, resolve_flags,
-						     lock->old_oid.hash, type);
+						     &lock->old_oid, type);
 	}
 	if (!resolved) {
 		last_errno = errno;
@@ -1286,7 +1286,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 
 	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
 				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				orig_oid.hash, &flag)) {
+				&orig_oid, &flag)) {
 		ret = error("refname %s not found", oldrefname);
 		goto out;
 	}
diff --git a/sequencer.c b/sequencer.c
index f1f895774a..982fc35caf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -488,7 +488,7 @@ static int is_index_unchanged(void)
 	struct object_id head_oid;
 	struct commit *head_commit;
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		return error(_("could not resolve HEAD commit\n"));
 
 	head_commit = lookup_commit(&head_oid);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index cea3285ada..d846c88ed2 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -127,15 +127,15 @@ static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
 
 static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	const char *refname = notnull(*argv++, "refname");
 	int resolve_flags = arg_flags(*argv++, "resolve-flags");
 	int flags;
 	const char *ref;
 
 	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-				      sha1, &flags);
-	printf("%s %s 0x%x\n", sha1_to_hex(sha1), ref, flags);
+				      &oid, &flags);
+	printf("%s %s 0x%x\n", oid_to_hex(&oid), ref, flags);
 	return ref ? 0 : 1;
 }
 
diff --git a/transport-helper.c b/transport-helper.c
index 640ce5a492..bf05a2dcf1 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -942,10 +942,9 @@ static int push_refs_with_export(struct transport *transport,
 					int flag;
 
 					/* Follow symbolic refs (mainly for HEAD). */
-					name = resolve_ref_unsafe(
-						 ref->peer_ref->name,
-						 RESOLVE_REF_READING,
-						 oid.hash, &flag);
+					name = resolve_ref_unsafe(ref->peer_ref->name,
+								  RESOLVE_REF_READING,
+								  &oid, &flag);
 					if (!name || !(flag & REF_ISSYMREF))
 						name = ref->peer_ref->name;
 
diff --git a/worktree.c b/worktree.c
index cb35db03fa..2799abd555 100644
--- a/worktree.c
+++ b/worktree.c
@@ -31,7 +31,7 @@ static void add_head_info(struct worktree *wt)
 	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
 					 "HEAD",
 					 0,
-					 wt->head_oid.hash, &flags);
+					 &wt->head_oid, &flags);
 	if (!target)
 		return;
 
-- 
2.14.2.822.g60be5d43e6

