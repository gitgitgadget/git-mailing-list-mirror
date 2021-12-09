Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4092FC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhLIFGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhLIFGI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:06:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AFDC0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:02:35 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d24so7761847wra.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1t6fUM9dIfjv8mULemZn5mxf9x0t/L0TWKqYPZZE0Rw=;
        b=A3kocVSTugxjb02zcfmREPI6Zc2zMHrPvJTJHa/7OE74LLP3/+e7zqTBtDPXH6qpag
         mNQADOcX6IMYeC4HdiL07pkeqyXGKCSMNxfJARL8NXxiXO1SsFr+XeVQtcjukZsjnIl/
         Xzg3tRv/g+FmWXhikJNYOyGZASXv1jHbfYlvy1s0Gmfgv0DAfRaRS5+jz1uKxFeWWuIz
         zvMha7t+kZmigeMS5hj0kW1rAPGUnykP6iqKETmYouZndAyPh1Ua3eqDWT9+oPu4AFCA
         k24RHUG7nXbBUlE/UAVGw2hl6dnroVezrBQOETzBR+b56dAqOmMp5/fVU9bC2HWh4BAy
         guzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1t6fUM9dIfjv8mULemZn5mxf9x0t/L0TWKqYPZZE0Rw=;
        b=q2bgXKsFdlg0SEdi8zrOCIY4mr/xj3ry4lgsg5tc7Pc0wsqdKAKSKTTBHK6cH/U7nL
         VMut8f6SD7TpT42H11RvxDDjosrUPzE+LhUbtJiOl3yOiIQIZSn/l45Qt7e/I+VdsTbZ
         HofnZ35O22hpNF972Uf4DdZ4XGCBSDfQRvgWA61SgHihNiCr/pFo0JrvdNkTVR6ns6F1
         bisvlDUMFNVAJS+YeRWQ7cdZxDdEKQA1k7aszA8cdtdH1HhRJLtV7lM6Ek3buZIrhl3Y
         S4qKNUnxGijMwKHM3DKJytCK2Y3xWklanFVErQCvUj8n4gnpXxWAV/QQNhBE2lhPt8no
         0lfw==
X-Gm-Message-State: AOAM530x2O3Z5jpX6GBb+aYGjwcFQ1RsBLUQxq5AVza1QpV+IdZwOH2n
        A1fu1KoAl3tsnVWfpr1x/xEaTnXDouCgmg==
X-Google-Smtp-Source: ABdhPJwmdH7x75tpafzzL8NOqnV67Hjpz1buvR/PgX4e1Arb426MGbJm83bCyr/XrirdICAg7ZMjRg==
X-Received: by 2002:adf:e843:: with SMTP id d3mr3648405wrn.452.1639026153911;
        Wed, 08 Dec 2021 21:02:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w22sm4270394wmi.27.2021.12.08.21.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:02:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] refs API: remove "failure_errno" from refs_resolve_ref_unsafe()
Date:   Thu,  9 Dec 2021 06:02:28 +0100
Message-Id: <patch-3.3-a42539d103c-20211209T045735Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g218b4aae189
In-Reply-To: <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com>
References: <xmqqo85q2a42.fsf@gitster.g> <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the now-unused "failure_errno" parameter from the
refs_resolve_ref_unsafe() signature. In my recent 96f6623ada0 (Merge
branch 'ab/refs-errno-cleanup', 2021-11-29) series we made all of its
callers explicitly request the errno via an output parameter.

As that series shows all but one caller ended up passing in a
boilerplate "ignore_errno", since they only cared about whether the
return value was NULL or not, i.e. if the ref could be resolved.

There was one caller left in sequencer.c that used the
"failure_errnO', but as of the preceding commit it doesn't use that
"failure_errno" either.

So let's remove this output parameter. Not only isn't it used now, but
we'd like to slowly move the refs API to a more file-backend
independent way of communicating error codes, having it use a
"failure_errno" was only the first step in that direction. If this or
any other function needs to communicate what specifically is wrong
with the requested "refname" it'll be better to have the function set
some output enum of well-defined error states than piggy-backend on
"errno".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c                    | 51 +++++++++++++--------------------------
 refs.h                    |  7 +-----
 refs/files-backend.c      | 31 +++++++-----------------
 sequencer.c               |  4 +--
 t/helper/test-ref-store.c |  3 +--
 worktree.c                | 11 +++------
 6 files changed, 32 insertions(+), 75 deletions(-)

