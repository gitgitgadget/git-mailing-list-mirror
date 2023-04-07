Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE5EC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDGHAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbjDGHAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:00:50 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79267DBF
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:00:47 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id E76AF2410B;
        Fri,  7 Apr 2023 03:00:45 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pkg5V-fZp-00; Fri, 07 Apr 2023 09:00:45 +0200
Date:   Fri, 7 Apr 2023 09:00:45 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] rebase: implement --rewind
Message-ID: <ZC+/nYp2RRF9Gjrd@ugly>
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
References: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
 <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de>
 <ZCMRpnS9gzN1Rlbh@ugly>
 <4fa6d2da-4885-09d9-dddb-6f19efda6398@gmx.de>
 <ZC2Qhi73YKSOJrM2@ugly>
 <230406.86zg7ls2jx.gmgdl@evledraar.gmail.com>
 <CAMP44s13z=hZHzU+EB7qBZnqQcmRGe4aknF=wocOK9uh6NHbcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMP44s13z=hZHzU+EB7qBZnqQcmRGe4aknF=wocOK9uh6NHbcA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2023 at 07:21:39PM -0500, Felipe Contreras wrote:
>Imagine there was a rebase log for each branch, then `git rebase`
>could use that information to redo a previous rebase, even if that
>rebase was aborted. To restart your current rebase you could do `git
>rebase -i --redo 1` (1 being the previous one). If in the middle of
>that you decide actually your original approach was better, you just
>freely abort, and do `git rebase -i --redo 2`.
>
what exactly would you save to that log?
what comes to my mind is the todo file produced by my --rewind before 
the user edits it: the already rewritten commits (which can of course be 
saved as a single ref), and the remaining todo.
that would make it very much the same thing as the checkpoints phillip 
postulated and i expanded upon.

one difference to what i envisaged would be that one could easily resume 
a rebase one erroneously discarded entirely.

>Wouldn't that solve all the problems?
>
it would, but not necessarily optimally.

consider that after the initial implementation phase, my working branch 
is most of the time inside a 'reshape' (rebase -i --keep-base), and 
since i wrote the initial version of rewind, i initiate new reshapes 
much less often. i basically move freely between the commits in the 
branch.
inserting an additional step of aborting prior to redoing feels just 
clumsy.
at this point i'm actually thinking in the opposite direction: introduce 
commands that let me move by a few commits without even opening the todo 
editor (where have i seen that already? jj?).

the second aspect is performance/resource usage.
the intermediate abort would potentially touch a lot of files each time.  
that costs ssd life and often unneeded recompiles.
and given johannes' use case with *many* merges, rebasing from scratch 
would waste *quite* some time. as i pointed out in the other mail, my 
approach currently suffers from that as well, but it would be rather 
easy to sidestep it. your approach otoh would definitely need a 
fundamental improvement to the skipping algo (*).

(*) this of course sounds like a good idea regardless, but it's not 
necessarily wise to bet on it. i think the problem here is that redoing 
merges is *expected* to be "lossy". if they were marked for replay as 
proposed in https://github.com/gitgitgadget/git/pull/1491 , one could 
also just skip over them.

