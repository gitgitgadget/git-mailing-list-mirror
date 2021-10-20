Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB3C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C38C613A9
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTOlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:41:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63453 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJTOlV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:41:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8416915D47B;
        Wed, 20 Oct 2021 10:39:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PtNte2uuCQzz
        dmo+sRxr3fgaHrmsKcJ5AtSAhzzWw9I=; b=ct/ZcMrHBusogpK9g6OPZvttm5gX
        iyPsM5i3V7MssB6mfHDIkH/1qvanYHJQDzyD5+6saXundTngh1exSPyd1HddDWCC
        SI4suRoQWLdjYf1xpHkT7QBFRDyzXDdBk1PmkNXZzDvIgByWTu59Blc1ulqQj8UZ
        9yWZj1Sv78RL4Gs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C25015D47A;
        Wed, 20 Oct 2021 10:39:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DDC9815D479;
        Wed, 20 Oct 2021 10:39:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v2 2/4] ref-filter API user: add and use a
 ref_sorting_release()
References: <211020.864k9boo0f.gmgdl@evledraar.gmail.com>
        <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
        <RFC-patch-v2-2.4-0ae71c19ab7-20211020T131627Z-avarab@gmail.com>
Date:   Wed, 20 Oct 2021 07:39:02 -0700
In-Reply-To: <RFC-patch-v2-2.4-0ae71c19ab7-20211020T131627Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 20 Oct
 2021 15:24:34
        +0200")
Message-ID: <xmqqpmrzrcah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 78EAECE6-31B3-11EC-9D31-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +void ref_sorting_release(struct ref_sorting *sorting)
> +{
> +	struct ref_sorting *next =3D sorting->next;
> +	if (next)
> +	       ref_sorting_release(next);
> +	free(sorting);
> +}

Looks like a deep recursion that can be turned into an iteration
fairly easily?  I guess it does not matter as long as we won't deal
with thousands of sort keys...

