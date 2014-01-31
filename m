From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Ensure __BYTE_ORDER is always set
Date: Thu, 30 Jan 2014 21:35:14 -0500
Message-ID: <CAPig+cS-ae3PGPGAAam6oKnFS4SxUOg2RE_7aUJrMyqE+sZvvw@mail.gmail.com>
References: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com>
	<20140130204538.GA1130@sigill.intra.peff.net>
	<20140130215002.GB1130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Vicent Marti <tanoku@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 31 03:35:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W93wx-0007wV-5H
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 03:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbaAaCfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 21:35:16 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:41014 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbaAaCfP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 21:35:15 -0500
Received: by mail-yk0-f173.google.com with SMTP id 20so20768690yks.4
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 18:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iyl7Z3+aLofSeVRd2Ej0Xg1F8/yhTNbOhLOzrFiQMcU=;
        b=lMPgcb+V28aTQlPJiaQoDQ6cVYUQwfGP4qEcS3B7f2wlGn3KwWXGpHf1MECkM/QDRC
         wJCTf2qGspkLXkX3Zo9e4pFtmL9JGQG+BH/VubWM9iaYj/127vdDNobdTM//TqSQiXE9
         bppvqUtiFJ1gl0cfrJAyLeNoJ+KdFv1XtUlYI/d54qSdEn5FL+IdfGQeb+wkHTxQThLg
         2J2du01Xh2QRLhSRxbITynBfbKvrk2xEPdT1+AGOXXfHxGImU1AOohvCAJWxvgHqXqSv
         TNWBTqCGQuih5wmBBFRNWQndKM14NCqPyDsC7nk+PqEEyzmK+rWHm/V3n/B63dVf0lHM
         hjvA==
X-Received: by 10.236.200.35 with SMTP id y23mr16454815yhn.38.1391135714675;
 Thu, 30 Jan 2014 18:35:14 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Thu, 30 Jan 2014 18:35:14 -0800 (PST)
In-Reply-To: <20140130215002.GB1130@sigill.intra.peff.net>
X-Google-Sender-Auth: t6DLrTOKKMMTt1gCpIzkm1IJyqs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241288>

On Thu, Jan 30, 2014 at 4:50 PM, Jeff King <peff@peff.net> wrote:
> I think we could do this with something like the patch below, which
> checks two things:
>
>   1. When we expand the ewah, it has the same number of bits we claimed
>      in the on-disk header.
>
>   2. The ewah header matches the number of objects in the packfile.
>
> The first catches a corruption in the ewah data itself, and the latter
> when the header is corrupted. You can test either by breaking the
> endian-swapping. :)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index ae0b57b..a31e529 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -130,6 +131,31 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
>                 return NULL;
>         }
>
> +       /*
> +        * It's OK for us to have too fewer bits than objects, as the EWAH

s/fewer/few/

> +        * writer may have simply left off an ending that is all-zeroes.
> +        *
> +        * However it's not OK for us to have too many bits, as that would
> +        * entail touching objects that we don't have. We are careful
> +        * enough to avoid doing so in later code, but in the case of
> +        * nonsensical values, we would want to avoid even allocating
> +        * memory to hold the expanded bitmap.
> +        *
> +        * There is one exception: we may "go over" to round up to the next
> +        * 64-bit ewah word, since the storage comes in chunks of that size.
> +        */
> +       expected_bits = index->pack->num_objects;
> +       if (expected_bits & 63) {
> +               expected_bits &= ~63;
> +               expected_bits += 64;
> +       }
> +       if (b->bit_size > expected_bits) {
> +               error("unexpected number of bits in bitmap: %"PRIuMAX" > %"PRIuMAX,
> +                     (uintmax_t)b->bit_size, (uintmax_t)expected_bits);
> +               ewah_pool_free(b);
> +               return NULL;
> +       }
> +
>         index->map_pos += bitmap_size;
>         return b;
>  }
> --
