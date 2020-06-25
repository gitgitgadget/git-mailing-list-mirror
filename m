Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19459C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 06:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC68F206FA
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 06:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390015AbgFYGQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 25 Jun 2020 02:16:26 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42180 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390012AbgFYGQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 02:16:25 -0400
Received: by mail-wr1-f54.google.com with SMTP id o11so4525568wrv.9
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 23:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BOx/iLg8Shll3R7HF4pVrklokfF4MFEWT1iun9uU6pE=;
        b=qVHYmRw4HEArc3HscrHuK22D6tWzxZVNkVqbYm9W4bkv4Vg+Dl9Iv0dIH5B6ujMEVj
         WFONgIio6iHymPo0LYfD/sYESw3Pbq6cmn/7HnESN18BKJvSBy94kp0xFakmOTrmV8xt
         WFppq/d4Q4F+tLZU4853kaLXAa+8K43YNvwPUHpwvSBPllfjl8MhL2svcdQ5NMq7V3Ib
         aZWJDFqMNnA5BILV1o5tuwt1aNVT8gKLYzIDNrlOZP10es5rkYqKb51r2YWBPvR9qOh6
         risBG8n//DTfdWVw5QjblZzjTaDlPgxy/dyYLmGrlIrM7VzOpIbAk8fE7uDje3Ts9F+q
         JtIQ==
X-Gm-Message-State: AOAM531fIvLE6fbZKt8xdn17KYBa/ec3iW/MFIxlvM1VvxObPbalvq2a
        ptTFtZfa+T+IO+KJXtP1sHlllgTmr3q5Nm9mlAoZk3vA5sg=
X-Google-Smtp-Source: ABdhPJx/Hm4mJSVt0gfOJpl7DGobWU1cpYdsVtaga5yInW3KN3AfDCtE0emvZKmGsqEVzuEGOkJUwuM/xDHsxffHjys=
X-Received: by 2002:adf:e648:: with SMTP id b8mr35813682wrn.386.1593065783442;
 Wed, 24 Jun 2020 23:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbriek39i9NSHRw6DZm0dftk-GkeAYR74c0xyss0vbeDHu1Hw@mail.gmail.com>
In-Reply-To: <CAHbriek39i9NSHRw6DZm0dftk-GkeAYR74c0xyss0vbeDHu1Hw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 25 Jun 2020 02:16:12 -0400
Message-ID: <CAPig+cSaJXqx8F_OXL5uLsQ0g2Y5LQF4Q3b_gFZ+VjSqiN+zfQ@mail.gmail.com>
Subject: Re: git init --separate-git-dir doesn't play nice with linked working trees
To:     =?UTF-8?B?SGVucsOpIEJvdGhh?= <henrebotha@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 12:48 PM Henré Botha <henrebotha@gmail.com> wrote:
> I have identified two potential problems when using git init
> --separate-git-dir with a repo that has linked working trees (created
> using git worktree add).
>
> 1. Moving the gitdir of a main working tree doesn't inform linked
> working trees that their gitdir has moved. It seems to me that if I do
> cd main-worktree && git init --separate-git-dir=.git_repo, the git
> init command should go to all the linked working trees and change
> their Git links to point at main-worktree/.git_repo. But perhaps
> there's some use case I'm not aware of where you'd want to change only
> the gitdir path of the main working tree, and not those of linked
> working trees.

This is almost certainly an oversight in the implementation; the
--separate-git-dir option wasn't mentioned during development of
git-worktree as far as I recall.

As this relocation of the repository is entirely under Git's control
(as opposed to the user mucking around as with "mv .git ../foo), it
does indeed seem reasonable that --separate-git-dir should update the
worktree meta-information files. As far as I know, there is no
existing machinery to perform this sort of update, though, so it would
have to be implemented from scratch.

> 2. Attempting to move the gitdir of a linked working tree breaks the
> linked working tree entirely.
> It seems to me that if I do cd linked-worktree && git init
> --separate-git-dir=.git_repo, it should fail, or warn, or do something
> other than break the linked working tree. (I note that
> linked-worktree/{.git,.git_repo/commondir,.git_repo/gitdir} all point
> at the wrong thing after this operation; manually fixing them restores
> functionality, though it loses the link to the main working tree.)

Again, an oversight; --separate-git-dir wasn't on anyone's mind during
development. This is just utterly broken, as far as I can tell; it
doesn't move the repository out of the main worktree to the new
location but instead seems to make a copy of it (minus the
.git/worktrees directory) and drops entries from the original
.git/worktrees directory, thus breaking everything. I suppose it could
error out, though friendlier would be for it to behave correctly.
