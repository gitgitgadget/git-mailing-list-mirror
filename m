Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61C520964
	for <e@80x24.org>; Tue,  4 Apr 2017 13:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbdDDNNt (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 09:13:49 -0400
Received: from siwi.pair.com ([209.68.5.199]:63948 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753640AbdDDNNr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 09:13:47 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 569CE846A0;
        Tue,  4 Apr 2017 09:13:39 -0400 (EDT)
Subject: Re: [PATCH v4 2/4] fsck: force core.checksumindex=1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
References: <20170403185306.36164-1-git@jeffhostetler.com>
 <20170403185306.36164-3-git@jeffhostetler.com>
 <CACBZZX7DFuLia8RzB908EG7+oWQiFGkFEq14bzT77A75msM98Q@mail.gmail.com>
 <20170404022945.nmadthjzovmjplyb@sigill.intra.peff.net>
 <CACBZZX50+Mpj-GY11KNmh+BkNkWCX3OZjHFQ3iK8c8Hib90_Xg@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9abad913-66a6-f537-af77-8878c428b192@jeffhostetler.com>
Date:   Tue, 4 Apr 2017 09:13:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX50+Mpj-GY11KNmh+BkNkWCX3OZjHFQ3iK8c8Hib90_Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/4/2017 4:23 AM, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Apr 4, 2017 at 4:29 AM, Jeff King <peff@peff.net> wrote:
>> On Mon, Apr 03, 2017 at 10:31:03PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>>> On Mon, Apr 3, 2017 at 8:53 PM,  <git@jeffhostetler.com> wrote:
>>>> Teach fsck to override core.checksumindex and always verify
>>>> the index checksum when reading the index.
>>>
>>> Sorry to only chime in about this at v4.
>>>
>>> I think this patch & the documentation you added for
>>> core.checksumindex in 1/4 would be much less confusing if you made
>>> this a on-by-default command-line option like e.g. "full".
>>>
>>> With this patch nothing amends the documentation to indicate that the
>>> core.checksumindex is magically overridden when fsck runs, I think
>>> something like this (needs amending to integrate) on top would make
>>> this clearer:
>>
>> I think that is the wrong direction to reduce confusion. We don't need
>> more options to twiddle this flag, we need fewer. For instance, in your
>> proposed documentation:
>>
>>> @@ -61,6 +61,11 @@ index file, all SHA-1 references in `refs`
>>> namespace, and all reflogs
>>>         object pools.  This is now default; you can turn it off
>>>         with --no-full.
>>>
>>> +--[no-]checksum-index:
>>> +       Validate the checksum at the end of the index file, on by
>>> +       default, locally overrides any "core.checksumIndex" setting
>>> +       unless negated. See linkgit:git-config[1].
>>
>> That tells us _what_ it does, but I'm left scratching my head with
>> "why".
>>
>> I don't think there is any reason you would want fsck not to compute
>> that checksum (just like there is no option to ask fsck not to check
>> pack sha1 trailers).
>>
>> I would go so far as to say that the config option itself is unnecessary
>> in this iteration of the series. I only asked for it so that we could
>> test the verification code paths (both for correctness and performance).
>> But if fsck can exercise the code path, we can check correctness that
>> way. And for performance, it's probably enough to test two separate
>> builds (which Jeff has already done).
>>
>> Junio also asked for the usual "add a config, and then later we'll flip
>> the default" procedure. But IMHO that isn't necessary here. Nobody
>> should ever care about this flag. It was largely useless to check it on
>> every read in the first place. And if you suspect there's corruption in
>> your repository, you should run "git fsck".
>
> The part that confused my & I found unintuitive is that there's a new
> core.WHATEVER config that'll get silently overridden by a specific
> command, git-fsck.
>
> Nothing else I can think of in core.* works like this, i.e. it's a
> namespace for "applies to all of git", core.editor, core.ignoreCase
> etc.

My "force_core_checksum_index" global override was a bit of a hack.
I looked at having fsck explicitly set the "core.checksumindex" config
value (which would write to the disk in the code paths I followed)
before it loaded the index, but if we ever find an invalid checksum,
read_cache() would call die() and fsck would not have a chance to set
it back in the user's config.  So I introduced the global override.

>
> Having git-fsck have a command-line option that's on by default as I
> suggested is one way to get out of that confusion. It makes it a
> special case of a CLI option overriding some config.

I looked at doing that, but thought it would be overkill since
no one is likely to care about turning it off -- or rather, fsck
should always do it whenever it reads the index.

>
> But yeah, another way to resolve this is to get rid of the config
> option altogether, or document in git-config.txt that
> core.checksumIndex is obeyed by everything except git-fsck.
>

If there's no objections then, I'll just remove the config
setting and keep the force_ global for fsck.

Jeff

