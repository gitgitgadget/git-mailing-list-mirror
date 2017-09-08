Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ACD5208E3
	for <e@80x24.org>; Fri,  8 Sep 2017 06:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbdIHGi1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 02:38:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51793 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753206AbdIHGi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 02:38:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9986B1B9D;
        Fri,  8 Sep 2017 02:38:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q9HRHsyeFvwZidR4lm/gT7ehDtc=; b=IVX7xi
        eMznYzGsR/aXCsMJQHceITiy+eATOK81/ZA3Hk8jl6rM6vdBTX+13XNGYeS8xuD/
        VI5O+y8zQ9yPViKmxc0U0zEpjV9HuVGyhzGsrnNUbHKneQ2PuyxmL2SAL/KW/mbO
        nu4CskGI+T+7aMoQ9X6Vn8nx/+JpLqb62y6uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w5bxuqF8yDLcijU1mCb9x1MEOPrWHK8B
        nVkD9Oy6wrmhaWRhFQhG3RixqX7qf/NpYhHlNl2y2mMeZZve8IGEORndLMxBn88T
        nif0+2HfU6fstXWiR38sDaoKS0szgMp2UlKq272SHeiq+5uXuW4eiOmKAtk1nJXK
        9JfVicJC6Pg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0388B1B9C;
        Fri,  8 Sep 2017 02:38:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21F57B1B9B;
        Fri,  8 Sep 2017 02:38:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?0JLQsNC70LXQvdGC0Lg=?= =?utf-8?B?0L0=?= 
        <valiko.ua@gmail.com>, "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git shortlog -sn --follow -- <path>" counts all commits to entire repo
References: <CAJrPYn8_n1JD3hL1LSAVz2Khs=dZRVaZ-gpru5AV+ottv5WfAw@mail.gmail.com>
        <CAGZ79kZAeCERKn6he2LzAj97BXEJ5U+Fy4sorAPNmW_XaCS9Vg@mail.gmail.com>
        <20170908051015.ybq4egdrddecl4se@sigill.intra.peff.net>
Date:   Fri, 08 Sep 2017 15:38:17 +0900
In-Reply-To: <20170908051015.ybq4egdrddecl4se@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 8 Sep 2017 01:10:15 -0400")
Message-ID: <xmqqo9qlzodi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D3A6D5A-9460-11E7-848B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That's definitely the intent, but I think --follow is just buggy here.
> We don't seem to trigger a diff, which is where "git log" does the
> follow check (because of the way it's bolted onto the diff, and not the
> actual pathspec-pruning mechanism).

Yeah, at the same time, the usual caveat about "--follow" that it
would not work in general in a history with forks and merges due to
its keeping track of a single pathspec that is globally swapped out.

> Something like the patch below seems to work, but there are a lot of
> open questions. And it would probably want to do something to prevent
> nonsense like "shortlog -p" from showing actual diffs.
>
> I suspect a better solution might involve actually building on
> log-tree.c to do the traversal (since this internal traversal is
> supposed to be equivalent to "git log | git shortlog").

Probably.  That approach would also have an added benefit that when
"--follow" is fixed to keep track of which path it is following per
traversal for "git log", the result from "git shortlog --follow"
would automatically become correct, I guess?

Thanks.
