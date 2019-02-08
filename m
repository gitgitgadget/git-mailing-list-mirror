Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224AA1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 22:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBHWkF (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 17:40:05 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35874 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfBHWkE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 17:40:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so3129369qkf.3
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 14:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZO1BmSItaahYnHJ2g5UTOub8blrmXcJ4MLGJDqPMTI=;
        b=oOUdHKprsVqBLjBKd8q6O13q8tOP78ZaqzI8zBUtVYt3S0WKKbcssvpFrfAPw1dm1x
         2ikF1kJp3kRifBGN+mRln/IR2hnyWz/AHMiZO+r9LDMeAVBhm7ySJesmEHgeFZjU7ipU
         Z98GMmia5rmZ7A2SMkchPNpxRP9bJjOmsuUDY+mYkU7bZCD940XCL066LSlunuRaKmec
         Pnh24Ig8Dtut6wNrjCgliulk94RYgumoHaFlVk8TPMwgo0YfEo9e4qs/hNQ6WW81cxx+
         9w7ewthcLe6eFZbDFP8i65qXEJV+C5GR+OckO8FGHjCV32FVFGUg+PpMxI4qehBrsQYl
         iWig==
X-Gm-Message-State: AHQUAubQNlWDxI8yT7Vl+CE9Zy68a8AdIeKYlq5XpMCkH7Qo4Ih4DAjR
        wBlp7wlhd0LxAD6kQYaZjvgxRxKLDt7IDAXuYBs=
X-Google-Smtp-Source: AHgI3Ibs8b8plippK5AnmZ6naqFzWbNykH8V3DnqKOsnamoiBTrz97N+u56+XaaFb4jxJC3GL8J9h7rtDKKGZaTqye8=
X-Received: by 2002:a37:a4c2:: with SMTP id n185mr4661681qke.152.1549665603411;
 Fri, 08 Feb 2019 14:40:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.121.git.gitgitgadget@gmail.com> <cca9a543d52f3d7d9015709800e10ea57be1fea3.1549536364.git.gitgitgadget@gmail.com>
In-Reply-To: <cca9a543d52f3d7d9015709800e10ea57be1fea3.1549536364.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Feb 2019 17:39:53 -0500
Message-ID: <CAPig+cRPEoro_661Py+6RDTGvZdT4gAVK45jAuGr+g_Rt=en6A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mingw: fix CPU reporting in `git version --build-options`
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 7, 2019 at 5:46 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> We cannot rely on `uname -m` in Git for Windows' SDK to tell us what
> architecture we are compiling for, as we can compile both 32-bit and
> 64-bit `git.exe` from a 64-bit SDK, but the `uname -m` in that SDK will
> always report `x86_64`.
>
> So let's go back to our original design. And make it explicitly
> Windows-specific.

b22894049f (version --build-options: also report host CPU, 2017-12-15)
took this sort of case into consideration by introducing Makefile
variable HOST_CPU (which takes precedence over `uname -m`), with the
intention that, when cross-compiling, your build environment should
(somehow) set HOST_CPU to the canonical name of the CPU on which the
built Git will run (for instance, "x86_64" or "i686"). It would be
nice to employ this mechanism to solve this issue rather than
(re-)introducing a manually-maintained list of CPU names.

Can you say a few words (here in the email thread) about how the Git
for Windows SDK is instructed to build for one architecture or the
other? With such information, perhaps we can figure out how to get the
build environment itself to set HOST_CPU automatically so we don't
have to resort to and worry about maintenance costs of a hard-coded
CPU name list.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/compat/mingw.h b/compat/mingw.h
> @@ -6,6 +6,25 @@ typedef _sigset_t sigset_t;
> +#ifdef __MINGW64_VERSION_MAJOR
> +/*
> + * In Git for Windows, we cannot rely on `uname -m` to report the correct
> + * architecture: /usr/bin/uname.exe will report the architecture with which the
> + * current MSYS2 runtime was built, not the architecture for which we are
> + * currently compiling (both 32-bit and 64-bit `git.exe` is built in the 64-bit
> + * Git for Windows SDK).
> + */
> +#undef GIT_HOST_CPU
> +/* This was figured out by looking at `cpp -dM </dev/null`'s output */
> +#if defined(__x86_64__)
> +#define GIT_HOST_CPU "x86_64"
> +#elif defined(__i686__)
> +#define GIT_HOST_CPU "i686"
> +#else
> +#error "Unknown architecture"
> +#endif
> +#endif
