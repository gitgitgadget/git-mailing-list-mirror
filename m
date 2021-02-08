Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BB7C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 05:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B107364E25
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 05:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBHFmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 00:42:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58921 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBHFmm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 00:42:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B529111DC5C;
        Mon,  8 Feb 2021 00:42:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Pgh5ZOEWUgDW
        qSKR3tOrQyt19u4=; b=ESyTk6vf01fWWHrZ3rtXNpUbQcoZh3hB2b2BWppo/TmW
        x5Bge8kjLmgHhBdYYnLNQejw8oeIw92t6yUWlhMgJG2Rob0Cf0v/P1BOKu3bqmNU
        mdh23oqu0w5nyxvqtakv05UC+jElBfTX9V2Qec57nRFSB9sUO2zhdjZyez70kKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GvfHKd
        Tngiw685KHkmEt9pSV+Y2ofT7hmqzna+aQ+tsDOVHpZw2FZZ63gbc5UaxsQyBlah
        SG0NlIErVoEtL1PTen/9GzUv0mtGTIjmidewL3vsOHBWn4Cq78jfnUVzFljbkT9F
        QknWz2W7YzdRx/nbCgVFqgGn3tYSPiTgTeUww=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DD2211DC5A;
        Mon,  8 Feb 2021 00:42:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2B3711DC59;
        Mon,  8 Feb 2021 00:41:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 15/17] midx: use 64-bit multiplication for chunk sizes
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <83d292532a0fa3f3a0ad343421be4a99a03471d0.1611759716.git.gitgitgadget@gmail.com>
        <xmqq8s834c4s.fsf@gitster.c.googlers.com>
        <20210207195053.GA1016223@szeder.dev>
Date:   Sun, 07 Feb 2021 21:41:56 -0800
In-Reply-To: <20210207195053.GA1016223@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Sun, 7 Feb 2021 20:50:53 +0100")
Message-ID: <xmqqczxb6rq3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5BC6CB04-69D0-11EB-8683-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> No, that patch also removes lines like:=20
>
> -       chunk_offsets[cur_chunk] =3D chunk_offsets[cur_chunk - 1] + ctx=
.entries_nr * the_hash_algo->rawsz;
>
> -               chunk_offsets[cur_chunk] =3D chunk_offsets[cur_chunk - =
1] +
> -                                          ctx.num_large_offsets * MIDX=
_CHUNK_LARGE_OFFSET_WIDTH;

OK.  In other words, the above was replaced in the same patch with

    add_chunk(...., U32 * U32);

where the called function expects the result of the multiplication
as size_t in its function prototype.  It is a bit sad that U32*U32
to compute the argument that is to be passed as U64 must be casted
as (uint64_t)U32*U32 by the caller X-<.

The original that the above replaced, shown in your quote, is:

    U64 =3D U64 + U32 * U32;

I also wish that the fact that it is added to U64 is sufficient not
to require the RHS to be written as U64 + (uint64_t) U32 * U32 (in
other words, the original that was removed was OK without cast).

Sad.

