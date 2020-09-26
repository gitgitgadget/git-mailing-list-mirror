Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98347C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 23:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB602388E
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 23:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EpxWWxTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgIZXmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 19:42:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58570 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIZXmS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 19:42:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CC6CA3837;
        Sat, 26 Sep 2020 19:42:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CpubPqgX0Gb69Lu7QmlyCqgIwuo=; b=EpxWWx
        TpYB7IQWARU7Q0GRiaRFDNSd5hnSpuw6fmwvCAL+zEOF/qMvSmxvdkWjwOfO/bIo
        2SPiw4TTUckSgOGnGPSzMGVpPWsVwNdVCCr+s4Bm3np1m9eX3TjGOy3UsNHSaz0R
        r1cbB1CCeKExkH9Kwyvaqf5BnBDkAV++HCOlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XpwVcTreLxuHTs6N0zSW27bGCETRhkhX
        1pa21SNdbjfiIsEBbCJWNvm7oAencfnsA5CDEP6z0+7HRFsGpsxDUdKxtNG+DV3k
        8UNTDRVWc3d5HQSS2Dcsi9oXVobhbdgqck1O2+8scbCoGZW2zkOWOrrjiZe1UrT+
        VpA50G1N9Mg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04239A3836;
        Sat, 26 Sep 2020 19:42:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86188A3835;
        Sat, 26 Sep 2020 19:42:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 1/3] push: add reflog check for "--force-if-includes"
References: <20200926101324.73457-1-shrinidhi.kaushik@gmail.com>
        <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
        <20200926114626.28823-2-shrinidhi.kaushik@gmail.com>
