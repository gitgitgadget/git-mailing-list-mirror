Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DF3C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 07:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhLKHOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 02:14:55 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:45888 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKHOz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 02:14:55 -0500
Received: by mail-pl1-f178.google.com with SMTP id b11so7705354pld.12
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKO5qscbXG68SxuP9w8ifgTWydiSWS5wLmh4ydU+TPA=;
        b=2UN0+db6IxYfuAQSgCJRpqThY9PRHRQ566xw1XcDJct68KlrWHRfcASajI78Mor006
         vmrakHmGKCWH5R0wvQnqfTVdKgXCg291urXespy3OzSEkNmWmSdSFp35YbDrtgEJ1Jhs
         uUPCG8uTaoVMF9THgfBMYNiz37YZII6BauDDM8u5kMqGjV4q6Veirw73NL63/kmA6oVX
         ObLb3ZXAZCSgVvsK4QHN5K2hwiCdfXfzVP4KX58BsCr1c25ZuTm6+eWJ2YyszT6d/i8L
         rxNDS9qcoyIl2sH74SVN8Lps8B4dZH8bpVFxPrCW8X1O4TUW1YTifTVyU6CdzkolIdyg
         GFwA==
X-Gm-Message-State: AOAM532FKDYJKZ3kcvZqDufh/OnCMjS9OG0yi3WbsNjpuRIvTth6OjCV
        i0IEGJaq9CKlasDGKM+U8NEZHWi+oRSQtgpetjkB5xjT+wMdJw==
X-Google-Smtp-Source: ABdhPJyTsJDPVXDUCD6o4ozEfQomuBuLeqxCe5SQ0dT5y7lGT75UBsdj7MAHQA9xAu/Hnux6IOm3fD/s0p5CrGopNKY=
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr29357411pjq.104.1639206894462;
 Fri, 10 Dec 2021 23:14:54 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-13-sunshine@sunshineco.com> <YbMd4cuRs9aiPWbX@coredump.intra.peff.net>
In-Reply-To: <YbMd4cuRs9aiPWbX@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Dec 2021 02:14:43 -0500
Message-ID: <CAPig+cQ98aac8die8Sw8cnu9rN=ciMW91QO51mVtcNS=boQtsw@mail.gmail.com>
Subject: Re: [PATCH 12/19] tests: fix broken &&-chains in `{...}` groups
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 4:29 AM Jeff King <peff@peff.net> wrote:
> On Thu, Dec 09, 2021 at 12:11:08AM -0500, Eric Sunshine wrote:
> > Fix broken &&-chains in `{...}` groups in order to reduce the number of
> > possible lurking bugs.
>
> Seems good. This is mostly stuff we don't expect to fail (mostly
> "echo"), so I doubt they're important on their own. But getting a clean
> state for the linter _is_ important.

In this patch, I think the only &&-chain which really matters (i.e.
could hide a genuine failure if broken) is t5515-fetch-merge-logic.sh.
Aside from most of these being unlikely to fail (`echo`), most of the
exit codes are being lost down pipes anyhow. As such, I had a hard
time justifying this patch since it exists mostly to satisfy the
linter which isn't smart enough to distinguish between the cases. What
ultimately convinced me that this patch was worthwhile was (1) that
there are legitimate cases, such as t5515-fetch-merge-logic.sh, where
we really do want to be told about the broken &&-chain, and (2) that
it's easier to have a single simple rule which we can point test
authors at ("chain all your test commands with `&&`") rather than
complex rules laying out cases when you do and don't need to maintain
the &&-chain.
