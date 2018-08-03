Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3AF1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 07:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeHCJEg (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 05:04:36 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42820 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeHCJEg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 05:04:36 -0400
Received: by mail-yw1-f68.google.com with SMTP id y203-v6so612975ywd.9
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 00:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfsNlvUztViY9DOkM2N710okzP3kX61Tl/xQC/5Eh/A=;
        b=Pfn2fyxyd4Q3u8B3JCe71ua0JAgIyobYBEqD6qb+HUCWMMMWF5bAz3RNVHBGKr92Dy
         Db/TZ118YONY9Dm6Nq2DKt4P3y56TIZ2loafGf2bkJFjizT4ejxZTVv27KgSAYY3cFll
         6h52NmTBCF7LE6fJNq2ykgl7xMwv5tEO7dZuBt7W54Z1UWEF3RDOjU+oJTlGV0AZRHBF
         /NM5+HeXCBmTF6Ym5ROcErVJXSTiWNda/v3g1xrMwHhnN0+bm55RAjWcwG3THR35PMW5
         mhNdGVpMyfYb7mj+JC14ha3jKJEnFgZtSiLvMXqtN6XBjuDRsuAhsfifha6QSXsXXTfX
         G1Jg==
X-Gm-Message-State: AOUpUlHK7n3r6k7B9L5aM21DXXf07JJOKKlm+/BcbqL6oskFvQ/Cizfn
        6iPC8BhUmyd+mWnk9zKXLx6WxOVOiimRrgaLDkZ1sfb+
X-Google-Smtp-Source: AAOMgpcAxPMVT1ltxJfMCzCcVDtHWgIpsWTaNQCxvffIpvnwtAlzoKXfGpd7FhG8WA5SQ6X/a+OIa2ayRp3LoPGKLvg=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr1389267ywr.16.1533280181693;
 Fri, 03 Aug 2018 00:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180802112002.720-1-phillip.wood@talktalk.net> <20180802112002.720-2-phillip.wood@talktalk.net>
In-Reply-To: <20180802112002.720-2-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Aug 2018 03:09:30 -0400
Message-ID: <CAPig+cSZ3Zm=qFcvGjyj_uStn=JMAYuskMa0O_2yxkKjaRWTSg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sequencer: handle errors in read_author_ident()
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 7:20 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> The calling code did not treat NULL as an error. Instead NULL caused
> it to fallback to using the default author when creating the new
> commit. This changed the date and potentially the author of the
> commit which corrupted the author data compared to its expected
> value. Fix this by returning and integer and passing in a parameter to
> receive the author.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -701,57 +701,59 @@ static char *get_author(const char *message)
> -static const char *read_author_ident(struct strbuf *buf)
> +static int read_author_ident(char **author)
>  {
> +       struct strbuf buf = STRBUF_INIT;
> -       if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
> -               return NULL;
> +       if (strbuf_read_file(&buf, rebase_path_author_script(), 256) <= 0) {
> +               strbuf_release(&buf);
> +               return -1;
> +       }

[...much noisiness snipped...]

> @@ -794,12 +796,14 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>         if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
> -               struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
> -               const char *author = is_rebase_i(opts) ?
> -                       read_author_ident(&script) : NULL;
> +               struct strbuf msg = STRBUF_INIT;
> +               char *author = NULL;
>
> +               if (is_rebase_i(opts) && read_author_ident(&author))
> +                       return -1;
> +

I think this patch can be simplified considerably by shifting one's
perspective. If we admit that read_author_ident() is already correctly
reporting an error by returning NULL (which is exactly what it is
doing), then the bug is is purely on the calling side; namely, the
caller is ignoring the error. (In fact, your commit message already
states this.)

So, if it's the caller which is buggy, then read_author_ident() does
not require _any_ changes (meaning all the noisiness in this patch can
be dropped), and only the caller needs a fix, and that change can be
quite tiny. To wit, instead of initializing 'author' like this (as
done in the current "buggy" code):

    const char *author = is_rebase_i(opts) ?
        read_author_ident(&script) : NULL;

Do this instead:

    const char *author = NULL;
    ...
    if (is_rebase_i(opts)) {
        author = read_author_ident(&script);
        if (!author) {
            strbuf_release(&script);
            return -1;
        }
    }

That's it, a minimal fix giving the same result, without all the code
churn, thus safer (less opportunity, for instance, to introduce a leak
as in v1). Of course, you can collapse the above even further to:

    if (is_rebase_i(opts) &&
        !(author = read_author_ident(&script)) {
            strbuf_release(&script);
            return -1;
    }

Though, I think that is less readable.
