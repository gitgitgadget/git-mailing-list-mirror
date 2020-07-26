Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B7C433E0
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB687206E3
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGZX2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:28:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43910 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGZX2l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 19:28:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id a15so13053715wrh.10
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 16:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPWZMJ0hjtYzcnash3M0h9i+5K2ouROiM6LE1cWxQMw=;
        b=XFc9KWJH7JRXvxRsL/aUH2JE9tdCIoyFJpebrDwwvwTAx8Y9Ln5Gzrx9b/BfiM5T5r
         IoFqE/kTycFbD8eU/227xVmd2iL8udWiZHgtZLrk5WKGCigb6nDMGr5xJ1hWOfheImjH
         eXYDRnEXvFNKWg832JdI6FEOMdaEFGrhPnXO9BlGVTf1D8jxAoXpEKvYHUHSL0AOyYMr
         NmIFJg1YiBnXxHkT80wVg/mhGKdtwako0CQ5lyz7Ll2RR70hhPZ99LqkPi7kiMObck1s
         XJ7RDxI5vphp39lyHm1qOCBMN0jofRVx0nPAx8FrlD0iO5AC45lEoaYKAKqg0QTVfwii
         8YUg==
X-Gm-Message-State: AOAM531aPEWdViPRmxwngft8CXTadPmUJV41RSiNOwK/m6A0LTR6BKTk
        DjpVFmAjecdZuWiKoQ1a+/zgADvh5cdckwMty7g=
X-Google-Smtp-Source: ABdhPJwPqxUMBN6VXVsLj3K5QcE9bOpqdYBQXZmG59mqbrC1Vb7kX+DaaTaoWJ8E1I+mOVAuHqtHuf3P4BKT1QDvO4c=
X-Received: by 2002:adf:b352:: with SMTP id k18mr18582517wrd.386.1595806119621;
 Sun, 26 Jul 2020 16:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-30-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-30-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 19:28:28 -0400
Message-ID: <CAPig+cR4G5czLgAo=H-+HXOye+qCLmtUcE9-DKoh=+yptMitPw@mail.gmail.com>
Subject: Re: [PATCH v4 29/39] http-fetch: set up git directory before parsing
 pack hashes
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:56 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In dd4b732df7 ("upload-pack: send part of packfile response as uri",
> 2020-06-10), the git http-fetch code learned how to take  ac --packfile

s/take\s+ac/take a/

> option.  This option takes an argument, which is the name of a packfile
> hash, and parses it using parse_oid_hex.  It does so before calling
> setup_git_directory.
>
> However, in a SHA-256 repository this fails to work, since we have not
> set the hash algorithm in use and parse_oid_hex fails as a consequence.
> To ensure that we can parse packfile hashes of the right length, let's
> set up the git directory before we start parsing arguments.
> ---

Missing sign-off.

> diff --git a/http-fetch.c b/http-fetch.c
> @@ -86,6 +86,8 @@ int cmd_main(int argc, const char **argv)
> +       setup_git_directory();
> +
>         while (arg < argc && argv[arg][0] == '-') {
>                 const char *p;
> @@ -115,8 +117,6 @@ int cmd_main(int argc, const char **argv)
>         if (argc != arg + 2 - (commits_on_stdin || packfile))
>                 usage(http_fetch_usage);
>
> -       setup_git_directory();

This change has the unfortunate side-effect that "git http-fetch -h"
will no longer work if setup_git_directory() fails, which could easily
be the case if the user is trying to get help for the command from
some arbitrary location in the filesystem.

It might be better to setup_git_directory() on-demand when it's needed
by --packfile= rather than doing it unconditionally before the
argument-parsing loop.
