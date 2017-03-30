Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0857D20966
	for <e@80x24.org>; Thu, 30 Mar 2017 16:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933850AbdC3QAk (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 12:00:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59377 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933464AbdC3QAj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 12:00:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EA4F6A5E8;
        Thu, 30 Mar 2017 12:00:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6iD+EpezLWG7jkDtegrWqVKI3Ys=; b=oxo4Ze
        kqECUccsQH17Zb4gBR+FMxJ12olibyTZpB4hiranCAz41TBC4mkNw/TbzopzBg56
        oenBLxE7lfYvkUOPIl9qiBJS5XmFQzzvCWjyiUtDlwxg9Ol4yxjzt1ZVuaDGFqGE
        XDvBqWNDLCFwpkFP3jETPASdxcx10WU19vekQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AqmNxgWHWS6M1KSN8omZrEq2/S59Qa/I
        MBE4jz3tD88l4lRoCBnnWFpTaS5ue8ayLcpqeCHdfMcLFtMl3tyOKug8YLFWC100
        6PnFROoO8ndg0zz6Kne+8eIbT0e/qx0AiRyfgul8dhwvT/nQOtUdlzxjSZ7Jopgd
        LeAei+QZA/8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93DEC6A5E7;
        Thu, 30 Mar 2017 12:00:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D24F96A5E5;
        Thu, 30 Mar 2017 12:00:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] read-cache: avoid git_path() race in freshen_shared_index()
References: <20170329080820.8084-1-chriscool@tuxfamily.org>
        <xmqqfuhwau6r.fsf@gitster.mtv.corp.google.com>
        <20170329175614.uecvtvmzoj2wfle3@sigill.intra.peff.net>
        <CAP8UFD29xWU5bHwewUSq26pVTwK-gy3uSVG2aGTCrDak3620=A@mail.gmail.com>
Date:   Thu, 30 Mar 2017 09:00:35 -0700
In-Reply-To: <CAP8UFD29xWU5bHwewUSq26pVTwK-gy3uSVG2aGTCrDak3620=A@mail.gmail.com>
        (Christian Couder's message of "Thu, 30 Mar 2017 10:40:38 +0200")
Message-ID: <xmqq7f367o0s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0398903C-1562-11E7-A880-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Mar 29, 2017 at 7:56 PM, Jeff King <peff@peff.net> wrote:
> ...
>> Yeah, it looks like that is what happened. I see that Christian bisected
>> the rebase to find the commit in the series that introduces the problem.
>> I'm mildly curious which commit upstream created the problem[1].
>
> I bisected it to 18633e1a22 (rebase -i: use the rebase--helper
> builtin, 2017-02-09).
> This commit is indeed changing how the interactive rebase works, but
> it is not easy to see how it impact git_path() usage.

That small series activates a large body of code that hasn't been exercised
so it is not surprising.  

> Yeah, I am very tempted to just rewrite the commit message like this:
>
> ------------
>
> When performing an interactive rebase in split-index mode,
> the commit message that one should rework when squashing commits
> can contain some garbage instead of the usual concatenation of
> both of the commit messages.
>
> Bisecting shows that c3a0082502 (read-cache: use
> freshen_shared_index() in read_index_from(), 2017-03-06) is involved,
> which points to the unsafe use of git_path() in
> freshen_shared_index().
>
> ------------
>
> and change the subject to "read-cache: avoid using git_path() in
> freshen_shared_index()".

Sure.  It may not be even worth mentioning a not-so-useful bisect
result, and the potential riskiness of the original code (iow why
this fix is the right thing) can be seen from the patch alone.

Thanks for following it through.
