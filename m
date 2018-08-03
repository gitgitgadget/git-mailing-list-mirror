Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2E01F597
	for <e@80x24.org>; Fri,  3 Aug 2018 23:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbeHDBoq (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 21:44:46 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44816 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbeHDBoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 21:44:46 -0400
Received: by mail-yw1-f66.google.com with SMTP id l9-v6so1600234ywc.11
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 16:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHbAZnZzfG7u1e/qa2x31zIDMoA9HNNh4EBVP/EnhjI=;
        b=Ic2Fa/fTKA8O4cwpC0PHyPHFzs3LuYcAUdCmJInXzmLTeCry8EuAy0o/b0TiZKvKbz
         p3Lioi6iGCqHDDkuEpq/bBG/7/2nL1Ee5E7ti7hDhA4lkpKx+bFeYnUwT7+hOkQ6Rjah
         0IAp1JLudXcizGjIzpqf8TPWLa8yt5Fnt1gdRTH5WHTOe9VN2UiGGEg4G8ggAsbzoJhZ
         6H5+U4HMisTfhlv0o8Jg2Z5FDVvvuhBqZ4omgbC9JZA4YXS4JwWHPEDnbCXGgu1X8cyy
         +u4rPUFYNxjp9jrOFCpZ2+fNQA+95wa1tjpaz/rUHxIYCPbw9J0Lo7n5D5hUln5et2qW
         0tTQ==
X-Gm-Message-State: AOUpUlEknv7yU0kQLa8Zp2Un/fjbCtx4zCjo9uqUFkigRKClux3dS8wV
        v3hdFhSm5divWLK70IztPS5govp907snUUPCnBo=
X-Google-Smtp-Source: AAOMgpeB0P1nUsEs6Eb5wWW7GImSQJ53Vk6fpCn5np4OanwDznA77UgYB+I3GX/yFNhciA1x2E6exfeUdUOC/4KGbPA=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr3273637ywc.70.1533339634415;
 Fri, 03 Aug 2018 16:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180803231407.10662-1-newren@gmail.com>
In-Reply-To: <20180803231407.10662-1-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Aug 2018 19:40:22 -0400
Message-ID: <CAPig+cR75Q7HDipttU9dqtNjf23SYNJ98o=0-=JFtPgMMjFxHA@mail.gmail.com>
Subject: Re: [PATCH] t7406: Make a test_must_fail call fail for the right reason
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 7:14 PM Elijah Newren <newren@gmail.com> wrote:
> A test making use of test_must_fail was failing like this:
>   fatal: ambiguous argument '|': unknown revision or path not in the working tree.
> when the intent was to verify that a specific string was not found
> in the output of the git diff command, i.e. that grep returned
> non-zero.  Fix the test to do that.
> ---
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> @@ -599,7 +599,7 @@ test_expect_success 'submodule update - update=none in .git/config but --checkou
>          git diff --raw | grep "        submodule" &&
>          git submodule update --checkout &&
> -        test_must_fail git diff --raw \| grep "        submodule" &&
> +        git diff --raw | test_must_fail grep " submodule" &&

Unfortunately, this is a mis-use of test_must_fail() which is intended
only for Git commands; it does extra checking to ensure that the Git
command failed in a sane way (say, by returning a failing exit status)
rather than by crashing. It's not intended for use with system
commands which are assumed to be bug-free.

Having a Git command upstream of a pipe is also discouraged since the
pipe swallows its exit status, which means we won't know if the Git
command actually crashed. So, what you really want is this:

    git diff --raw >out &&
    ! grep "<literal-tab>" out &&

(where <literal-tab> is a literal TAB)

Since this script has a number of instances of Git commands upstream
pipes, it may not make sense to fix just this one. So, either a
preparatory cleanup patch could fix them all at once, and then this
patch could come on top or, if you don't want to fix all the pipe
cases, you could do this instead:

    ! git diff --raw | grep "<literal-tab>" &&
