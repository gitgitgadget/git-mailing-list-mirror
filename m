Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069FD1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 17:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfIPRfq (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 13:35:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65423 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfIPRfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 13:35:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 780FB91F80;
        Mon, 16 Sep 2019 13:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xvAjGYYAFSvF7ay+7xd9o1YrBx8=; b=fgL07o
        hnW4d2B5Fh7H+KV8XfFtBYlFOk8UEarCdeRCh/wug1P/9bKnK0IM5AZLvIzyZFgf
        VdJ6FNQziaYra/JBaE1Acp+++BGNRXQGBN9EnWr/jwhwXH0qX3vUUShznhAn8Hkj
        7ReFzCofTGgT9Fo6T5iGt0SxUq6ZLMEjWikbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dku52J137OAIKCONIMVbbz8nbi8huSkd
        HcAWH8gC5P2tRDWwLxCzwj8UtKhSIWcm9MDOypjF6VGbSYZCIIcRjFoj3eQaA486
        z/buVKBwEo5D+73Q6TRs6tsX0UFZORpSlWak8DyKsB06WTQH97Bb9Q2jnlocGRud
        R2j72ZYUHd0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70F1191F7F;
        Mon, 16 Sep 2019 13:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9539F91F7E;
        Mon, 16 Sep 2019 13:35:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: diff.renames not working?
References: <CAHd499BT35jvPtsuD9gfJB0HJ=NxtzyQOaiD7-=sHJbFYhphpg@mail.gmail.com>
        <20190914033017.GA30458@sigill.intra.peff.net>
Date:   Mon, 16 Sep 2019 10:35:40 -0700
In-Reply-To: <20190914033017.GA30458@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 13 Sep 2019 23:30:17 -0400")
Message-ID: <xmqqlfuob0ur.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 683A7756-D8A8-11E9-95A5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   - a way to independently specify the source pathspec and the
>     output-limiting pathspec. This is a cheaper version of the one
>     above, where you could look at a subset of the tree a sources, but
>     limit the set of shown paths even further. It's not conceptually
>     that difficult, but syntactically it gets weird since you have two
>     lists of pathspecs on the command-line.

Yes, the pathspec has always been input limiter and I think we have
discussed adding separate output limiter from time to time, but
nothing has happened.

Back in the scripted porcelain days, it would conceptually have been
simpler and cleaner, as you probably would run "diff-tree --raw"
with no (or "input") pathspec, filter its output with "output"
pathspec, and then convert the raw diff to a patch ( we used to have
such a filter, before we gave the -p option to all three "diff"
family backends).

Introducing an option to say "Pretend as if the system supported
output pathspec, and use the pathspec as such, without any input
pathspec" feels like a dirty hack compared to conceptual purity of
having two separate sets, and having to run without any input
pathspec may not be usable in truly large project, but I suspect it
may be good enough for most people (i.e. your "first one" that
wouldn't be too hard).  I am not sure if I like it, though X-<.

>> ```
>> git diff --follow master...topic -- ZPay/ZPayClient.hpp
>> ```
>
> So yes, that does work, and is why I added the "(clean)" qualifier
> above. It behaves like the "-C -C -C" I proposed. But the fact that it
> does so is entirely accidental. What happens is this:

I am kinda surprised that "diff" gets affected by "--follow" (I knew
that the command line parser would take that option meant for "log"
family without complaining) at all.
