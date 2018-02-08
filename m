Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910C11F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeBHUnM (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:43:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:45796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752185AbeBHUnL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:43:11 -0500
Received: (qmail 4509 invoked by uid 109); 8 Feb 2018 20:43:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Feb 2018 20:43:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14838 invoked by uid 111); 8 Feb 2018 20:43:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Feb 2018 15:43:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2018 15:43:09 -0500
Date:   Thu, 8 Feb 2018 15:43:09 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] color.h: document and modernize header
Message-ID: <20180208204309.GA4541@sigill.intra.peff.net>
References: <20180208201546.194935-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180208201546.194935-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 08, 2018 at 12:15:46PM -0800, Stefan Beller wrote:

>  int color_fprintf(FILE *fp, const char *color, const char *fmt, ...)
>  {
>  	va_list args;
> diff --git a/color.h b/color.h
> index fd2b688dfb..8c7e6c41c2 100644
> --- a/color.h
> +++ b/color.h
> @@ -72,26 +72,50 @@ extern int color_stdout_is_tty;
>   * Use the first one if you need only color config; the second is a convenience
>   * if you are just going to change to git_default_config, too.
>   */
> -int git_color_config(const char *var, const char *value, void *cb);
> -int git_color_default_config(const char *var, const char *value, void *cb);
> +extern int git_color_config(const char *var, const char *value, void *cb);
> +extern int git_color_default_config(const char *var, const char *value, void *cb);

Hmph, I thought we weren't adding "extern" everywhere. See:

  https://public-inbox.org/git/xmqq8tea5hxi.fsf@gitster.mtv.corp.google.com/

Other than that, these changes mostly look like improvements. A few
comments:

> +/*
> + * Resolve the constants as returned by git_config_colorbool()
> + * (specifically "auto") to a boolean answer.
> + */
> +extern int want_color(int var);

This explanation left me even more confused about what should go in
"var", and I think I'm the one who wrote the function. ;)

I think the point is that "var" is a quad-state variable (yes, no, auto,
or "unknown") and we are converting to a boolean. This would probably be
a lot more clear if GIT_COLOR_* were all enum values and not #defines,
and this function took the matching enum type.

So I think that's what you were trying to name with "constants as
returned by...", but it definitely took me some thinking to parse it.

> +/*
> + * Translate a Git color from 'value' into a string that the terminal can
> + * interpret and store it into 'dst'. The Git color values are of the form
> + * "foreground [background] [attr]" where fore- and background can be a color
> + * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
> + */
> +extern int color_parse(const char *value, char *dst);
> +extern int color_parse_mem(const char *value, int len, char *dst);

The inputs here are called "value" mostly because we feed them from the
var/value pair of config. But maybe "colorspec", or even just "src"
would be more clear than "value".

> +/*
> + * Output the formatted string in the specified color (and then reset to normal
> + * color so subsequent output is uncolored). Omits the color encapsulation if
> + * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
> + * the color. The `color_print_strbuf` prints the given pre-formatted strbuf
> + * instead, up to its first NUL character.
> + */

It probably doesn't matter much in practice, but the color_print_strbuf
behavior sounds like a bug. Shouldn't it print the whole strbuf, even if
it has an embedded NUL?

> +/*
> + * Check if the given color is GIT_COLOR_NIL that means "no color selected".
> + * The caller needs to replace the color with the actual desired color.
> + */
> +extern int color_is_nil(const char *color);

Is this a parsed color string, or a human-readable source? I think
consistent naming of the two variables would help (using a type doesn't
work since they're both "const char *").

> diff --git a/grep.c b/grep.c
> index 3d7cd0e96f..834b8eb439 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -18,6 +18,11 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
>  	fwrite(buf, size, 1, stdout);
>  }
>  
> +static void color_set(char *dst, const char *color_bytes)
> +{
> +	xsnprintf(dst, COLOR_MAXLEN, "%s", color_bytes);
> +}
> +

This part seems OK. I think we made color_set() globally available with
the notion that other callers might make use of it. But it's pretty
horrid as public interfaces go, requiring that the caller has created a
buffer of the appropriate size. We'd do better to have a "struct color"
with the correctly-sized buffer. But at this point I don't think it's worth
overhauling the color code.


Those are all suggestions. Given that there's no documentation currently
on most of these, I think even if you don't take any of my suggestions,
this would still be a net improvement (modulo the "extern" thing).

-Peff
