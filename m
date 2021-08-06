Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C76EC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B1E61179
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhHFQvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 12:51:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54123 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhHFQvC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 12:51:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3568142381;
        Fri,  6 Aug 2021 12:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2bfqJEteIu+WUYScQc+GbMYWqsUDwFYRs0bPaw
        ZZ6ig=; b=NRTQzyYmxjbbGFGGH4/rKwThnpCMKV6FasaK5kEFum933eijurCGKT
        xlZLte177h9fn5gvzQh+tr+wYFNU/Aa+TwakEJQWjDzi0vwPr/1SoKci4ejeDt/H
        FzD4V0dtGP3du9i3D4XxXUHLct+jXr2L064rTKiJqEy/11dMMcfVQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EAFAF142380;
        Fri,  6 Aug 2021 12:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3293014237C;
        Fri,  6 Aug 2021 12:50:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 2/6] connected: do not sort input revisions
References: <cover.1624858240.git.ps@pks.im> <cover.1628162156.git.ps@pks.im>
        <9d7f484907e2bd2492e6676238579e9f0c6ed374.1628162156.git.ps@pks.im>
        <xmqqfsvnloju.fsf@gitster.g> <YQzQGVQdh4t0uZ3N@ncase>
Date:   Fri, 06 Aug 2021 09:50:42 -0700
In-Reply-To: <YQzQGVQdh4t0uZ3N@ncase> (Patrick Steinhardt's message of "Fri, 6
        Aug 2021 08:00:57 +0200")
Message-ID: <xmqqwnoyikkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70E24BBA-F6D6-11EB-80A0-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Wouldn't that effectively change semantics though? If the user passes
> `git rev-list --no-walk=unsorted --no-walk`, then the result is a sorted
> revwalk right now. One may argue that most likely, nobody is doing that,
> but you never really know.

True.

> An easier approach which keeps existing semantics is to just make
> `--no-walk` and `--unsorted-input` mutually exclusive:
>
>     - If the `unsorted_input` bit is set and `no_walk` isn't, and we
>       observe any `--no-walk` option, then we bail.
>
>     - Likewise, if the `no_walk` bit is set, then we bail when we see
>       `--unsorted-input` regardless of the value of `unsorted_input`.
>       This would keep current semantics of `--no-walk`, but prohobit
>       using it together with the new option.

True again.  As I said, I do prefer going in the "start tight to
forbid combination" route.  But as I pointed out, the coverage by
the posted patch seemed to have gap(s).

Thanks.

