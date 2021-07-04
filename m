Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12B1C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 05:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01E7613B1
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 05:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhGDF73 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 4 Jul 2021 01:59:29 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:47053 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDF73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 01:59:29 -0400
Received: by mail-ed1-f41.google.com with SMTP id s15so19212769edt.13
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 22:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v6TEEzzpS14AXnnSD7B9U2nRpA+eYf9DCux04WM7Rmg=;
        b=YJHE+ZXimDUPwYoOR5dsWu/cW43lA2Y0ZDKVA5NMZg/Hao8JJNcgNtCqXgE6P2kXZ9
         0oC2NwjbL1o0AYtYtha1pQVzdKotb2jGwsHSgXIWp5iDhgm15kuscHjLCh9jvLvLkAdx
         PGWaZT1g7C1Cq+nig+lwIUhQ1FBJ2s6gxJI639pzCjETz/RKi9TKMvofpRmoKgb1rEGz
         8sBqdKg/GH5ScnF9YsPln7w6Oa9ldvR3FK/ra3uW4eOQ06vtm/SED391rtku5J0wzpas
         AU74zz95/IjwA/Bcb/tWI6QcBj7CSeJJ9MCLYfiBHJ0VpvjOLMbmG11ogFz9Y6YQg0WN
         Ve6g==
X-Gm-Message-State: AOAM531KIpGPHwO8g4DEQ/bco+atLOAos8/zofHRjzLNSM32o29KUuvH
        RLQnaIGnWya7PHfuiFkN6VzwGqjywH4IjVt8/4k=
X-Google-Smtp-Source: ABdhPJwyOpQJULQE6ViEnckLrDSwLAgzCs5REq462rCS4DGCimYqAF+gFEazuKgsum1Rfo/9sMBHzugMBAbI9um8THE=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr8628485edu.221.1625378212298;
 Sat, 03 Jul 2021 22:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210615172038.28917-1-congdanhqx@gmail.com> <cover.1625362488.git.congdanhqx@gmail.com>
 <ab542ae9aa35decd2bc55561c5ba8f5653fa07a2.1625362489.git.congdanhqx@gmail.com>
In-Reply-To: <ab542ae9aa35decd2bc55561c5ba8f5653fa07a2.1625362489.git.congdanhqx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Jul 2021 01:56:41 -0400
Message-ID: <CAPig+cRNw_RVx3CCXN-Usz0Jmi0iphDv2Vqg1cZFqa+QricuJw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] test-lib-functions: introduce test_stdout_line_count
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 4, 2021 at 1:46 AM Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> In some tests, we're checking the number of lines in output of some
> commands, including but not limited to Git's command.
>
> We're doing the check by running those commands in the left side of
> a pipe, thus losing the exit status code of those commands. Meanwhile,
> we really want to check the exit status code of Git's command.
>
> Let's write the output of those commands to a temporary file, and use
> test_line_count separately in order to check exit status code of
> those commands properly.
>
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -845,6 +845,32 @@ test_line_count () {
> +# SYNOPSIS:
> +#      test_stdout_line_count <bin-ops> <value> <cmd> [<args>...]
> +#
> +# test_stdout_line_count checks that the output of a command has the number
> +# of lines it ought to. For example:
> +#
> +# test_stdout_line_count = 3 git ls-files -u
> +# test_stdout_line_count -gt 10 ls
> +test_stdout_line_count () {
> +       local ops val trashdir &&
> +       if test "$#" -le 3
> +       then
> +               BUG "expect 3 or more arguments"
> +       fi &&
> +       ops="$1" &&
> +       val="$2" &&
> +       shift 2 &&
> +       if ! trashdir="$(git rev-parse --git-dir)/trash"; then
> +               BUG "expect to be run inside a worktree"
> +       fi &&
> +       mkdir -p "$trashdir" &&
> +       "$@" >"$trashdir/output" &&
> +       test_line_count "$ops" "$val" "$trashdir/output"
> +}
> +
> +
>  test_file_size () {

Nit: one too many blank lines after the test body.

A minor think-out-loud: I wonder if there would be value in deriving
the name of the output file from the command being run (perhaps by
using `tr` to translate oddball characters to underscore or to fold
them out). This might or might not help someone debugging a test
failure since there would be less chance of "$trashdir/output" being
repeatedly clobbered. Anyhow, it's something that could be done later
if deemed useful, not something for the present series. (I'm not
interested in seeing this series re-rolled endlessly.)