diff --git a/refs.c b/refs.c
index 533cf5a2b2e..4b1f990213d 100644
--- a/refs.c
+++ b/refs.c
@@ -269,10 +269,9 @@ char *refs_resolve_refdup(struct ref_store *refs,
 			  struct object_id *oid, int *flags)
 {
 	const char *result;
-	int ignore_errno;
 
 	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-					 oid, flags, &ignore_errno);
+					 oid, flags);
 	return xstrdup_or_null(result);
 }
 
@@ -294,11 +293,10 @@ struct ref_filter {
 
 int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid, int *flags)
 {
-	int ignore_errno;
 	struct ref_store *refs = get_main_ref_store(the_repository);
 
 	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-				    oid, flags, &ignore_errno))
+				    oid, flags))
 		return 0;
 	return -1;
 }
@@ -310,9 +308,8 @@ int read_ref(const char *refname, struct object_id *oid)
 
 int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
-	int ignore_errno;
 	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING,
-					 NULL, NULL, &ignore_errno);
+					 NULL, NULL);
 }
 
 int ref_exists(const char *refname)
@@ -656,15 +653,13 @@ int expand_ref(struct repository *repo, const char *str, int len,
 		struct object_id *this_result;
 		int flag;
 		struct ref_store *refs = get_main_ref_store(repo);
-		int ignore_errno;
 
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
 		r = refs_resolve_ref_unsafe(refs, fullref.buf,
 					    RESOLVE_REF_READING,
-					    this_result, &flag,
-					    &ignore_errno);
+					    this_result, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
@@ -693,14 +688,12 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 	for (p = ref_rev_parse_rules; *p; p++) {
 		struct object_id hash;
 		const char *ref, *it;
-		int ignore_errno;
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
 		ref = refs_resolve_ref_unsafe(refs, path.buf,
 					      RESOLVE_REF_READING,
-					      oid ? &hash : NULL, NULL,
-					      &ignore_errno);
+					      oid ? &hash : NULL, NULL);
 		if (!ref)
 			continue;
 		if (refs_reflog_exists(refs, path.buf))
@@ -1382,10 +1375,9 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
-	int ignore_errno;
 
 	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
-				    &oid, &flag, &ignore_errno))
+				    &oid, &flag))
 		return fn("HEAD", &oid, flag, cb_data);
 
 	return 0;
@@ -1674,15 +1666,13 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
 				    struct object_id *oid,
-				    int *flags, int *failure_errno)
+				    int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
 	int unused_flags;
 	int symref_count;
 
-	assert(failure_errno);
-
 	if (!oid)
 		oid = &unused_oid;
 	if (!flags)
@@ -1692,10 +1682,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-		    !refname_is_safe(refname)) {
-			*failure_errno = EINVAL;
+		    !refname_is_safe(refname))
 			return NULL;
-		}
 
 		/*
 		 * dwim_ref() uses REF_ISBROKEN to distinguish between
@@ -1710,9 +1698,10 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
+		int failure_errno;
 
 		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
-				      &read_flags, failure_errno)) {
+				      &read_flags, &failure_errno)) {
 			*flags |= read_flags;
 
 			/* In reading mode, refs must eventually resolve */
@@ -1724,9 +1713,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 			 * may show errors besides ENOENT if there are
 			 * similarly-named refs.
 			 */
-			if (*failure_errno != ENOENT &&
-			    *failure_errno != EISDIR &&
-			    *failure_errno != ENOTDIR)
+			if (failure_errno != ENOENT &&
+			    failure_errno != EISDIR &&
+			    failure_errno != ENOTDIR)
 				return NULL;
 
 			oidclr(oid);
@@ -1752,16 +1741,13 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		}
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-			    !refname_is_safe(refname)) {
-				*failure_errno = EINVAL;
+			    !refname_is_safe(refname))
 				return NULL;
-			}
 
 			*flags |= REF_ISBROKEN | REF_BAD_NAME;
 		}
 	}
 
-	*failure_errno = ELOOP;
 	return NULL;
 }
 
