Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164F4C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF4561CB3
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhGFV4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:56:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64834 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFV4t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:56:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 104E7135FE6;
        Tue,  6 Jul 2021 17:54:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0RHMEGsBpTnj4puWLCAnCjAz1ho4yF+yWnII3/
        2Q+e4=; b=oNTE2uBuGJLLWMTsliyqeYul2rDvHUnlZJSBkXByd/18piy9+Yik8o
        lEghZZJUPYwOqdTTSQubV7D9NLnqjJb+ZepgBAW0VikWemnbuOgxqDgQdXxO3by0
        3k91HCsTIzd0djdy7MGIs4l2wWdluPVa5UJNewxkTUaurZSBwPFUU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08689135FE5;
        Tue,  6 Jul 2021 17:54:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C28B135FE1;
        Tue,  6 Jul 2021 17:54:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        =?utf-8?Q?'=C3=86v?= =?utf-8?Q?ar_Arnfj=C3=B6r=C3=B0_Bjarmason'?= 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "'Alex Henrie'" <alexhenrie24@gmail.com>,
        "'Richard Hansen'" <rhansen@rhansen.org>
Subject: Re: [RFC PATCH 01/35] merge: improve fatal fast-forward message
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
        <20210705123209.1808663-2-felipe.contreras@gmail.com>
        <87bl7f5ho1.fsf@evledraar.gmail.com>
        <60e4bf9a6a628_1c4281208b@natae.notmuch>
        <04de01d772a8$540c6690$fc2533b0$@nexbridge.com>
        <xmqq1r8bi2l0.fsf@gitster.g>
        <04e001d772ae$3d87e0b0$b897a210$@nexbridge.com>
Date:   Tue, 06 Jul 2021 14:54:05 -0700
In-Reply-To: <04e001d772ae$3d87e0b0$b897a210$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 6 Jul 2021 17:31:05 -0400")
Message-ID: <xmqqsg0rglc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B01744D8-DEA4-11EB-9413-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On July 6, 2021 4:56 PM, Junio C Hamano wrote:
>>"Randall S. Becker" <rsbecker@nexbridge.com> writes:
>>
>>>>If you do:
>>>>
>>>>  % git merge --ff-only
>>>>  fatal: Not possible to fast-forward, aborting.
>>>>
>>>>That "aborting" part is redundant; we know `git merge` should abort
>>> if the fast-forward is not possible, we explicitely told git to do
>>> that.
>>>
>>> `git merge` is a special operation where errors (conflicts, for one)
>>> may leave the repository in a merge pending state where you
>>> subsequently may have to use `git merge --abort` to reset the
>>> situation or `git add` to continue. The `aborting` output makes it
>>> clear that you do not have to do the `--abort` and *cannot* do the
>>> `add` because there was an implicit `--abort` done resulting from the
>>> failure. This is important information for the user.
>>
>>If so, adding ", aborting" to the end is misleading.  In this particular failure mode, the command pretends that the merge did not even
>>start.
>
> You know that, and I know that. I contend that git users do not
> generally want to care about failure modes. While a flow
> description might be instructive, I doubt many git users would
> look at it. We can only hope that front ends know how to make this
> clean for them.

They may not care about "failure modes" but they would want to know
that in this situation, unlike other times, they do not have to say
"git merge --abort" (or "git reset --hard").  Saying ", aborting"
does not help as much as saying say ", not starting a merge", for
example.

