Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A834846F
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321887; cv=none; b=EMDwas79OKo07OWe1nfGrPUlFtA5zw1ofFRVo4UC/h7zF1z3S03SHcD7y4i3cd3UdUBtzLArT8BQuTrnz9bDjonZ7SBDJU/2WhkIOF8x4shKPETsHTrSJ+IAPeOn4/aY0+p39prX5MpenB8POC9qsskL06JqskusQKqvaDtl09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321887; c=relaxed/simple;
	bh=qvuwjRRSuTm/tk6Mop7hdGFAPeDX+eL7GnZ7aaf8LNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS6mQsGYJUUB3BsUL/4gDWaBoZmlPu3RIfaDXe9mfb7jqL6S1VfX3MxwgkFsheaPkcSGOe4up+UKpLcLRm2qSmUaTXFX5mmHxxcBHYFRyIQjR1cxzp63atIzValkoTxWFMrDW+TqiI/BUuWT+58sCixCOUZcwlg8oYsip4l709I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Da1NjNzo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Da1NjNzo"
Received: (qmail 1916 invoked by uid 109); 4 Aug 2025 15:38:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qvuwjRRSuTm/tk6Mop7hdGFAPeDX+eL7GnZ7aaf8LNc=; b=Da1NjNzop07FiUmBUDhUey1SqKiUWIH7jFwCwUA7worXDF+5wWZs+5n+XfMAwHZN7KDHPeb3RmDvtybx2yr6JieEQi6cAWJbS1ykP/oAEKp2gtzdQE6ecG/uZBffyt2YOu2/AgCo/0d4+GhbAzRtYXUoA0nFCKQ0loNHLn+z0JWvNF8XfQu2EPhVCnVA8j85uw7axIx3g6XEa3ac08ybucleKsy4UOBjy8CLbBYyLaMUnI+PHkDJUqwSUrpp+L0k11aXA/INcsRtLoK2nupVqGFyWJ1tv1iS9MPxBSgb0qvueyRiMC3o0/sdWgfzkAS7LQ00Z7TBwMpwQWgNvKVEcA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Aug 2025 15:38:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21416 invoked by uid 111); 4 Aug 2025 15:38:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Aug 2025 11:38:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Aug 2025 11:38:03 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 7/9] refs/files: detect race when generating reflog
 entry for HEAD
Message-ID: <20250804153803.GB109984@coredump.intra.peff.net>
References: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
 <20250804-pks-reflog-append-v4-7-13213fef7200@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804-pks-reflog-append-v4-7-13213fef7200@pks.im>

On Mon, Aug 04, 2025 at 11:46:07AM +0200, Patrick Steinhardt wrote:

> +		/*
> +		 * Check that "HEAD" didn't racily change since we have looked
> +		 * it up. If it did we remove the reflog-only updateg from the
> +		 * transaction again.
> +		 *
> +		 * Note that this does not catch all races: if "HEAD" was
> +		 * racily changed to point to one of the refs part of the
> +		 * transaction then we would miss writing the split reflog
> +		 * entry for "HEAD".
> +		 */
> +		if (!(update->type & REF_ISSYMREF) ||
> +		    strcmp(update->parent_update->refname, referent.buf)) {
> +			if (unlock_ref(lock))
> +				strmap_remove(&backend_data->ref_locks,
> +					      update->refname, 0);
> +
> +			memmove(transaction->updates + update_idx,
> +				transaction->updates + update_idx + 1,
> +				(transaction->nr - update_idx - 1) * sizeof(*transaction->updates));
> +			transaction->nr--;
> +
> +			ret = 1;
> +			goto out;
> +		}

OK, so this is basically the same as the patch you posted earlier. Let's
see how it fares with my hacky GIT_TEST_FORCE_SPLIT_HEAD_UPDATE patch:

  $ GIT_TEST_FORCE_SPLIT_HEAD_UPDATE=1 git branch foo HEAD^
  fatal:

Yikes. I'm not sure if there's a bug here, or if my hacky patch is
violating some other assumption. It looks like we get to the die() call
in branch.c:create_branch() because the transaction reports failure, but
with an empty err strbuf.

Ah, I think I see it. When we return from lock_ref_for_update(), we've
set "ret" to "1", indicating we are skipping the update. But then we do
this:

  if (ret > 0)
	continue;

