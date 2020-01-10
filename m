Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996CCC33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 11:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534F520721
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 11:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgAJLPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:15:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:33490 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727685AbgAJLPR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 06:15:17 -0500
Received: (qmail 4399 invoked by uid 109); 10 Jan 2020 11:15:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Jan 2020 11:15:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24243 invoked by uid 111); 10 Jan 2020 11:21:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2020 06:21:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Jan 2020 06:15:16 -0500
From:   Jeff King <peff@peff.net>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: Add support for axiterm colors in parse_color
Message-ID: <20200110111516.GA474613@coredump.intra.peff.net>
References: <CANsz78+ugmd62F4Qk+VT7Pi=ZPtMSkZjXOwLNRCFhoS9jrOkeQ@mail.gmail.com>
 <CANsz78K-BiswWPdhd_N25NuApcv7zSb2cw2Y9DSinkpNpuogYw@mail.gmail.com>
 <CANsz78LEZiocv_E-Hvj3iBahFFgomPb3BFNdmas2iqxqRLfRiw@mail.gmail.com>
 <20200108095229.GC87523@coredump.intra.peff.net>
 <CANsz78Lm3ggVZLrSxM5tc0MozFMdAmVBOix_3sjJT4+s3VHLPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANsz78Lm3ggVZLrSxM5tc0MozFMdAmVBOix_3sjJT4+s3VHLPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 09, 2020 at 07:20:09PM -0500, Eyal Soha wrote:

> > That said, I'm not entirely opposed to having more human-readable
> > aliases. I'm not sure if it's worth using the 16-color version (e.g.,
> > "ESC[91m" versus the 256-color version "ESC[38;5;9m"). It's possible it
> > would be compatible with more terminals, and it is slightly fewer bytes.
> 
> My motivation for this patch was to fix the github workflow log output
> that doesn't support 8bit colors properly.  Only the "ANSI" colors
> 0-15 worked.  None of the 8-bit colors worked except for 30-37, 40-47,
> 90-97, and 100-107, which matched the ANSI colors.  That is a very
> broken color scheme!  But that's how it displayed.

That makes sense. I'm not too surprised to see a terminal that supports
one but not the other.

But I wonder if there are ones that go the other way around: supporting
256-color mode but not ANSI 90-97, etc. I doubt it, but I think it would
be nice to split that change out into a separate commit in case we do
run into problems.

> Done.  Here's a new patch!

Thanks. The content here is looking pretty good (though I have a few
comments below).

Can you also format it as described in Documentation/SubmittingPatches
and re-send? In particular, it needs a regular commit message and your
signoff.

> +enum {
> +       COLOR_BACKGROUND_OFFSET = 10,
> +       COLOR_FOREGROUND_ANSI = 30,
> +       COLOR_FOREGROUND_RGB = 38,
> +       COLOR_FOREGROUND_256 = 38,
> +       COLOR_FOREGROUND_BRIGHT_ANSI = 90,
> +};

The split in this enum mostly makes sense to me. It changes the meaning
of "value" for COLOR_ANSI, but this is all local to color.c, so your
changes to output_color() are all that's needed.

It might be easier to follow the patch if switching to this enum came in
a separate preparatory patch.

> @@ -92,7 +100,13 @@ static int parse_color(struct color *out, const
> char *name, int len)
>         for (i = 0; i < ARRAY_SIZE(color_names); i++) {
>                 if (match_word(name, len, color_names[i])) {
>                         out->type = COLOR_ANSI;
> -                       out->value = i;
> +                       out->value = i + COLOR_FOREGROUND_ANSI;
> +                       return 0;
> +               }
> +               if (*name == '+' &&
> +                   match_word(name+1, len-1, color_names[i])) {
> +                       out->type = COLOR_ANSI;
> +                       out->value = i + COLOR_FOREGROUND_BRIGHT_ANSI;
>                         return 0;
>                 }

It would be slightly simpler and more efficient handle the "+" outside
the loop, like:

  int offset = COLOR_FOREGROUND_ANSI;
  if (*name == '+') {
          offset = COLOR_FOREGROUND_BRIGHT_ANSI;
	  name++;
	  len--;
  }

and then in the loop just set "out->value = i + offset".

You'd probably want to hoist this out to a separate function since
"name" needs to be unchanged in the later part of the function.

I dunno. It's almost certainly an unmeasurable micro-optimization, but
somehow the flow of it seems simpler to me.

I also wondered if we'd want English aliases like "brightred" that some
other systems use. It would be easy to add that to the check I showed
above without having to repeat as much.

> @@ -109,10 +123,15 @@ static int parse_color(struct color *out, const
> char *name, int len)
>                 else if (val < 0) {
>                         out->type = COLOR_NORMAL;
>                         return 0;
> -               /* Rewrite low numbers as more-portable standard colors. */
> +               /* Rewrite 0-7 as more-portable standard colors. */
>                 } else if (val < 8) {
>                         out->type = COLOR_ANSI;
> -                       out->value = val;
> +                       out->value = val + COLOR_FOREGROUND_ANSI;
> +                       return 0;
> +               /* Rewrite 8-15 as more-portable aixterm colors. */
> +               } else if (val < 16) {
> +                       out->type = COLOR_ANSI;
> +                       out->value = val - 8 + COLOR_FOREGROUND_BRIGHT_ANSI;

And I think this 8-15 handling might want to be a separate commit on
top, just because it's possible it might regress some cases (though
again, I do doubt it).

>         case COLOR_256:
> -               out += xsnprintf(out, len, "%c8;5;%d", type, c->value);
> +         out += xsnprintf(out, len, "%d;5;%d", COLOR_FOREGROUND_256 + offset,
> +                          c->value);

Looks like some unwanted tab/space conversion (here and elsewhere).

> +test_expect_success 'axiterm bright fg color' '
> +       color "+red" "[91m"

s/axi/aix/ (here and below).

> +test_expect_success '8-15 are aliases for aixterm color names' '
> +       color "12 13" "[94;105m"

Makes sense.

-Peff
