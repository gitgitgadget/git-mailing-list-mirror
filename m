Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D91B1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 20:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeIXCqr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Sep 2018 22:46:47 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:42568 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIXCqr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 22:46:47 -0400
Received: by mail-qt1-f173.google.com with SMTP id z8-v6so7104811qto.9
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 13:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+GxNHW07PzmFmBu+FUlQiRVZ0O2F0WDqHCFidlts4z8=;
        b=TEJdmn1bFifgB5oW7vioNfXo2UMRSyi2AyvpXh8CF9JnlnOPVLwdYkjxnAaTWvCvAJ
         MHvbvuQPQk4lT0uJGsYVDC0QH9W6Ii3HTqXf0Xiolf+p+GqraKEemeJ0JU4URLaI0Ym1
         PlhaLl1mYJL8Jcg9g5QZCp7VtWVKgJdozEd1R00fCZ8/Rc2YFJk6vqk3KtHGGxpMVPkA
         o8+4Ljj4qhsiX+z11DmuhLkmOx6hWdFK3uk5TziTYGFdGrzhBlq+PREuWJoUD3d/hU0g
         egoMHV/UOF/hq7dMv+sahoWgNACB/yAE5tHV1gyACEASeMQmgMhx1tU8XDb2ZCv2Wi/c
         t14A==
X-Gm-Message-State: ABuFfogvhqXBNoMPB9XdQ6+mD1axK8pnEwsPx6O+Qf12pjM4ms1RGYJk
        eMg3euZz/4SlMHEaCOWfwoHYKjWAh0JVq8BOKMg=
X-Google-Smtp-Source: ACcGV627nifyOnRV11SN/DHhGmS9PBm1b13WCUOyMpXPPd5beTF7NxRXKUF2ZO+yyVawxinrmK/aV0pXCFLQ3oxqGdo=
X-Received: by 2002:a0c:964a:: with SMTP id 10-v6mr4220588qvy.62.1537735675694;
 Sun, 23 Sep 2018 13:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com>
In-Reply-To: <20180923170438.23610-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 23 Sep 2018 16:47:44 -0400
Message-ID: <CAPig+cR4d3p=PoLAC=0Pss64tBa1eVq3Zz2a70spmc6Vb=cUdw@mail.gmail.com>
Subject: Re: [PATCH] worktree: add per-worktree config files
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 1:04 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> A new repo extension is added, worktreeConfig. When it is present:
>
>  - Repository config reading by default includes $GIT_DIR/config _and_
>    $GIT_DIR/config.worktree. "config" file remains shared in multiple
>    worktree setup.
>
>  - The special treatment for core.bare and core.worktree, to stay
>    effective only in main worktree, is gone. These config files are
>    supposed to be in config.worktree.

"These config _settings_ are supposed to be..."

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -2,8 +2,9 @@ CONFIGURATION FILE
>  The Git configuration file contains a number of variables that affect
> -the Git commands' behavior. The `.git/config` file in each repository
> -is used to store the configuration for that repository, and
> +the Git commands' behavior. The files `.git/config` and optionally
> +`config.worktree` (see `extensions.worktreeConfig` below) are each

s/are/in/

> +repository is used to store the configuration for that repository, and
>  `$HOME/.gitconfig` is used to store a per-user configuration as
> diff --git a/t/t2029-worktree-config.sh b/t/t2029-worktree-config.sh
> @@ -0,0 +1,82 @@
> +cmp_config() {
> +       if [ "$1" = "-C" ]; then

Style:

    if test "$1" = "-C"
    then
        ...

> +}
> +
> +test_expect_success 'setup' '
> +       test_commit start &&
> +       git config --worktree per.worktree is-ok &&

Did you want:

    cmp_config false extensions.worktreeConfig

at this point in the test or something? It's not clear what the
intention is here.

> +       git worktree add wt1 &&
> +       git worktree add wt2 &&
> +       git config --worktree per.worktree is-ok &&
> +       cmp_config true extensions.worktreeConfig
> +'
> +test_expect_success 'core.bare no longer for main only' '
> +       git config core.bare true &&
> +       cmp_config true core.bare &&
> +       cmp_config -C wt1 true core.bare &&
> +       cmp_config -C wt2 true core.bare &&
> +       git config --unset core.bare

Should this be?

    test_when_finished "git config --unset core.bare" &&

or perhaps test_config()?

> +'
