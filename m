Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3352EC636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 22:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBAW4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBAW4v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 17:56:51 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B00465F23
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 14:56:50 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id x139so1673429ybe.13
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 14:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8oBgwRXjOJFiuadkonl7SJKxrjhtqJf0/H6FzcNPSvA=;
        b=fWCEJ81j6X2OKeOJ1PJ5poX6ySQ7d9XmEM1uMhJmGz5iqe2dA6FjnNNp0yaUhUi33m
         X+T3Wr1B2X3yZrw7as2U/FKOEzsanrJ1cmO9rNWDllBCUD0dp/r+VKxr9tuC7ZLqMMlh
         33RFCODr3IzRc7JfeRt+OZ9PAoSaxfaZblS9krKwdfiVL+FNYSQJaZSFDQ30TzpYMsBT
         ZacwxAtVjf/X8xErHEzlMTt5X5PzyhznxAUxpDMxV1WXyJP2QAEm91PaddSlJxLMfj0s
         AcYfJVaiBJfTYnuh/uBx+H7KnwtCpv50PSyvV/DkcLeQPSPcRxQcsBNuXqy178oNZqWK
         /F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8oBgwRXjOJFiuadkonl7SJKxrjhtqJf0/H6FzcNPSvA=;
        b=M7baIvB9Wk12lhDOZWFPhy120kvrey8ARqERuC5ZOU0bapa6MCMtfaobPZiZc9QdW6
         x07mgE7E482A8lGTfoVZfd9S0RA55SiFs1G6tbnR4kktzkE+p6qKfkJoUBsmRtbzoDXA
         KuNrpoowjhjow6y26KZODbww99HUmLLk1/Qu5m/Xh0ayiFv2PesHW/Gf1WwlaoXNyqL2
         2BbnRU4vn4FjOIzj6QaLk4aH2NUsj0PEIeE0hzfxD94p0J993NjKEavCJAsMKhC2i76l
         r19WNEL/iZ7LDvAapOljSPsn0sb2QAj/yWXHXcCcfYfkOYRI4GJv7KZvafF6wQd8nMPK
         Ylyw==
X-Gm-Message-State: AO0yUKUbZnY1AYrAe4RzKbq2srJpZXsXpgROYTogIH9vSOqTd93qoGEN
        Lw89MQx/MUznAwUecgeZcJ7n9R7yg5GPR1iFz1jpQxp+ltc=
X-Google-Smtp-Source: AK7set+GuTkYNjbHwkOzFpcCDeMiv4qjAg5rwjTnKA7j4xfmWAIGN3z9kH6XEJ710/a05BPTvcsZee+QUHsU9BPaK9w=
X-Received: by 2002:a25:f449:0:b0:7dc:7cf:3ba7 with SMTP id
 p9-20020a25f449000000b007dc07cf3ba7mr491132ybe.333.1675292209257; Wed, 01 Feb
 2023 14:56:49 -0800 (PST)
MIME-Version: 1.0
From:   Palaniappan Nagarajan <palaniappan.feb22@gmail.com>
Date:   Wed, 1 Feb 2023 14:56:37 -0800
Message-ID: <CAPsey7=9y=j3s1gmO5sFbZXfD_X9osEJ8i-x=SdRM0e27Pbtpg@mail.gmail.com>
Subject: [Help][Bug] Git pull fails while pulling large commits on FUSE based filesystem
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Community,
We have a peculiar environment: We use git repository on a directory
mounted using s3-fuse(https://github.com/s3fs-fuse/s3fs-fuse). The
directory is backed up to the Amazon S3 bucket. Whenever we try to run
`git pull` that could pull in *large commits*, we are facing the
following error.

$ git pull origin main
remote: Enumerating objects: 102, done.
remote: Counting objects: 100% (102/102), done.
remote: Compressing objects: 100% (101/101), done.
remote: Total 102 (delta 1), reused 102 (delta 1), pack-reused 0
Receiving objects: 100% (102/102), 72.24 MiB | 15.48 MiB/s, done.
Resolving deltas: 100% (1/1), completed with 1 local object.
fatal: Failed to checksum '.git/objects/pack/tmp_pack_VvTvzo': No such
file or directory
fatal: fetch-pack: invalid index-pack output

I can confirm that the file '.git/objects/pack/tmp_pack_XXXXX' is
present once the command completes. In the S3 fuse logs, I see that
the file is read before the file is created.

The issue happens only during `git pull` and `git clone` with the
large commits works without any issues.

Can anyone help with any pointers/ workaround/ potential solution to
fix this issue? Is there a way to override the location of temporary
files "tmp_pack_XXXXX" files so that it can be created outside the
mount directory? Setting the object directory outside the mount
directory using GIT_OBJECT_DIRECTORY is not an option as we want to
backup git history.

P.S. My experiment that could throw some light on the issue.
1. Created a Git repository with 1000 files of 1 MB.
(https://github.com/cyn0/2kfiles-large)
2. Git clone on the mounted directory works without any issue.
3. Added 5 files of each 1MB size to the repository.
(https://github.com/cyn0/2kfiles-large/commit/42aa5d83e9035460ffa9c3b2f4494c0828f6b1c7)
4. From the mounted directory, "git pull origin main" works without any size.
5. Now, add 100 files of each 1MB to the repository.
(https://github.com/cyn0/2kfiles-large/commit/7304886116d9bdec8a8c2da020776995a6624bd2)
6. From the mounted directory, "git pull origin main" fails with the
above error.

Thanks in advance for your help!

Regards,
Palaniappan
