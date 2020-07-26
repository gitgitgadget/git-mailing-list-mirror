Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A907C433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 21:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E37B2065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 21:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGZVaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 17:30:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46508 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGZV37 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 17:29:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id r12so12891173wrj.13
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 14:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B18NhWuuus2WoIksiS6Roy6jJoYF/EfQ6VH96os9bF8=;
        b=q0Q0DzDj/g2AF3EQXwRY4IfCPpAxUkbiRFLEskSlJ6hgDQMNg4pXL37YMDJUH1XKNF
         +5we5yG2YqVcJyQsTodN+FE8ffqjMHd9HLDejbv86vmkwyCd6vdbFyVD8255JzUxHeQw
         +Cc63m4TdE7oDgsHy47DrGwg3P7WxR4w+PagOFAErBPsi6aTETKvyJROqV1Lo9mTYqiR
         XJYNXpII8Pbt0GU66YdaeMvuZvJ8MxhdrC6cz9u0ewNWaYPW5jCG+ia1vZNpx3O/2ZCi
         8piyqBlerktDcHQQcLqgN8A2PIsxeJCV7hEUBVhl6jYobInMf26H6qnEucFwQS7EAN+U
         sX/g==
X-Gm-Message-State: AOAM533o52T2dMtTBaQ4OqBhuagD+AEN4wymajfD4Qc8gD7V4+/7dMQD
        sLNg1ArF6rmDmar57o2XeoRcraqUNkRY2p0+fq/tRFB5
X-Google-Smtp-Source: ABdhPJw3pWiloKhmRprCb9rAPkxpWlEDueXOciBPSE9lM089k/ULlugePraBLsXq+34L8h0/4RM0PLes2ZsWcAjNnKA=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr9500682wrv.120.1595798997722;
 Sun, 26 Jul 2020 14:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-31-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-31-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 17:29:46 -0400
Message-ID: <CAPig+cRUj2RGz1=+3EDr5G_Mq2sXPnztCr-iPDGH+WycQ2iwjA@mail.gmail.com>
Subject: Re: [PATCH v4 30/39] builtin/verify-pack: implement an
 --object-format option
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:56 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> A recently added test in t5702 started using git verify-pack outside of
> a repository.  While this poses no problems with SHA-1, with SHA-256 we
> implicitly rely on the setup of the repository to initialize our hash
> algorithm settings.
>
> Since we're not in a repository here, we need to provide git verify-pack
> help to set things up properly.  git index-pack already knows an
> --object-format option, so let's accept one as well and pass it down to
> our git index-pack invocation.  Since we're now dynamically adjusting
> the elements in argv, let's switch to using struct argv_array to manage
> them.  Finally, let's make t5702 pass the proper argument on down to its
> git verify-pack caller.

A few comments below... use your own judgment as to whether they are
worth a re-roll.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
> @@ -7,21 +7,28 @@
> +static int verify_one_pack(const char *path, unsigned int flags, const char *hash_algo)
>  {
> +       struct argv_array argv = ARGV_ARRAY_INIT;
> +       struct strbuf arg = STRBUF_INIT, hash_arg = STRBUF_INIT;
>
> +       if (hash_algo) {
> +               strbuf_addf(&hash_arg, "--object-format=%s", hash_algo);
> +               argv_array_push(&argv, hash_arg.buf);
> +       }

Rather than bothering with a separate strbuf, this would be easier:

    argv_array_pushf(&argv, "--object-format=%s", hash_algo);

Doing so would also fix a secondary problem that 'hash_arg' is being leaked.

> @@ -31,9 +38,9 @@ static int verify_one_pack(const char *path, unsigned int flags)
> -       index_pack.argv = argv;
> +       index_pack.argv = argv.argv;

'struct child_process' already has an 'args' member which is a 'struct
argv_array' of which you can take advantage instead of creating your
own local 'argv' in this function. run_command() automatically clears
the built-in 'argv_array', which frees you the effort of having to do
so manually.

>         err = run_command(&index_pack);
> @@ -47,6 +54,7 @@ static int verify_one_pack(const char *path, unsigned int flags)
>         strbuf_release(&arg);
> +       argv_array_clear(&argv);

This is where 'hash_arg' is being linked. This is also where you could
eliminate the call to argv_array_clear() if you take advantage of the
'argv_array' already provided by 'child_process'.
