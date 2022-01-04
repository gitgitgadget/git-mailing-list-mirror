Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3375C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiADMh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiADMh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:37:27 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B8AC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 04:37:27 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d201so83714983ybc.7
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 04:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=i+i1w2WqwrA336TWSsfzaVe49TTpk041lxYz30HKDUM=;
        b=ZTEynDL1iHsVvz0f/3Iwu6S0LJLtl5uirhJf20iPBduULSGKNqLi0OW8QjXi11HJuQ
         ztYKZhE/4asHV8+pUbRmtXPdsPrsU6ncSReiQ5mgjDHY3z88ugRie30RGH1pfsWt9qdN
         E8KcvkvLozZ+BcHQaUEmKTnAv5WTpi2Z5GXqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i+i1w2WqwrA336TWSsfzaVe49TTpk041lxYz30HKDUM=;
        b=PnHLgfN4c8de+gZQmifrr4nYVDUOQRArR6B7cp/4mlne+9Iy2/axD2GI9sWNkQvK5A
         2kDcSTnlY2bdX7fQX2a7Vokbu/AljYBtJLXtYYYdHmoD0zqd8gtPebxCsqZV9d23Po3G
         Z5a433jAOtqre1UfM8jkZwIMLjEs9LXSy2T1x+eZ5pe2LhzEJWCuBhusHwsqempxuOeU
         w1QlsqS+WCihtjNN9RrA9pmYo0UUxtLvda7XP48uANld+vOAVojf3Y4ZdhmKlz9cRjFN
         MZWjl+x+xuzq36U5v8DT9QSCnvJnBYJdCLYSQ0DnjZl+P2Pqd4acNMHQVFK+CeeNVNBS
         hzRw==
X-Gm-Message-State: AOAM5323V5WiVjaMNxzXyKU8eUKuA5nkq/QsVCkDUAgRReaH36WpKMky
        +WPUwpJHuq/+tqU3+944YeYq7vVnbj3UaBtdQ9qJzemlyv7KuA==
X-Google-Smtp-Source: ABdhPJwzY16oOBTiKxMc92JkHQPjCozAIQPtSFdlwCrfirSz3K9CCz5F/fRFXpxaZCzIzsEXhPld8mye904/j4SluKc=
X-Received: by 2002:a25:cecc:: with SMTP id x195mr54723700ybe.485.1641299846232;
 Tue, 04 Jan 2022 04:37:26 -0800 (PST)
MIME-Version: 1.0
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Tue, 4 Jan 2022 12:36:50 +0000
Message-ID: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
Subject: Bug using `fetch` with blank `-c` arguments to git
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While investigating some issues with a different project, I discovered
the command `git -c config.helper= fetch` was working with the Debian
stable version of Git (v2.30.2) but not with my local build
(v2.34.1.428.gdcc0cd074f).

Specifically, I see the following output:

$ ./git -c credential.helper= fetch
error: bogus format in GIT_CONFIG_PARAMETERS
fatal: unable to parse command-line config

Investigating with `git bisect`, the change in behaviour seems to have
been introduced in 1ff21c05ba ("config: store "git -c" variables using
more robust format", 2021-01-12).

I see the same behaviour with `-c config.helper=`, `-c
core.autocrlf=`, `-c core.autocrlf` and `-c core.autocrlf=true`..
Notably the behaviour does not affect all other git commands; `git -c
core.autocrlf= log -1` works as expected.

I think this is a regression; I can't see any reason why these
commands shouldn't work.

Curiously, I'm seeing this behaviour on both my Raspberry Pi OS and
Debian Bullseye systems, but not my Cygwin systems. I've not yet tried
to work out what the difference is there. In all cases, I was testing
with my own build, built with `make -j<num> configure && ./configure
--prefix=$HOME/.local && make -j<num>`.
