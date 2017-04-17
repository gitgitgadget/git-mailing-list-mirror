Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7594C20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 14:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbdDQOxK (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 10:53:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:33005 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752223AbdDQOxI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 10:53:08 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 65E3B8456F;
        Mon, 17 Apr 2017 10:53:07 -0400 (EDT)
Subject: Re: [PATCH v10 3/3] read-cache: speed up add_index_entry during
 checkout
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <20170414191230.52825-1-git@jeffhostetler.com>
 <20170414191230.52825-4-git@jeffhostetler.com>
 <d9f1acc8-03e3-abc6-af9d-da55a33218fa@web.de>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <28ef82b9-ab7a-ccaf-7bae-4eaa332725f8@jeffhostetler.com>
Date:   Mon, 17 Apr 2017 10:53:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <d9f1acc8-03e3-abc6-af9d-da55a33218fa@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/15/2017 1:55 PM, René Scharfe wrote:
> Am 14.04.2017 um 21:12 schrieb git@jeffhostetler.com:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Very nice, especially the perf test!  But can we unbundle the different
> optimizations into separate patches with their own performance numbers?
> Candidates IMHO: The change in add_index_entry_with_check(), the first
> hunk in has_dir_name(), the loop shortcuts.  That might also help find
> the reason for the slight slowdown of 0006.3 for the kernel repository.

Let me take a look at this and see if it helps.

>> diff --git a/read-cache.c b/read-cache.c
>> index 97f13a1..ba95fbb 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -910,6 +910,9 @@ int strcmp_offset(const char *s1, const char *s2,
>> size_t *first_change)
>>   /*
>>    * Do we have another file with a pathname that is a proper
>>    * subset of the name we're trying to add?
>> + *
>> + * That is, is there another file in the index with a path
>> + * that matches a sub-directory in the given entry?
>>    */
>>   static int has_dir_name(struct index_state *istate,
>>               const struct cache_entry *ce, int pos, int ok_to_replace)
>> @@ -918,9 +921,51 @@ static int has_dir_name(struct index_state *istate,
>>       int stage = ce_stage(ce);
>>       const char *name = ce->name;
>>       const char *slash = name + ce_namelen(ce);
>> +    size_t len_eq_last;
>> +    int cmp_last = 0;
>> +
>> +    /*
>> +     * We are frequently called during an iteration on a sorted
>> +     * list of pathnames and while building a new index.  Therefore,
>> +     * there is a high probability that this entry will eventually
>> +     * be appended to the index, rather than inserted in the middle.
>> +     * If we can confirm that, we can avoid binary searches on the
>> +     * components of the pathname.
>> +     *
>> +     * Compare the entry's full path with the last path in the index.
>> +     */
>> +    if (istate->cache_nr > 0) {
>> +        cmp_last = strcmp_offset(name,
>> +            istate->cache[istate->cache_nr - 1]->name,
>> +            &len_eq_last);
>> +        if (cmp_last > 0) {
>> +            if (len_eq_last == 0) {
>> +                /*
>> +                 * The entry sorts AFTER the last one in the
>> +                 * index and their paths have no common prefix,
>> +                 * so there cannot be a F/D conflict.
>> +                 */
>> +                return retval;
>> +            } else {
>> +                /*
>> +                 * The entry sorts AFTER the last one in the
>> +                 * index, but has a common prefix.  Fall through
>> +                 * to the loop below to disect the entry's path
>> +                 * and see where the difference is.
>> +                 */
>> +            }
>> +        } else if (cmp_last == 0) {
>> +            /*
>> +             * The entry exactly matches the last one in the
>> +             * index, but because of multiple stage and CE_REMOVE
>> +             * items, we fall through and let the regular search
>> +             * code handle it.
>> +             */
>> +        }
>> +    }
>>         for (;;) {
>> -        int len;
>> +        size_t len;
>>             for (;;) {
>>               if (*--slash == '/')
>> @@ -930,6 +975,66 @@ static int has_dir_name(struct index_state *istate,
>>           }
>>           len = slash - name;
>>   +        if (cmp_last > 0) {
>> +            /*
>> +             * (len + 1) is a directory boundary (including
>> +             * the trailing slash).  And since the loop is
>> +             * decrementing "slash", the first iteration is
>> +             * the longest directory prefix; subsequent
>> +             * iterations consider parent directories.
>> +             */
>> +
>> +            if (len + 1 <= len_eq_last) {
>> +                /*
>> +                 * The directory prefix (including the trailing
>> +                 * slash) also appears as a prefix in the last
>> +                 * entry, so the remainder cannot collide (because
>> +                 * strcmp said the whole path was greater).
>> +                 *
>> +                 * EQ: last: xxx/A
>> +                 *     this: xxx/B
>> +                 *
>> +                 * LT: last: xxx/file_A
>> +                 *     this: xxx/file_B
>> +                 */
>> +                return retval;
>> +            }
>> +
>> +            if (len > len_eq_last) {
>> +                /*
>> +                 * This part of the directory prefix (excluding
>> +                 * the trailing slash) is longer than the known
>> +                 * equal portions, so this sub-directory cannot
>> +                 * collide with a file.
>> +                 *
>> +                 * GT: last: xxxA
>> +                 *     this: xxxB/file
>> +                 */
>> +                return retval;
>> +            }
>> +
>
> At this point len and len_eq_last are equal -- otherwise one of the two
> previous conditions would have triggered.  Silly question: Is this
> necessary for the following shortcut to work?  Removing the two checks
> above doesn't seem to affect performance very much, and at least the
> test suite still passes..

Both of these are highly dependent on the shape of the
pathnames in the tree.  Let me try to quantify this.

>
>> +            if (ce_namelen(istate->cache[istate->cache_nr - 1]) > len) {
>> +                /*
>> +                 * The directory prefix lines up with part of
>> +                 * a longer file or directory name, but sorts
>> +                 * after it, so this sub-directory cannot
>> +                 * collide with a file.
>> +                 *
>> +                 * last: xxx/yy-file (because '-' sorts before '/')
>> +                 * this: xxx/yy/abc
>> +                 */
>> +                return retval;
>> +            }
>
> istate->cache_nr can be zero if remove_index_entry_at() had been called
> in a previous iteration, resulting in a segfault.  Checking right here
> is probably the easiest way out; not sure if exiting early when the
> index becomes empty would be better.

yeah, i guess remove_...() could delete them all and this test
would be ill-defined.  Let me fix that.

>
>> +
>> +            /*
>> +             * This is a possible collision. Fall through and
>> +             * let the regular search code handle it.
>> +             *
>> +             * last: xxx
>> +             * this: xxx/file
>> +             */
>> +        }
>> +
>>           pos = index_name_stage_pos(istate, name, len, stage);
>>           if (pos >= 0) {
>>               /*
>> @@ -1021,7 +1126,16 @@ static int add_index_entry_with_check(struct
>> index_state *istate, struct cache_e
>>         if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
>>           cache_tree_invalidate_path(istate, ce->name);
>> -    pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce),
>> ce_stage(ce));
>> +
>> +    /*
>> +     * If this entry's path sorts after the last entry in the index,
>> +     * we can avoid searching for it.
>> +     */
>> +    if (istate->cache_nr > 0 &&
>> +        strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
>> +        pos = -istate->cache_nr - 1;
>> +    else
>> +        pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce),
>> ce_stage(ce));
>>         /* existing match? Just replace it. */
>>       if (pos >= 0) {
>>
