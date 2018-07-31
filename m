Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68141F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbeGaWaL (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 18:30:11 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33954 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeGaWaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 18:30:11 -0400
Received: by mail-yw0-f196.google.com with SMTP id j68-v6so6327877ywg.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 13:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sk2Q1OoY8siNwKdr1IUwFTqPgi2vWOpYp1cyQMHhoiU=;
        b=uSGD2sta8jdBdT+YunwSwcvsKPzDNytETrOlpE+WUAVor5iXpbRjYCugRVJ5kCaagv
         Ii+PGe9eshbjSUHIZuLBIY6G+pYfkA0ZaegBMCoc4ed7OJ6mHlsQRRK/pIBYuW/ZlwbF
         oZjWNDcAGX7HwYY02lmG2IZWxlxAuXLt7TT921UfdCGp0YsgKAgLO6B8GG9rzzMN7YdY
         2yfcNXbbWA/yiWgUyWyvoTHj1EhgCT2E8mU0IRPseERzCC06Xayb5t/9jdGsGzw1rMsz
         ZAR8RgeMXxHArU8IPbMhugjZGRVhGiQrrAN03Or0kOnJLfvtKDo20zknIOhYYe1alyu7
         jXRA==
X-Gm-Message-State: AOUpUlEmVRCnt08d7D/ri3ayuF819c4py1jLgLxUWOBylVcTQQamvJuE
        nx9eq4IaQkcuo89w0Ai+ZSnD0lnPJZOJ5j3EHAcsHnoM
X-Google-Smtp-Source: AAOMgpfXul8qHnrSVcfzsS0VckSDg3gNhBWQH8Wrafsv76WPViAi6y2N8+jPe0GO+cnTNXvzDMW25aDe4Lp74Rqdyjc=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr11976982ywq.120.1533070083421;
 Tue, 31 Jul 2018 13:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731111532.9358-1-phillip.wood@talktalk.net> <20180731111532.9358-2-phillip.wood@talktalk.net>
In-Reply-To: <20180731111532.9358-2-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Jul 2018 16:47:52 -0400
Message-ID: <CAPig+cT15a-QTTAjC61td4h_YhHz0WSa8iT_3XqUUc6LZHWC=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sequencer: handle errors in read_author_ident()
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 7:15 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> The calling code treated NULL as a valid return value, so fix this by
> returning and integer and passing in a parameter to receive the author.

It might be difficult for future readers (those who didn't follow the
discussion) to understand how/why NULL is not sufficient to signal an
error. Perhaps incorporating the explanation from your email[1] which
discussed that the author name, email, and/or date might change
unexpectedly would be sufficient. This excerpt from [1] might be a
good starting point:

    ... the caller does not treat NULL as an error, so this will
    change the date and potentially the author of the commit
    ... [which] does corrupt the author data compared to its
    expected value.

[1]: https://public-inbox.org/git/c80cf729-1bbe-10f5-6837-b074d371b91c@talktalk.net/

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -701,57 +701,58 @@ static char *get_author(const char *message)
> -static const char *read_author_ident(struct strbuf *buf)
> +static int read_author_ident(char **author)

So, the caller is now responsible for freeing the string placed in
'author'. Okay.

>  {
> -       if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
> -               return NULL;
> +       if (strbuf_read_file(&buf, rebase_path_author_script(), 256) <= 0)
> +               return -1;

I think you need to strbuf_release(&buf) in this error path since
strbuf_read_file() doesn't guarantee that the strbuf hasn't been
partially populated when it returns an error. (That is, this is
leaking.)

>         /* dequote values and construct ident line in-place */

Ugh, this comment should have been adjusted in my series. A minor
matter, though, which can be tweaked later.

>         /* validate date since fmt_ident() will die() on bad value */
>         if (parse_date(val[2], &out)){
> -               warning(_("invalid date format '%s' in '%s'"),
> +               error(_("invalid date format '%s' in '%s'"),
>                         val[2], rebase_path_author_script());
>                 strbuf_release(&out);
> -               return NULL;
> +               strbuf_release(&buf);
> +               return -1;

You were careful to print the error, which references a value from
'buf', before destroying 'buf'. Good.

(A simplifying alternative would have been to not print the actual
value and instead say generally that "the date" was bad. Not a big
deal.)

>         }
> -       strbuf_swap(buf, &out);
> -       strbuf_release(&out);
> -       return buf->buf;
> +       *author = strbuf_detach(&out, NULL);

And, 'author' is only assigned when 0 is returned, so the caller only
has to free(author) upon success. Fine.

> +       strbuf_release(&buf);
> +       return 0;
>  }
>
>  static const char staged_changes_advice[] =
> @@ -794,12 +795,14 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
> -               struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
> -               const char *author = is_rebase_i(opts) ?
> -                       read_author_ident(&script) : NULL;
> +               struct strbuf msg = STRBUF_INIT;
> +               char *author = NULL;
>                 struct object_id root_commit, *cache_tree_oid;
>                 int res = 0;
>
> +               if (is_rebase_i(opts) && read_author_ident(&author))
> +                       return -1;

Logic looks correct, and it's nice to see that you went with 'return
-1' rather than die(), especially since the caller of run_git_commit()
is already able to handle -1.
