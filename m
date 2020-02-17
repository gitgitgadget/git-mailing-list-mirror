Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0672EC34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D296A208C4
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgBQRYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:24:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33034 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgBQRYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:24:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so372311wmc.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 09:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCRZyktjx+L7QUBOJak3yqJIuimZzhigkYtTlnJeypY=;
        b=K7SyVW99mygspspr+xT0IelUG2MO2JfablKJN6LeIoHWw9Tlm/EQG++YIfY+u5bPzN
         vJw2jNf4jNBJNAmMieYWrzThBMwA7MqPD9m4JmZwos0hhJ7iUUllKfLc7UyRMKH2SnOH
         l+HDummLZIB8zYNyBFLZcbtaHY+zYpOYm4izsqSQdNqALMssKoyUFdpckvWdOAxVp+WF
         XogDnALbUGD7HovVdPygr0Xbt84TJYfxXPi5azQrIcFowHGJX4S4IZRWivlWt9llJeVZ
         t8DHrGfoql0TP+33R7jcVoXmuiEce3JaGzPT529ZYKqqi2Y5ng5V+nZNy/M3sWAL9B1n
         aRdg==
X-Gm-Message-State: APjAAAUsSEW5PfqCNudFpvd89uBD2HXN8xKdn/IYlIVD+WEgMHPKShyB
        EuEsInd73llAwjKkLTJ/aE2p/iBxFwMMEcgXMY4=
X-Google-Smtp-Source: APXvYqztdbaaf+b4X5vbx2ssZYn734SL1tw85XXVztGApr0VZvrLGrFIFpDBDyw2n9EObfQL5Z4y+z8CIHI1ZZilS7w=
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr88877wme.130.1581960252066;
 Mon, 17 Feb 2020 09:24:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.553.git.1581619239467.gitgitgadget@gmail.com> <pull.553.v2.git.1581956750001.gitgitgadget@gmail.com>
In-Reply-To: <pull.553.v2.git.1581956750001.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 17 Feb 2020 12:24:01 -0500
Message-ID: <CAPig+cQWMvBi4vkAFMjV7LWjKJudja08ZqVMNfLfALxbBfpzXg@mail.gmail.com>
Subject: Re: [PATCH v2] mingw: workaround for hangs when sending STDIN
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 11:26 AM Alexandr Miloslavskiy via
GitGitGadget <gitgitgadget@gmail.com> wrote:
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> +test_expect_success 'stash handles large files' '
> +       x=0123456789abcde\n && # 16

Did you intend for the \n in this assignment to be a literal newline?
Every shell with which I tested treats it instead as an escaped 'n'.

> +       x=$x$x$x$x$x$x$x$x  && # 128
> +       x=$x$x$x$x$x$x$x$x  && # 1k
> +       x=$x$x$x$x$x$x$x$x  && # 8k
> +       x=$x$x$x$x$x$x$x$x  && # 64k
> +       x=$x$x$x$x$x$x$x$x  && # 512k
> +       x=$x$x$x$x$x$x$x$x  && # 4m
> +       x=$x$x              && # 8m
> +       echo $x >large_file.txt &&
> +       unset x             && # release memory

By the way, are the embedded newlines actually important to the test
itself, or are they just for human consumption if the test fails? I
ask because I was curious about how other tests create large files,
and found that a mechanism similar to your original (but without the
pitfalls) has been used. For instance, t1050-large.sh uses:

    printf "%2000000s" X >large1 &&

which is plenty portable and (presumably) doesn't have such demanding
memory consumption.
