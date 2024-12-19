Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614ED1A071C
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636813; cv=none; b=eLH0Cs02lO1gfsRnrCXCJiBAcFqqpe1ifHGpsjQzsNbt3eQgB5f7J+tkqhytOeO0hCYy9CG34jr1B2dEewl5kKF/LjWw+C5FWymeAyF3yop/XzTxmFKQ7cmCAmbbS+tfxQdYi3jLw9Z4XO+kgfIwmLPNbq1OxJwPfl0W6jgiCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636813; c=relaxed/simple;
	bh=6VdKuUWCKf5wY7w9RyC1nIVVjsRgh5zGRx42gtSOKxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=njrbTF7FHrazTTp/LgN+8muhqSIPITTRgsX1/ibLxMH6XJ8TQ3Zs4S1hRiY5OEwDnMsTnHYgFv+tqf3i8PzZGXVM0MC8LZyyc8YYMG75QJ61QYa+EB5MR+4fl3dwtwTd7796PFWjv4dyuF+f2zwvPhNRKNT8LjJXkVYJG9Q9M4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=xA48Gp01; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="xA48Gp01"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734636809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5Bt2rZr0pIphoQfMIKjzgCHzI3wjN3LdJJcE7ZaCM4=;
	b=xA48Gp01pPGUKXLYzkumzseZi/IwKzFC4yD1twAv3KtAIuc/PquuiBWqXfkL5XKx8yl4ma
	Kohs0O766V0t4P/QzsnuhY+yBONOhUX3eLVTsfOqIjgnCVd8kua+0TIl14bXwWiUKky6Yz
	eCYUUkwidhRZudcTp5k30mmyTuOJOcU=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 7/8] refs: allow multiple reflog entries for the same
 refname
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-7-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-7-d7cd3f197453@gmail.com>
Date: Thu, 19 Dec 2024 20:33:17 +0100
Message-ID: <871py3h3ia.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The reference transaction only allows a single update for a given
> reference to avoid conflicts. This, however, isn't an issue for reflogs.
> There are no conflicts to be resolved in reflogs and when migrating
> reflogs between backends we'd have multiple reflog entries for the same
> refname.
>
> So allow multiple reflog updates within a single transaction. Also the
> reflog creation logic isn't exposed to the end user. While this might
> change in the future, currently, this reduces the scope of issues to
> think about.
>
> In the reftable backend, the writer sorts all updates based on the
> update_index before writing to the block. When there are multiple
> reflogs for a given refname, it is essential that the order of the
> reflogs is maintained. So add the `index` value to the `update_index`.
> The `index` field is only set when multiple reflog entries for a given
> refname are added and as such in most scenarios the old behavior
> remains.
>
> This is required to add reflog migration support to `git refs migrate`.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/files-backend.c    | 15 +++++++++++----
>  refs/reftable-backend.c | 22 +++++++++++++++++++---
>  2 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index c11213f52065bcf2fa7612df8f9500692ee2d02c..8953d1c6d37b13b0db701888b3db92fd87a68aaa 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2611,6 +2611,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  
>  	update->backend_data = lock;
>  
> +	if (update->flags & REF_LOG_ONLY)
> +		goto out;
> +
>  	if (update->type & REF_ISSYMREF) {
>  		if (update->flags & REF_NO_DEREF) {
>  			/*
> @@ -2829,13 +2832,16 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  	 */
>  	for (i = 0; i < transaction->nr; i++) {
>  		struct ref_update *update = transaction->updates[i];
> -		struct string_list_item *item =
> -			string_list_append(&affected_refnames, update->refname);
> +		struct string_list_item *item;
>  
>  		if ((update->flags & REF_IS_PRUNING) &&
>  		    !(update->flags & REF_NO_DEREF))
>  			BUG("REF_IS_PRUNING set without REF_NO_DEREF");
>  
> +		if (update->flags & REF_LOG_ONLY)
> +			continue;
> +
> +		item = string_list_append(&affected_refnames, update->refname);
>  		/*
>  		 * We store a pointer to update in item->util, but at
>  		 * the moment we never use the value of this field
> @@ -3035,8 +3041,9 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  
>  	/* Fail if a refname appears more than once in the transaction: */
>  	for (i = 0; i < transaction->nr; i++)
> -		string_list_append(&affected_refnames,
> -				   transaction->updates[i]->refname);
> +		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
> +			string_list_append(&affected_refnames,
> +					   transaction->updates[i]->refname);
>  	string_list_sort(&affected_refnames);
>  	if (ref_update_reject_duplicates(&affected_refnames, err)) {
>  		ret = TRANSACTION_GENERIC_ERROR;
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index b2e3ba877de9e59fea5a4d066eb13e60ef22a32b..bec5962debea7b62572d08f6fa8fd38ab4cd8af6 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -990,8 +990,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  		if (ret)
>  			goto done;
>  
> -		string_list_append(&affected_refnames,
> -				   transaction->updates[i]->refname);
> +		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
> +			string_list_append(&affected_refnames,
> +					   transaction->updates[i]->refname);
>  	}
>  
>  	/*
> @@ -1301,6 +1302,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>  	struct reftable_log_record *logs = NULL;
>  	struct ident_split committer_ident = {0};
>  	size_t logs_nr = 0, logs_alloc = 0, i;
> +	uint64_t max_update_index = ts;
>  	const char *committer_info;
>  	int ret = 0;
>  
> @@ -1405,7 +1407,19 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>  				}
>  
>  				fill_reftable_log_record(log, &c);
> -				log->update_index = ts;
> +
> +				/*
> +				 * Updates are sorted by the writer. So updates for the same
> +				 * refname need to contain different update indices.
> +				 */
> +				log->update_index = ts + u->index;

During my review I was having a hard time figuring out when `u->index`
was not 0 and where it is being set. Can you maybe explain a bit?

> +
> +				/*
> +				 * Note the max update_index so the limit can be set later on.
> +				 */
> +				if (log->update_index > max_update_index)

Is there a lot of value in having this if clause? I was a bit confused
why it is here, because I think we can do the assignment to
max_update_index unconditionally.

> +					max_update_index = log->update_index;
> +
>  				log->refname = xstrdup(u->refname);
>  				memcpy(log->value.update.new_hash,
>  				       u->new_oid.hash, GIT_MAX_RAWSZ);
> @@ -1469,6 +1483,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>  	 * and log blocks.
>  	 */
>  	if (logs) {
> +		reftable_writer_set_limits(writer, ts, max_update_index);

So max_update_index is used to set the limits on the current writer, but
using reftable_stack_next_update_index() it's also used to give the next
stack it's starting point for their range. Now I'm not familiar enough
with the code, but are all stacks handled in sequential order? And how
does a stack relate to a reftable file?

> +
>  		ret = reftable_writer_add_logs(writer, logs, logs_nr);
>  		if (ret < 0)
>  			goto done;
>
> -- 
> 2.47.1
