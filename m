Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E633DC2D0A8
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 05:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB296206B5
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 05:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgI3FdZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 30 Sep 2020 01:33:25 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:44482 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3FdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 01:33:25 -0400
Received: by mail-ej1-f41.google.com with SMTP id a3so160052ejy.11
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 22:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iEZZL2MRjVZPuStt76xGYNrFfSDRvVzAJnPU+7WOHWk=;
        b=tYXNc7dTDFyP2Qlf8aSp24kRQNA1gIs3PrpwjzBQPuntU1U6lP8iBxeU1CJVW3LB0L
         N8RtSXyuCslMB6MaUipWXOeNI6NeLDF15/FP3NSgOlZ4N7zr8f1h9P+dDn9AmwxtMQNC
         QBuD3/1XYBnHjOwdvw/oi5LBhEM/bGIv6OQ2PA14zZSIAZUKsR/GOl4GDpssPtBzXFDt
         9vHVkn7hKs/GPP428klDviclfILFUNfQH/2QOMKL9Ue8sxVOFlo6tRbnbDNs4clNwcC1
         zbYK50EL9vZmX+4qHzSRpH+v37moiMzNBYEXy0dpAZ6yjakZQSqhddVDX4O1eUwg3LR0
         pTgA==
X-Gm-Message-State: AOAM532lR43cEW8iXDql0K0htH7+LIGvKRKay9wCUn+HnK3943k+zC6N
        drJq3IE/M8zLYtDEBuSDpx2PjQLu89jHaSUhIao=
X-Google-Smtp-Source: ABdhPJwbcSn5aEMF6eK1p+rRnswR0DK+9dkZ65h4Gv+NIbEkgli+Soy4iz2WMJaf+6lMxn0X/Lutn+AJfAYn4TOEBEA=
X-Received: by 2002:a17:907:43c3:: with SMTP id i3mr145902ejs.231.1601444002006;
 Tue, 29 Sep 2020 22:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAA9rTudStQOK7kRa6jYJHE3D3grnFF3idQe65h9t6oJB30xa1A@mail.gmail.com>
In-Reply-To: <CAA9rTudStQOK7kRa6jYJHE3D3grnFF3idQe65h9t6oJB30xa1A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Sep 2020 01:33:11 -0400
Message-ID: <CAPig+cTwNwt+_f4FYDqy5xVsDVU3pqfKXtK6GKtWLLqbU6Y8Vg@mail.gmail.com>
Subject: Re: GIT_DIR output from git worktree list
To:     =?UTF-8?Q?Gabriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 29, 2020 at 1:31 PM Gabriel Nützi <gnuetzi@gmail.com> wrote:
> When you do move the .git folder somewhere else:
>
> git init Test && cd Test && mv .git .git-b
> git --git-dir=.git-b --work-tree . worktree list
>
> the output is :
> ..../Test/.git-b  0000000 [master]
>
> Why is the output a .git Dir and not a worktree. I expected `.../Test`.

Because the implementation doesn't really look for or know where the
main worktree is. Instead, it's taking the path of the repository and
stripping off "/.git" if present, and reporting that as the main
worktree. Under normal circumstances this works just fine because
either (a) the repository _is_ the .git directory within the main
worktree, or (b) it's a bare repository and there is no main worktree,
thus it reports the repository path instead of the non-existent main
worktree.

I suppose one way to fix this would be to specially check if
--work-tree or GIT_WORK_TREE is specified and use that value as the
path of the main worktree. (This special case would only be used when
computing the main worktree path; it would not be used when computing
linked worktree paths.)
