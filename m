Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672B81F462
	for <e@80x24.org>; Wed, 29 May 2019 20:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfE2U50 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 16:57:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:54557 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfE2U50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 16:57:26 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4A8FB3F4051;
        Wed, 29 May 2019 16:57:25 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:c90f:aaf8:aafe:c1ce] (unknown [IPv6:2001:4898:a800:1010:7a45:aaf8:aafe:c1ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9E7B73F4019;
        Wed, 29 May 2019 16:57:24 -0400 (EDT)
Subject: Re: [PATCH] list-objects-filter: merge filter data structs
To:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@comcast.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
References: <cover.1558484115.git.matvore@google.com>
 <341bc55d4a3f5438b1523525cf683f96d75e8c3e.1558484115.git.matvore@google.com>
 <20190524004938.GB46998@google.com> <20190528184801.GA4556@comcast.net>
 <20190528224010.GA4700@comcast.net>
 <xmqq4l5dyrcu.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e9147614-80f9-4c18-b431-539e2376295d@jeffhostetler.com>
Date:   Wed, 29 May 2019 16:57:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4l5dyrcu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/29/2019 3:48 PM, Junio C Hamano wrote:
> Matthew DeVore <matvore@comcast.net> writes:
> 
>> Simplify the filter execution data logic and structs by putting all
>> execution data for all filter types in a single struct. This results in
>> a tiny overhead for each filter instance, and in exchange, invoking
>> filters is not only easier but the list-objects-filter public API is
>> simpler and more opaque.
> 
> Hmmm...
> 
>> +struct filter_data {
>> +	/* Used by all filter types. */
>>   	struct oidset *omits;
>> +
>> +	enum list_objects_filter_result (*filter_object_fn)(
>> +		struct repository *r,
>> +		enum list_objects_filter_situation filter_situation,
>> +		struct object *obj,
>> +		const char *pathname,
>> +		const char *filename,
>> +		struct filter_data *filter_data);
>> +
>> +	/* BEGIN tree:<depth> filter data */
>> +
>> +	/*
>> +	 * Maps trees to the minimum depth at which they were seen. It is not
>> +	 * necessary to re-traverse a tree at deeper or equal depths than it has
>> +	 * already been traversed.
>> +	 *
>> +	 * We can't use LOFR_MARK_SEEN for tree objects since this will prevent
>> +	 * it from being traversed at shallower depths.
>> +	 */
>> +	struct oidmap seen_at_depth;
>> +
>> +	unsigned long exclude_depth;
>> +	unsigned long current_depth;
>> +
>> +	/* BEGIN blobs:limit=<limit> filter data */
>> +
>> +	unsigned long max_bytes;
>> +
>> +	/* BEGIN sparse:... filter data */
>> +
>> +	struct exclude_list el;
>> +
>> +	size_t nr, alloc;
>> +	struct frame *array_frame;
>>   };
> 
> I am hoping that I am not misreading the intention but you do not
> plan to use the above so that you can say "apply 'tree:depth=4' and
> 'blobs:limit=1G' at the same time" by filling the fields in a single
> struct, do you?  For combined filter, you'll still have multiple
> instances of filter_data struct, strung together in a list that says
> "all of these must be satisfied" or something like that, right?
> 
> And if that is the case, I am not sure why the above "struct with
> all these fields" is a good idea.  If these three (and probably we
> will have more as the system evolves) sets of fields in this outer
> struct for different filters were enclosed in a union, that would be
> a different story, though.
> 

I'm not sure I like the combined structure as proposed.
But let's think about it.

I think part of problem with my original version was putting the
filter_fn and filter_free_fn in the traversal_context rather than
inside the filter_*_data structure.

I did a simple combined structure for the list_objects_filter_options
and kind of regretted it because it wasn't obvious which data fields
were defined or undefined in each filter constructor.  But it was
convenient when parsing the command line.

I think having a combined structure with a union enclosing a structure
for the data fields in each filter type would be worth considering.
That way you have a somewhat self-documenting sub-structure for each
filter type that indicates which fields are defined.

I'd also suggest keeping the "oidset omits" inside each of the
sub-structures, but that's just me.


BTW, I don't see a free_fn.  That may collapse out with your proposal
but I wanted to ask.

Thanks
Jeff

