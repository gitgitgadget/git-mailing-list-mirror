Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B5C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ADF661029
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhEGE2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:28:52 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:34711 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGE2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:28:51 -0400
Received: by mail-ej1-f48.google.com with SMTP id a4so11535668ejk.1
        for <git@vger.kernel.org>; Thu, 06 May 2021 21:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCNWmo1rcpe4SgEY2J3FR7Il784o5iu5TRftqhlgaYs=;
        b=NY/co/NQe9TJuGO8u088E3Y7yDJaqgFPqDXer9pcFNddBr+wkdaLw/n7IkMIEMWf31
         W8zoGokCYvEeC0tgHx/8RUMSPPUNmXBwxPB2MosRz7v6fDlMFnMFySWevHmX8CEBgUzd
         zcyUvnWd4D22FjVJsNxpuyOxD+Hae+l1/0tedOx+pmB0aJ/mcu/wXGTFbwbvwHHP4MzI
         jDhWIAUEjyJ9QuOSBfzy/TrHsHskSetSDgQ2ZJ19WY0fdBrCx8aOZ90EptdhrFykGT4H
         jUZKMu+Xbh/z5QELX/dyDQp1Lj7SNwBzuNXHZvT6Ud4Vvogy7+Pr+h0EqHQOnyaLQ3ET
         Xnng==
X-Gm-Message-State: AOAM531fQQtgdOXA5RUNt0m0kBMy3fFFAdgbDigKlpKqXv3bA/kkfDyy
        d79B3oQ4QsQFGuBzg1aVEM0uWRDlR3MN9c0akF0=
X-Google-Smtp-Source: ABdhPJx3kt385KUZcDy03ac/go8Wg+gPTo7Fz+3j+xHQIu4zcu0ZBxEBHMRWM5bBVXMZtl4kfQZIMpAg2fdl/3v44rk=
X-Received: by 2002:a17:906:c44d:: with SMTP id ck13mr7963004ejb.371.1620361670596;
 Thu, 06 May 2021 21:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com> <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
In-Reply-To: <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 May 2021 00:27:39 -0400
Message-ID: <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 7, 2021 at 12:05 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> PNPM is apparently creating deeply nested (but ignored) directory
> structures; traversing them is costly performance-wise, unnecessary, and
> in some cases is even throwing warnings/errors because the paths are too
> long to handle on various platforms.  Add a testcase that demonstrates
> this problem.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> @@ -746,4 +746,44 @@ test_expect_success 'clean untracked paths by pathspec' '
> +test_expect_failure 'avoid traversing into ignored directories' '
> +       test_when_finished rm -f output error &&
> +       test_create_repo avoid-traversing-deep-hierarchy &&
> +       (
> +               cd avoid-traversing-deep-hierarchy &&
> +
> +               >directory-random-file.txt &&
> +               # Put this file under directory400/directory399/.../directory1/
> +               depth=400 &&
> +               for x in $(test_seq 1 $depth); do
> +                       mkdir "tmpdirectory$x" &&
> +                       mv directory* "tmpdirectory$x" &&
> +                       mv "tmpdirectory$x" "directory$x"
> +               done &&

Is this expensive/slow loop needed because you'd otherwise run afoul
of command-line length limits on some platforms if you tried creating
the entire mess of directories with a single `mkdir -p`?

> +               git clean -ffdxn -e directory$depth >../output 2>../error &&
> +
> +               test_must_be_empty ../output &&
> +               # We especially do not want things like
> +               #   "warning: could not open directory "
> +               # appearing in the error output.  It is true that directories
> +               # that are too long cannot be opened, but we should not be
> +               # recursing into those directories anyway since the very first
> +               # level is ignored.
> +               test_must_be_empty ../error &&
> +
> +               # alpine-linux-musl fails to "rm -rf" a directory with such
> +               # a deeply nested hierarchy.  Help it out by deleting the
> +               # leading directories ourselves.  Super slow, but, what else
> +               # can we do?  Without this, we will hit a
> +               #     error: Tests passed but test cleanup failed; aborting
> +               # so do this ugly manual cleanup...
> +               while test ! -f directory-random-file.txt; do
> +                       name=$(ls -d directory*) &&
> +                       mv $name/* . &&
> +                       rmdir $name
> +               done

Shouldn't this cleanup loop be under the control of
test_when_finished() to ensure it is invoked regardless of how the
test exits?

> +       )
> +'
