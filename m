Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CC7C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD9C60FF0
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhGLT6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 15:58:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56479 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhGLT6I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 15:58:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8386C14DB00;
        Mon, 12 Jul 2021 15:55:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PfYIgD0OkwOznWtUopsOVNOj5YEvnbaqEIl+J6
        MlwcA=; b=OY5jbY5WalstWrLPPpiQF90Da66AO8YLCVxBJIVh1CApdfGCIDs+du
        4qMJfy9EOZH/6VDLwU38WkQltl0cloht2XV3i5SNF14mRcycFedIdkDE5qIbO1Fm
        3x4x9iNEMXsk7lqGOHgnyLti8eR2kuUxxMGvLQsACXoauktMMz834=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BFB514DAFF;
        Mon, 12 Jul 2021 15:55:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C7D9F14DAFE;
        Mon, 12 Jul 2021 15:55:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
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
Date:   Mon, 12 Jul 2021 12:55:14 -0700
In-Reply-To: <CAMMLpeSBgURtX+MKbABKdmFuuoTA-Dw3h8uONwNeiP5aqcnfpA@mail.gmail.com>
        (Alex Henrie's message of "Mon, 12 Jul 2021 12:24:56 -0600")
Message-ID: <xmqq8s2b489p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1458938E-E34B-11EB-B362-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Sorry, I misspoke. I was thinking of the case where fast-forwarding is
> impossible.

When we cannot fast-forward (i.e. we have our own development that
is not in the tip of their history),

 --ff-only would cause the operation fail
 --ff would become no-op (as it merely allows fast-forwarding)
 --no-ff would become no-op (as it merely forbids fast-forwarding)

and the latter two case, we'd either merge or rebase (with possibly
specified mode like --preserve-merges).  I thought the current
documentation is already fairly clear on this point?

> If fast-forwarding is possible, --ff-only already effectively
> implies --no-rebase, and we might want to make that explicit in
> the documentation.

When we fast-forward (i.e. their history is descendant from ours,
and the user did not give --no-ff), it does not matter if it is done
using the merge backend, the rebase backend, or by the "git pull"
wrapper. The end user does not care.  The end result is that the tip
of the branch now points at the tip of the history we pulled from
the other side and that is all what matters.

So, from that point of view, I do not think we want to say rebase or
merge or anything else for such a case in the documentation.

THanks.
