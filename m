Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3810CC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 07:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiJYH46 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 25 Oct 2022 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiJYH45 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 03:56:57 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C94F167F50
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 00:56:55 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id y12so14715702edc.9
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 00:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHlqXlfi4MF8pqnSR3GMYHreZ08l1fDZEjdtRE8ilYg=;
        b=Kp3v8zR0FJlzm6hHFAWzTAuZZqypUuZVBMsy1BArzK/1AJrs5WdqrK5F28y8UbUkPn
         YASHpDCXPrDAqURs6HNOi1gMtzq9zKIQ5QHApJG4DH+iwISI7mAYSjbxl0e/sEJdNQW4
         UR0S6sendy2TraLQTtyhtcm50fktM0vKWvk5mvFhUgaGUflN2FV8gBXKBDwXBMmvyDSI
         BjNeEM/axKvR2vVbdWG0twBwezJwnknfie/COrFDkGRktvYcC+cD0xzWqvhEJy2xPz3h
         v9u/6+OO7wvTJNiQhqqPatJWhG3BbHC0tl9AIBzYa/QoqOZuxVaJMueYNRWqnStTakXA
         nSeA==
X-Gm-Message-State: ACrzQf1Z11QL98Y7RSQPI2Pu10VJTIzuTvbV4WMDIAJaN8T4K2qX+ARP
        eWPHQznaDaS4o9lU1JVUBXnO97mDLLh3FA7Ip5gdfs7uuzQ=
X-Google-Smtp-Source: AMsMyM64dEIb6JuA7SrlJGwN8x8n1K1j+pMQ/OjqvY3L5vw7/JqC2uDY7myvDkcfpooMeh9hvNmlqlEukMk0kPliKx0=
X-Received: by 2002:a05:6402:4301:b0:45d:422b:5d5d with SMTP id
 m1-20020a056402430100b0045d422b5d5dmr33586675edc.153.1666684613328; Tue, 25
 Oct 2022 00:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <491oWe6HDMJXQK2Ru2VbzFrlUajNlVhnIErZZ1dxUaPpCElsgpASAEQFc2Zi1R4G53hAIMHopETEJn7E_TzeeC6uOzGBffQDRK2AWYPIxKQ=@protonmail.com>
In-Reply-To: <491oWe6HDMJXQK2Ru2VbzFrlUajNlVhnIErZZ1dxUaPpCElsgpASAEQFc2Zi1R4G53hAIMHopETEJn7E_TzeeC6uOzGBffQDRK2AWYPIxKQ=@protonmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 25 Oct 2022 09:56:15 +0200
Message-ID: <CA+JQ7M_woJmQdaB24-eNxSRJLN4GPgTyZcPfKsXAkP+B1QOT-Q@mail.gmail.com>
Subject: Re: Adding --force-if-newer flag to git push
To:     Sergey <sryze@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2022 at 7:02 PM Sergey <sryze@protonmail.com> wrote:
>
> Sometimes I find that a feature like this would be useful when I work on multiple different computers and I want to just push all local branches to the repo at once to sync it with whatever is the latest version. I know that using --force is kind of frowned upon in the Git community, so this is probably not the best idea because it would promote usage of this feature among the users. I just wanted to know your opinions and see if someone else would find it useul or it's just a dumb idea.

Once you know the relevant options, it's pretty trivial to roll your
own script/workflow/configuration that suits your own work case. I'll
share how I solve the problem you describe. First, I'd like to mention
  git pull --rebase
which is basically
  git fetch origin && git rebase @{upstream}
or
  git pull --rebase=merges
which is basically
  git fetch origin && git rebase --rebase-merges @{upstream}
This does a fetch and afterwards, attempts to rebase any local changes
on top of the remote tracking branch. I'd recommend this approach over
force pushing. It keeps forced history rewrites away from the upstream
repository, which is generally best reserved for "truer" or more
finished work. It also allows for better recovery, in case you mess
up, chances are your history is preserved in the reflog. This can be
configured as the default either globally, per repo or per branch
https://git-scm.com/docs/git-config#Documentation/git-config.txt-pullrebase

Be aware that there are potential situations where this will not
automagically resolve the difference in history in a way that you may
expect and I'd only configure this as default if you feel comfortable
rolling back in case that situation arises. As a starting point, you
can manually initialize the rebase using @{upstream} or @{U}
 git fetch
 git rebase @{U}

If you want to investigate the divergence between a local branch and
its upstream, there are several commands that may be useful depending
on exactly how you want to compare them (often situational in my
experience.) The see which is newer you can run
  git show -q --format=fuller HEAD HEAD@{U}
but sometimes you want to know more say, how do the trees differ
  git log --online --graph HEAD...HEAD@{U}
or perhaps the difference in contents
  git diff HEAD HEAD@{U}
etc. etc.

Happy hunting!