Date:   Sat, 26 Sep 2020 16:42:10 -0700
In-Reply-To: <20200926114626.28823-2-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Sat, 26 Sep 2020 17:16:24 +0530")
Message-ID: <xmqqwo0ggl65.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5F9D796-0051-11EB-AFF4-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> @@ -2252,11 +2263,11 @@ int is_empty_cas(const struct push_cas_option *cas)
>  /*
>   * Look at remote.fetch refspec and see if we have a remote
>   * tracking branch for the refname there.  Fill its current
> - * value in sha1[].
> + * value in sha1[], and as a string.

I think the array being referred to was renamed to oid[] sometime
ago.  "and as a string" makes it sound as if sha1[] gets the value
as 40-hex object name text, but that is not what is being done.

    Fill the name of the remote-tracking branch in *dst_refname,
    and the name of the commit object at tis tip in oid[].

perhaps?

>   * If we cannot do so, return negative to signal an error.
>   */
>  static int remote_tracking(struct remote *remote, const char *refname,
> -			   struct object_id *oid)
> +			   struct object_id *oid, char **dst_refname)
>  {
>  	char *dst;
>  
> @@ -2265,9 +2276,154 @@ static int remote_tracking(struct remote *remote, const char *refname,
>  		return -1; /* no tracking ref for refname at remote */
>  	if (read_ref(dst, oid))
>  		return -1; /* we know what the tracking ref is but we cannot read it */
> +
> +	*dst_refname = dst;
> +	return 0;
> +}
> +
> +/*
> + * The struct "reflog_commit_list" and related helper functions
> + * for list manipulation are used for collecting commits into a
> + * list during reflog traversals in "if_exists_or_grab_until()".

Has the name of that function changed since this comment was
written?

> + */
> +struct reflog_commit_list {
> +	struct commit **items;

Name an array in singular when its primary use is to work on an
element at a time---that will let you say item[4] to call the 4-th
item, instead of items[4] that smells awkward.

An array that is used mostly to pass around a collection as a whole
is easier to think about when given a plural name, though.

> +	size_t nr, alloc;
> +};
> +
> +/* Add a commit to list. */
> +static void add_commit(struct reflog_commit_list *list, struct commit *commit)
> +{
> +	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
> +	list->items[list->nr++] = commit;
> +}
> +
> +/* Free and reset the list. */
> +static void free_reflog_commit_list(struct reflog_commit_list *list)
> +{
> +	FREE_AND_NULL(list->items);
> +	list->nr = list->alloc = 0;
> +}
> +
> +struct check_and_collect_until_cb_data {
> +	struct commit *remote_commit;
> +	struct reflog_commit_list *local_commits;
> +	timestamp_t remote_reflog_timestamp;
> +};
> +
> +/* Get the timestamp of the latest entry. */
> +static int peek_reflog(struct object_id *o_oid, struct object_id *n_oid,
> +		       const char *ident, timestamp_t timestamp,
> +		       int tz, const char *message, void *cb_data)
> +{
> +	timestamp_t *ts = cb_data;
> +	*ts = timestamp;
> +	return 1;
> +}

The idea is to use a callback that immediately says "no more" to
grab the data from the first item in the iteration.  It feels
somewhat awkward but because there is no "give us the Nth entry" API
function, it is the cleanest way we can do this.

> +static int check_and_collect_until(struct object_id *o_oid,
> +				   struct object_id *n_oid,
> +				   const char *ident, timestamp_t timestamp,
> +				   int tz, const char *message, void *cb_data)
> +{
> +	struct commit *commit;
> +	struct check_and_collect_until_cb_data *cb = cb_data;
> +
> +	/*
> +	 * If the reflog entry timestamp is older than the remote ref's
> +	 * latest reflog entry, there is no need to check or collect
> +	 * entries older than this one.
> +	 */
> +	if (timestamp < cb->remote_reflog_timestamp)
> +		return -1;
> +
> +	/* An entry was found. */
> +	if (oideq(n_oid, &cb->remote_commit->object.oid))
> +		return 1;
> +
> +	/* Look-up the commit and append it to the list. */
> +	if ((commit = lookup_commit_reference(the_repository, n_oid)))
> +		add_commit(cb->local_commits, commit);

This is merely a minor naming thing, but if you rename add_commit()
to append_commit(), you probably do not even need the comment before
this statement.

>  	return 0;
>  }
>  
> +#define MERGE_BASES_BATCH_SIZE 8

Hmph.  Do we still need batching?

> +/*
> + * Iterate through the reflog of the local ref to check if there is an entry
> + * for the given remote-tracking ref; runs until the timestamp of an entry is
> + * older than latest timestamp of remote-tracking ref's reflog. Any commits
> + * are that seen along the way are collected into a list to check if the
> + * remote-tracking ref is reachable from any of them.
> + */
> +static int is_reachable_in_reflog(const char *local, const struct ref *remote)
> +{
> +	timestamp_t date;
> +	struct commit *commit;
> +	struct commit **chunk;
> +	struct check_and_collect_until_cb_data cb;
> +	struct reflog_commit_list list = { NULL, 0, 0 };
> +	size_t count = 0, batch_size = 0;
> +	int ret = 0;
> +
> +	commit = lookup_commit_reference(the_repository, &remote->old_oid);
> +	if (!commit)
> +		goto cleanup_return;
> +
> +	/*
> +	 * Get the timestamp from the latest entry
> +	 * of the remote-tracking ref's reflog.
> +	 */
> +	for_each_reflog_ent_reverse(remote->tracking_ref, peek_reflog, &date);
> +
> +	cb.remote_commit = commit;
> +	cb.local_commits = &list;
> +	cb.remote_reflog_timestamp = date;
> +	ret = for_each_reflog_ent_reverse(local, check_and_collect_until, &cb);
> +
> +	/* We found an entry in the reflog. */
> +	if (ret > 0)
> +		goto cleanup_return;

Good.  So '1' from the callback is "we found one, no need to look
further and no need to do merge-base", and '-1' from the callback is
"we looked at all entries that are young enough to matter and we
didn't find exact match".  Makes sense.

> +	/*
> +	 * Check if the remote commit is reachable from any
> +	 * of the commits in the collected list, in batches.
> +	 */

I do not know if batching would help (have you measured it?), but if
we were to batch, it is more common to arrange the loop like this:

	for (chunk = list.items;
             chunk < list.items + list.nr;
	     chunk += size) {
             	size = list.items + list.nr - chunk;
                if (MERGE_BASES_BATCH_SIZE < size)
			size = MERGE_BASES_BATCH_SIZE;
		... use chunk[0..size] ...
		chunk += size;
	}

That is, assume that we can grab everything during this round, and
if that bites off too many, clamp it to the maximum value.  If you
are not comfortable with pointer arithmetic, it is also fine to use
an auxiliary variable 'count', but ...

> +	chunk = list.items;
> +	while (count < list.nr) {
> +		batch_size = MERGE_BASES_BATCH_SIZE;
> +
> +		/* For any leftover entries. */
> +		if ((count + MERGE_BASES_BATCH_SIZE) > list.nr)
> +			batch_size = list.nr - count;
> +
> +		if ((ret = in_merge_bases_many(commit, batch_size, chunk)))
> +			break;
> +
> +		chunk += batch_size;
> +		count += MERGE_BASES_BATCH_SIZE;

... you are risking chunk and count to go out of sync here.

It does not matter within this loop (count will point beyond the end
of list.item[] while chunk will never go past the array), but future
developers can be confused into thinking that they can use chunk and
count interchangeably after this loop exits, and at that point the
discrepancy may start to matter.

But all of the above matters if it is a good idea to batch.  Does it
make a difference?

    ... goes and looks at in_merge_bases_many() ...

Ah, it probably would.  

I thought in_merge_bases_many() would stop early as soon as any of
the traversal from chunk[] reaches commit, but it uses a rather more
generic paint_down_to_common() so extra items in chunk[] that are
topologically older than commit would result in additional traversal
from commit down to them, which would not contribute much to the end
result.  It may be a good #leftovebit idea for future improvement to
teach in_merge_bases_many() to use a custom replacement for
paint_down_to_common() that stops early as soon as we find the
answer is true.

> +	}
> +
> +cleanup_return:
> +	free_reflog_commit_list(&list);
> +	return ret;
> +}
> +

Thanks.
