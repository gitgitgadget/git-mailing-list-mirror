Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE7CC433DF
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3036D206F6
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgGZXzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:55:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40087 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGZXzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 19:55:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so2531444wrc.7
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 16:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP7tG/ya/Bwxcbwaz6Bhj3dxdP3oiC25CA8PRxUh45w=;
        b=Q4yuPFMw7Z+QBH6QIvIDiogFTqyzrjQaW1DsCw7hcwUUIBncHjpIfHL107tGGTDWId
         g9KO9XBAAV7OnF8UTbAKkw+SYTLV6ZF13j8raHtmcnOEc5mxpAyPLnsE/iobdVn4PjqN
         1avRJDVEDO+WnjMPd86XiPLa0Wh6XYDDBMo7Uv6v3ZJXsJkav4fqOxsgx6o3Mo3QVICn
         aRW7jQ7/GAQGIJ96yUnNEJwTuHEKxho3MmXzb1EM7qkTzAiuB2ZuCG9kyyqKeRK9GZfn
         MnwYGzBcgf92JmILEU55/mvLqCFVpr/Fz0nxtv4ZhJjCIaFYIRzzXvKRu9v7rtQTPkxa
         QhdQ==
X-Gm-Message-State: AOAM5328X5Vxr2QwRKAdohW2tgxO5HLyIl0w+yNYD8SxW3+FMr/IIRr2
        DEdg1ByedVEM8OdEZVyudVcSJllJH1xM6wKfza1Wt9eo5PE=
X-Google-Smtp-Source: ABdhPJyNdxsBNOy8bEgejBvPMk/lAHAyvDMObP0uXHRXgRdtSwPNQ+pJW9X0xwOgNfJ7RpiMY0k9MsZpE9liPKW8wXU=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr9811070wrv.120.1595807705198;
 Sun, 26 Jul 2020 16:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-38-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-38-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 19:54:54 -0400
Message-ID: <CAPig+cTD6yjqj9Mpte2zdFNXhJSk9Ju01SZYyptBCsSb9cxakA@mail.gmail.com>
Subject: Re: [PATCH v4 37/39] ci: run tests with SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:56 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Now that we have Git supporting SHA-256, we'd like to make sure that we
> don't regress that state.  Unfortunately, it's easy to do so, so to
> help, let's add code to run one of our CI jobs with SHA-256 as the
> default hash.  This will help us detect any problems that may occur.
>
> We pick the linux-clang job because it's relatively fast and the
> linux-gcc job already runs the testsuite twice.  We want our tests to
> run as fast as possible, so we wouldn't want to add a third run to the
> linux-gcc job.  To make sure we properly exercise the code, let's run
> the tests in the default mode (SHA-1) first and then run a second time
> with SHA-256.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> @@ -24,6 +24,11 @@ linux-gcc)
> +linux-clang)
> +       make test
> +       export GIT_TEST_DEFAULT_HASH=sha256
> +       make test
> +       ;;

If the default someday flips from sha1 to sha256, then this will
merely run the entire test suite twice with SHA-256. Perhaps it could
be more explicit like this:

    export GIT_TEST_DEFAULT_HASH=sha1
    make test
    export GIT_TEST_DEFAULT_HASH=sha256
    make test
