Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD3FC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2500761104
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbhHaSQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:16:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52483 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbhHaSQa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 14:16:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45FBDEDB1F;
        Tue, 31 Aug 2021 14:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qQutO+s+M/dk
        Vt1SSxUVsRDXXV4MT07A6uv8jNUFLEA=; b=w1HC1aUYTpfueDKOj1Aqjeov0QiU
        aaYIEtDHFbDETrY3022e60wGBobjSFGHwYlXxlTTWHs9z1qkVJDj4pqPWelYciIG
        2zhSyuACoxOVHvD3Oe4xwnNrqoTcf5W5+FvU+sefIRUGHVpquMLa6ZUN+e4cHfU6
        khuNWxvQ1GXAhI0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CF7BEDB1E;
        Tue, 31 Aug 2021 14:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2ACDEDB1D;
        Tue, 31 Aug 2021 14:15:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bruno Albuquerque <bga@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] protocol-caps.c: fix memory leak in send_info()
References: <patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com>
        <patch-1.1-9acbc21cdd3-20210831T134632Z-avarab@gmail.com>
        <CAPeR6H6g_VM3SUyjfYfc+mQa27af7AJE9wbKN_TUdG6m5rAUow@mail.gmail.com>
Date:   Tue, 31 Aug 2021 11:15:33 -0700
In-Reply-To: <CAPeR6H6g_VM3SUyjfYfc+mQa27af7AJE9wbKN_TUdG6m5rAUow@mail.gmail.com>
        (Bruno Albuquerque's message of "Tue, 31 Aug 2021 08:32:36 -0700")
Message-ID: <xmqqtuj5tr96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6ECE0480-0A87-11EC-B9FE-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bruno Albuquerque <bga@google.com> writes:

> On Tue, Aug 31, 2021 at 6:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
> [Replying again as I used HTML mail by mistake. Sorry.]
>
>> Fix a memory leak in a2ba162cda (object-info: support for retrieving
>> object info, 2021-04-20) which appears to have been based on a
>> misunderstanding of how the pkt-line.c API works. There is no need to
>> strdup() input to packet_writer_write(), it's just a printf()-like
>> format function.
>>
>> This fixes a potentially large memory leak, since the number of OID
>> lines the "object-info" call can be arbitrarily large (or a small one
>> if the request is small).
>>
>> This makes t5701-git-serve.sh pass again under SANITIZE=3Dleak, as it
>> did before a2ba162cda2.
>
>
> Thanks for cleaning up after me. Yes, this was my lack of knowledge on
> how the internals of Git works. I was also not aware of SANITIZE=3Dleak
> so thanks for the heads up. This looks good to me.

Thanks, both.

Will apply.
