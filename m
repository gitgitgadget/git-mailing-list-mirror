Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251051F404
	for <e@80x24.org>; Fri, 14 Sep 2018 00:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeINFoC (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 01:44:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37958 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeINFoC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 01:44:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id g197-v6so4282152qke.5
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 17:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8VyPhk7loFna6WbvEQ3iHuMPcRGBzpo5T0fC6mAvOE=;
        b=ss2RZK89A+UWuu4r2RZGzTCi206ZHTEZ7xydaBsTab5pIfWTREab+diYLCeah1NtNJ
         YiHZwElaOdH8cBkDTtAJulaBY600c8kPneFGLNdcjrfWN1uNPhEpg2dQxUK6lYTTa6z2
         2nLhD5eZK17R2bl2CuJMxaLyGIeEY+1y5aZlBoGWprnFbKZMsYTsbEhsjwUtwiLckctq
         az5FeJCQYKm+mlkgnD4jfmf5FwlpzRhR/YHKWQDq9WJTwyo3VGZzzCbZJDdGOiOz6c0t
         wjZFE64lIuZHjWj0vDzI4qm0OIf2DF0JqXE1Izg9MpljfYyAIRva7fulNzBdtI2sQiOL
         qc1w==
X-Gm-Message-State: APzg51CKl82Av90i4DATDY1QqpPhFT4KrO1paCMyxPV2Hd4lRTWEvSnz
        3G7NtXS5T2U9Ehl2EXit9nG0iIphnKGfngrjB7bL8Ru5
X-Google-Smtp-Source: ANB0Vda9Wf33LymvXUog7rwDdVuHY4NngLgsoPJd/85gPcN34H6YgwASkH9MJzzIudc7iMY98W+YZ0eeIyMWwPJBAqA=
X-Received: by 2002:ae9:ef13:: with SMTP id d19-v6mr7017377qkg.152.1536885130346;
 Thu, 13 Sep 2018 17:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180912101029.28052-1-phillip.wood@talktalk.net> <20180912101029.28052-4-phillip.wood@talktalk.net>
In-Reply-To: <20180912101029.28052-4-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Sep 2018 20:31:58 -0400
Message-ID: <CAPig+cS8ncvp8Se2Q24z9CFkiVey2zHP8i3oYVDPfGoP1kuDdA@mail.gmail.com>
Subject: Re: [PATCH 3/3] sequencer: use read_author_script()
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 6:11 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> Use the new function to read the author script, updating
> read_env_script() and read_author_ident(). This means we now have a
> single code path that reads the author script and uses sq_dequote() to
> dequote it. This fixes potential problems with user edited scripts
> as read_env_script() which did not track quotes properly.
> [...]
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  /*
>   * Read a list of environment variable assignments (such as the author-script
>   * file) into an environment block. Returns -1 on error, 0 otherwise.
>   */

According to this comment, this function is capable of parsing a file
of arbitrary "NAME=Value" lines, and indeed the original code does
just that, but...

>  static int read_env_script(struct argv_array *env)
>  {
> +       char *name, *email, *date;
>
> -       if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
> +       if (read_author_script(rebase_path_author_script(),
> +                              &name, &email, &date, 0))

...the new implementation is able to handle only GIT_AUTHOR_NAME,
GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE, in exactly that order.

This seems like a pretty serious (and possibly buggy) change of
behavior, and makes the function much less useful (in general). Is it
true that it will only ever be used for files containing that limited
set of names? If so, the behavior change deserves mention in the
commit message, the function comment needs updating, and the function
itself probably ought to be renamed.

> +       strbuf_addstr(&script, "GIT_AUTHOR_NAME=");
> +       strbuf_addstr(&script, name);
> +       argv_array_push(env, script.buf);
> +       strbuf_reset(&script);
> +       strbuf_addstr(&script, "GIT_AUTHOR_EMAIL=");
> +       strbuf_addstr(&script, email);
> +       argv_array_push(env, script.buf);
> +       strbuf_reset(&script);
> +       strbuf_addstr(&script, "GIT_AUTHOR_DATE=");
> +       strbuf_addstr(&script, date);
> +       argv_array_push(env, script.buf);
> +       strbuf_release(&script);

Mentioned earlier[1], this can all collapse down to:

argv_array_pushf(env, "GIT_AUTHOR_NAME=%s", name);
argv_array_pushf(env, "GIT_AUTHOR_EMAIL=%s", email);
argv_array_pushf(env, "GIT_AUTHOR_DATE=%s", date);

However, it's unfortunate that this manual and hard-coded
reconstruction is needed at all. If you restructure the factoring of
this patch series, such ugliness can be avoided altogether. For
instance, the series could be structured like this:

1. Introduce a general-purpose function for reading a file containing
arbitrary "NAME=Value" lines (not carrying about specific key names or
their order) and returning them in some data structure (perhaps via
'string_list' as parse_key_value_squoted() in patch 2/3 does).

2. Build read_author_script() atop #1, making it expect and extract
GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE (possibly in
that order, or possibly not if we don't care).

3. Retrofit existing parsers to call one of those two functions (this
step may happen over several patches). So, for instance,
read_env_script() would call the generic parser from #1, whereas
sequencer.c:read_author_ident() would call the more specific parser
from #2.

More below...

> @@ -790,54 +771,25 @@ static char *get_author(const char *message)
>  /* Read author-script and return an ident line (author <email> timestamp) */
>  static const char *read_author_ident(struct strbuf *buf)
>  {
> -       const char *keys[] = {
> -               "GIT_AUTHOR_NAME=", "GIT_AUTHOR_EMAIL=", "GIT_AUTHOR_DATE="
> -       };
> -       if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
> +       if (read_author_script(rebase_path_author_script(),
> +                              &name, &email, &date, 0))
>                 return NULL;
> -       /* dequote values and construct ident line in-place */
> -       for (in = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
> -               if (!skip_prefix(in, keys[i], (const char **)&in)) {
> -                       warning(_("could not parse '%s' (looking for '%s')"),
> -                               rebase_path_author_script(), keys[i]);
> -                       return NULL;
> -               }
> -               if (!sq_dequote(in)) {
> -                       warning(_("bad quoting on %s value in '%s'"),
> -                               keys[i], rebase_path_author_script());
> -                       return NULL;
> -               }
> -       if (i < 3) {
> -               warning(_("could not parse '%s' (looking for '%s')"),
> -                       rebase_path_author_script(), keys[i]);
> -               return NULL;
> -       }

The parsing code being thrown away here does a better job of
diagnosing problems (thus helping the user figure out what went wrong)
than the new shared parser introduced by patch 2/3. The shared
function only ever reports a generic "unable to parse", whereas the
above code gets specific, saying that it was looking for a particular
key or that quoting was broken. I'd have expected the new shared
parser to encompass the best features of the existing parsers (such as
presenting better error messages).

>         /* validate date since fmt_ident() will die() on bad value */
> -       if (parse_date(val[2], &out)){
> +       if (parse_date(date, buf)){

Re-purposing the strbuf 'buf', which is passed into this function,
binds this function too tightly with its caller by assuming that the
caller will never need the original content of 'buf' anymore. Thus, it
would be better for this code continue using its own local strbuf
'out' rather than re-purposing the incoming 'buf'.

>                 warning(_("invalid date format '%s' in '%s'"),
> -                       val[2], rebase_path_author_script());
> -               strbuf_release(&out);
> +                       date, rebase_path_author_script());
> +               strbuf_release(buf);

Likewise, it's doubly odd to see this function releasing 'buf' which
it does not own.

>                 return NULL;
>         }

[1]: https://public-inbox.org/git/CAPig+cRvUr26GZyW6ecYhpwABueBqaEfZH1+JjLaqZo8+RTD6Q@mail.gmail.com/
