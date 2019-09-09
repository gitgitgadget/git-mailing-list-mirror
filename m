Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391A31F461
	for <e@80x24.org>; Mon,  9 Sep 2019 13:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405006AbfIINyj (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 09:54:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:52156 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404954AbfIINyj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 09:54:39 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8ADD43F4116;
        Mon,  9 Sep 2019 09:54:38 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:6099:d0b3:95b6:588c] (unknown [IPv6:2001:4898:a800:1012:11cd:d0b3:95b6:588c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 113483F4113;
        Mon,  9 Sep 2019 09:54:38 -0400 (EDT)
Subject: Re: [PATCH v3 1/2] list-objects-filter: only parse sparse OID when
 'have_git_dir'
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
References: <20190829231925.15223-1-jon@jonsimons.org>
 <20190829231925.15223-2-jon@jonsimons.org>
 <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
 <20190904045424.GA6488@sigill.intra.peff.net>
 <xmqqv9u6po4j.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f32d2e8c-abec-0ec1-daa7-4c10470c5553@jeffhostetler.com>
Date:   Mon, 9 Sep 2019 09:54:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9u6po4j.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/5/2019 2:57 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> So these patches are punting on the greater question of why we want to
>> parse so early, and are not making anything worse. AFAICT, "clone
>> --filter=sparse:oid" has never worked (even though our tests did cover
>> the underlying rev-list and pack-objects code paths).
>> ...
>> TBH, I'm not sure why the original is so eager to parse early. I guess
>> it allows:
>>
>>    - a dual use of the options parser; we can use it both to sanity-check
>>      the options before sending them to a server, and to actually use the
>>      filter ourselves.
>>
>>    - earlier detection maybe gives us a cleaner error path (e.g.,
>>      rev-list can do its own error handling). But I'd think doing it when
>>      we actually initialize the filter would be enough.
>>
>> I.e., if we want to go all the way, I think this two-patch series could
>> basically be replaced with something like the (totally untested)
>> approach below, which just pushes the parsing closer to the
>> point-of-use.
>>
>> Adding Jeff Hostetler to the cc, in case he recalls any reason not to
>> use that approach.
> 
> Thanks.
> 

I think both of Peff's guesses are correct.

IIRC I wrote the original parse_list_objects_filter() and friends to
syntax check the command line arguments of rev-list.  In hindsight,
this looks a bit aggressive at that layer, or rather now that it is
being used by various places in other commands (such as parsing
messages from the wire), it shouldn't call die() as Peff suggests.

I like the code Peff suggests.  Making parse_list_objects_filter()
a bit simpler and not call die().  Callers should then check the
function return value as necessary.

It would be nice if we could continue to let parse_list_objects_filter()
do the syntax checking -- that is, we can still check that we received a
ulong in "blob:limit:<nr>" and that "sparse:oid:<oid>" looks like a hex
value, for example.  Just save the actual <oid> lookup to the higher
layer, if and when that makes sense.

Jeff

