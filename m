Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5303BC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 20:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjARUn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjARUny (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 15:43:54 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1DE5F3B6
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:43:47 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1674074624; x=1674333824;
        bh=NQQqvRVpuCIYkVwNvl7d37skkuv8KJGmmiGmLAY5BAI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=r+tNlUbCNYClP9D4oVVC6BbhtbABe0i+GvHbn1AZE+jAxzgMCm/36WydygembeRCU
         PVmAqUEqmEwsXG47y3x1nW2jFSXeCQWqVv4tv8MXEkB9JX5fNa/0a7JQPpphYMIyOD
         UfsD9OnmBNDo4Gt2J1s84TWH+pfoFvEfKWGl8HFgtmLP9qTqlIHqWEyT/3r0hvsNei
         GnKSzp0t3e2hbFh2Nq6VyASGpbM38r45P+yRH5vAe6lAr1xXLUVFGEiUPACAvLCqnC
         LP1BrazPDW/FeNdPvu8U1CxrFEKKRSMqZnQMt3rCaH6kHs2BgXX4niHAhdvvkztMxS
         zi5NZ/aZgkZKQ==
To:     phillip.wood@dunelm.org.uk
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH] worktree add: introduce basic DWYM for --orphan
Message-ID: <20230118204323.gn6rs3gydybsqt4g@phi>
In-Reply-To: <cddc6987-3b58-4688-65f8-3da0fbd1cc51@dunelm.org.uk>
References: <20230114224956.24801-1-jacobabel@nullpo.dev> <cddc6987-3b58-4688-65f8-3da0fbd1cc51@dunelm.org.uk>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/16 10:52AM, Phillip Wood wrote:
> Hi Jacob
>
> On 14/01/2023 22:50, Jacob Abel wrote:
> > Introduces a DWYM shorthand of --orphan for when the worktree directory
> > and the to-be-created branch share the same name.
> >
> > Current Behavior:
> >      % git worktree list
> >      /path/to/git/repo        a38d39a4c5 [main]
> >      % git worktree add --orphan new_branch ../new_branch/
> >      Preparing worktree (new branch 'new_branch')
> >      % git worktree add --orphan ../new_branch2/
> >      usage: git worktree add [<options>] <path> [<commit-ish>]
> >         or: git worktree list [<options>]
> >      [...]
> >      %
> >
> > New Behavior:
> >
> >      % git worktree list
> >      /path/to/git/repo        a38d39a4c5 [main]
> >      % git worktree add --orphan new_branch ../new_branch/
> >      Preparing worktree (new branch 'new_branch')
> >      % git worktree list
> >      /path/to/git/repo        a38d39a4c5 [main]
> >      /path/to/git/new_branch  a38d39a4c5 [new_branch]
> >      % git worktree add --orphan ../new_branch2/
> >      Preparing worktree (new branch 'new_branch2')
> >      % git worktree list
> >      /path/to/git/repo        a38d39a4c5 [main]
> >      /path/to/git/new_branch  a38d39a4c5 [new_branch]
> >      /path/to/git/new_branch2 a38d39a4c5 [new_branch2]
> >      %
>
> Thanks for working on this. As I said in my previous mail I think it
> would be easier to use OPT_BOOL() for --orphan from the start. By using
> OPT_STRING() you'll run into problems with "git worktree add --orphan
> --lock <directory>"
>
> Best Wishes
>
> Phillip
>
> > [...]

Ah, good point. I missed that.

Also given the way the conversation is going, I'll drop this patch and inte=
grate
the changes into the patches of the main series since I'll be re-rolling.

