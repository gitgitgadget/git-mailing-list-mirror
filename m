Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372DA20969
	for <e@80x24.org>; Mon, 27 Mar 2017 20:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbdC0UvA (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 16:51:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:49537 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752616AbdC0Uu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 16:50:58 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 100E98460C;
        Mon, 27 Mar 2017 16:50:41 -0400 (EDT)
Subject: Re: [PATCH v2 5/7] name-hash: perf improvement for
 lazy_init_name_hash
To:     Junio C Hamano <gitster@pobox.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
 <1490276825-41544-6-git-send-email-git@jeffhostetler.com>
 <xmqqinmu1n8o.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <122907b4-e689-c436-18df-27664186a8ce@jeffhostetler.com>
Date:   Mon, 27 Mar 2017 16:50:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqinmu1n8o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/27/2017 4:24 PM, Junio C Hamano wrote:
> git@jeffhostetler.com writes:
>
>> +/*
>> + * We use n mutexes to guard n partitions of the "istate->dir_hash"
>> + * hashtable.  Since "find" and "insert" operations will hash to a
>> + * particular bucket and modify/search a single chain, we can say
>> + * that "all chains mod n" are guarded by the same mutex -- rather
>> + * than having a single mutex to guard the entire table.  (This does
>> + * require that we disable "rehashing" on the hashtable.)
>> + *
>> + * So, a larger value here decreases the probability of a collision
>> + * and the time that each thread must wait for the mutex.
>> + */
>> +#define LAZY_MAX_MUTEX   (32)
>
> Good thinking is very well explained in the in-code comment.
>
>> +static int handle_range_dir(
>> +	struct index_state *istate,
>> +	int k_start,
>> +	int k_end,
>> +	struct dir_entry *parent,
>> +	struct strbuf *prefix,
>> +	struct lazy_entry *lazy_entries,
>> +	struct dir_entry **dir_new_out)
>> +{
>> +	int rc, k;
>> +	int input_prefix_len = prefix->len;
>> +	struct dir_entry *dir_new;
>> +
>> +	dir_new = hash_dir_entry_with_parent_and_prefix(istate, parent, prefix);
>> +
>> +	strbuf_addch(prefix, '/');
>> +
>> +	/*
>> +	 * Scan forward in the index array for index entries having the same
>> +	 * path prefix (that are also in this directory).
>> +	 */
>> +	if (strncmp(istate->cache[k_start + 1]->name, prefix->buf, prefix->len) > 0)
>> +		k = k_start + 1;
>> +	else if (strncmp(istate->cache[k_end - 1]->name, prefix->buf, prefix->len) == 0)
>> +		k = k_end;
>> +	else {
>> +		int begin = k_start;
>> +		int end = k_end;
>> +		while (begin < end) {
>> +			int mid = (begin + end) >> 1;
>> +			int cmp = strncmp(istate->cache[mid]->name, prefix->buf, prefix->len);
>> +			if (cmp == 0) /* mid has same prefix; look in second part */
>> +				begin = mid + 1;
>> +			else if (cmp > 0) /* mid is past group; look in first part */
>> +				end = mid;
>> +			else
>> +				die("cache entry out of order");
>
> Dying at this low level in the callchain in a worker thread made me
> feel a little bit nervous, but even if we arrange to return to the
> caller without doing extra computation, we would want to detect and
> abort when the cache entries are not sorted anyway, so this hsould
> be OK.

yeah, i wasn't sure if there was any need to complicate things
returning this error.  the index is sorted before we get here,
so this should never happen.

>
>> +		}
>> +		k = begin;
>> +	}
>> +
>> +	/*
>> +	 * Recurse and process what we can of this subset [k_start, k).
>> +	 */
>> +	rc = handle_range_1(istate, k_start, k, dir_new, prefix, lazy_entries);
>> +
>> +	strbuf_setlen(prefix, input_prefix_len);
>> +
>> +	*dir_new_out = dir_new;
>> +	return rc;
>> +}
>
> The varilable "rc" (return code?) is a lot more than return code; it
> tells how many entries we processed and signals the caller that it
> still needs to sweep the remainder if we didn't reach k_end.  The
> caller of this function calls the variable to receive this
> "processed", so I didn't find it too confusing while reading the
> code top-down, though.

The "rc" variable came from clear_ce_flags_dir().  I stole the
diving logic from it and clear_ce_flags_1(), so I tried to keep
the same name here.

(And that reminds me, the linear search in clead_ce_flags_dir()
could be sped up with a variation of the binary search I put in
here.  But that's for another day.)

>
>> +static int handle_range_1(
>> +	struct index_state *istate,
>> +	int k_start,
>> +	int k_end,
>> +	struct dir_entry *parent,
>> +	struct strbuf *prefix,
>> +	struct lazy_entry *lazy_entries)
>> +{
>> +	int input_prefix_len = prefix->len;
>> +	int k = k_start;
>> +
>> +	while (k < k_end) {
>> +		struct cache_entry *ce_k = istate->cache[k];
>> +		const char *name, *slash;
>> +
>> +		if (prefix->len && strncmp(ce_k->name, prefix->buf, prefix->len))
>> +			break;
>
> At first I was worried by this early return (i.e. we chop the entire
> active_nr entries into lazy_nr_dir_threads and hand each of them a
> range [k_start, k_end)---stopping before a thread reaches the end of
> the range it is responsible for will leave gaps), but then realized
> that this early return "we are done with the entries in the same
> directory" kicks in only for recursive invocation of this function,
> which makes it correct and perfectly fine.
>
> I also briefly wondered if it is worth wiggling the boundary of
> ranges for adjacent workers to align with directory boundaries, as
> the last round of hashes done by a worker and the first round of
> hashes done by another worker adjacent to it will be hashing for the
> same parent directory, but I think that would be counter-productive
> and think your "almost even" distribution would be a lot more
> sensible.  After all, when distribution of paths is skewed, a single
> directory may have disproportionally more (leaf) entries than the
> remainder of the index and in such a case, we would want multiple
> workers to share the load of hashing them, even if that means they
> may have to hash the same leading path independently.

I thought about various options along this, but yeah the work to
find the end of the directory would have to be done before the
threads started or each thread would have to tweak their endpoints
and that might be more expensive than just repeating a few
directory component calculations along the boundaries (and much
more complicated).

>
> Nicely done.  Let's have this in 'next' and then in 'master'
> soonish.
>
> Thanks.
>

Thanks
Jeff
