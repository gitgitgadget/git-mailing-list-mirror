Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B2C433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 05:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC0F208A9
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 05:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgH2Esn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 00:48:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39890 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgH2Esn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 00:48:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6028A1F66E;
        Sat, 29 Aug 2020 04:48:42 +0000 (UTC)
Date:   Sat, 29 Aug 2020 04:48:42 +0000
From:   Eric Wong <e@yhbt.net>
To:     Ivan Baldo <ibaldo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fastest way to set files date and time to latest commit time of
 each one
Message-ID: <20200829044842.GA5732@dcvr>
References: <CAEbcw=3mOoYuJo2mQgqB2aJgn-D2i_7ZRmhfPvYNVHD1Kp8wuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEbcw=3mOoYuJo2mQgqB2aJgn-D2i_7ZRmhfPvYNVHD1Kp8wuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ivan Baldo <ibaldo@gmail.com> wrote:
>   Hello.
>   I know this is not standard usage of git, but I need a way to have
> more stable dates and times in the files in order to avoid rsync
> checksumming.
>   So I found this
> https://stackoverflow.com/questions/2179722/checking-out-old-file-with-original-create-modified-timestamps/2179876#2179876
> and modified it a bit to run in CentOS 7:
> 
> IFS="
> "
> for FILE in $(git ls-files -z | tr '\0' '\n')
> do
>     TIME=$(git log --pretty=format:%cd -n 1 --date=iso -- "$FILE")
>     touch -c -m -d "$TIME" "$FILE"
> done
> 
>   Unfortunately it takes ages for a 84k files repo.
>   I see the CPU usage is dominated by the git log command.

running git log for each file isn't necessary.

On Debian, rsync actually ships the `git-set-file-times' script
in /usr/share/doc/rsync/scripts/ which only runs `git log' once
and parses it.

You can also get my (original) version from:
https://yhbt.net/git-set-file-times

>   I know a way I could use to split the work for all the CPU threads
> but anyway, I would like to know if you guys and girls know of a
> faster way to do this.

Much of your overhead is going to be from process spawning.
My Perl version reduces that significantly.

I haven't tried it with 84K files, but it'll have to keep all
those filenames in memory.  I'm not sure if parallelizing
utime() syscalls is worth it, either; maybe it helps on SSD
more than HDD.
