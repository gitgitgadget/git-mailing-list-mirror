Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7ADC433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67558611CB
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhEESWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:22:49 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:37876 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhEESWs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:22:48 -0400
Received: by mail-ej1-f44.google.com with SMTP id w3so4329776ejc.4
        for <git@vger.kernel.org>; Wed, 05 May 2021 11:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuOcqKX5+cOo/wmMn7WmEyGiudb8rWgc8HYhhiMg4cs=;
        b=YLagKn6aqVPqrT7b8u3FNts3+VkxF1Mz7UlhP90bIG4u/arJcwsCzcWr+7XMLs9j7V
         WamofPTbdwSdKXX9jrnrxVUtz/yp64itqa8YsnpRELQ2Mh8iVN1jV0Kq2e9WXRa4+bsc
         Q2hwBX9o4A/iR/yUlX1tvwkQehlpll94XeUyN1SgB4KSpe2FTW3yXzxbwRsH0WG2WYYF
         HJQA6WEQMxAsbQDjH7X0WTVksaH6qaqrJONVriHpzN5rMtr6Gp95a1s+brFINx7fJw60
         nySzvta9kBZXHRE7KU/SyXB7aQmbrxRK8nqBmALDUxfspWwFXfqtsZKr9jRQldAKRr78
         syMQ==
X-Gm-Message-State: AOAM5309DCfIPPic2jlX80uQMJHlHeaNG4iEScv5u6ZLjqjstNNjeMHX
        1XCeIKoA1nKVVLyKPbbgs3VM9d5lvtW5uaV1jjw=
X-Google-Smtp-Source: ABdhPJz5FRV5V9BGSeAChvV+hoMEajSeioCYsIBBYYX0+RNqzYE7zaIClh2SHl1q2EAAvgrrJBQFHV+lEjKtCDWSRnE=
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr116458ejd.168.1620238910416;
 Wed, 05 May 2021 11:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
 <YJLgmXS/fJm1BQb4@coredump.intra.peff.net>
In-Reply-To: <YJLgmXS/fJm1BQb4@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 May 2021 14:21:38 -0400
Message-ID: <CAPig+cTX179z5MrTvSmgYGzZdc4xz=2G_ffHsyVOXsKVHrL93w@mail.gmail.com>
Subject: Re: BUG: Git path --config doesn't work with ~ symbol
To:     Jeff King <peff@peff.net>
Cc:     Theodor Negrescu <theodor.negrescu@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 5, 2021 at 2:14 PM Jeff King <peff@peff.net> wrote:
> On Wed, May 05, 2021 at 09:06:12PM +0300, Theodor Negrescu wrote:
> > I ran the command "git config --file ~/git-settings/.gitconfig -l"
> > (git-settings is a repo where I keep my config, the global one is just
> > an include)
>
> I don't think this is a bug in git-config. It is generally the shell
> that is responsible for expanding "~" and passing along the result to
> commands. E.g.:
>
>   $ strace -e execve git config --file ~/foo --list
>   execve("/home/peff/local/git/current/bin/git", ["git", "config", "--file", "/home/peff/foo", "--list"], 0x7ffc10a88130 /* 55 vars */) = 0
>
> I'd guess this might be related to Windows somehow. Are you entering the
> command in a bash shell, or via some other mechanism?

Is OPT_FILENAME supposed to handle tilde-expansion? I ask because
git-config is using OPT_STRING for this option, whereas other commands
use OPT_FILENAME for their `--file` options.
