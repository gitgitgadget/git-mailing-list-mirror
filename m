Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD25C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 04:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKJEOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 23:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKJENu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 23:13:50 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC45D122
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 20:13:21 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id q5so450855ilt.13
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 20:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYsEm6n/uUWKVocW7E3XudYisG0Bw0aLpDHpwqnRzWI=;
        b=1p4HGAyvtrgR6UEORJXhzav2MngWQ7TAJkl0tOZHVMRSMvnKo0d889xAQCp/I+3HMd
         jLlA58e3KIMAzSDn4eeyjlOlBZk9gGql4iv8NK2HM8ok9Kq/+6LOXKAwRruZn0ea/Brc
         VAe8beuVERcDyFrvm6nm3PAAeQ9H4BrOVrcT5c8Y2b6LNAsCc5EBPobXyCR2rkk6bqC+
         udglUk9hyCQN5qfl/bZxqxm2l6oUj3sGXdyeAZilQJownS7ZpilOTj0W+WiZ1st3WgAc
         U7MDcGrW5Arvo5bia7lwx+lQCdEZTzY6W6bEJX/6YURq8DfnCZSvCYCchsdHsP9rcTCj
         f2cw==
X-Gm-Message-State: ACrzQf2MqHaLZ0NxlpCe6GSmh0VZl3ittflt/3PwM8XmMTnNv9wvD63j
        7AI1Z17aAof/lYcOUjsCP2ZhF8lY2uwuAm4KYkPEYo3f
X-Google-Smtp-Source: AMsMyM7el+mb9vtpNEgK56yJGlnLu4HjBtEiXzcbPFmbPcP3X8jT3HSupGZDqCZSFqTZZmg/xppZJnlfsOCbrbOcBt0=
X-Received: by 2002:a92:290b:0:b0:300:c7c3:665d with SMTP id
 l11-20020a92290b000000b00300c7c3665dmr23761700ilg.249.1668053601001; Wed, 09
 Nov 2022 20:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104010242.11555-4-jacobabel@nullpo.dev>
 <CAPig+cSVzewXpk+eDSC-W-+Q8X_7ikZXXeSQbmpHBcdLCU5svw@mail.gmail.com> <20221104164147.izizapz5mdwwalxu@phi>
In-Reply-To: <20221104164147.izizapz5mdwwalxu@phi>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Nov 2022 23:13:10 -0500
Message-ID: <CAPig+cRNpGUkRWW=q7-UckceeK0k37ncW-rH38boD=kY2oqLSg@mail.gmail.com>
Subject: Re: [PATCH 3/4] worktree add: add --orphan flag
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2022 at 12:42 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> On 22/11/04 01:03AM, Eric Sunshine wrote:
> > On Thu, Nov 3, 2022 at 9:07 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> > Are we sure we want to be modeling this after `git checkout --orphan`?
> > If I understand correctly, that option has long been considered (by
> > some) too clunky, which is why `git switch --orphan` was simplified to
> > accept only a branch name but no commit-ish, and to start the orphan
> > branch with an empty directory. My own feeling is that modeling it
> > after `git switch --orphan` is probably the way to go...
>
> I would argue that the `git checkout --orphan` command format is preferable to
> `git switch --orphan` when creating new worktrees. Reason being that in many
> cases (except when working in a new repo), if you are trying to create a
> worktree from an orphan you will be doing it with a different commit-ish
> currently checked out in your worktree than the one you want to use for the
> orphan (or you aren't in any worktree).

I guess I'm not understanding the use-case being described here or
that this series is trying to address. In my own experience, the very,
very few times I've used --orphan was when I needed a branch with no
existing history (i.e. "orphan") and with no existing files. For that
use-case, `git switch --orphan` is ideal, whereas `git checkout
--orphan` is a bother since it requires manually removing all content
from the directory and clearing the index.

> Requiring the commit-ish to be inferred would limit the user to checking out
> an orphan from an existing worktree (in which case they could just create a
> new worktree normally and use `git switch --orphan` to move that to an orphan
> branch).

I'm not following what you mean by inferred commit-ish. `git switch
--orphan` does not infer any commit-ish; it starts the orphaned branch
with an empty directory, hence there is no commit-ish involved.

The `git switch --orphan` behavior was intentionally implemented to
"fix" what has long been considered (by some) a UX botch in the
behavior of `git checkout --orphan`. It was argued that in the vast
majority of cases, people wanted an orphan branch to mean both "no
history" and "no files". So, in that sense, it feels like a step
backward to adopt `git checkout --orphan` when introducing `git
worktree --orphan`.

But, as I said, I'm genuinely not grasping your use-case, so I'm
having trouble understanding why you consider `git checkout --orphan`
a better model. If you can elaborate your use-case more thoroughly,
perhaps it would help (at least me).
