Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB0C4708E
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 23:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbjAEXYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 18:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjAEXYB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 18:24:01 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074BE69516
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 15:24:00 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4a2f8ad29d5so805107b3.8
        for <git@vger.kernel.org>; Thu, 05 Jan 2023 15:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7PWJ+NuAsW5s2vA9QgZOe3idm9eB7zTent9a3jd7JNg=;
        b=cuslJPKtJoF5C8ov77k6/ayUush9fz+cO012RtgK+dlU5I65pa9z8DwjQzPg8/KWdi
         POup39VAhx5X9FLj67ynSBBROaiUJy6mfyv14B8ytJSHsu8oyegMV31LRFxM5KIHW2MD
         LtqC/uDCnUZFF7MeaglVeoraDolKEOU9+ZfabndtKw4OG30ld8w7kdDxYW+HEOfUE3gH
         00wfxrgjTqaVlsvg8BPZRclzZ4Wl5I6TQg6fIlnBbhv4hma5C5rnsP+patQ65OBa50dx
         kID30+8AxlMk6qpOHyehES5BZusG3EIJQoP8vuUOkRf2IlMYAazY7oeB7ILIeXFlC/uv
         Hy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PWJ+NuAsW5s2vA9QgZOe3idm9eB7zTent9a3jd7JNg=;
        b=sagvaP2+uLflW0ec3fycuMq0pdOUWmqU2K1cq6VSDuBezDWXtZ8eyHc2irsxWIwkzC
         L2HrcakAZLuo4DSuVpR4ruwRVP9igymRM9ywdeNvUsruSCTdZZVwGUFJLgvfyymfEWLJ
         ldBSNeyjv18JnAEkoLZfD4ZxKOMcuNse0Mdo5mSnpnhq79IfQ37Mk0yMjF9nHAAMm+Jv
         qXNks20IIomWXEaN3gGyVMk8IYiYjgj6Fyu0ytZAiBVV2ygxB/FfsBh644RnO/woXih/
         i7/YyWN6r+Yn4eBKFsLeV1bufYJV8mSJrHS9l8IA6wyfaOzTXVlXDGRoz8YYY4ZPd6fI
         JNWA==
X-Gm-Message-State: AFqh2krvy8QTOPgsvgZaxfRX7tMPqSKYUtAw9KQhU8E+J7yJathnXnPU
        CRfFg++/Ybh8eWSReakm7lB/zHVcC1XhAtctsKX7qr/ENB1IwRmCm3M=
X-Google-Smtp-Source: AMrXdXssCl0Uj5PLOQtVkx80fJi3u/8BRvHwrBiWT4AjI58aL5N9ejGLNJozH3ngJ44Imka+1clKXIzihgVmkWRGXdQ=
X-Received: by 2002:a81:484f:0:b0:3ed:90d2:2ab8 with SMTP id
 v76-20020a81484f000000b003ed90d22ab8mr66459ywa.67.1672961039002; Thu, 05 Jan
 2023 15:23:59 -0800 (PST)
MIME-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com>
In-Reply-To: <20230104215415.1083526-1-calvinwan@google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 5 Jan 2023 15:23:48 -0800
Message-ID: <CAFySSZA6EnWJr8N_G2dtt8=PKL8qtJnnm65x0yzWXuTBFfj4cw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] submodule: parallelize diff
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the broken link to the previous versions. Looks like I had
some encoding issues with copy/paste. Here are the previous versions

v4: https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/
v3: https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/
v2: https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/
v1: https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/

On Wed, Jan 4, 2023 at 1:54 PM Calvin Wan <calvinwan@google.com> wrote:
>
> Original cover letter for context:
> https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/
>
> Thank you again everyone for the numerous reviews! For this reroll, I
> incorporated most of the feedback given, fixed a bug I found, and made
> some stylistic refactors. I also added a new patch at the end that swaps
> the serial implementation in is_submodule_modified for the new parallel
> one. While I had patch 6 originally smushed with the previous one,
> the diff came out not very reviewer friendly so it has been separated
> out.
>
> Changes since v4
>
> (Patch 1)
> The code in run-command.c that calls duplicate_output_fn has been
> cleaned up and no longer passes a separate strbuf for the output. It
> instead passes an offset that represents the starting point in the
> original strbuf.
>
> (Patch 5)
> Moved status parsing from status_duplicate_output to status_finish. In
> pp_buffer_stderr::run-command.c, output is gathered by strbuf_read_once
> which reads 8192 bytes at once so a longer status message would error
> out during status parsing since part of it would be cut off. Therefore,
> status parsing must happen at the end of the process rather than in
> duplicate_output_fn (and has subsequently been moved).
>
> (Patch 6)
> New patch swapping serial implementation in is_submodule_modified for
> the new parallel one.
>
> Calvin Wan (6):
>   run-command: add duplicate_output_fn to run_processes_parallel_opts
>   submodule: strbuf variable rename
>   submodule: move status parsing into function
>   diff-lib: refactor match_stat_with_submodule
>   diff-lib: parallelize run_diff_files for submodules
>   submodule: call parallel code from serial status
>
>  Documentation/config/submodule.txt |  12 ++
>  diff-lib.c                         | 104 ++++++++++--
>  run-command.c                      |  16 +-
>  run-command.h                      |  27 ++++
>  submodule.c                        | 250 ++++++++++++++++++++++-------
>  submodule.h                        |   9 ++
>  t/helper/test-run-command.c        |  21 +++
>  t/t0061-run-command.sh             |  39 +++++
>  t/t4027-diff-submodule.sh          |  19 +++
>  t/t7506-status-submodule.sh        |  19 +++
>  10 files changed, 441 insertions(+), 75 deletions(-)
>
> --
> 2.39.0.314.g84b9a713c41-goog
>
