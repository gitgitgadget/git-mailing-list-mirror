Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0555C43381
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECFE64E0A
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhA2UeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:34:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58726 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhA2Ubl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 15:31:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94D7799591;
        Fri, 29 Jan 2021 15:30:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gkrzNQdoF2tK0XTi0ggdZIH1CJc=; b=hzvGil
        hDeIB2jmyw6hzxSKKxYacwJcxSA2ZRQaNDrVoYdfPU4TZOVK2vGTzIj6lFrnFDZJ
        WtxOhMp/kFN0JFg0CHGGTL/24ZEvdIQ3tw3weMM8x6ZsXMRefsJVZsyxMMFbcVpg
        nSJXiDnHh8XGuEcC6zcyqX2qYbLlKv42dOzOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rlsNWW7Jie4KZ7IbKKUqyJOmHPZXmQ0P
        kemt+ZQzMVlIYgkg1Mi39MlFJxjrzvPTsJP7CEUX6sl6P7q3SWcGU1WHVlYe/aLF
        Bjt9OS/F+zPfJdj2w8dt/36TyXUaJYsnO3/GHrNTELgi2MatR9usXWXPzU0TqqiY
        EUYhEMIPoPQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 828D49958F;
        Fri, 29 Jan 2021 15:30:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB38F9958E;
        Fri, 29 Jan 2021 15:30:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
References: <cover.1611098616.git.me@ttaylorr.com>
        <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
        <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
        <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
Date:   Fri, 29 Jan 2021 12:30:38 -0800
In-Reply-To: <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Jan 2021 14:19:25 -0500")
Message-ID: <xmqq35yjtrip.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D96D0F62-6270-11EB-9BF2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> If there is an out-of-band guarantee that .kept packs won't refer to
>> outside world, then we can obtain identical results to what existing
>> --honor-pack-keep (which traverses everything and then filteres out
>> what is in .keep pack) does by just stopping traversal when we see
>> an object that is found in a .keep pack.  OK, I guess that it
>> answers the correctness question I asked about [02/10].
>> 
>> It still is curious how we can safely "assume", but presumably we
>> will see how in a patch that appears later in the series.
>
> I think this would generally happen if the .keep packs are generated
> using something like "git repack -a", which packs everything reachable
> together. So if you do:
>
>   git repack -ad
>   touch .git/objects/pack/pack-whatever.keep
>   ... some more packs come in, perhaps via pushes ...
>   # imagine repack knew how to pass this along...
>   git repack -a --assume-kept-packs-closed
>
> then you'd repack just the objects that aren't in the big pack.

Yeah.  As a tool to help the above workflow, where you are only
creating another .keep out of youngest objects (i.e. those that are
either loose or in non-kept packs), because by definition anything
in .keep cannot be pointing back at these younger objects, it does
make sense to take advantage of "the set of packs with .keep as a
whole is closed".

It may become tricky once we start talking about creating a new
.keep out of youngest objects PLUS a few young keep packs, though.

Starting from all on-disk .keep packs, you'd mark them as in-core
keep bit, then drop in-core keep bit from the few young keep packs
that you intend to coalesce with the youngest objects---that is how
I would imagine your repacking strategy would go.  The set of all
the on-disk .keep packs may give us "closed" guarantee, but if we 
exclude a few latest packs from that set, would the remainder still
give us the "closed" guarantee we can take advantage of, in order to
pack these youngest objects (including the ones in the kept packs
that we are coalescing)?
