Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04158C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 18:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05B923428
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 18:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbhAGSyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 13:54:33 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:43987 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbhAGSyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 13:54:32 -0500
Received: by mail-ej1-f54.google.com with SMTP id jx16so11081092ejb.10
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 10:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqShZr+fRuIM94Muvarsx15YY9ZLKOGlDKtVPGrVt6E=;
        b=jK9INh2htv0TQ5ZOPdOCuUuceVzNIvx52UFrOuCe6YlFJ+Fg80S11P1MoUK9S9YKT8
         RH56j1z2F5bwap+SNtbqPf16UgpUrl4kofrEW+NPiiEq6BZPPRsUZLwXlzRrKuxjWGYa
         ZIC4WErck7gGykX9yTSYuQJHBMIvqr4MiIwV7EwyW+vRvC4k7D5OZkGdA0Mal0h4tU5U
         2ugV2mUBSH1dW2tjVjMvveO6lZVHewRJVxenylyWV2qSiT3ljMw0CZcsyQukuFEFnMOw
         XGX9pSeJaNrBxleq9dofLfkv9VeyiYzu8ld0WhqU9IcGt1u2/EBI1tngT4GJV0c1MnJb
         RZmQ==
X-Gm-Message-State: AOAM533uj8lng9aAUsiV7fvHi7QgPxHEf0HAhuiXY/3J3gIx6/AYAKed
        YS4t1j/n9ZgnOHFIptXjrzOVC2+jsSL8lbd7oRg=
X-Google-Smtp-Source: ABdhPJw86fVpbygUF+5XmtEBM1BLZvU8fJfTL/09ZI2XbZAum++JpK0j2R5fFF3qU5w1EDKa1lThklSsCq53PNo+DAg=
X-Received: by 2002:a17:906:6b88:: with SMTP id l8mr139182ejr.482.1610045631105;
 Thu, 07 Jan 2021 10:53:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <pull.830.v2.git.1609821783.gitgitgadget@gmail.com> <2b171a142b36b114d5ff526073fe3fd9517a4d32.1609821783.git.gitgitgadget@gmail.com>
 <CAPig+cTfHsd7WMvcX1_433WVOG+y4FceUACBx_4UfnjJTgVY6g@mail.gmail.com> <73f51832-583a-27e8-65fa-86eb0ebac4cf@gmail.com>
In-Reply-To: <73f51832-583a-27e8-65fa-86eb0ebac4cf@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Jan 2021 13:53:40 -0500
Message-ID: <CAPig+cSLsLibDik3YYTPdwbHpywStMxR_4rRBZfYrX7S-cFnNA@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] update-index: remove static globals from callbacks
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 7, 2021 at 6:19 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 1/7/2021 12:09 AM, Eric Sunshine wrote:
> > Will there ever be a case in which `cd.istate` will be different from
> > `cd.repo->index`? If not, then we could get by with having only
> > `cd.repo`; callers requiring access to `istate` can fetch it from
> > `cd.repo`. If, on the other hand, `cd.istate` can be different from
> > `cd.repo->istate` -- or if that might become a possibility in the
> > future -- then having `cd.istate` makes sense. Not a big deal, though.
> > Just generally curious about it.
>
> I don't believe that 'istate' and 'repo->index' will ever be
> different in this file. This includes the members of the
> callback_data struct, but also the method parameters throughout.
>
> It could be possible to replace all references to 'istate' with
> 'repo->index' but the patches get slightly more messy. I also
> think the code looks messier, but you do make a good point that
> there is no concrete reason to separate the two.

I agree that it would make the code a bit noisier (to read) if
`istate` is eliminated from the callback structure, however, even
though I didn't originally feel strongly one way or the other about
having both `repo` and `istate` in the structure, I'm now leaning more
toward seeing `istate` eliminated. My one (big) concern with `istate`
is that it confuses readers into wondering whether `istate` and
`repo->istate` will ever be different. One way to avoid such confusion
would be to leave a comment in the code stating that the two values
will always be the same. The other way, of course, is to eliminate
`istate` from the structure altogether. I don't want to make more work
for you, but the more I think about it, the more I feel that removing
`istate` is the sensible thing to do. (And it doesn't require an extra
patch -- it can just be how this patch is crafted -- without ever
introducing `istate` to the structure in the first place.)
