Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C690C433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 02:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E381020672
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 02:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbgG2ChH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:37:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42912 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgG2ChH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 22:37:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so17137438wrx.9
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 19:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lg/tZOAg2lHyhDZuP2aGSxIP+TOdkNJTED5onidLMic=;
        b=o7ya+Hg5yJRBYkzROLsZ55270SsC1trprnxqKg3a7njSLc7kXsX9vC3es2qBRim7Wh
         i6Ckd0d1EkvZtjbvBmo0910tNv6H2YDOZ2QyZ/iKtVgQX0Vwq9Nt4QwW8dTk7TFbgeoq
         Ki2ZGcj85kghpcvVy6vpLeTwKQxbVnF+WRCmeiIZ+w9XbedObb+Zcz6aFLu2ycBq6KTb
         J3HnGRgfjJJQe4+SnF4sT8Sgqldl7JEzKnUDN7pg7MqrrFSpU+RMdNGBkPeRqZc9bArZ
         azQx3jRwabn5iujSKWrvP7w9pYNGJh3sNQhXl563AVHQzB0jjN9SbIxVOv3nIepD8+mR
         Ersw==
X-Gm-Message-State: AOAM531nf5uladdO6Wk05eQ8VaOHARYsJQuUF+jyS3xjNs7CotUhch0u
        B2OONqdSCTTcKLh7epZyxK5M7tlnHOl++kiQXw2m9pRnzes=
X-Google-Smtp-Source: ABdhPJwn6Ef28lTDrwh2DINunkMJQhBuoDBVdQo1+YtF3isGns2Wyf88tUOeYV1KtdXqeXYiGGDj8jB592LVyC0FRnU=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr27837270wrn.415.1595990224609;
 Tue, 28 Jul 2020 19:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net> <20200728233446.3066485-30-sandals@crustytoothpaste.net>
In-Reply-To: <20200728233446.3066485-30-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Jul 2020 22:36:53 -0400
Message-ID: <CAPig+cSP-NKjBHfD+REAUECJm4qjhKMc0vhYg9rMaeapWSTKWg@mail.gmail.com>
Subject: Re: [PATCH v5 29/39] http-fetch: set up git directory before parsing
 pack hashes
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 7:35 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In dd4b732df7 ("upload-pack: send part of packfile response as uri",
> 2020-06-10), the git http-fetch code learned how to take  ac --packfile
> option.  This option takes an argument, which is the name of a packfile
> hash, and parses it using parse_oid_hex.  It does so before calling
> setup_git_directory.
>
> However, in a SHA-256 repository this fails to work, since we have not
> set the hash algorithm in use and parse_oid_hex fails as a consequence.
> To ensure that we can parse packfile hashes of the right length, let's
> set up the git directory before we start parsing arguments.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/http-fetch.c b/http-fetch.c
> @@ -86,6 +86,8 @@ int cmd_main(int argc, const char **argv)
> +       setup_git_directory_gently(NULL);
> +
>         while (arg < argc && argv[arg][0] == '-') {
>                 const char *p;
> @@ -115,8 +117,6 @@ int cmd_main(int argc, const char **argv)
>         if (argc != arg + 2 - (commits_on_stdin || packfile))
>                 usage(http_fetch_usage);
>
> -       setup_git_directory();

In the previous version of this series the setup_git_directory() call
was moved verbatim above the 'while' loop, and my review pointed out
that doing so made "git-http-fetch -h" fail when not in a Git
repository. It was recommended, therefore, to take advantage of
setup_git_directory_gently() to fix this problem.

But note that setup_git_directory() is defined like this:

    const char *setup_git_directory(void)
    {
        return setup_git_directory_gently(NULL);
    }

So, your use of setup_git_directory_gently(NULL) in this version of
the patch is no better than the plain setup_git_directory() call in
the previous version. It is still impossible to ask git-http-fetch for
help when not in a Git repository.

To fix this, you must pass non-NULL for the 'nongit' argument of
setup_git_directory_gently().

For robustness, in order to retain the original behavior (prior to
this patch), it would be best to check the value of 'nongit' _after_
the 'while' loop and error out if not in a repository. Perhaps
something like this (taking a hint from builtin/diff.c):

    setup_git_directory_gently(&nongit);

    while (...) {
        ...
    }

    if (nongit)
        die(_("not a git repository"));
