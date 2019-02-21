Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4BF1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 17:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfBURdu convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 21 Feb 2019 12:33:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:50414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfBURdu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 12:33:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08B18ABD5;
        Thu, 21 Feb 2019 17:33:49 +0000 (UTC)
Date:   Thu, 21 Feb 2019 18:33:48 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is
 deleted.
Message-ID: <20190221183348.30f759c2@kitsune.suse.cz>
In-Reply-To: <CAPig+cTQMZFF-oX-SOzB5JR=V1WThBihC+kNm-2wjbpAWf-OHA@mail.gmail.com>
References: <cover.1550508544.git.msuchanek@suse.de>
        <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
        <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com>
        <20190221145056.53b98b2a@kitsune.suse.cz>
        <adc0f7f9-aa41-780e-6fce-94d493fac318@talktalk.net>
        <CAPig+cTQMZFF-oX-SOzB5JR=V1WThBihC+kNm-2wjbpAWf-OHA@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Feb 2019 12:12:28 -0500
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Thu, Feb 21, 2019 at 12:07 PM Phillip Wood <phillip.wood@talktalk.net> wrote:
> > On 21/02/2019 13:50, Michal Suchánek wrote:  
> > >> On Tue, Feb 19, 2019 at 12:05 AM Michal Suchanek <msuchanek@suse.de> wrote:  
> > > The problem is we don't forbid worktree names ending with ".lock".
> > > Which means that if we start to forbid them now existing worktrees
> > > might become inaccessible.  
> >
> > I think it is also racy as the renaming breaks the use of mkdir erroring
> > out if the directory already exists. One solution is to have a lock
> > entry in $GIT_COMMON_DIR/worktree-locks and make sure the code that
> > iterates over the entries in $GIT_COMMON_DIR/worktrees skips any that
> > have a corresponding ignores in $GIT_COMMON_DIR/worktree-locks. If the
> > worktree-locks/<dir> is created before worktree/<dir> then it should be
> > race free (you will have to remove the lock if the real entry cannot be
> > created and then increment the counter and try again). Entries could
> > also be locked on removal to prevent a race there.  
> 
> I wonder, though, how much this helps or hinders the use-case which
> prompted this patch series in the first place; to wit, creating
> hundreds or thousands of worktrees. Doing so serially was too slow, so
> the many "git worktree add" invocations were instead run in parallel
> (which led to "discovery" of race conditions). Using a global worktree
> lock would serialize worktree creation, thus slowing it down once
> again.

I created thousands of worktrees only for stress-testing. The real
workload needs only a dozen of them. That still leads to hitting a
race condition occasionally and automation failure.

Creating a separate lock directory will probably work. The question is
when do you need to take the lock. Before adding a worktree, sure.
Before deleting it as well. The problem is that deleting a worktree
successfully without creating some broken state needs to exclude
processes that might add stuff in the worktree directory. How many
operations then do *not* need to take the lock?

Thanks

Michal
