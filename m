Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7500FC636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 17:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBERvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 12:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBERvM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 12:51:12 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608041CF4A
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 09:51:10 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id z1so9971019plg.6
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 09:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ktiXr7BQFzUFT4Urxfb2OfWkLJlgCMBnuziz48k8M0=;
        b=ut9g4ry4Hec/VyqOgiKMx+W0BlkrvvmXV1XrGgTJK9I1SCrFgP2jYngpVqhH5vhxzi
         3vbLuDKFgvbZ0571KjGDl2fCYbZHqVkUDhqqGG5SQ3Bi5baMtcLqQzvayyfh1V+PITvj
         WGZDoqEWgnC+n2FU35rm1zf801yBQKDJWoPAz8EuOc4tlHAJTHM8Z0RVf3QM1u6kd8bb
         jUh49HXw1LrVQXjHdFQJ3oE426Q18aeXPepL6LcmdojjvvnWLGIdDpPbWVI2bgL9QVMD
         aFMk0rYrjijIVVm2yRMCIxbNNmmukLkWsuuSIPM9yC6dOGbXMPTjPiJ1zh8W/QVh1Dwi
         mbOQ==
X-Gm-Message-State: AO0yUKXaYwTUlUUl2D91A6yoyMJfuB0ufgNA+2I1LmAZJGgjFZSFkt2F
        VOxLAf1skUERrG5E/0zQpk7XAHtfQk9Z8qyFuEdOLqT9
X-Google-Smtp-Source: AK7set9T2XI0j+P3E4idLgbMRIzTTCJ4a4PvvsHkizV94lMFHt5zuijg3r2i64uXh6ID/1ynqhpiKO/qeNm9A82xMJE=
X-Received: by 2002:a17:90a:6587:b0:230:7861:1897 with SMTP id
 k7-20020a17090a658700b0023078611897mr1392644pjj.134.1675619469228; Sun, 05
 Feb 2023 09:51:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com> <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
In-Reply-To: <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Feb 2023 12:50:57 -0500
Message-ID: <CAPig+cQNoX1-DN1=aFEX=MxEvoYhdu0NxPyhH++B4_1G2Dmp8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2023 at 11:47 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> It can be useful to specify diff algorithms per file type. For example,
> one may want to use the minimal diff algorithm for .json files, another
> for .c files, etc.
>
> Teach the diff machinery to check attributes for a diff algorithm.
> Enforce precedence by favoring the command line option, then looking at
> attributes, then finally the config.
>
> To enforce precedence order, set the `xdl_opts_command_line` member
> during options pasing to indicate the diff algorithm was set via command
> line args.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
> diff --git a/diff.c b/diff.c
> @@ -3652,6 +3652,27 @@ static void builtin_diff(const char *name_a,
> +               if (!o->xdl_opts_command_line) {
> +                       static struct attr_check *check;

`check` is declared static...

> +                       const char *one_diff_algo;
> +                       const char *two_diff_algo;
> +
> +                       check = attr_check_alloc();

... is allocated here...

> +                       attr_check_append(check, git_attr("diff-algorithm"));
> +
> +                       git_check_attr(the_repository->index, NULL, one->path, check);
> +                       one_diff_algo = check->items[0].value;
> +                       git_check_attr(the_repository->index, NULL, two->path, check);
> +                       two_diff_algo = check->items[0].value;
> +
> +                       if (!ATTR_UNSET(one_diff_algo) && !ATTR_UNSET(two_diff_algo) &&
> +                               !strcmp(one_diff_algo, two_diff_algo))
> +                               set_diff_algorithm(o, one_diff_algo);
> +
> +                       attr_check_free(check);

... and freed here...

> +               }

... so the reason for the `static` declaration is not clear. Am I
missing something obvious?
