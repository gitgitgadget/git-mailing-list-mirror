Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CCCC47089
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 04:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLGEdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 23:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiLGEdh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 23:33:37 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3D956EC2
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 20:33:35 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso380769pjh.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 20:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y/x1FVsqcUskXR9wnn6E1mhOfZOcVC0B2qtHOIiGWk=;
        b=3sbyQffE7cCuJLoD9gvv8SoDpJKl1Kb+Mlh/Cx3AG+4UOH1usULKSuERLC2W9wB1Ye
         9ralzBS/ZM4vts42Vgnz8NoYdUYJqbLRA1PK6nYTmMxs5lFG6UnemcAYuzaWAQDp8vdY
         Cz/SKgNJZeIzW27ARuEGXE8Lf0Uttb2eBR4uXMNECT/f7Lmz2mYrQluavWiDqsCkTRms
         rkTDast3DSFz5IgVy/9CUuCHEe8Wp2+RLH3Ji9+TXQL9teu1xU+SYoL/vAciY6Cyotff
         IsF6RThBOGjpcyM1J81rJWvK/unwCTQPSrcNdJagLhZLf6Zz1k+THfZE7+qa0VE2kNUa
         Bc/g==
X-Gm-Message-State: ANoB5pljcfP895idv7ppxCHPHy04TiRTeLWq7qFtQB+e1/36tn5ArYjr
        tdS/y+wzFLLWBE8sLwaMaitFsc7kD5gGWXq4/k96r4JvoLA=
X-Google-Smtp-Source: AA0mqf4xGvDQcJdKjIwMXWAc538MYarzxYKb8obZo64vXrcvbrd8W5lOf1rfrau7zhnEjd8tAqwDL8BYRuiSe4PjgHs=
X-Received: by 2002:a17:902:868b:b0:186:8c19:d472 with SMTP id
 g11-20020a170902868b00b001868c19d472mr73752673plo.12.1670387614824; Tue, 06
 Dec 2022 20:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20221205193625.2424202-1-lars@oddbit.com>
In-Reply-To: <20221205193625.2424202-1-lars@oddbit.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Dec 2022 23:33:23 -0500
Message-ID: <CAPig+cTypsXUrzkdO7S3cGFRWdO5CiaTKU_uM7av=M3nGHQ0+w@mail.gmail.com>
Subject: Re: [PATCH v2] line-range: Fix infinite loop bug with degenerate regex
To:     Lars Kellogg-Stedman <lars@oddbit.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 5, 2022 at 2:45 PM Lars Kellogg-Stedman <lars@oddbit.com> wrote:
> line-range: Fix infinite loop bug with degenerate regex

s/Fix/fix/

> When the -L argument to "git log" is passed the degenerate regular
> expression "$" (as in "-L :$:line-range.c"), this results in an
> infinite loop in find_funcname_matching_regexp() (the function
> iterates through the file correctly, but when it reaches the end of
> the file it matches $ against the empty string, "", and at that points
> loops forever).

s/points/point/

> Modify the loop condition from while (1) to while (*start) so that the
> loop exits when start is the empty string. In this case, "git log" exits
> with the error:
>
>     fatal: -L parameter '$' starting at line 1: no match

I've never really used `-L:funcname:`, so it took me by surprise that
this would be reported as a fatal error. However, now that I've read
through the code and put a bit of thought into degenerate cases, I
can't come up with any better way to report it. Okay.

> Originally reported in <https://stackoverflow.com/q/74690545/147356>.
>
> Signed-off-by: Lars Kellogg-Stedman <lars@oddbit.com>
> ---
> diff --git a/line-range.c b/line-range.c
> @@ -135,7 +135,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
>  {
>         int reg_error;
>         regmatch_t match[1];
> -       while (1) {
> +       while (*start) {
>                 const char *bol, *eol;
>                 reg_error = regexec(regexp, start, 1, match, 0);
>                 if (reg_error == REG_NOMATCH)
> @@ -161,6 +161,8 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
>                         return bol;
>                 start = eol;
>         }
> +
> +    return NULL;
>  }

I'm not particularly familiar with this code (even though I touched it
years ago), so I can't say whether this is the best fix, but it seems
reasonable now that I've studied the code and put some thought into
degenerate cases. I had wondered if it would be possible to catch
these degenerate cases in some general way, but whatever ideas I had
seemed too special-purpose; your solution here is straightforward and
probably more robust than special-purpose code.

Style-wise, I'd probably drop the blank line before `return NULL`.

Please do re-roll once more with a test which verifies that this bug
has been fixed. Here's a test you can add to the bottom of
t/t4211-line-log.sh for that purpose (be sure to re-indent it with
TABs which Gmail mushes out):

    test_expect_success 'degenerate -L:$: does not hang' '
        >content-immaterial &&
        git add content-immaterial &&
        git commit -m immaterial &&
        test_must_fail git log -L:$:content-immaterial
    '

And here's my sign-off which you can insert above your own sign-off if
you include the above test.

    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
