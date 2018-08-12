Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12C21F404
	for <e@80x24.org>; Sun, 12 Aug 2018 06:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeHLIy4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 04:54:56 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43198 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeHLIy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 04:54:56 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so11477984ywb.10
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 23:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAJKicUXSnatblrPtZJrB93c8sPac3Mx9ELEubnTg0s=;
        b=ROtxwCyw/lVmqRnNUocQ8T5rj4hGGrlvv8/Cw97ufmZ7bdiNHpvs54pjyYL0GP5O27
         UfhfbFnAUDnNrC9yAX/AtBkeir3qTZZ0AP/p1tHVJHmwbmHr/XUMS/g/1qBniab8uW/7
         cKSlUuHYOM21BbRthBDkWakrVqxKD+DIC1NJD5ezvm0X5WcS8J8p1wUZVJoaUT/urzjq
         IJGtcWWsalXwxU1doFzHfcRInv2rNGmdn3ZjRCVo5o6EqdKJrE1larEFEJbFLSQyT8Uv
         oswMGJvszQ6tEamVm/erXCnQeAZJwj0H45c9ivfPWId2CTyH3Dvfd3b+lIXdnERiOXrS
         rZ3w==
X-Gm-Message-State: AOUpUlFiUpQ/qhMFC34IIpDdpUTKk1PkCtT7DBBDO/HtwhmRKRgj6pWr
        8RJDHb5rdJuPzAz43FgGPsHkBWaPicCpLzm+538=
X-Google-Smtp-Source: AA+uWPwixXUtjsdHLv7yx6GL6PylOC4AsojhOXkfpfncFH2ETyE4kB8PyLLOxB2OV23sgihldVXEECVeiERlL32HgYo=
X-Received: by 2002:a25:5bd7:: with SMTP id p206-v6mr6529254ybb.287.1534054683954;
 Sat, 11 Aug 2018 23:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cQK7JSosa0hNhgw7xoSui2f0m6yfRLWytsg_Zow3bN5bg@mail.gmail.com>
 <20180812040620.15298-1-wchargin@gmail.com>
In-Reply-To: <20180812040620.15298-1-wchargin@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Aug 2018 02:17:52 -0400
Message-ID: <CAPig+cTca5YsXeXYbEEuq8Y_GraUYWwzdKO7r+PR9=JRTR_xFA@mail.gmail.com>
Subject: Re: [PATCH v3] test_dir_is_empty: properly detect files with newline
 in name
To:     William Chargin <wchargin@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 12, 2018 at 12:07 AM William Chargin <wchargin@gmail.com> wrote:
> While the `test_dir_is_empty` function appears correct in most normal
> use cases, it can fail when filenames contain newlines. This patch
> changes the implementation to check that the output of `ls -a` has at
> most two lines (for `.` and `..`), which should be better behaved.
>
> The newly added unit test fails before this change and passes after it.
>
> Signed-off-by: William Chargin <wchargin@gmail.com>
> ---
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> @@ -821,6 +821,37 @@ test_expect_success 'tests clean up even on failures' "
> +test_expect_success FUNNYNAMES \
> +       'test_dir_is_empty behaves even in pathological cases' "
> +       test_expect_success 'should fail with a normal filename' '
> +               mkdir nonempty_dir &&
> +               touch nonempty_dir/some_file &&

We usually avoid "touch" unless the timestamp of the file is
significant. In this case, it isn't, so it would be more idiomatic to
say simply:

    >nonempty_dir/some_file &&

> +               test_must_fail test_dir_is_empty nonempty_dir

This is an abuse of test_must_fail() which is intended strictly for
testing 'git' invocations which might fail for reasons other than the
expected one (for instance, git might crash). Instead, you should just
use '!', like this:

    ! test_dir_is_empty nonempty_dir

> +       test_expect_success 'should fail with dot-newline-dot filename' '
> +               mkdir pathological_dir &&
> +               touch \"pathological_dir/.
> +       .\" &&
> +               test_must_fail test_dir_is_empty pathological_dir

Same comments as above.
