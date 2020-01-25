Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC46C2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDB92070A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 17:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XwNl0iw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgAYR1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 12:27:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61341 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgAYR1o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 12:27:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E38FFA6191;
        Sat, 25 Jan 2020 12:27:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VTv9fEPDLkekxTGFGPaeVc/FYZM=; b=XwNl0i
        w27VR57m8XB/YzcunsAQ0z4vlbz2dPICVthiRmupx4nWMg1tOnCG7/V+lsIF1cXi
        fiKYCGyD6fK0DNa2vbunAvKAi+qdcY4TbvaRQKqSHN3piNR7rZjlVcehi8kNiQVl
        ulCpyjSZF6Mv3BrxdKIrs2kNGR4VGvJh5zGTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jkfS9ZfTksNw9NEfoTwQrpN001t8j8Bb
        3jj12nYe+NeIpn8JgYqZUyt+X+eRbX9J9EVS9ISC4M7uXeTsm0HHYL3vsItd/6eW
        g+t2LX0n8B6OkYp/cfFczsfMaXSfeM2cv4lUgQEz+0uBYUOh8ck6O9Gw+Xq+LSaf
        uyE97LJTRe0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DAE0CA6190;
        Sat, 25 Jan 2020 12:27:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0AE01A618F;
        Sat, 25 Jan 2020 12:27:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/4] merge-recursive: silence -Wxor-used-as-pow warning
References: <20200125053542.GA744596@coredump.intra.peff.net>
        <20200125053723.GA744673@coredump.intra.peff.net>
Date:   Sat, 25 Jan 2020 09:27:36 -0800
In-Reply-To: <20200125053723.GA744673@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 25 Jan 2020 00:37:23 -0500")
Message-ID: <xmqq4kwjcupj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC1D4466-3F97-11EA-BDD6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The merge-recursive code uses stage number constants like this:
>
>   add = &ci->ren1->dst_entry->stages[2 ^ 1];
>   ...
>   add = &ci->ren2->dst_entry->stages[3 ^ 1];
>
> The xor has the effect of flipping the "1" bit, so that "2 ^ 1" becomes
> "3" and "3 ^ 1" becomes "2", which correspond to the "ours" and "theirs"
> stages respectively.
>
> Unfortunately, clang-10 and up issue a warning for this code:
>
>   merge-recursive.c:1759:40: error: result of '2 ^ 1' is 3; did you mean '1 << 1' (2)? [-Werror,-Wxor-used-as-pow]
>                   add = &ci->ren1->dst_entry->stages[2 ^ 1];
>                                                      ~~^~~
>                                                      1 << 1
>   merge-recursive.c:1759:40: note: replace expression with '0x2 ^ 1' to silence this warning
>
> We could silence it by using 0x2, as the compiler mentions. Or by just
> using the constants "2" and "3" directly. But after digging into it, I
> do think this bit-flip is telling us something. If we just wrote:
>
>   add = &ci->ren2->dst_entry->stages[2];
>
> for the second one, you might think that "ren2" and "2" correspond. But
> they don't. The logic is: ren2 is theirs, which is stage 3, but we
> are interested in the opposite side's stage, so flip it to 2.

So, the logical name for "^1" operator applied to 2 (ours) and 3
(theirs) is "the_other_side()"?  the_other_side(theirs) == ours.

I would have written (5 - side) instead of (side ^ 1) if I were
writing this, though.

> So let's keep the bit-flipping, but let's also put it behind a named
> function, which will make its purpose a bit clearer. This also has the
> side effect of suppressing the warning (and an optimizing compiler
> should be able to easily turn it into a constant as before).

OK.  Now I see you named it flip_stage(), which is even better than
"the-other-side" above.  Makes sense.

I still think ((2 + 3) - two_or_three_to_be_flipped) easier to
reason about than the bit flipping, as the implementation detail,
though.

Thanks.
