Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71993C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 06:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbjD0GQn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 27 Apr 2023 02:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD0GQl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 02:16:41 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4199D35A4
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 23:16:40 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-751319e0dbfso128465985a.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 23:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682576199; x=1685168199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sy8CkoFEvlI8c7ja7OlQB65zZeFFBTwfbdH1/TlWHRM=;
        b=ChwfsJWbkGq+zsokF/kirRtfbmEuROvJP4+BvsH9wPV+GiVfq3FotT7tjTZ68OOi2P
         83T8VQYFOumEoxlqEgU9n7icPUh2/7YN6YzeOLBwEWRKrxYgFFFoSR/wqWd1ABrM9cNd
         9uSJB94BZBnWnWw48FEuqg9TPmoFML9Fwk29rWfflSde/XRWBRaZwtJ3qmC7GI58uBg9
         sHfCePjVRSP9AJSH1K1K+x+kdRnk9j59BPpSOaAVIG8dQVMXcmH7opBOTAAxZV907JNP
         osbilF7s9r5pAkf0uBLWznQedUjnCbiwj7XhLMt/TMfuRV7AcunnEVMtE0pdbX2MzbpT
         t1xg==
X-Gm-Message-State: AC+VfDwJkuhXcgsHjJ/e/x/wFHZGH2PQc3tuhacjzZuTLlGlSoFF+xzm
        dX25k68zwgaUsQIjHJJgXQiv4WOYvqnlvzie6vD1nceAPKg=
X-Google-Smtp-Source: ACHHUZ6tOxTSPMhlz6RzgwJQPEZSU9zPC61g5twI6h/734JlBDbSI2g/+TbgeMWDM3iYOwWLoi4CJL3iMDmGqInkJr4=
X-Received: by 2002:a05:6214:409:b0:5ef:5060:436c with SMTP id
 z9-20020a056214040900b005ef5060436cmr9824790qvx.17.1682576199190; Wed, 26 Apr
 2023 23:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
 <1897dff1-bb4d-9715-dd1c-86763c052589@gmail.com> <xmqq5y9lc9ep.fsf@gitster.g>
 <51adbbcb-bbfa-58cc-03a4-82809c0c555e@gmail.com> <xmqqwn1xnahy.fsf@gitster.g>
In-Reply-To: <xmqqwn1xnahy.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Apr 2023 02:16:28 -0400
Message-ID: <CAPig+cRm1XaMzgDQZGS8vwpD_k8srQH0NGmziT_J7mtTHnR7OA@mail.gmail.com>
Subject: Re: [PATCH 2/3] worktree: warn when removing a worktree with orphan commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 1:50 AM Junio C Hamano <gitster@pobox.com> wrote:
> Whichever phrasing you end up using, I think the order of messages
> should be made consistent between the two cases.  That is,
>
> > Maybe "HEAD position was" fits for both usages.  This is how it would
> > look like:
> >
> >    $ git checkout -
> >    HEAD position was 7906992 commit-b
> >    HEAD is now at 2efe05c commit-a
>
> Here "git checkout" reports the lost HEAD and then the end result.
>
> >    $ git worktree add test --detach && git worktree remove test
> >    Preparing worktree (detached HEAD 2efe05c)
> >    HEAD is now at 2efe05c commit-a
> >    HEAD position was 2efe05c commit-a
>
> But here "git worktree add" reports the end resultfirst and then
> reports the lost HEAD.  It probably should report them in reverse.

There may be a misunderstanding here due to the unfortunate
construction of Rubén's example which muddles together the output of
`git worktree add` and `git worktree remove`. For clarity, his example
should probably have been written:

  $ git worktree add test --detach
  Preparing worktree (detached HEAD 2efe05c)
  HEAD is now at 2efe05c commit-a
  $ git worktree remove test
  HEAD position was 2efe05c commit-a

although showing only the `git worktree remove` command would probably
have been even clearer.

Such example output does a good job of arguing in favor of your
suggestion to use phrasing which is more alarming:

  $ git checkout -
  Commit 2efe05c "commit-a" left dangling
  HEAD is now at 7906992 commit-b

  $ git worktree remove test
  Commit 2efe05c "commit-a" left dangling

(Hopefully someone can come up with better wording than "About to lose
history leading to" and "Commit ... left dangling", neither of which
sound quite right.)
