Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21181C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 18:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiAMSDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 13:03:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56920 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiAMSDH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 13:03:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16651FF172;
        Thu, 13 Jan 2022 13:03:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6FYlB0msuWRz
        J03oLAavCdJiSzy1t3rytooQSpB2Ri8=; b=E96cPHJUx8HAdOnFRjHc5HpQ+GmQ
        S/QeIaszvsXDwSqPCY4CBf4EecIaGXjuvFW5E7W77e0BZBBhAMVUKlugN0Wv4Fgb
        lA9zXUFoIWvb1Tnl+ROQ7GJbQMMb3Oq62qyd0Nw7yRNy9i6M39RURB1F+czyLwg7
        cLajHleYxExLeNc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37BFBFF170;
        Thu, 13 Jan 2022 13:03:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9699DFF16F;
        Thu, 13 Jan 2022 13:03:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     rsbecker@nexbridge.com, 'Taylor Blau' <me@ttaylorr.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [BUG] Re: Git 2.35.0-rc0
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com>
        <Ydzw+RqR6IfbT/oM@nand.local>
        <010b01d80697$0c848770$258d9650$@nexbridge.com>
        <Ydzyv8ZCEpDDRBXT@nand.local>
        <010d01d8069e$8d330480$a7990d80$@nexbridge.com>
        <xmqqzgo0u5j7.fsf@gitster.g>
        <220113.864k67vkea.gmgdl@evledraar.gmail.com>
Date:   Thu, 13 Jan 2022 10:03:01 -0800
In-Reply-To: <220113.864k67vkea.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 13 Jan 2022 14:21:44 +0100")
Message-ID: <xmqqv8ynikdm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D99B744-749B-11EC-A8AB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> https://lore.kernel.org/git/87wnn62nhp.fsf@evledraar.gmail.com/ this us=
e
> of uncompress2() is just saving a few lines of boilerplate instead of
> using the underlying zlib functions, which every other in-tree user
> uses.

I looked at the source of uncompress2(), and I tend to agree that,
we do NOT HAVE TO add dependency on it.  You should be able to
rewrite the new caller without using it.

But this is a 5-year old API function, that first appeared how many
years ago in their public release?  In a few years, I would say that
we would be laughed at if we avoid it with "it is not available
everywhere".

And in the meantime, we ship a copy lifted from upstream, so those
with older zlib would be OK with it, too.

That is how I view what we have today.  To me, the logical
conclusion of the observation is that, we do not have good reason
to avoid it.

When we are adding a new piece of code that drives inflate(), we
should remember that we now have uncompress2() available in the
codebase, and see if we can simplify it by using uncompress2().  The
same is true for a case where we refactor existing code that can
become simpler with uncompress2().

Thanks.
