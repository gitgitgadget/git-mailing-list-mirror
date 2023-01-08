Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595B1C53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 06:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAHGdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 01:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAHGdF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 01:33:05 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DF1C76E
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 22:33:04 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id a184so3948187pfa.9
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 22:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKhPC7GrV999/Ut+oeExezhMG2ZY7tDJH6U0znI+6jg=;
        b=pc5GM/8tFdBmW2c4Xu2UJApBNUGuL7O2yCVMQi8/UG1nfRnMeCOfLju/iXxVZ81KNL
         s5LGS+675GUZmEU9T74wPccUeaAgZ4cmhPgGeC0HfTqfIMSGv6TNd26KpcT2K/G/bbnC
         YUevVAHppJHS+uSDR5GGwhilLz28r94jWCunXlPcD1xi5/1i3zDOMf1rCopuY9iRmzS+
         xssdapVhc0wry3OlkVQ8E2tUWlpPwYCeLds9dTm+qC/uAuivIMttWlxpbg+oyO49p+4Q
         SkjAni6FN46DaOjhzX+c95wKM7kX7EBleOWkqNQSdF1dJuQsu35KJUiFO96nXWo9m8mz
         nLCA==
X-Gm-Message-State: AFqh2kouNfzs8WiwfiLp/UfvAeQucWK4xjoEQajRs4jFZwblUntqvGT9
        h3MCtwSwU2EV6aA8ohlWOiIs3iCxx9RtTmaVPEsxJ9i8drM=
X-Google-Smtp-Source: AMrXdXt6CVS55YDsdVuS2Fql9c9tJck/WwoKtOUp2dh3nBEUUPKz/OtZdPzqhIdmKS0Mq77nfBxU7P9g8GOHwySeurE=
X-Received: by 2002:a05:6a00:1414:b0:580:e5ef:79f2 with SMTP id
 l20-20020a056a00141400b00580e5ef79f2mr2981211pfu.60.1673159583316; Sat, 07
 Jan 2023 22:33:03 -0800 (PST)
MIME-Version: 1.0
References: <CAC-j02OVoFDFjeGUjcs0ZMwPSXKLL_GBme2m2-ttzGTbxXNP-w@mail.gmail.com>
In-Reply-To: <CAC-j02OVoFDFjeGUjcs0ZMwPSXKLL_GBme2m2-ttzGTbxXNP-w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Jan 2023 01:32:52 -0500
Message-ID: <CAPig+cScBFJCBN97g12v9Eg1-7+m8_EzAnpT2uSSdzTNwqjjVQ@mail.gmail.com>
Subject: Re: Bug report between git hooks and git worktree
To:     Preston Tunnell Wilson <prestontunnellwilson@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 7, 2023 at 2:20 PM Preston Tunnell Wilson
<prestontunnellwilson@gmail.com> wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Add a git hook that executes git commands inside of another folder. Let's
> call this other folder `FolderA`.
> Add a git worktree branch/folder, `cd` to it, and commit something there.
> Let's call this git worktree folder `FolderW`.
>
> I would expect the git command to output details from `FolderA`.
> It's confusing to me that there is a difference in behavior between
> the "main" branch and `FolderW` in git hooks.

This issue comes up from time to time[1][2]. What is happening is that
Git is setting environment variables pointing at the original
repository, so even though you invoke a Git command in a different
repository, it's picking up the environment variables and consulting
the original repository instead. When writing hooks which invoke Git
commands in a foreign repository, the "best practice" approach is to
clear the environment variables before running the Git command in the
other repository[3]. If you add this to the top of your hook script,
it works as expected:

    unset $(git rev-parse --local-env-vars)

Unfortunately, this "fix" isn't actually documented anywhere.

[1]: https://lore.kernel.org/git/CAPig+cQEC6CAV-Es9Ok96s8Cj=Dj76PRyOt4qKQus+rppswuyA@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com/
[3]: https://lore.kernel.org/git/20190516221702.GA11784@sigill.intra.peff.net/
