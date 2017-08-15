Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2DF208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbdHOSFr (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:05:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61242 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751460AbdHOSFq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:05:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7C06A3F44;
        Tue, 15 Aug 2017 14:05:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zVG6Z7ChU8NF37R/c2tXr7mjOX4=; b=Wu0wWO
        mLqlVXQfos2lACAPXbifn9HQAS8ysJNSGlJW6O3fPeA1wpV4qThGf4/vJ3E/UNAz
        x/Q6FrYeJ/ac2YfvRXSCKsCAKNM9PDZDAQ2ozla0EIGaIalANMQtARW8rAUpc305
        goWOrlpyT3S6YQX/ExLpsG42TirRV2CnEXmyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lIOYBLChrqh1HyxFJokkGk2u7J8wqMDC
        0OwZCbDmhaENtBxFlUeZjw7mgP1xPTEHMDVMdi1//5UkAp1m9loFH1ZFjPeg/8TB
        T2t45kbYf22T3ZcxhKPjdnECq746EFz+A3X6pNkmHW2CMj0zY92yr/vSKzW4Zb+I
        qOgIZhtef9s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD1EFA3F43;
        Tue, 15 Aug 2017 14:05:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A463A3F42;
        Tue, 15 Aug 2017 14:05:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Willford <kewillf@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] commit: skip discarding the index if there is no pre-commit hook
References: <20170810185416.8224-1-kewillf@microsoft.com>
        <20170814215425.23784-1-kewillf@microsoft.com>
        <20170814221309.tg7wizmvx3gtzfc7@sigill.intra.peff.net>
        <DM2PR21MB004160EA994A445A89BD50F7B78D0@DM2PR21MB0041.namprd21.prod.outlook.com>
        <20170815045313.njpq5wf7iuredhoe@sigill.intra.peff.net>
Date:   Tue, 15 Aug 2017 11:05:38 -0700
In-Reply-To: <20170815045313.njpq5wf7iuredhoe@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 15 Aug 2017 00:53:14 -0400")
Message-ID: <xmqq60doso3x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58D938C8-81E4-11E7-A95B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 15, 2017 at 04:23:50AM +0000, Kevin Willford wrote:
>
>> > This read_cache_from() should be a noop, right, because it immediately
>> > sees istate->initialized is set? So it shouldn't matter that it is not
>> > in the conditional with discard_cache(). Though if its only purpose is
>> > to re-read the just-discarded contents, perhaps it makes sense to put it
>> > there for readability.
>> 
>> I thought about that and didn't know if there were cases when this would be called
>> and the cache has not been loaded.  It didn't look like it since it is only called from 
>> cmd_commit and prepare_index is called before it.  Also if in the future this call would
>> be made when it had not read the index yet so thought it was safest just to leave
>> this as always being called since it is basically a noop if the istate->initialized is set.
>
> Yeah, I agree it might be safer as you have it. And hopefully the
> comment above the discard would point anybody in the right direction.

I agree that it would not hurt to have it outside the conditional,
because read_cache_from() is a no-op when it is already populated.
I however do not think it is sensible to call prepare_to_commit()
without having populated the in-core index---in the function, nobody
conditionally reads the in-core index, expecting that the caller
might not have prepared the in-core index, when we need to do the
wt-status thing, for example.

>> Also based on this commit
>> https://github.com/git/git/commit/2888605c649ccd423232161186d72c0e6c458a48
>> it looked like the discard_cache was added independent of the read_cache_from call,
>> which made me think that the two were not tied together.

That one comes from the first commit of the C reimplementation,
f5bbc322 ("Port git commit to C.", 2007-11-08).

If I am reading the old code correctly, read_cache_from() is called
for entirely different reasons.  Back in the old code, when doing
"commit --patch", prepare_index() called interactive_add(), which
would return to us after updating the index file in the filesystem.
The caller of prepare_index(), which was cmd_commit(), needed to
read that off of the filesystem hence the call is there.

When not doing "--patch", prepare_index() called read_cache(), so
the read_cache_from() there was a no-op.

2888605c ("builtin-commit: fix partial-commit support", 2007-11-18)
was to fix the mistake of not re-reading the index from the file at
that point for non "--patch" cases.  Having read_cache_from() that
is most of the time no-op was not sufficient and needed additional
discard_cache() there.
