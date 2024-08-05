Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3015E5B8
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878664; cv=none; b=F+4dMT5Zc/Kge3Sdq1tF0dMRd/KOUY8xxAN0tWHwN1b3z0XeL9QPzzouI2otZKFbvTanoebzYX6J4jTsuQG0lyb+Pf7gdDlFrG28nQ+MB5YnQNxme01uGUtwLkSAp2FZyx6zGc7+3LAnReQZ4DnxuKUBggfsRgKfY0dgtyIrxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878664; c=relaxed/simple;
	bh=gt97o2e6ruzOWrkZKYqgT0injixU32FGOXQQgiYU3Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n3/mlP6/Fwze7ax8IxaoC+PuW/Dxva4YvugLVkh+NwByVZZkRWS91klKKSD8FdtP9WJ9fmgh//I0RSErbemqewt6y7B9lqK1xhqubRVowea3GWLvFIYamQdQT1ibOisky6s2ka1TgCderqFh4oFamk4v1WRiZpSlXyabZUa/wdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qzj3Ngdz; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qzj3Ngdz"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 751C61894D;
	Mon,  5 Aug 2024 13:24:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gt97o2e6ruzOWrkZKYqgT0injixU32FGOXQQgi
	YU3Hk=; b=Qzj3NgdzJff6c1n81+Sdoph5ojK6SDOy2VcYmz8sJ+MGfdSxNPvDI2
	QnU+zzhZMicqZ3a8MQCiIsbUWFyxWBgfSoyY5qUQ3lFFSFAOLYp9ZrDKibKGE3wa
	pZ6KVTNpLpIDwiZbfgdzhtYAWbhwDBnbpD7cI6mqOsZ3igoGcMlzM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E7E71894B;
	Mon,  5 Aug 2024 13:24:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6199E1894A;
	Mon,  5 Aug 2024 13:24:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Sven Strickroth via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Sven Strickroth
 <email@cs-ware.de>
Subject: Re: [PATCH] repository: prevent memory leak when releasing ref stores
In-Reply-To: <xmqq34nj3pez.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	05 Aug 2024 09:28:04 -0700")
References: <pull.1758.git.git.1722855364436.gitgitgadget@gmail.com>
	<xmqq34nj3pez.fsf@gitster.g>
Date: Mon, 05 Aug 2024 10:24:10 -0700
Message-ID: <xmqqed723mth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 883033EE-534F-11EF-82C7-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> However, I am fuzzy on the existing uses in the backend
> implementation.  For example:
>
>         static void files_ref_store_release(struct ref_store *ref_store)
>         {
>                 struct files_ref_store *refs = files_downcast(ref_store, 0, "release");
>                 free_ref_cache(refs->loose);
>                 free(refs->gitcommondir);
>                 ref_store_release(refs->packed_ref_store);
>         }
>
> The packed-ref-store is "released" here, as part of "releasing" the
> files-ref-store that uses it as a fallback backend.  The caller of
> files_ref_store_release() is refs.c:ref_store_release()
>
>         void ref_store_release(struct ref_store *ref_store)
>         {
>                 ref_store->be->release(ref_store);
>                 free(ref_store->gitdir);
>         }
>
> So if you have a files based ref store, when you are done you'd be
> calling ref_store_release() on it, releasing the resources held by
> the files_ref_store structure, but I do not know who frees the
> packed_ref_store allocated by files_ref_store_init().  Perhaps it is
> already leaking?  If that is the case then an API update like I
> suggested above would make even more sense to make it less likely
> for such a leak to be added to the system in the future, I suspect.

Ahh, that was the leak that you plugged in a separate patch.

So it does point us in the other direction to redefine _release with
a different behaviour that releases the resource held by the
structure, and frees the structure itself.

Something along the following line (caution: totally untested) that
allows your two patches to become empty, and also allows a few
callers to lose their existing explicit free()s immediately after
they call _release(), perhaps?

If this were to become a real patch, I think debug backend should
learn to use the same _downcast() to become more like the real ones
before it happens in a preliminary clean-up patch.

 refs.h                  |  5 +++--
 refs.c                  | 19 ++++++++-----------
 refs/refs-internal.h    |  2 +-
 refs/files-backend.c    |  6 +++---
 refs/packed-backend.c   |  5 +++--
 refs/reftable-backend.c |  6 +++---
 refs/debug.c            |  6 +++---
 7 files changed, 24 insertions(+), 25 deletions(-)

diff --git c/refs.h w/refs.h
index b3e39bc257..e4f092f6ac 100644
--- c/refs.h
+++ w/refs.h
@@ -119,9 +119,10 @@ int is_branch(const char *refname);
 int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err);
 
 /*
- * Release all memory and resources associated with the ref store.
+ * Release all memory and resources associated with the ref store, including
+ * the ref_store itself.
  */
-void ref_store_release(struct ref_store *ref_store);
+void ref_store_release(struct ref_store **ref_store);
 
 /*
  * Remove the ref store from disk. This deletes all associated data.
diff --git c/refs.c w/refs.c
index 915aeb4d1d..cb76a5d4bd 100644
--- c/refs.c
+++ w/refs.c
@@ -1936,10 +1936,11 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	return refs;
 }
 
-void ref_store_release(struct ref_store *ref_store)
+void ref_store_release(struct ref_store **ref_store)
 {
-	ref_store->be->release(ref_store);
-	free(ref_store->gitdir);
+	(*ref_store)->be->release(ref_store);
+	free((*ref_store)->gitdir);
+	FREE_AND_NULL(*ref_store);
 }
 
 struct ref_store *get_main_ref_store(struct repository *r)
@@ -2848,8 +2849,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 * be closed. This is required for platforms like Cygwin, where
 	 * renaming an open file results in EPERM.
 	 */
