Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96B41F991
	for <e@80x24.org>; Thu,  3 Aug 2017 15:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbdHCP7j (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 11:59:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58500 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751183AbdHCP7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 11:59:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B54C1A366D;
        Thu,  3 Aug 2017 11:59:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KsIz9eCZtbuXL8CkNoqv0Ks98BI=; b=wOrm6g
        hPC0/rXKXv9LnKzVUxQ+UeT6bCtX7zkkZ3IfSBnjr1G1pLF1T4Js2xI87lWhA6Sh
        NZYjnGoAwZ4uIXhMQDVTNoSP/3RvBq4FqYBTkVaERA7Cu7mN4bhTT41x6TVIwt6O
        ty8cr5MlY1FUL2xITcNbsfc6UVxRtAwpZZK20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sSfDaOUS6bJNSahaXHqak1oknaHTKvIE
        AwX2YlM1/PVodB6CmkL4xEisnne/Zmdb656kdYk6rTjb7vZlYyAFU2Lmg4y1FVTY
        SqmHC5UveTH0ueKs+UPGXbosn31mv4UssV5fDvo2HKxkkhg3muHnJoscFpGB1eBq
        thDlwAjRRFU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE74EA366C;
        Thu,  3 Aug 2017 11:59:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A4BCA366B;
        Thu,  3 Aug 2017 11:59:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH DONOTAPPLY 5/4] revision: let --stdin set rev_input_given
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
        <20170802223416.gwiezhbuxbdmbjzx@sigill.intra.peff.net>
Date:   Thu, 03 Aug 2017 08:59:33 -0700
In-Reply-To: <20170802223416.gwiezhbuxbdmbjzx@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 2 Aug 2017 18:34:16 -0400")
Message-ID: <xmqq3798r6ai.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BECCC782-7864-11E7-AD08-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This patch makes "rev-list --stdin </dev/null" return an empty set.
> Which makes sense to me. But a side effect is that:
>
>   git log --stdin </dev/null
>
> now shows nothing (rather than HEAD). I think that's probably the right
> thing. But:
>
>   (echo --; echo t) | git log --stdin
>
> no longer defaults to HEAD. Which maybe people would see as a
> regression. I could see arguments either way.

Yeah, thanks for thinking this through.  I do think this would be a
regression.  On the other hand,

    (printf "%s\n" --tags=no-such -- t) | git log --stdin

should not default to HEAD and show nothing, I would think.

So if we wanted to do the "--stdin" thing properly, we probably need
to keep the "--stdin" option itself neutral wrt "did we get rev
input?"; instead, each input item that comes in from the standard
input stream would decide if the user wants us to fall back to the
default, perhaps?

> But this also breaks filter-branch (or at least a few of its tests),
> which really wants to do:
>
>   git rev-list --default HEAD --stdin <maybe-empty
>
> and traverse HEAD.

Hmph.  Do you mean the former should traverse from HEAD while the
latter should give us empty in the following two, because unlike
"log", "rev-list" does not do the "default to HEAD" thing if it is
not told to do so?

    git rev-list --default HEAD --stdin </dev/null
    git rev-list --stdin </dev/null

If so, I think the reasoning makes sense.

> I didn't dig enough to see if it's actually sane or
> not. The failing tests seem to be weird noop filters that our test
> script uses. But I'm worried it would break some real case, too.

Thanks.  Let's not rush things.  

The ones you sent for application 1-4/4 all are improvements.
