Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5383C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 23:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E80611CB
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 23:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGLXDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 19:03:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60490 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLXDU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 19:03:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E84614F083;
        Mon, 12 Jul 2021 19:00:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rOUTQnrH0hpM7wDZgal+1VCTEf+RwVn4IMgrHb
        bUWSs=; b=iJpllxVhB2dADWLO47m47fYJCe70p7WdBCyW8fO5GlXCBp5aQngsnL
        eS6wG5XBRRMAXELUp9PSh8slb2xL7Vp2Q+xLoyt6Wf203CODvOFgnYmf9xhVGXT9
        iK7PwSUV9UwDhFa6dKtHagPvzVEhY0HN2QVIHqKxV6lB6N++YzTrA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 682A214F082;
        Mon, 12 Jul 2021 19:00:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9678B14F07A;
        Mon, 12 Jul 2021 19:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding
 is impossible
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
        <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
        <xmqqpmvn5ukj.fsf@gitster.g>
        <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
        <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
        <CAMMLpeSBgURtX+MKbABKdmFuuoTA-Dw3h8uONwNeiP5aqcnfpA@mail.gmail.com>
        <xmqq8s2b489p.fsf@gitster.g>
        <CABPp-BH+LPbfdgixvSEGpLxwCHHSK99PFmE3q04jPZjLaqr5Xg@mail.gmail.com>
Date:   Mon, 12 Jul 2021 16:00:25 -0700
In-Reply-To: <CABPp-BH+LPbfdgixvSEGpLxwCHHSK99PFmE3q04jPZjLaqr5Xg@mail.gmail.com>
        (Elijah Newren's message of "Mon, 12 Jul 2021 13:51:18 -0700")
Message-ID: <xmqqbl772l4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2E5B9A6-E364-11EB-9E7B-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> When we cannot fast-forward (i.e. we have our own development that
>> is not in the tip of their history),
>>
>>  --ff-only would cause the operation fail
>>  --ff would become no-op (as it merely allows fast-forwarding)
>>  --no-ff would become no-op (as it merely forbids fast-forwarding)
>>
>> and the latter two case, we'd either merge or rebase (with possibly
>> specified mode like --preserve-merges).  I thought the current
>> documentation is already fairly clear on this point?
>
> git pull's --no-ff is documented to "create a merge commit in all
> cases", and thus as worded, seems incompatible with rebasing to me.

It smells like a "too literally to be useful" interpretation of a
pice of documentation that has no relevance to "pull --rebase" to
me, though.  It comes from merge-options.txt and would not be
relevant to "git pull --rebase" to begin with.
