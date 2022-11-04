Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F10C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 04:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiKDEdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 00:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKDEdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 00:33:49 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C08205C4
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 21:33:47 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id s10so1148080ioa.5
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 21:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3WX1lsbTurzHVfmAEgIfxFQnAo/KNszeSAK40RalbQ=;
        b=13O0AgUKCZRZLgfXBcxoWsnOo/LUquvHI2gAuscnBqz/a95caYp3s3SMeIimcvUCx0
         vWdjOyeNrS2IhwsVdzX/aiXlXWb9mwH4NlxK3DpiHX7R7KbwW1yLvJRsthTJWJV3RceN
         CpDL3AizX3Vye0OoG1/dTf+f+F+lP4Dmx8oe70QkfaQmlVXT46ZO1227TjmU1t5l2bMv
         my3WOzxx64Vq8FVlzNUwnebRoIY/VK6pav10Vw5M6G1X315JhOOnIVW0GdtMfaGlnjBm
         /IHp6mqkINfh+mhrmP/ljVmFEfFabtk8WQP/n8Bb19ILcfi+cV7nA/WKY2/65q5IVfL5
         h1Mg==
X-Gm-Message-State: ACrzQf11QWWUFVSKtdb3G4tQNTYnbUWWZ+Xf7A1dgLe8Fg0WQtYceuqA
        /1UxrmilCtQcx4q8K9caqUePnnusRYjjQV6p9X6xPZgu0ic=
X-Google-Smtp-Source: AMsMyM5G0ljiqflorg87FzCshwR/JRNEVOIuUSYkc4U3QgSKOuSzBVzvRMhTAwb2+GMomH8YJvc+QUjeb9tYtmYg/e0=
X-Received: by 2002:a5d:8251:0:b0:6ca:d7ff:375c with SMTP id
 n17-20020a5d8251000000b006cad7ff375cmr20100227ioo.197.1667536427215; Thu, 03
 Nov 2022 21:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
In-Reply-To: <20221104010242.11555-1-jacobabel@nullpo.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Nov 2022 00:33:36 -0400
Message-ID: <CAPig+cQV7Udz4mn2V7P8ZsVoFiCRMJwNiG23GL6NAOxM4iuzmw@mail.gmail.com>
Subject: Re: [PATCH 0/4] worktree: Support `--orphan` when creating new worktrees
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 3, 2022 at 9:07 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> While working with the worktree based git workflow, I realised that setting
> up a new git repository required switching between the traditional and
> worktree based workflows. Searching online I found a SO answer [1] which
> seemed to support this and which indicated that adding support for this should
> not be technically difficult.

I've also found myself using an orphaned worktree on occasion, so I
can see the value in supporting this use-case directly. In fact, the
idea all along was that `git worktree add` would start with a small
set of options but gain additional options over time as the need
arose. It was foreseen in [1], for instance, that --orphan might one
day be added.

> This patchset has three parts:
>   * adding `-B` to the usage docs (noticed during dev and it seemed too small
>     to justify a separate submission)
>   * switching from `git reset --hard` to `git checkout` for worktree checkout
>   * adding orphan branch functionality (as is present in `git-checkout`)
>     to `git-worktree-add`

I'm pretty sure that we don't want to go the route of using
heavyweight and heavily-featured `git checkout` as a substitute for
lightweight `git reset --hard`. In fact, worktree functionality
started life as a special checkout mode invoked by `git checkout
--to`. A good deal of work[2][3][4] went into extracting that
functionality to a standalone `git worktree add` command, and
eventually ridding `git worktree add` of its unfortunate dependency
upon `git checkout` as a backend[5][6][7], and ridding `git checkout`
of its ugly intimate specialized knowledge of a newly-crafted
worktree.

The key motivation for rejecting `git checkout` as backend and
migrating to `git reset --hard` came from Junio[8][9], and I trust
that his observations are still pertinent.

So, rather than swapping out `git reset --hard` in favor of `git
checkout`, we probably want to stick with the already-established
approach of adding the necessary machinery to `git worktree add`
itself (or by refactoring `git checkout` machinery to be reusable),
just as we did for other `git worktree` options which have `git
checkout` counterparts, such as --track[10], --guess-remote[11],
--[no]-checkout[12], --quiet[13], etc.

[1]: https://lore.kernel.org/git/1436573146-3893-11-git-send-email-sunshine@sunshineco.com/
[2]: https://lore.kernel.org/git/1435640202-95945-1-git-send-email-sunshine@sunshineco.com/
[3]: https://lore.kernel.org/git/1435969052-540-1-git-send-email-sunshine@sunshineco.com/
[4]: https://lore.kernel.org/git/1436203860-846-1-git-send-email-sunshine@sunshineco.com/
[5]: https://lore.kernel.org/git/1436573146-3893-1-git-send-email-sunshine@sunshineco.com/
[6]: https://lore.kernel.org/git/1437034825-32054-1-git-send-email-sunshine@sunshineco.com/
[7]: https://lore.kernel.org/git/1437174017-81687-1-git-send-email-sunshine@sunshineco.com/
[8]: https://lore.kernel.org/git/xmqqh9physyu.fsf@gitster.dls.corp.google.com/
[9]: https://lore.kernel.org/git/CAPig+cSBp-U_jC3fcPXkZQ6kEPh7TRs2bAwKYQGGTtoGR3UYeg@mail.gmail.com/
[10]: https://lore.kernel.org/git/20171129200451.16856-4-t.gummerer@gmail.com/
[11]: https://lore.kernel.org/git/20171129200451.16856-6-t.gummerer@gmail.com/
[12]: https://lore.kernel.org/git/01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com/
[13]: https://lore.kernel.org/git/20180815205630.32876-1-gitter.spiros@gmail.com/
