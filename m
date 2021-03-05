Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB3CC433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2926650A0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCETdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:33:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50736 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhCETc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 14:32:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F26CAA0AAB;
        Fri,  5 Mar 2021 14:32:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=32wRJ31452Aa26H0l87UNDdYf1Q=; b=D1rJXI
        yixpKNP/8YGuGwp/lG/Vr1TCpbc7VREkLIFu66JgYo4ZskO6hDqOSTq+FiaLNQ5C
        dFon3z9Rekk060tDm85lEXj3cETDRWWuAsqlaJRLmt4z+kRGRNaz63WfnNPqMqLd
        qZwNwwmCiIohnx2+sw4gzCgPBVm4rdDaBlzqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gfAHy2bSJlHCBarirRXZm4lBfFzFEkMv
        +UMq+YSC9ydYLXQUyttv4r3ui6tJM/0W0wl8+OmCVbYMAmT4fLxxxyUOn/Qay6z5
        ZxGTnfwhgOu9BiddFcWXLmYZniLrseH6pmXFbVOHjhDHvuKPrFbrN75uqr0ur8OA
        qBlgCFT1VC0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EABE3A0AA9;
        Fri,  5 Mar 2021 14:32:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75CDDA0AA8;
        Fri,  5 Mar 2021 14:32:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/5] builtin/repack.c: be more conservative with
 unsigned overflows
References: <cover.1614957681.git.me@ttaylorr.com>
        <d55324f7a256fce491a29a1debf142f817eb01d3.1614957681.git.me@ttaylorr.com>
Date:   Fri, 05 Mar 2021 11:32:57 -0800
In-Reply-To: <d55324f7a256fce491a29a1debf142f817eb01d3.1614957681.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 5 Mar 2021 10:21:56 -0500")
Message-ID: <xmqqr1kt9z12.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9758DA18-7DE9-11EB-BD2F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> There are a number of places in the geometric repack code where we
> multiply the number of objects in a pack by another unsigned value. We
> trust that the number of objects in a pack is always representable by a
> uint32_t, but we don't necessarily trust that that number can be
> multiplied without overflow.
>
> Sprinkle some unsigned_add_overflows() and unsigned_mult_overflows() in
> split_pack_geometry() to check that we never overflow any unsigned types
> when adding or multiplying them.
>
> Arguably these checks are a little too conservative, and certainly they
> do not help the readability of this function. But they are serving a
> useful purpose, so I think they are worthwhile overall.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>

I do not deserve this for my idle thinking-out-aloud speculation.
You did all the thinking and work.

I do not know if just dying is a useful thing to do, though.  These
all happen in the "discover where the split point is, to figure out
which packs to coalesce" phase where we haven't touched anything on
disk, so in that sense it is safe to die, but what recourse do users
have after seeing these errors?

For example, in the first overflow check in hunk -388,11, presumably
when total_size for a given set of packfiles does not fit in
int32_t, it won't be fruitful to attempt to coalesce such a set of
packs into one, so perhaps a better fix may be to shift the split
point earlier to find a point that lets us to pack as many as we
could?

I do not offhand know what a sensible and gentler fallback position
would be for the factor multiplication, but presumably, if the right
hand side of this ...

>  		if (geometry_pack_weight(ours) < factor * total_size) {

... overflows, we can say it would definitely be larger than our
weight and continue, instead of "no, we cannot multiply total with
factor, as that would give us too big a number", I guess.

I am OK to either (1) leave the code as-is without this patch, because
the overflow would only affect the largest of packs and would be rare,
and people who would notice when they hit it would probably are the ones
with enough resource to diagnose, report and even give us a fix ;-)
or (2) apply this patch as-is, because the only people who will see
the die() would be the same ones affected by (1) above anyway.

And applying this patch as-is would give better chance than (1) for
the overflow to be noticed.

So, let's queue the patch as-is.

Thanks.
