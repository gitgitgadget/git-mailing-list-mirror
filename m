Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B21C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C4B61CA2
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhGFU64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:58:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55341 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFU6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:58:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DFE714960F;
        Tue,  6 Jul 2021 16:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aU4+I2S2nf1MYDZjIKxAEnhrJmap+9hzfvYlB4
        6Klvw=; b=CaUVYNCVj63f0HC7/RD3SF2MOkRNYGJrSvcqjrWeF+uEnY5MRLbRiG
        ZekVdyWaqKc8Wq3MP4GNfPQhQ7JLCBvgTedrQNJO3/42pQ2u3n6+ob/ja7kJ5z04
        Uqn1/6amZHyLiDeGrAoRzSlbSrE5UJIUv4TMwggQD6MmKNspmGLCI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36B7114960E;
        Tue,  6 Jul 2021 16:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A42014960B;
        Tue,  6 Jul 2021 16:56:12 -0400 (EDT)
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
Date:   Tue, 06 Jul 2021 13:56:11 -0700
In-Reply-To: <04de01d772a8$540c6690$fc2533b0$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 6 Jul 2021 16:48:46 -0400")
Message-ID: <xmqq1r8bi2l0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98DCEF1E-DE9C-11EB-8ECB-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>>If you do:
>>
>>  % git merge --ff-only
>>  fatal: Not possible to fast-forward, aborting.
>>
>>That "aborting" part is redundant; we know `git merge` should abort
> if the fast-forward is not possible, we explicitely told git to do
> that.
>
> `git merge` is a special operation where errors (conflicts, for one)
> may leave the repository in a merge pending state where you
> subsequently may have to use `git merge --abort` to reset the
> situation or `git add` to continue. The `aborting` output makes it
> clear that you do not have to do the `--abort` and *cannot* do the
> `add` because there was an implicit `--abort` done resulting from the
> failure. This is important information for the user.

If so, adding ", aborting" to the end is misleading.  In this
particular failure mode, the command pretends that the merge did not
even start.

