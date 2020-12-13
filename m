Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E9AC433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 02:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C01322D71
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 02:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgLMCgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 21:36:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34964 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgLMCgU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 21:36:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id u19so13531302edx.2
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 18:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSZW2XT+SmLk7s+iTS9Ck+fcLcyxGrA8XCwaIqVbnFg=;
        b=qOMKCUfRycVz+mG/tFcpwPBvZwsO6ukWH9EoDGcvJI6LjkCZenRFBwiywGRI27rb4E
         lOqdhqIDxQM2Gaz+oEVkXPDODgEhCesUxFm+NjY46Rw9lEjSty1FQKLVkNZLetzuIIrh
         u6u3/6ltLlR3O0D64ZD9HIizGvvCl1Ua1Tomrx/gXqMc/0c8mhIYIWQS7GyUJkW+WSSa
         kvsK6QJw/gjcaGBdAbLQwNl6dgsHYAkN7HPMM4E4pZoQjWLY6yTQDHpEdRY9qJQCPDwd
         60wEf3SAJcRFGIID8468sG283aMJ90jP+p+AuwlODznIcV5j66Z5dx9SXTiA389T6DXw
         094g==
X-Gm-Message-State: AOAM532WXkK/db+XR5kXsbRpGV7HYk4MzzdBzQgyWPJMf0nIbBjhO8yc
        uJ1i8+9I7eNeglRRlJx9j9mCOW86TO9hDBU8OAs=
X-Google-Smtp-Source: ABdhPJxij/nb+uNDFbaDG88EmnIt5vkpfcCeib39Aly9BN3kKNzthyaKGgCBSbBgss1+7dN6vJI7JevLaZgw5X9fhLQ=
X-Received: by 2002:a50:a692:: with SMTP id e18mr18808146edc.233.1607826938816;
 Sat, 12 Dec 2020 18:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20201213002529.542928-1-sandals@crustytoothpaste.net> <20201213002529.542928-2-sandals@crustytoothpaste.net>
In-Reply-To: <20201213002529.542928-2-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 12 Dec 2020 21:35:28 -0500
Message-ID: <CAPig+cTFJv8LZWp6Mvi1OXabZ+5NmEw8fu8NeQuwhZDAbnA59Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] abspath: add a function to resolve paths with
 missing components
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 12, 2020 at 7:26 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Currently, we have a function to resolve paths, strbuf_realpath.  This
> function canonicalizes paths like realpath(3), but permits a trailing
> component to be absent from the file system.  In other words, this is
> the behavior of the GNU realpath(1) without any arguments.
>
> In the future, we'll need this same behavior, except that we want to
> allow for any number of missing trailing components, which is the
> behavior of GNU realpath(1) with the -m option.  This is useful because
> we'll want to canonicalize a path that may point to a not yet present
> path under the .git directory.  For example, a user may want to know
> where an arbitrary ref would be stored if it existed in the file system.

This improved explanation helps the reader better understand why such
functionality is wanted. Thanks.

> Let's refactor strbuf_realpath to move most of the code to an internal
> function and then pass it two flags to control its behavior.  We'll add
> a strbuf_realpath_forgiving function that has our new behavior, and
> leave strbuf_realpath with the older, stricter behavior.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/abspath.c b/abspath.c
> +#define REALPATH_MANY_MISSING (1 << 0)
> +#define REALPATH_DIE_ON_ERROR (1 << 1)
> +
> +static char *strbuf_realpath_1(struct strbuf *resolved, const char *path,
> +                              int flags)

We normally declare these composed-of-bits "flags" arguments as
`unsigned` rather than `int`.

> @@ -89,7 +85,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
>         if (!*path) {
> -               if (die_on_error)
> +               if (flags & REALPATH_DIE_ON_ERROR)

Nit: If you declare a local variable named `die_on_error`:

    int die_on_error = flags & REALPATH_DIE_ON_ERROR;

then you won't have to touch the existing five places where this
condition is checked, thus making the diff less noisy and the code
(subjectively) a bit easier to read at a glance. Not at all worth a
re-roll, though.

Aside from these minor comments, this version is a nice improvement
over the last.
