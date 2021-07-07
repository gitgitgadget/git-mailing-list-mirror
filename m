Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090D3C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD65561C59
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhGGXM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 19:12:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62813 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhGGXM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 19:12:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B660DD03E2;
        Wed,  7 Jul 2021 19:09:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Df3lAcD/ANPO
        ay+MsvGKm+2v0599GeZMO+2U5sESwX0=; b=LM+GmAmUcm2/eahANAV9HhqHdu20
        M51LWvIw99gqgtKxdmsbTfisB4c9uxV3iPsqmyXktfZx0IweJa38N8EcmytUll/l
        YiQcjRqiNZ1WAOY1z2W8KCGaIlOBEEoVtmSKrnmX4mHwY+yOeN+pH9QzHF5G5NP/
        6Z+YzNLj2TtQFOI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE7FCD03E1;
        Wed,  7 Jul 2021 19:09:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B6E7D03E0;
        Wed,  7 Jul 2021 19:09:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] strbuf.h API users: don't hardcode 8192, use
 STRBUF_HINT_SIZE
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
        <patch-2.3-a920a9971e8-20210707T103712Z-avarab@gmail.com>
        <xmqqo8bdda2j.fsf@gitster.g>
Date:   Wed, 07 Jul 2021 16:09:44 -0700
In-Reply-To: <xmqqo8bdda2j.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        07 Jul 2021 15:37:56 -0700")
Message-ID: <xmqqim1ld8lj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B348B62-DF78-11EB-B921-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change a couple of users of strbuf_init() that pass a hint of 8192 to
>> pass STRBUF_HINT_SIZE instead.
>>
>> Both of these hardcoded occurrences pre-date the use of the strbuf
>> API. See 5242bcbb638 (Use strbuf API in cache-tree.c, 2007-09-06) and
>> af6eb82262e (Use strbuf API in apply, blame, commit-tree and diff,
>> 2007-09-06).
>>
>> In both cases the exact choice of 8192 is rather arbitrary, e.g. for
>> commit buffers I think 1024 or 2048 would probably be a better
>> default (this commit message is getting this commit close to the
>> former, but I daresay it's already way above the average for git
>> commits).
>
> Yes, they are arbitrary within the context of these callers.
>
> I do not think using STRBUF_HINT_SIZE macro in them is the right
> thing to do at all, as there is no reason to think that the best
> value for the write chunk sizes in these codepath has any linkage to
> the best value for the read chunk sizes used by strbuf_read() at
> all.  When benchmarking reveals that the best default size for
> strbuf_read() is 16k, you'd update STRBUF_HINT_SIZE to 16k, but how
> do you tell that it also happens to be the best write buffer size
> for the cache-tree writeout codepath (answer: you don't)?

Having said all that, I wouldn't be so opposed to an approach that

 - declares that we need only one "default I/O buffer size";

 - declares that the appropriate size for it is 8192;

 - #define DEFAULT_IO_SIZE 8192;

 - does something like your [PATCH 1/3], but not limited to strbuf
   API, and

 - covers also the writeout codepath of cache-tree, etc. that uses
   hardcoded I/O buffer size.

The biggest trouble I had with the posted patches, especially the
[PATCH 2/3], was that I am quite sure that you wouldn't have used
STRBUF_HINT_SIZE in the cache-tree writeout codepath or commit-tree
codepath if they didn't use strbuf as a convenient way to get an
elastic buffer.  The more relevant commonality across codepaths that
use 8192 is that the constant is used for sizing the I/O buffer, and
I got an impression that the 3-patch series posted did an incomplete
job of touching some that happen to use strbuf.

An approach that concentrated on the "right" commonality, i.e. we
have hardcoded magic constants for I/O buffer sizing, would have
covered copy.c, diff-delta.c, http-backend.c etc. that do not use
strbuf API where they have hardcoded 8k constants.

Thanks.

