Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316DF20248
	for <e@80x24.org>; Mon,  4 Mar 2019 13:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfCDNaJ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 4 Mar 2019 08:30:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:56660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfCDNaI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 08:30:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88254AE99;
        Mon,  4 Mar 2019 13:30:06 +0000 (UTC)
Date:   Mon, 4 Mar 2019 14:30:02 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     phillip.wood@dunelm.org.uk,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is
 deleted.
Message-ID: <20190304143002.56a6c4ec@kitsune.suse.cz>
In-Reply-To: <4309841e-2b98-22d4-505e-1b9ea2f5e3bb@talktalk.net>
References: <cover.1550508544.git.msuchanek@suse.de>
        <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
        <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com>
        <20190221145056.53b98b2a@kitsune.suse.cz>
        <adc0f7f9-aa41-780e-6fce-94d493fac318@talktalk.net>
        <CAPig+cTQMZFF-oX-SOzB5JR=V1WThBihC+kNm-2wjbpAWf-OHA@mail.gmail.com>
        <4309841e-2b98-22d4-505e-1b9ea2f5e3bb@talktalk.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, 21 Feb 2019 17:27:04 +0000
Phillip Wood <phillip.wood@talktalk.net> wrote:

> Hi Eric
> 
> On 21/02/2019 17:12, Eric Sunshine wrote:
> > On Thu, Feb 21, 2019 at 12:07 PM Phillip Wood <phillip.wood@talktalk.net> wrote:  
> >> On 21/02/2019 13:50, Michal Suchánek wrote:  
> >>>> On Tue, Feb 19, 2019 at 12:05 AM Michal Suchanek <msuchanek@suse.de> wrote:  
> >>> The problem is we don't forbid worktree names ending with ".lock".
> >>> Which means that if we start to forbid them now existing worktrees
> >>> might become inaccessible.  
> >>
> >> I think it is also racy as the renaming breaks the use of mkdir erroring
> >> out if the directory already exists. One solution is to have a lock
> >> entry in $GIT_COMMON_DIR/worktree-locks and make sure the code that
> >> iterates over the entries in $GIT_COMMON_DIR/worktrees skips any that
> >> have a corresponding ignores in $GIT_COMMON_DIR/worktree-locks. If the
> >> worktree-locks/<dir> is created before worktree/<dir> then it should be
> >> race free (you will have to remove the lock if the real entry cannot be
> >> created and then increment the counter and try again). Entries could
> >> also be locked on removal to prevent a race there.  
> > 
> > I wonder, though, how much this helps or hinders the use-case which
> > prompted this patch series in the first place; to wit, creating
> > hundreds or thousands of worktrees. Doing so serially was too slow, so
> > the many "git worktree add" invocations were instead run in parallel
> > (which led to "discovery" of race conditions). Using a global worktree
> > lock would serialize worktree creation, thus slowing it down once
> > again.  
> 
> The idea is that there are per-worktree lock stored under worktree-locks 
> (hence the plural name). Using a separate directory for the locks gets 
> round the problems of name clashes between the lock for a worktree 
> called foo and one called foo.lock and means we can rely on mkdir 
> erroring out if the worktree name already exists as there is no renaming.

I suppose this separate directory would work. When are you supposed to
take the lock, though?

When adding worktree, sure.

When managing worktrees, sure. Otherwise you would see the incomplete
worktrees.

When doing anything in git? Probably. Because otherwise you could
accidentally use the incomplete worktree. Or somebody deleting worktree
would fail removing it because you would keep adding files to it.

Isn't git supposed to allow parallel access to the repository?

As things stand if you wanted to implement worktree locking you would
need to lock the worktree for *every* operation that touches it, and
for many operations you would have to lock/unlock *all* worktrees one by
one to find the worktree you are supposed to work on.

I don't feel like adding locking to all of git to fix this problem.

Sure, adding enough locking to ensure repository consistency at all
times would be nice but it also needs to be granular enough to not harm
performance. I can't say I understand the git repository layout and
usage well enough to design that.

Thanks

Michal
