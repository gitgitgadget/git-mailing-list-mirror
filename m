Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82268C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 09:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A662070E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 09:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgAHJwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:52:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:60104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726087AbgAHJwb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 04:52:31 -0500
Received: (qmail 21034 invoked by uid 109); 8 Jan 2020 09:52:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Jan 2020 09:52:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8428 invoked by uid 111); 8 Jan 2020 09:58:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jan 2020 04:58:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jan 2020 04:52:29 -0500
From:   Jeff King <peff@peff.net>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: Add support for axiterm colors in parse_color
Message-ID: <20200108095229.GC87523@coredump.intra.peff.net>
References: <CANsz78+ugmd62F4Qk+VT7Pi=ZPtMSkZjXOwLNRCFhoS9jrOkeQ@mail.gmail.com>
 <CANsz78K-BiswWPdhd_N25NuApcv7zSb2cw2Y9DSinkpNpuogYw@mail.gmail.com>
 <CANsz78LEZiocv_E-Hvj3iBahFFgomPb3BFNdmas2iqxqRLfRiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANsz78LEZiocv_E-Hvj3iBahFFgomPb3BFNdmas2iqxqRLfRiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 10:36:53AM -0500, Eyal Soha wrote:

> https://en.wikipedia.org/wiki/ANSI_escape_code
> 
> ANSI color codes 90-97 and 100-107 are brighter versions of the 30-37
> and 40-47 colors.  To view them, run `colortest-16`.  In that
> colortest, they are named with a leading "+".  Maybe git config could
> support those colors, too, with a leading plus in the name?  They are
> nice for having a different shade of a color in a diff.

Depending on your terminal, you can already access these colors via
256-color mode. Generally 0-7 are the standard colors there, then 8-15
are the "bright" variants, and then an rgb cube.

You can see how your terminal displays all of them with something like
this:

  reset=$(git config --type=color --default=reset foo.bar)
  for i in $(seq 0 255); do
    color=$(git config --type=color --default="$i" foo.bar)
    echo "$color$i$reset"
  done

Some terminals also show "bold red" as bright red, but many modern ones
seem to actually provide a bold font.

That said, I'm not entirely opposed to having more human-readable
aliases. I'm not sure if it's worth using the 16-color version (e.g.,
"ESC[91m" versus the 256-color version "ESC[38;5;9m"). It's possible it
would be compatible with more terminals, and it is slightly fewer bytes.

> diff --git a/color.c b/color.c
> index ebb222ec33..a39fe7d133 100644
> --- a/color.c
> +++ b/color.c
> @@ -33,6 +33,7 @@ struct color {
>                 COLOR_UNSPECIFIED = 0,
>                 COLOR_NORMAL,
>                 COLOR_ANSI, /* basic 0-7 ANSI colors */
> +               COLOR_AXITERM, /* brighter than 0-7 ANSI colors */

What's AXITERM? I couldn't find it mentioned anywhere around ANSI codes.

I kind of wonder if we could just call these ANSI as well, and have
color_output() just decide whether to add an offset of 60 when we see a
color number between 8 and 15. Or possibly c->value should just have the
60-offset value in the first place.

>   * already have the ANSI escape code in it. "out" should have enough
>   * space in it to fit any color.
>   */
> -static char *color_output(char *out, int len, const struct color *c, char type)
> +static char *color_output(char *out, int len, const struct color *c,
> +                          const char *type)

This "type" field was already pretty ugly, and I think your patch makes
it even worse. It would probably be less bad if we just passed in the
integer 30 instead of '3', and then do:

  /* handles ANSI; your bright colors would want to add 60 */
  out += xsnprintf(out, len, "%d", type + c->value);

And then likewise the 256-color and rgb paths would do:

  out += xsnprintf(out, len, "%d;5;%d", type + 8, c->value);

Bonus points for declaring:

  enum {
    COLOR_FOREGROUND = 30,
    COLOR_BACKGROUND = 40,
  } color_ground;

to make the caller more readable.

>         case COLOR_ANSI:
> -               if (len < 2)
> +       case COLOR_AXITERM:
> +               if (len < strlen(type) + 1)
>                         BUG("color parsing ran out of space");
> -               *out++ = type;
> -               *out++ = '0' + c->value;
> +               out += xsnprintf(out, len, "%s%c", type, '0' + c->value);

This BUG() can go away. The point was to make sure we don't overflow
"out", but xsnprintf() will check that for us (that's why there isn't
one in the COLOR_256 and COLOR_RGB case arms).

> @@ -279,14 +287,24 @@ int color_parse_mem(const char *value, int
> value_len, char *dst)
>                 if (!color_empty(&fg)) {
>                         if (sep++)
>                                 OUT(';');
> -                       /* foreground colors are all in the 3x range */
> -                       dst = color_output(dst, end - dst, &fg, '3');
> +                       /* foreground colors are in the 3x range */
> +                       char *range = "3";
> +                       if (fg.type == COLOR_AXITERM) {
> +                               /* axiterm fg colors are in the 9x range */
> +                               range = "9";
> +                       }
> +                       dst = color_output(dst, end - dst, &fg, range);

And if we can handle the regular/bright stuff instead of color_output(),
we don't need to have this extra fg.type check.

-Peff
