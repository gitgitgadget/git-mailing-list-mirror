From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] pack-bitmaps: plug memory leak, fix allocation size for recent_bitmaps
Date: Mon, 18 May 2015 17:57:13 -0700
Message-ID: <CAGZ79kZeX_VqcvTt_kgGKyWH0SV2zsV_j1KuxNhwR18zWfp5LA@mail.gmail.com>
References: <555A7499.7090900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue May 19 02:57:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuVqR-0006Jl-IF
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 02:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbbESA5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2015 20:57:15 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36366 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbESA5O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2015 20:57:14 -0400
Received: by iepj10 with SMTP id j10so2360494iep.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 17:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zplzbHyMjkxHeyCDloF83/rJpyYhFwlrw7Zr+IQ1fSw=;
        b=KYo6jmtsI5HjGik53NaMjXpgkZFcm23ijaXZ5sU44rNsPjzcpfLAgr1FLsai2LMkPv
         vMrBVo+WFImG2uq3EygO0HSs1uIgiqgKqWaDWaWELb8QODKLXbNWCEQmuFPm7iyEO5cJ
         PoAidO1kBZdc+ARCWBi8DVmC2IrvdBh0nD1c2V430tjx91xEHh4dkXof83bdLaN9xomX
         KJlfoUnqi6W5rBro+HVHCedc99D356YaRU8NA4Hv4lK6dCBGRw4MkWFFmzqT8hU1KSzZ
         1vHZ4eyoHAsgBwUDbEbP9U6wYEkNl39h7LuvvYJZ6sfZgnsGyvMtb2gTNMdArRv52m/f
         Om+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zplzbHyMjkxHeyCDloF83/rJpyYhFwlrw7Zr+IQ1fSw=;
        b=RtP1zE49oIuzm1RUNO3ph7joyvWMbNNVYDtstXUikzSM9d0QTvR2mBnEj7OlCQjUZh
         60QPX717iD8jfw2RcthWX3uz2TEqYfPIR/DR/56YnEwZaeRh1Dr+kG6LHBZJTbxSKx98
         w26QRFe33sdNrHroQlHpsnPZfYBF6vxe5vf4Vrcsck68PPkkkdVysA3sdMgw1UWtQ+kx
         EMrK+EGwugCkzJ3mw8LLHPR4mUGSm/x9gVkeL8WeAUdxtHIxk3Gd8ghmqJYnfxP4SioY
         PBoBei+U8aoM8yf+JYI74P058Wb8OgUN84lFAqgaScJxpc6K9Bwg3AV5Zhu3lqdDIg2T
         dXEQ==
X-Gm-Message-State: ALoCoQnBoZOrdaVgJ+2hq45mSZPzZHRciobFPvyBxRqryewlHsiiTvar4dqNm+Nf2pKCflTVMOxa
X-Received: by 10.50.47.44 with SMTP id a12mr5016408ign.10.1431997034052; Mon,
 18 May 2015 17:57:14 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 18 May 2015 17:57:13 -0700 (PDT)
In-Reply-To: <555A7499.7090900@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269338>

On Mon, May 18, 2015 at 4:24 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Use an automatic variable for recent_bitmaps, an array of pointers.
> This way we don't allocate too much and don't have to free the memory
> at the end.  The old code over-allocated because it reserved enough
> memory to store all of the structs it is only pointing to and never
> freed it.  160 64-bit pointers take up 1280 bytes, which is not too
> much to be placed on the stack.
>
> MAX_XOR_OFFSET is turned into a preprocessor constant to make it
> constant enough for use in an non-variable array declaration.
>
> Noticed-by: Stefan Beller <stefanbeller@gmail.com>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> This seems to have fallen through the cracks, or did I just miss it?

I planned on resending it eventually. ;)
But with the usual definition of 'eventually',
it may take a while.

Thanks for picking this up!
Stefan



>
>  pack-bitmap.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 62a98cc..e5abb8a 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -209,14 +209,12 @@ static inline uint8_t read_u8(const unsigned ch=
ar *buffer, size_t *pos)
>         return buffer[(*pos)++];
>  }
>
> +#define MAX_XOR_OFFSET 160
> +
>  static int load_bitmap_entries_v1(struct bitmap_index *index)
>  {
> -       static const size_t MAX_XOR_OFFSET =3D 160;

Is there a reason why we prefer defines over a  static const size_t her=
e?

> -
>         uint32_t i;
> -       struct stored_bitmap **recent_bitmaps;
> -
> -       recent_bitmaps =3D xcalloc(MAX_XOR_OFFSET, sizeof(struct stor=
ed_bitmap));
> +       struct stored_bitmap *recent_bitmaps[MAX_XOR_OFFSET] =3D { NU=
LL };

This looks fine to me.

>
>         for (i =3D 0; i < index->entry_count; ++i) {
>                 int xor_offset, flags;
> --
> 2.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
