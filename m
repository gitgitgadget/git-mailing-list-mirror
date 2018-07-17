Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A51831F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbeGQSS6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:18:58 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36695 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeGQSS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:18:57 -0400
Received: by mail-yb0-f195.google.com with SMTP id s1-v6so753969ybk.3
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 10:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPdOmJYk7QI/wz2UJKYEbBu3Y1UQLlBmhCD+YXzGuXE=;
        b=hA+JK+tfKFSi8W2MdNZRbJafBncaBHVHUK3jVdshJUhmH6juq59K0fzmjdroESTwl0
         +CTS/WZLwoD4xL8fw12H4rs6veBU2Aeh3gDhKFL5jz6oDAKjfa0m2jdgqezPM+t6SNTw
         HwUlmzmlzp0Gl85+9Wlk/EauqvL8yUpRYlAhgDg494beBJwnAUMgyoCg7532CDBQGVB4
         jJydZHxEOYTtkHsOTT4pzwGA6ViZJlfd8NxRACufhKuCAcelCquKlFsJXRtbnH06mave
         +WytbRXcGHrkVUSDuzO8GwdJqVKwAqzWRakwYDf0sNDKJ97mYz8P90AEapg0XBIKgkbB
         ne0Q==
X-Gm-Message-State: AOUpUlHjLMaIijMIGkPXr8By5LKEoIWTTV5v/STVdeRivdZzqUwCj4EJ
        eIDqjl4H8eV7P3W8K0vf7SrisOyqV9gfuM0U69U=
X-Google-Smtp-Source: AAOMgpePYlI8WNLE6q+tXfSjR47YMNT02Nhw7cAMgs3utJHLbzT7xt6chJkxE/GkUVuRd0GYIgfaEpGQITGenRXPDmg=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr1439474ybp.76.1531849514436;
 Tue, 17 Jul 2018 10:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.9.git.gitgitgadget@gmail.com> <pull.9.v2.git.gitgitgadget@gmail.com>
 <c7ee6e00875bbfe6108dcdcc43cb389096a28188.1531835498.git.gitgitgadget@gmail.com>
In-Reply-To: <c7ee6e00875bbfe6108dcdcc43cb389096a28188.1531835498.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Jul 2018 13:45:03 -0400
Message-ID: <CAPig+cRh5qezsFFkecwM1uVdeCwgTFqFnpUPDmb+GdNFVUUx4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] repack -ad: prune the list of shallow commits
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 9:51 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> While it is true that we never add unreachable commits into pack files
> intentionally (as `git repack`'s documentation states), we must not
> forget that a `git fetch --prune` (or even a `git fetch` when a ref was
> force-pushed in the meantime) can make a commit unreachable that was
> reachable before.
>
> Therefore it is not safe to assume that a `git repack -adlf` will keep
> unreachable commits alone (under the assumption that they had not been
> packed in the first place).
>
> This is particularly important to keep in mind when looking at the
> `.git/shallow` file: if any commits listed in that file become
> unreachable, it is not a problem, but if they go missing, it *is* a
> problem. One symptom of this problem is that a deepening fetch may now
> fail with
>
>         fatal: error in object: unshallow <commit-hash>
>
> To avoid this problem, let's prune the shallow list in `git repack` when
> the `-d` option is passed, unless `-A` is passed, too (which would force
> the now-unreachable objects to be turned into loose objects instead of
> being deleted). Additionally, e also need to take `--keep-reachable` and

s/, e/, we/

> `--unpack-unreachable=<date>` into account.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