-	ref_store_release(new_refs);
-	FREE_AND_NULL(new_refs);
+	ref_store_release(&new_refs);
 
 	/*
 	 * Until now we were in the non-destructive phase, where we only
@@ -2887,8 +2887,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 * make sure to lazily re-initialize the repository's ref store with
 	 * the new format.
 	 */
-	ref_store_release(old_refs);
-	FREE_AND_NULL(old_refs);
+	ref_store_release(&old_refs);
 	repo->refs_private = NULL;
 
 	ret = 0;
@@ -2900,10 +2899,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 			    new_gitdir.buf);
 	}
 
-	if (new_refs) {
-		ref_store_release(new_refs);
-		free(new_refs);
-	}
+	if (new_refs)
+		ref_store_release(&new_refs);
 	ref_transaction_free(transaction);
 	strbuf_release(&new_gitdir);
 	return ret;
diff --git c/refs/refs-internal.h w/refs/refs-internal.h
index fa975d69aa..2ba2372acb 100644
--- c/refs/refs-internal.h
+++ w/refs/refs-internal.h
@@ -511,7 +511,7 @@ typedef struct ref_store *ref_store_init_fn(struct repository *repo,
 /*
  * Release all memory and resources associated with the ref store.
  */
-typedef void ref_store_release_fn(struct ref_store *refs);
+typedef void ref_store_release_fn(struct ref_store **refs);
 
 typedef int ref_store_create_on_disk_fn(struct ref_store *refs,
 					int flags,
diff --git c/refs/files-backend.c w/refs/files-backend.c
index aa52d9be7c..8ebb1681ac 100644
--- c/refs/files-backend.c
+++ w/refs/files-backend.c
@@ -151,12 +151,12 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
 	return refs;
 }
 
-static void files_ref_store_release(struct ref_store *ref_store)
+static void files_ref_store_release(struct ref_store **ref_store)
 {
-	struct files_ref_store *refs = files_downcast(ref_store, 0, "release");
+	struct files_ref_store *refs = files_downcast(*ref_store, 0, "release");
 	free_ref_cache(refs->loose);
 	free(refs->gitcommondir);
-	ref_store_release(refs->packed_ref_store);
+	ref_store_release(&refs->packed_ref_store);
 }
 
 static void files_reflog_path(struct files_ref_store *refs,
diff --git c/refs/packed-backend.c w/refs/packed-backend.c
index a0666407cd..8321a4cc17 100644
--- c/refs/packed-backend.c
+++ w/refs/packed-backend.c
@@ -260,13 +260,14 @@ static void clear_snapshot(struct packed_ref_store *refs)
 	}
 }
 
-static void packed_ref_store_release(struct ref_store *ref_store)
+static void packed_ref_store_release(struct ref_store **ref_store)
 {
-	struct packed_ref_store *refs = packed_downcast(ref_store, 0, "release");
+	struct packed_ref_store *refs = packed_downcast(*ref_store, 0, "release");
 	clear_snapshot(refs);
 	rollback_lock_file(&refs->lock);
 	delete_tempfile(&refs->tempfile);
 	free(refs->path);
+	FREE_AND_NULL(*ref_store);
 }
 
 static NORETURN void die_unterminated_line(const char *path,
diff --git c/refs/reftable-backend.c w/refs/reftable-backend.c
index fbe74c239d..0af010acfb 100644
--- c/refs/reftable-backend.c
+++ w/refs/reftable-backend.c
@@ -337,9 +337,9 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	return &refs->base;
 }
 
-static void reftable_be_release(struct ref_store *ref_store)
+static void reftable_be_release(struct ref_store **ref_store)
 {
-	struct reftable_ref_store *refs = reftable_be_downcast(ref_store, 0, "release");
+	struct reftable_ref_store *refs = reftable_be_downcast(*ref_store, 0, "release");
 	struct strmap_entry *entry;
 	struct hashmap_iter iter;
 
@@ -400,7 +400,7 @@ static int reftable_be_remove_on_disk(struct ref_store *ref_store,
 	 * required so that the "tables.list" file is not open anymore, which
 	 * would otherwise make it impossible to remove the file on Windows.
 	 */
-	reftable_be_release(ref_store);
+	reftable_be_release(&ref_store);
 
 	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
 	if (remove_dir_recursively(&sb, 0) < 0) {
diff --git c/refs/debug.c w/refs/debug.c
index 547d9245b9..be6230045c 100644
--- c/refs/debug.c
+++ w/refs/debug.c
@@ -33,10 +33,10 @@ struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_stor
 	return (struct ref_store *)res;
 }
 
-static void debug_release(struct ref_store *refs)
+static void debug_release(struct ref_store **refs)
 {
-	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
-	drefs->refs->be->release(drefs->refs);
+	struct debug_ref_store *drefs = *(struct debug_ref_store **)refs;
+	drefs->refs->be->release(&drefs->refs);
 	trace_printf_key(&trace_refs, "release\n");
 }
 
