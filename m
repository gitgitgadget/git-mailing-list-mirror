Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FBFC432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CE360F41
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 19:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhHPTMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 15:12:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51003 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhHPTMV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 15:12:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED559D6129;
        Mon, 16 Aug 2021 15:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8qu3f5YozaXy
        QCabZetnGM0wWqJxmPXHbC7/9BUoGvw=; b=GqfdkFPjklgQSwch98o3BeJeEpVb
        hFwj6ijkxQaVOggvr/KmIqn4a2gNbrogNv7GtA0ReT9sSmVWBGCifh/FFm9eaq/Q
        JdqoDBqZ6IyGXRr8jZF8P/QH7bt5eDXf8xRz4SD+vQpENZw0pdrG7hhY+CQgO77G
        T1hZfeEgXGSb7wU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3308D6128;
        Mon, 16 Aug 2021 15:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6BBFCD6127;
        Mon, 16 Aug 2021 15:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] oidtree: avoid unaligned access to crit-bit tree
References: <20210627024718.25383-1-e@80x24.org>
        <20210629205305.7100-6-e@80x24.org>
        <3cbec773-cd99-cf9f-a713-45ef8e6746c3@ahunt.org>
        <9583052d-9181-7532-304a-4bacfb9e1147@web.de>
Date:   Mon, 16 Aug 2021 12:11:47 -0700
In-Reply-To: <9583052d-9181-7532-304a-4bacfb9e1147@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 14 Aug 2021 22:00:38 +0200")
Message-ID: <xmqqv945qk5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CE17739A-FEC5-11EB-9C6C-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The flexible array member "k" of struct cb_node is used to store the ke=
y
> of the crit-bit tree node.  It offers no alignment guarantees -- in fac=
t
> the current struct layout puts it one byte after a 4-byte aligned
> address, i.e. guaranteed to be misaligned.
>
> oidtree uses a struct object_id as cb_node key.  Since cf0983213c (hash=
:
> add an algo member to struct object_id, 2021-04-26) it requires 4-byte
> alignment.  The mismatch is reported by UndefinedBehaviorSanitizer at
> runtime like this:
>
> hash.h:277:2: runtime error: member access within misaligned address 0x=
00015000802d for type 'struct object_id', which requires 4 byte alignment
> 0x00015000802d: note: pointer points here
>  00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00=
  00 00 00 00 00 00 00 00  00
>              ^
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior hash.h:277:2 in
>
> We can fix that by:
>
> 1. eliminating the alignment requirement of struct object_id,
> 2. providing the alignment in struct cb_node, or
> 3. avoiding the issue by only using memcpy to access "k".
>
> Currently we only store one of two values in "algo" in struct object_id=
.
> We could use a uint8_t for that instead and widen it only once we add
> support for our twohundredth algorithm or so.  That would not only avoi=
d
> alignment issues, but also reduce the memory requirements for each
> instance of struct object_id by ca. 9%.
>
> Supporting keys with alignment requirements might be useful to spread
> the use of crit-bit trees.  It can be achieved by using a wider type fo=
r
> "k" (e.g. uintmax_t), using different types for the members "byte" and
> "otherbits" (e.g. uint16_t or uint32_t for each), or by avoiding the us=
e
> of flexible arrays like khash.h does.
>
> This patch implements the third option, though, because it has the leas=
t
> potential for causing side-effects and we're close to the next release.
> If one of the other options is implemented later as well to get their
> additional benefits we can get rid of the extra copies introduced here.
>
> Reported-by: Andrzej Hunt <andrzej@ahunt.org>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  cbtree.h  |  2 +-
>  hash.h    |  2 +-
>  oidtree.c | 20 +++++++++++++++-----
>  3 files changed, 17 insertions(+), 7 deletions(-)

Thanks.  Among the choices you considered (and I agree that each of
them is a solution that goes in a reasonable direction), the one
chosen here certainly is the least risky one.

