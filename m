Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273631FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 14:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032050AbdDTOAO (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 10:00:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:39064 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031743AbdDTOAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 10:00:12 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8EF878456D;
        Thu, 20 Apr 2017 10:00:05 -0400 (EDT)
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20170418194421.22453-1-git@jeffhostetler.com>
 <20170418194421.22453-2-git@jeffhostetler.com>
 <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
 <xmqqd1c9cdzi.fsf@gitster.mtv.corp.google.com>
 <20170419025608.xy5nvso6k6lb5z7g@sigill.intra.peff.net>
 <20170419031839.m2zgwywa2soejiqk@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <40228c69-7946-3ef1-35de-4cea9b0312e4@jeffhostetler.com>
Date:   Thu, 20 Apr 2017 10:00:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170419031839.m2zgwywa2soejiqk@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/18/2017 11:18 PM, Jeff King wrote:
> On Tue, Apr 18, 2017 at 10:56:08PM -0400, Jeff King wrote:
>
>>> When adding many things, we often just append and then sort at the
>>> end after we finished adding.  I wonder if recent "check the last
>>> one and append" optimization beats that strategy.
>>
>> The big question is whether we need to detect duplicates while we're
>> appending to the list, which is hard on an unsorted list.  In this
>> function, at least, we do detect when the path already exists and return
>> the existing entry. I'm not sure under what circumstances we would see
>> such a duplicate, though, as each filename should appear only once in
>> the tree diff. I would think.
>>
>> Doing:
>>
>> diff --git a/diffcore-rename.c b/diffcore-rename.c
>> index f7444c86b..56a493d97 100644
>> --- a/diffcore-rename.c
>> +++ b/diffcore-rename.c
>> @@ -86,7 +86,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
>>  		struct diff_rename_src *src = &(rename_src[next]);
>>  		int cmp = strcmp(one->path, src->p->one->path);
>>  		if (!cmp)
>> -			return src;
>> +			die("BUG: duplicate rename src: %s", one->path);
>>  		if (cmp < 0) {
>>  			last = next;
>>  			continue;
>>
>> passes the test suite, at least. :)
>
> Maybe relevant: 4d6be03b9 (diffcore-rename: avoid processing duplicate
> destinations, 2015-02-26). That's on the dst side, but possibly we
> should do something similar on the src side.
>
> BTW, I think the return value from register_rename_src() is
> questionable. It points to a "struct diff_rename_src" that may be
> reallocated by further calls to the function. Fortunately nobody
> actually looks at it, let alone saves it, so there's no bug.
>
> We may want to convert that return value to a void (if not just return
> an int for "hey, there's a duplicate", like we do for add_rename_dst()).
>
> Also, presumably that function could learn the same "check the last one"
> trick that the src side does. Which leads me back to "surely we can
> generalize this". I don't think bsearch() is quite what we want, because
> its interface doesn't tell us where to put the item when it isn't found.
> But I think we could make a general bsearch-like function that has
> similar semantics to index_name_pos(), with its negative-integer return.
>
> And then that would be a general lookup function, and we could easily
> build a general "look up and add" function around that. And the "check
> the last one" optimization would go in the latter.


I do see your point.  And I do get tired of littering the code with
"check the last before binary searching" tricks.  It would be nice
if we could better isolate this.  I've tried to follow the path of
least change/damage -- don't change functionality, but just short-cut
when possible, so the patches I've pushed up this month have mostly
taken that form.

And you're right, the gains on this particular patch are relatively
minor and it is a bit of a contrived case (lots of renames??), but
it did come up while testing on the Windows repo.  It doesn't happen
often, but it did happen.

So I'm OK with rejecting this one.

Perhaps the thing to learn from this (and the other ones) is that
we have lots of places where we are building a sorted list by
iterating over a sorted list.  The insert routines are general
purpose and cannot assume this, so they search first.  Perhaps it
would be clearer to have independent _append and _insert functions
and have the caller explicitly call the appropriate one.  The mainline
iterations on the existing index could just call the _append form
and never have to worry about searching or the negative-integer
return trick.  Whereas, the random iterations (such as on the
command's arg list), would always call the _insert form.

Jeff