I think there are two problems there:

  1. That "ret" is also used as our return from
     files_transaction_prepare(). So if this is the last update in the
     transaction, then we return "1", rather than "0" for success, and
     the caller thinks there was an error.

  2. If it's not the last transaction, then we go to the next element in
     the loop. But because it's a for-loop, we still increment "i",
     which is wrong (because we shrunk the transaction list). We need to
     check that "i" again.

So maybe:

@@ -2910,8 +2914,11 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					  head_ref, &refnames_to_check,
 					  err);
 		if (ret) {
-			if (ret > 0)
+			if (ret > 0) {
+				ret = 0; /* not an error; we skipped it */
+				i--; /* we shrunk the list */
 				continue;
+			}
 			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
 				strbuf_reset(err);
 				ret = 0;

I confirmed that fixes case (1). I guess I could test case (2) with a
bigger transaction involving multiple refs, but it's awkward because my
"force split update" patch would try to create multiple HEAD updates. :-/

I guess maybe it should be "pretend HEAD is this", like so:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 851b1b33f4..564b77d0da 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2895,6 +2895,14 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		FREE_AND_NULL(head_ref);
 	}
 
+	{
+		const char *v = getenv("GIT_TEST_PRETEND_SPLIT_HEAD");
+		if (v) {
+			free(head_ref);
+			head_ref = xstrdup(v);
+		}
+	}
+
 	/*
 	 * Acquire all locks, verify old values if provided, check
 	 * that new values are valid, and write new values to the

We have to be a bit tricky here. The split head update is always added
at the end during the transaction preparation. So we need a situation
where another update is added _after_ that. I guess it would be another
symref split (but done by updating the symref).

So:

  git symbolic-ref refs/heads/SYMREF refs/heads/dest
  (
    echo "create refs/heads/foo HEAD"
    echo "create refs/heads/SYMREF HEAD"
  ) |
  GIT_TEST_PRETEND_SPLIT_HEAD=refs/heads/foo git update-ref --stdin

ends up with four updates:

  - the original create foo
  - the original create SYMREF
  - the reflog update of HEAD from split_head_update()
  - the update of refs/heads/dest from split_symref_update()

And indeed, running that through the debugger shows that we'd otherwise
skip the final update with your patch (but the extra "i--" fixes it).

I also tried this with SANITIZE=leak, and I think you'd need something
like this, as well:

diff --git a/refs.c b/refs.c
index 946eb48941..27c182e107 100644
--- a/refs.c
+++ b/refs.c
@@ -1184,6 +1184,15 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 	return tr;
 }
 
+void ref_update_free(struct ref_update *u)
+{
+	free(u->msg);
+	free(u->committer_info);
+	free((char *)u->new_target);
+	free((char *)u->old_target);
+	free(u);
+}
+
 void ref_transaction_free(struct ref_transaction *transaction)
 {
 	size_t i;
@@ -1204,13 +1213,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		break;
 	}
 
-	for (i = 0; i < transaction->nr; i++) {
-		free(transaction->updates[i]->msg);
-		free(transaction->updates[i]->committer_info);
-		free((char *)transaction->updates[i]->new_target);
-		free((char *)transaction->updates[i]->old_target);
-		free(transaction->updates[i]);
-	}
+	for (i = 0; i < transaction->nr; i++)
+		ref_update_free(transaction->updates[i]);
 
 	if (transaction->rejections)
 		free(transaction->rejections->update_indices);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 851b1b33f4..0246715383 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2640,6 +2640,7 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 				transaction->updates + update_idx + 1,
 				(transaction->nr - update_idx - 1) * sizeof(*transaction->updates));
 			transaction->nr--;
+			ref_update_free(update);
 
 			ret = 1;
 			goto out;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 95a4dc3902..6b5895a3b3 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -144,6 +144,8 @@ struct ref_update {
 	const char refname[FLEX_ARRAY];
 };
 
+void ref_update_free(struct ref_update *);
+
 int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);

It's a little hard to see that freeing update inside
lock_ref_for_update() is safe (but we "goto out" after and don't look at
it again). I think it would all be a bit more obvious if
lock_ref_for_update() just returned 1 for "skip this", and then the
caller actually shrunk the transaction list.

-Peff