@@ -1776,10 +1762,8 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags)
 {
-	int ignore_errno;
-
 	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refname,
-				       resolve_flags, oid, flags, &ignore_errno);
+				       resolve_flags, oid, flags);
 }
 
 int resolve_gitlink_ref(const char *submodule, const char *refname,
@@ -1787,15 +1771,14 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 {
 	struct ref_store *refs;
 	int flags;
-	int ignore_errno;
 
 	refs = get_submodule_ref_store(submodule);
 
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags,
-				     &ignore_errno) || is_null_oid(oid))
+	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
+	    is_null_oid(oid))
 		return -1;
 	return 0;
 }
diff --git a/refs.h b/refs.h
index 45c34e99e3a..859dfe946af 100644
--- a/refs.h
+++ b/refs.h
@@ -58,11 +58,6 @@ struct worktree;
  * resolved. The function returns NULL for such ref names.
  * Caps and underscores refers to the special refs, such as HEAD,
  * FETCH_HEAD and friends, that all live outside of the refs/ directory.
- *
- * Callers should not inspect "errno" on failure, but rather pass in a
- * "failure_errno" parameter, on failure the "errno" will indicate the
- * type of failure encountered, but not necessarily one that came from
- * a syscall. We might have faked it up.
  */
 #define RESOLVE_REF_READING 0x01
 #define RESOLVE_REF_NO_RECURSE 0x02
@@ -72,7 +67,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
 				    struct object_id *oid,
-				    int *flags, int *failure_errno);
+				    int *flags);
 
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 85e195a2573..0356debdaff 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -282,11 +282,10 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len));
 		} else {
-			int ignore_errno;
 			if (!refs_resolve_ref_unsafe(&refs->base,
 						     refname.buf,
 						     RESOLVE_REF_READING,
-						     &oid, &flag, &ignore_errno)) {
+						     &oid, &flag)) {
 				oidclr(&oid);
 				flag |= REF_ISBROKEN;
 			} else if (is_null_oid(&oid)) {
@@ -1011,7 +1010,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
-	int ignore_errno;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -1039,7 +1037,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	}
 
 	if (!refs_resolve_ref_unsafe(&refs->base, lock->ref_name, 0,
-				     &lock->old_oid, NULL, &ignore_errno))
+				     &lock->old_oid, NULL))
 		oidclr(&lock->old_oid);
 	goto out;
 
@@ -1403,7 +1401,6 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	struct strbuf tmp_renamed_log = STRBUF_INIT;
 	int log, ret;
 	struct strbuf err = STRBUF_INIT;
-	int ignore_errno;
 
 	files_reflog_path(refs, &sb_oldref, oldrefname);
 	files_reflog_path(refs, &sb_newref, newrefname);
@@ -1417,7 +1414,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
 				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				     &orig_oid, &flag, &ignore_errno)) {
+				     &orig_oid, &flag)) {
 		ret = error("refname %s not found", oldrefname);
 		goto out;
 	}
