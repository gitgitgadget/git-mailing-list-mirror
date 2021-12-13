Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655CC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbhLMWKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:10:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50262 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbhLMWKT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:10:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D735111742;
        Mon, 13 Dec 2021 17:10:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rbRBOgirQVXQ
        4orVpaXtHyfs6Wn1V1x2IoIqI1hdUXM=; b=dgPKnk3e5nb3zwPSoMWL7ou5vfWF
        VcCGID4AvejIGbpZyrLjOD1GkOf7zWYa0EO5DdhS1q7NbaQ8YEBXjEMvbZ0M5lDk
        RozS+PAaxEtP3ms7i+0LTY5La+0GJVyd0pCtNn6/uakakSrXG5YOPKCboIAWKdrx
        NDas+EGfEiSXyGM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01554111741;
        Mon, 13 Dec 2021 17:10:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6977B111740;
        Mon, 13 Dec 2021 17:10:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 02/11] reftable: fix resource leak in error path
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <975a570d388fca79546987f4683fcd33419aad98.1639411309.git.gitgitgadget@gmail.com>
        <211213.86pmq08ogt.gmgdl@evledraar.gmail.com>
        <CAFQ2z_MrSEExScfBPku1uTZQgBYyk-B08U98zs5P7LNdLphutg@mail.gmail.com>
Date:   Mon, 13 Dec 2021 14:10:16 -0800
In-Reply-To: <CAFQ2z_MrSEExScfBPku1uTZQgBYyk-B08U98zs5P7LNdLphutg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 13 Dec 2021 17:44:46 +0100")
Message-ID: <xmqqzgp49mwn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 74E6775E-5C61-11EC-8AB7-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Mon, Dec 13, 2021 at 5:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Other things in the codebase don't check for NULL before feeding thing=
s
>> to reftable_free(), and our own free() has a coccicheck rule to catch
>> this sort of code, we should probably add reftable_free to that list..=
.
>
> Thanks, changed.
>
>> > +     struct reftable_block_source source =3D { NULL };
>>
>> Nit: It doesn't matter for semantics, but usually we use "{ 0 }", and
>> your 1/11 does too. Would be better to do that here for consistency.
>
> I got a past review where someone complained about this. I don't mind
> either way, but would rather not flipflop.

The last part is important. =20

For initializers that show the value for the first member in {} to
mean "everything is zero-initialized", only because the language
does not allow us to write

	struct foo var =3D {};

we historically used { NULL } for pointers and { 0 } for integral
types (primarily because auto checkers like sparse did not like us
to write a NULL pointer as 0), but we started preferring { 0 } as
more recent versions of checkers understand it as an idiom, and we
can freely reorder the struct members if we consistently spell the
"everything is zero-initialized" that way.

So, let's use { 0 } here, too.

Thanks.
