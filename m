Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6815C4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 01:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiLWBgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 20:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiLWBgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 20:36:42 -0500
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F181409D
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 17:36:41 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id v3so2443127pgh.4
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 17:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyMLh/AKpwSYaCwXTLKP2oCaO73A3B2DomtuP3UUMkE=;
        b=kSDHLcuypYFMjZXKlw4lGFBUXBsllkklU5J/hVyDnn7c/H/cMBBfcKx4U0Pc0acafG
         BZc74qdbLAN+KVvfOjoxrktjMsQtOBj4s3ogndXzw3wn8GcCLZv/aUtk3Zluotse1/Ci
         4Y2pZUkAIawqQ33SSE+rJXn1xFtQ8cGdOvUieGnPd4irEf03HZEmXUyoMensXynfalyQ
         cE+XqCR+mh3aEX4ePT1Xa/lbKZ8DV/TdzVfU5cuzwtYvQguIf4R4e3ja/kxnhiCNgeQy
         0v/vovZas3ldVcc4hHL1zaIOFYlNlyTY0GAf0n+BL3APDHFtNaW1UZJ5ayrAWcMF7nsX
         QUhw==
X-Gm-Message-State: AFqh2kr/2aK/g/MAaiO/WNPpSVB2okDKvrsJypuidmuoIzgQdyjc0ClO
        0cKMBzJeqsTWmrLUMpwG5o3+lZbVQ5tpD2EmjJBhzkSaMLE=
X-Google-Smtp-Source: AMrXdXsrooZqvj/KZGtFHej0Wc5BjQrJ1ey33eWrRPJ4eJ7TmzPeEpb2CFD1hU5bQIamZUKA5v8Bx4XAztndOjMG0Q8=
X-Received: by 2002:a63:a12:0:b0:478:fbfd:5278 with SMTP id
 18-20020a630a12000000b00478fbfd5278mr408160pgk.268.1671759401040; Thu, 22 Dec
 2022 17:36:41 -0800 (PST)
MIME-Version: 1.0
References: <CAPig+cRcezSp4Rqt1Y9bD-FT6+7b0g9qHfbGRx65AOnw2FQXKg@mail.gmail.com>
 <20221222093021.5251-1-tenglong.tl@alibaba-inc.com>
In-Reply-To: <20221222093021.5251-1-tenglong.tl@alibaba-inc.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Dec 2022 20:36:29 -0500
Message-ID: <CAPig+cTFBVAL2gd3LqQEzS--cXqJXR+1OVerii-D6JqFvJwXqQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2022 at 4:30 AM Teng Long <dyroneteng@gmail.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Taking a step back, perhaps think of this in terms of "separator". The
> > default behavior is to insert "\n" as a separator between notes. If
> > you add a --separator option, then users could supply their own
> > separator, such as "----\n" or, in your case, "" to suppress the blank
> > line.
>
> There is another question for me, if the separator we passed contains "\n"
> string , the argument the cmd receives will need to tranfer to '\n' character
> instead to make sure it's a linebreak but not a "\n" instead.
>
> So maybe like:
> +static void insert_separator(struct strbuf *message, const char *separator)
> +{
> +               while (*separator) {
> +                       if (*separator == '\\'){
> +                               switch (separator[1]) {
> +                                       case 'n':
> +                                               strbuf_addstr(&transfered, "\n");
> +                                               separator++;
> +                                               break;
> + [...]
> +                       separator++;
> +               }
> +}
>
> If the above is understood correctly, is there an api that handles escape
> characters already in the existing code (I haven't found one so far, so I need
> to confirm and replace it if there is one). In addition, the insert_separator
> function above handles three special characters \t\n\r. Do we need more?

You could probably use unquote_c_style() from quote.[hc]; something like this:

    struct strbuf orig = STRBUF_INIT;
    struct strbuf unquoted = STRBUF_INIT;
    strbuf_addf(&orig, "\"%s\"", separator);
    if (unquote_c_style(&unquoted, orig.buf, NULL) < 0) {
        strbuf_release(&unquoted);
        strbuf_release(&orig);
        die(_("some suitable error message"));
    }
    /* unquote succeeded -- use "unquoted" here */

However, I suspect that this is overkill, and you should explore
simpler ideas first.

For instance, it is perfectly acceptable to embed newlines directly in
shell strings, so this would work just fine without having to write
any extra string-unquoting code:

    % git notes add --separator='---
    ' <object>

But, I think you can make this even friendlier without having to do
any extra coding to support string-unquoting. In particular, use this
heuristic:

    - if the separator is zero-length, use it as-is
    - otherwise, if the separator ends with a newline, use it as-is
    - otherwise add a newline to the separator

In other words:

    if (!separator)
        separator = "\n"; /* default is one blank line */
    if (*separator == '\0')
        /* separator is empty; use as-is (no blank line) */
    else if (separator[strlen(separator) - 1] == '\n')
        /* user supplied newline; use as-is */
    else
        /* separator lacks newline; add it ourselves */

With the above logic, this defaults to a blank line between notes:

    % git notes add ...

this has no blank line between notes:

    % git notes add --separator='' ...

this uses a "---" + "\n" as separator:

    % git notes add --separator='---' ...

as does this:

    % git notes add --separator='---
    ' ...

and this places two blank lines between notes:

    % git notes add --separator='

    ' ...
