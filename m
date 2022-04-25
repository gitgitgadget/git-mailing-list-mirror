Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CFBC433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbiDYRd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiDYRdY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:33:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95824BBA0
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:30:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 641BF12F094;
        Mon, 25 Apr 2022 13:30:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xsIWUrrP7zRN
        YLg64xrjEieR7jDk1Z4zNa7PIU6pfJk=; b=ffu6l2OwU4YGjUSN+UkeENsnz9sy
        dSc6+jglPomxy3MkBrzplj3yQXRyNcMTAGhyqbwT2IaOQ+XcmzFIg34soATwWJ2B
        jRW3ddaD+RYKvYb3sLpXxqouX/+tbQVp6Z4kQe0c0OJ+qCLGR5RCmh8yCcb1HwO0
        rtcI10H4+tRlAEw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58E6A12F092;
        Mon, 25 Apr 2022 13:30:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C271A12F091;
        Mon, 25 Apr 2022 13:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [RFC PATCH 1/2] reftable: remove the "return_block" abstraction
References: <20220415083058.29495-1-carenas@gmail.com>
        <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
        <RFC-patch-1.2-76ed86bf88c-20220415T101740Z-avarab@gmail.com>
        <CAFQ2z_O7ytx=AsXuJbYnOdMwT0u03sMP-ZjRRjt4HFn48HT-2g@mail.gmail.com>
Date:   Mon, 25 Apr 2022 10:30:13 -0700
In-Reply-To: <CAFQ2z_O7ytx=AsXuJbYnOdMwT0u03sMP-ZjRRjt4HFn48HT-2g@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 25 Apr 2022 11:57:38 +0200")
Message-ID: <xmqqilqxvzoa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5E181BB2-C4BD-11EC-8561-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, Apr 15, 2022 at 12:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> This abstraction added in 1214aa841bc (reftable: add blocksource, an
>> abstraction for random access reads, 2021-10-07) has the caller
>> provide a "blockp->data", so there's not point in having the vtable
>> have a custom free() function.
>>
>> In addition this had what looked like a poor man's SANITIZE=3Daddress
>> doing a memset() to 0xff just before the data was free'd.
>
>>  void reftable_block_done(struct reftable_block *blockp)
>>  {
>> -       struct reftable_block_source source =3D blockp->source;
>> -       if (blockp && source.ops)
>> -               source.ops->return_block(source.arg, blockp);
>> +       FREE_AND_NULL(blockp->data);
>
>
> My thinking here is that we could mmap the reftable file to do reads.
> In that case, discarding the block would imply decreasing a refcount
> somewhere, rather than deallocating memory.

Sounds like a plan.  As a solution to the memset() thing, ripping
out this abstraction layer is indeed not just overkill but also
doing too much of "while we are at it".

Let's take what we've queued on cm/reftable-0-length-memset and
merge it down.

Thanks.
