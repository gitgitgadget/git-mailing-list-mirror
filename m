Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710DCC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4792660F92
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhJ2XQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 19:16:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55359 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJ2XQI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 19:16:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B464E288A;
        Fri, 29 Oct 2021 19:13:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P0Awu+umPBz6L6AG6if/UtbkCZxc1fe9+NXK1D
        JvkuU=; b=u3t10Iv0MPDOXtdS6tTKudW5WSgn4BGiLn2qCSHY3o3y8d0yOnHi+5
        7fq9Gr2fEIvFYw7z/O++zlvuHQAVeUvP9WIzDWISnjxYDWwBIU4Fs6jdOPlHLygW
        bVdMkzvh6BV3NLU959nUBBhAku/A4M8yO0ghL7jZSd6obEDLAvp7s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52101E2889;
        Fri, 29 Oct 2021 19:13:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AEAFE2886;
        Fri, 29 Oct 2021 19:13:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v3 7/8] odb: guard against data loss checking out a huge
 file
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <f59c523bcc48b187680be9149e9311f15bfe06dc.1635515959.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 16:13:37 -0700
In-Reply-To: <f59c523bcc48b187680be9149e9311f15bfe06dc.1635515959.git.gitgitgadget@gmail.com>
        (Matt Cooper via GitGitGadget's message of "Fri, 29 Oct 2021 13:59:18
        +0000")
Message-ID: <xmqq8rybh1b2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9554F34-390D-11EC-B460-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/delta.h b/delta.h
> index 2df5fe13d95..8a56ec07992 100644
> --- a/delta.h
> +++ b/delta.h
> @@ -90,15 +90,15 @@ static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
>  					       const unsigned char *top)
>  {
>  	const unsigned char *data = *datap;
> -	unsigned long cmd, size = 0;
> +	size_t cmd, size = 0;
>  	int i = 0;
>  	do {
>  		cmd = *data++;
> -		size |= (cmd & 0x7f) << i;
> +		size |= st_left_shift(cmd & 0x7f, i);
>  		i += 7;
>  	} while (cmd & 0x80 && data < top);
>  	*datap = data;
> -	return size;
> +	return cast_size_t_to_ulong(size);
>  }

OK.  The patch-delta code is reasonably self contained, so the next
step to measure the in-core object size in size_t shouldn't be too
bad, but before everything got size_t aware, we have to have the
"safe casting" somewhere, and I agree this "immediately before
return" is a good place to draw the line.

Nicely done.

>  			if (c > 9)
>  				break;
>  			hdr++;
> -			size = size * 10 + c;
> +			size = st_add(st_mult(size, 10), c);

Nice.

>  	if (oi->sizep)
> -		*oi->sizep = size;
> +		*oi->sizep = cast_size_t_to_ulong(size);

OK.

> @@ -1073,10 +1073,10 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
>  			break;
>  		}
>  		c = buf[used++];
> -		size += (c & 0x7f) << shift;
> +		size = st_add(size, st_left_shift(c & 0x7f, shift));
>  		shift += 7;
>  	}
> -	*sizep = size;
> +	*sizep = cast_size_t_to_ulong(size);

OK.

Looking good.
