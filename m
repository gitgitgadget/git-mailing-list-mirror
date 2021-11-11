Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EBFC433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 01:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A665611AD
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 01:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhKKCBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 21:01:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53520 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhKKCA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 21:00:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A11B0102F90;
        Wed, 10 Nov 2021 20:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=0wJgDMWiURCOxcgPuNSk1sJh3Byh7sWcxaffGI2gSTA=; b=xsKl
        p5oqM5E+Qzb1a70hWkg8yIWtoJf41AZpOKUeW5mNwbacuuy+WtPKBP+Eui84nqoH
        dp4ydHlsrrrywtBISCqPh5vl45/pfciiRtD3rRXq3Tg4oVwYlmgfBKx1HO/Tkuu5
        RTAdjbcBBED18OZWp38G9FKcMHd3gvAG56yl1TA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 997A6102F8F;
        Wed, 10 Nov 2021 20:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13B08102F8E;
        Wed, 10 Nov 2021 20:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] packfile: avoid overflowing shift during decode
References: <20211110234033.3144165-1-jonathantanmy@google.com>
Date:   Wed, 10 Nov 2021 17:58:08 -0800
Message-ID: <xmqqpmr7v4gf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D234D3C6-4292-11EC-89AA-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> situation by dying if the left shift overflows, but this patch is still
> worthwhile as it makes a bad header be reported as a bad header, not a
> fatal left shift overflow.

Hmph, I am not sure if I like to see it put that way, but I think
the problem is not anything new.

Even when we have a packfile that is in a good shape, the current
machine (especially its wordsize) may not be capable of extracting
the object we are looking at from the packstream, when the object is
larger than the current machine's ulong can express.  So it may be
an indication that your machine cannot use the packed object, but
may not be an indication that there is anything _wrong_ in the
object header.

    Side note.  I suspect that this should already be the case; you
    can pack a large object whose size do not fit in u32 on a box
    whose ulong is u64, and you wouldn't be able to use such a
    packfile on a box where ulong is u32.  There is no "bad object
    header" in the pack stream per-se, but we cannot use it there.

After all, the reason why we chose to use the varint encoding is
because we do not have to change the file format when we extend
beyond the architectures of prevailing word size of the day.

Having said all that, I think the patch is correct.  We later use
the number "shift" as the shift count like so

	size += (c & 0x7f) << shift;

In order for the uppermost bit from (c & 0x7f) to be still inside
"size", it is not sufficient that "shift" does not exceed the
bit-size of "size".  We need to subtract the bitscanreverse of
(0x7f), which is 7, which is exactly what your patch does.

Looking good.  Thanks.


>  packfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/packfile.c b/packfile.c
> index 89402cfc69..972c327e29 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1068,7 +1068,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
>  	size = c & 15;
>  	shift = 4;
>  	while (c & 0x80) {
> -		if (len <= used || bitsizeof(long) <= shift) {
> +		if (len <= used || (bitsizeof(long) - 7) <= shift) {
>  			error("bad object header");
>  			size = used = 0;
>  			break;
