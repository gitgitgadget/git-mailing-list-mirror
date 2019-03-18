Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E980520248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCRVjq (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:39:46 -0400
Received: from siwi.pair.com ([209.68.5.199]:37571 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfCRVjq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:39:46 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 903253F4042;
        Mon, 18 Mar 2019 17:39:45 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:7813:62b2:fade:96a7] (unknown [IPv6:2001:4898:8010:0:6149:62b2:fade:96a7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0C8A13F4000;
        Mon, 18 Mar 2019 17:39:45 -0400 (EDT)
Subject: Re: [PATCH 2/3] midx: verify: group objects by packfile to speed up
 object verification
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.166.git.gitgitgadget@gmail.com>
 <86f6b0325821a9e1742a28895f9c9b712a1fdec4.1552919394.git.gitgitgadget@gmail.com>
 <87pnqodvr9.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9c4da72d-6066-8d05-f181-a93c3926705f@jeffhostetler.com>
Date:   Mon, 18 Mar 2019 17:39:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <87pnqodvr9.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/18/2019 11:53 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 18 2019, Jeff Hostetler via GitGitGadget wrote:
> 
>> +static int compare_pair_pos_vs_id(const void *_a, const void *_b)
>> +{
>> +	struct pair_pos_vs_id *a = (struct pair_pos_vs_id *)_a;
>> +	struct pair_pos_vs_id *b = (struct pair_pos_vs_id *)_b;
>> +
>> +	if (a->pack_int_id < b->pack_int_id)
>> +		return -1;
>> +	if (a->pack_int_id > b->pack_int_id)
>> +		return 1;
>> +
>> +	return 0;
>> +}
> 
> Not a suggestion for a change, just a note that this sent me down the
> rabbit hole of looking at the different idioms we use for QSORT() in
> different places. Some use this form, some a ternary nest, and some the
> succinct subtraction idiom of e.g. (in this case):
> 
>      return b->pack_int_id - a->pack_int_id;

Yeah, I'm not sure which way is better or worse here.
An earlier draft of this function sorted by packfile id
and then by OID (thinking we might benefit from some
locality later when we do the verify), hence the independent
if statements.  But it didn't help, so I removed the other
lines.

On 43+M objects, your version is a hair faster, so I might
as well take it instead.

> 
>> +
>>   int verify_midx_file(const char *object_dir)
>>   {
>> -	uint32_t i;
>> +	struct pair_pos_vs_id *pairs = NULL;
>> +	uint32_t i, k;
>>   	struct progress *progress;
>>   	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
>>   	verify_midx_error = 0;
>> @@ -997,15 +1017,36 @@ int verify_midx_file(const char *object_dir)
>>   	}
>>
>>   	progress = start_progress(_("Verifying object offsets"), m->num_objects);
>> +
>> +	/*
>> +	 * Create an array mapping each object to its packfile id.  Sort it
>> +	 * to group the objects by packfile.  Use this permutation to visit
>> +	 * each of the objects and only require 1 packfile to be open at a
>> +	 * time.
>> +	 */
>> +	ALLOC_ARRAY(pairs, m->num_objects);
>>   	for (i = 0; i < m->num_objects; i++) {
>> +		pairs[i].pos = i;
>> +		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
>> +	}
>> +	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
>> +
>> +	for (k = 0; k < m->num_objects; k++) {
>> [...]
> 
> I have not tested this (or midx in general), but isn't this new QSORT()
> introducing the same sort of progress stalling that I fixed for
> commit-graph in 890226ccb57 ("commit-graph write: add itermediate
> progress", 2019-01-19)? I.e. something you can work around with a
> "display_progress(progress, 0)" before the QSORT().
> 

I wasn't tracking your commit-graph changes, but yes, I think it is.

Tinkering with how to display progress, I found a couple of problems.
On my 3599 packfile, 43M object example, QSORT() takes about 5 seconds.
But there's about 2 seconds of setup before the sort starts.  The final
verify loops takes about 17 seconds.

Here I put trace2 regions around the main loops and used the
GIT_TR2_PERF stream.

> | cmd_name     |     |           |           |            | multi-pack-index (multi-pack-index)
> | cmd_mode     |     |           |           |            | verify
> | data         | r0  |  0.031295 |  0.031295 | midx       | load/num_packs:3599
> | data         | r0  |  0.031330 |  0.031330 | midx       | load/num_objects:42704807
> | region_enter | r0  |  0.031352 |           | midx       | label:verify/prepare 
> | region_leave | r0  |  0.626547 |  0.595195 | midx       | label:verify/prepare 
> | region_enter | r0  |  0.626602 |           | midx       | label:verify/oid_order 
> | region_leave | r0  |  1.570195 |  0.943593 | midx       | label:verify/oid_order 
> | region_enter | r0  |  1.570253 |           | midx       | label:verify/sort_setup 
> | region_leave | r0  |  1.809723 |  0.239470 | midx       | label:verify/sort_setup 
> | region_enter | r0  |  1.809803 |           | midx       | label:verify/sort 
> | region_leave | r0  |  6.950595 |  5.140792 | midx       | label:verify/sort 
> | region_enter | r0  |  6.950651 |           | midx       | label:verify/offsets 
> | region_leave | r0  | 24.059736 | 17.109085 | midx       | label:verify/offsets 
> | exit         |     | 24.101434 |           |            | code:0

So just adding a delay progress block by itself around the sort doesn't
help much.  It just sits there for 7 seconds before the actual progress
starts.

If I add a non-delay progress block around the "verify/prepare",
"verify/oid_order" and the "verify/offsets" loops, we get a pretty good
experience.

There is the dead time while the sort() itself is running, but at least
there is isn't a 5+ second frozen at 0% message on screen.

I'll re-roll shortly.

Thanks,
Jeff