@@ -1463,7 +1460,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	 */
 	if (!copy && refs_resolve_ref_unsafe(&refs->base, newrefname,
 					     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-					     NULL, NULL, &ignore_errno) &&
+					     NULL, NULL) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
 			    NULL, REF_NO_DEREF)) {
 		if (errno == EISDIR) {
@@ -1828,12 +1825,10 @@ static int commit_ref_update(struct files_ref_store *refs,
 		 */
 		int head_flag;
 		const char *head_ref;
-		int ignore_errno;
 
 		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
 						   RESOLVE_REF_READING,
-						   NULL, &head_flag,
-						   &ignore_errno);
+						   NULL, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
@@ -1877,12 +1872,10 @@ static void update_symref_reflog(struct files_ref_store *refs,
 {
 	struct strbuf err = STRBUF_INIT;
 	struct object_id new_oid;
-	int ignore_errno;
 
 	if (logmsg &&
 	    refs_resolve_ref_unsafe(&refs->base, target,
-				    RESOLVE_REF_READING, &new_oid, NULL,
-				    &ignore_errno) &&
+				    RESOLVE_REF_READING, &new_oid, NULL) &&
 	    files_log_ref_write(refs, refname, &lock->old_oid,
 				&new_oid, logmsg, 0, &err)) {
 		error("%s", err.buf);
@@ -2156,7 +2149,6 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		(struct files_reflog_iterator *)ref_iterator;
 	struct dir_iterator *diter = iter->dir_iterator;
 	int ok;
-	int ignore_errno;
 
 	while ((ok = dir_iterator_advance(diter)) == ITER_OK) {
 		int flags;
@@ -2170,8 +2162,7 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (!refs_resolve_ref_unsafe(iter->ref_store,
 					     diter->relative_path, 0,
-					     &iter->oid, &flags,
-					     &ignore_errno)) {
+					     &iter->oid, &flags)) {
 			error("bad ref for %s", diter->path.buf);
 			continue;
 		}
@@ -2515,11 +2506,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * the transaction, so we have to read it here
 			 * to record and possibly check old_oid:
 			 */
-			int ignore_errno;
 			if (!refs_resolve_ref_unsafe(&refs->base,
 						     referent.buf, 0,
-						     &lock->old_oid, NULL,
-						     &ignore_errno)) {
+						     &lock->old_oid, NULL)) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
@@ -3210,14 +3199,12 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 		if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 		    !is_null_oid(&cb.last_kept_oid)) {
-			int ignore_errno;
 			int type;
 			const char *ref;
 
 			ref = refs_resolve_ref_unsafe(&refs->base, refname,
 						      RESOLVE_REF_NO_RECURSE,
-						      NULL, &type,
-						      &ignore_errno);
+						      NULL, &type);
 			update = !!(ref && !(type & REF_ISSYMREF));
 		}
 
diff --git a/sequencer.c b/sequencer.c
index a649bd737ba..d2002513cbe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1285,7 +1285,6 @@ void print_commit_summary(struct repository *r,
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
 	struct ref_store *refs;
-	int ignore_errno;
 
 	commit = lookup_commit(r, oid);
 	if (!commit)
@@ -1336,8 +1335,7 @@ void print_commit_summary(struct repository *r,
 	diff_setup_done(&rev.diffopt);
 
 	refs = get_main_ref_store(the_repository);
-	head = refs_resolve_ref_unsafe(refs, "HEAD", 0, NULL, NULL,
-				       &ignore_errno);
+	head = refs_resolve_ref_unsafe(refs, "HEAD", 0, NULL, NULL);
 	if (!head)
 		die(_("unable to resolve HEAD after creating commit"));
 	if (!strcmp(head, "HEAD"))
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 3986665037a..b314b81a45b 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -123,10 +123,9 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 	int resolve_flags = arg_flags(*argv++, "resolve-flags");
 	int flags;
 	const char *ref;
-	int ignore_errno;
 
 	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-				      &oid, &flags, &ignore_errno);
+				      &oid, &flags);
 	printf("%s %s 0x%x\n", oid_to_hex(&oid), ref ? ref : "(null)", flags);
 	return ref ? 0 : 1;
 }
diff --git a/worktree.c b/worktree.c
index 2c155b10150..b127eda266b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -28,13 +28,11 @@ static void add_head_info(struct worktree *wt)
 {
 	int flags;
 	const char *target;
-	int ignore_errno;
 
 	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
 					 "HEAD",
 					 0,
-					 &wt->head_oid, &flags,
-					 &ignore_errno);
+					 &wt->head_oid, &flags);
 	if (!target)
 		return;
 
@@ -420,7 +418,6 @@ const struct worktree *find_shared_symref(const char *symref,
 		const char *symref_target;
 		struct ref_store *refs;
 		int flags;
-		int ignore_errno;
 
 		if (wt->is_bare)
 			continue;
@@ -438,8 +435,7 @@ const struct worktree *find_shared_symref(const char *symref,
 
 		refs = get_worktree_ref_store(wt);
 		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
-							NULL, &flags,
-							&ignore_errno);
+							NULL, &flags);
 		if ((flags & REF_ISSYMREF) &&
 		    symref_target && !strcmp(symref_target, target)) {
 			existing = wt;
@@ -567,7 +563,6 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 		struct worktree *wt = *p;
 		struct object_id oid;
 		int flag;
-		int ignore_errno;
 
 		if (wt->is_current)
 			continue;
@@ -577,7 +572,7 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 		if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 					    refname.buf,
 					    RESOLVE_REF_READING,
-					    &oid, &flag, &ignore_errno))
+					    &oid, &flag))
 			ret = fn(refname.buf, &oid, flag, cb_data);
 		if (ret)
 			break;
-- 
2.34.1.930.g218b4aae189

