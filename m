Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2124AC433F5
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 21:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhLSVcw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 19 Dec 2021 16:32:52 -0500
Received: from elephants.elehost.com ([216.66.27.132]:35307 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbhLSVcw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 16:32:52 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BJLWlXF039282
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 19 Dec 2021 16:32:47 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Sean Allred'" <allred.sean@gmail.com>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>
Cc:     <git@vger.kernel.org>
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com> <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com> <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
In-Reply-To: <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
Subject: RE: Bug report - Can create worktrees from bare repo / such worktrees can fool is_bare_repository()
Date:   Sun, 19 Dec 2021 16:32:42 -0500
Organization: Nexbridge Inc.
Message-ID: <003f01d7f51f$f7bb0860$e7311920$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKeYwgHoGmGxJSEPR+fKunQIMLw7wFeNI06AY9doomqlgzoIA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 19, 2021 3:47 PM, Sean Allred wrote:
> To: Eric Sunshine <sunshine@sunshineco.com>
> Cc: git@vger.kernel.org
> Subject: Re: Bug report - Can create worktrees from bare repo / such
> worktrees can fool is_bare_repository()
> 
> > However, you missed the step (discussed in [1]) in which it is your
> > responsibility to move the `core.bare=true` setting from
> > git.git/config to git.git/worktree.config manually after setting
> > `extensions.worktreeconfig=true`.
> 
> Ahh, that makes sense!  I did notice the `core.bare` setting being respected
> in source and figured this had a part to play (which is why I included git-config
> output).
> 
> I think then that I was overzealous in trying to MWE-ify the issue: as I noted, I
> found this issue when I was trying to perform a sparse-checkout within the
> worktree.  To memory (I don't have my work system at the moment and
> don't have its `history`), I think it went something like this:
> 
>     git worktree add --no-checkout ../next && cd ../next
>     git sparse-checkout init --cone # auto-created a worktree config
>     git sparse-checkout set t
> 
> I think either the git-sparse-checkout-set command (or the git-checkout I ran
> after) would fail complaining that I was not in a worktree.  Based on the
> above, it sounds like `init` is creating the worktree-specific config, but is not
> overriding `core.bare` in that config.  Would a patch to take this step this
> automatically be well-received?  I see two options for when to set
> `core.bare=false` in worktree-specific config:
> 
>   1. At git-worktree-add: This is probably the earliest time which
>      makes sense, but may be over-reach.  I'm not up-to-speed on how
>      worktree-specific configs are generally considered on this list.
>      If I were implementing a workaround, though, this is probably
>      where I'd make it.
> 
>   2. At git-sparse-checkout-init: This is where the problem begins to
>      have an effect, so this might also make sense.
> 
> I'm glad to learn about bare repositories + worktrees being a supported use-
> case :-)

Fair enough, but what about the comparison code where is_bare_repository_cfg is compared with 1 (it is a boolean and sometimes set to -1). This would not generally pass a code review.
-Randall

