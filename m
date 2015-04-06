From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/6] strbuf: add an optimized 1-character strbuf_grow
Date: Sun, 5 Apr 2015 22:13:21 -0400
Message-ID: <CAPig+cTK5MJLfwETFfM1Zdw35M2geKKmA6Q9M0kHdMP9t8qLNg@mail.gmail.com>
References: <20150405010611.GA15901@peff.net>
	<20150405011127.GD30127@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 04:13:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YewXZ-00059x-AN
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 04:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbbDFCNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 22:13:24 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:34210 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbbDFCNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 22:13:23 -0400
Received: by laat2 with SMTP id t2so4816529laa.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 19:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TJ9F4rR6Nuqyo4+2QaaHo1hHU29yu6iH3agdcb6UlXQ=;
        b=TmepeYPfGtMQ+r/l/ASz8W7ceFIcy5VSTeeHn/lJTm8N1L/XWp5FeNzRtoxa69jSFM
         /IxMmIVMpHStLrpRYswQVLHyqpF316NVgSYmVuoe1Vx0DKS/xBTDQASQ90DJe8pK+1sW
         CoZe00nHeKYMhPk5Y31QJ8phJ43d36N8X0B4c0Y6QVHAk32LDorUFQGPx20BTQPi5AIV
         S9YQ55LFn6QcIq62B4LdlAzos3aJ0jm86MAanGQhZoqCnZZiNJGe043cAF8DTuePPvtl
         7NX1KaZI3DDptT0FIKF0JC0BnVktgcnRDdmrr5uJcAzua7N8SEqiK/sC5q6l4ubFNhPl
         IeKw==
X-Received: by 10.152.219.2 with SMTP id pk2mr11515397lac.107.1428286402024;
 Sun, 05 Apr 2015 19:13:22 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Sun, 5 Apr 2015 19:13:21 -0700 (PDT)
In-Reply-To: <20150405011127.GD30127@peff.net>
X-Google-Sender-Auth: gb8CXbLV1OGWqEylk7qbJ4T4Dng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266827>

On Sat, Apr 4, 2015 at 9:11 PM, Jeff King <peff@peff.net> wrote:
> We have to call strbuf_grow anytime we are going to add data
> to a strbuf. In most cases, it's a noop (since we grow the
> buffer aggressively), and the cost of the function call and
> size check is dwarfed by the actual buffer operation.
>
> For a tight loop of single-character additions, though, this
> overhead is noticeable. Furthermore, the single-character
> case is much easier to check; since the "extra" parameter is
> 1, we can do it without worrying about overflow.
>
> This patch adds a simple inline function for checking
> single-character growth. For the growth case, it just calls
> into the regular strbuf_grow(). This is redundant, as
> strbuf_grow will check again whether we need to grow. But it
> keeps our inline code simple, and most calls will not need
> to grow, so it's OK to treat this as a rare "slow path".
>
> We apply the new function to strbuf_getwholeline. [...]
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/strbuf.c b/strbuf.c
> index af2bad4..2facd5f 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -445,7 +445,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
>         strbuf_reset(sb);
>         flockfile(fp);
>         while ((ch = getc_unlocked(fp)) != EOF) {
> -               strbuf_grow(sb, 1);
> +               strbuf_grow_ch(sb);

strbuf_grow_ch() seems overly special-case. What about instead taking
advantage of inline strbuf_avail() to do something like this?

    if (!strbuf_avail())
        strbuf_grow(sb, 1);

(Minor tangent: The 1 is still slightly magical and potentially
confusing for someone who doesn't know that the buffer is grown
aggressively, so changing it to a larger number might make it more
obvious to the casual reader that the buffer is in fact not being
grown on every iteration.)

>                 sb->buf[sb->len++] = ch;
>                 if (ch == term)
>                         break;
> diff --git a/strbuf.h b/strbuf.h
> index 1883494..ef41151 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -137,6 +137,15 @@ static inline size_t strbuf_avail(const struct strbuf *sb)
>   */
>  extern void strbuf_grow(struct strbuf *, size_t);
>
> +/*
> + * An optimized version of strbuf_grow() for a single character.
> + */
> +static inline void strbuf_grow_ch(struct strbuf *sb)
> +{
> +       if (!sb->alloc || sb->alloc - 1 <= sb->len)
> +               strbuf_grow(sb, 1);
> +}
> +
>  /**
>   * Set the length of the buffer to a given value. This function does *not*
>   * allocate new memory, so you should not perform a `strbuf_setlen()` to a
> --
> 2.4.0.rc0.363.gf9f328b
