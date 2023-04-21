Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ED1C77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjDUTPZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 21 Apr 2023 15:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjDUTPK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:15:10 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65302170C
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:15:01 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-74df47ad36eso122700085a.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104500; x=1684696500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxULPCWS7uneHVMUuDvXi4t85vyvxcRdZX1ppvnzmgg=;
        b=lVCXoxGGeiHp+7EgnJvCt9K0WPDhBKDUr21M9euBtcGQN9mttyUdLm/7/YIhS+DR1S
         wYJ/iBLUPA8NSNb4vp1cVzsE3B0sVg/AKFW90Hft7kI+LYM0bbzsV0vct5ozTZwcfES3
         ggwdr/EtIWLr8+r4B4eh+OJCUKc51asd/suiSDkuhn0Kh9MgvoCYmDLKuR5tl/IVbmDY
         fiOaiiFMNg08vsjsPDEYI3dWe4fIKCto5wRivZU1CQAbRH1jzZhCZJ9X66WaFrfX/Xgb
         EWHBJXsJlXmrwpC2Z7DU7cpBJUGf0zHYguZi5l9e8QdM9COk8j5Lx5agZu25Ho5nW3EN
         JFGQ==
X-Gm-Message-State: AAQBX9ebz7X0eThNeHRcSRv/msnOlxki+G+/SPJDXiKAO/9hjGyHfvF3
        bb8vF0phwxzikjk37Jsgwgb+cf5KEs2ENJiflhk=
X-Google-Smtp-Source: AKy350b7XytHuwbr8kPmJsWWJY4+S3cHGboL2qDQC5cG2YIxHcNOp5+qeHboF6te8f9TB0pvmG3U2PJcMEGSoFoAiXg=
X-Received: by 2002:ad4:5be8:0:b0:5f3:deca:ead with SMTP id
 k8-20020ad45be8000000b005f3deca0eadmr8377891qvc.28.1682104500475; Fri, 21 Apr
 2023 12:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <9356d14b09a468d8ef2884cd7d76e59ec5c16691.1682089075.git.gitgitgadget@gmail.com>
In-Reply-To: <9356d14b09a468d8ef2884cd7d76e59ec5c16691.1682089075.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Apr 2023 15:14:49 -0400
Message-ID: <CAPig+cQ2z2jq05S1QxboBT-51gVSqsJsWTfGKRN6PPYxW=ZzmA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] rebase --continue: refuse to commit after failed command
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2023 at 11:12 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> If a commit cannot be picked because it would overwrite an untracked
> file then "git rebase --continue" should refuse to commit any staged
> changes as the commit was not picked. Do this by using the existing
> check for a missing author script in run_git_commit() which prevents
> "rebase --continue" from committing staged changes after failed exec
> commands.
>
> When fast-forwarding it is not necessary to write the author script as
> we're reusing an existing commit, not creating a new one. If a
> fast-forwarded commit is modified by an "edit" or "reword" command then
> the modification is committed with "git commit --amend" which reuses the
> author of the commit being amended so the author script is not needed.
> baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when fast-forwarding,
> 2021-08-20) changed run_git_commit() to allow a missing author script
> when rewording a commit. This changes extends that to allow a missing

s/changes/change/

> author script whenever the commit is being amended.
>
> If we're not fast-forwarding then we must remove the author script if
> the pick fails.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
