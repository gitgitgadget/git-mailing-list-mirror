Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC341F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbfBULNy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 21 Feb 2019 06:13:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:41144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfBULNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:13:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA4DEAEFE;
        Thu, 21 Feb 2019 11:13:52 +0000 (UTC)
Date:   Thu, 21 Feb 2019 12:13:50 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] setup: don't fail if commondir reference is
 deleted.
Message-ID: <20190221121350.28015371@naga.suse.cz>
In-Reply-To: <CAPig+cT48d9JJyqVx0WvBiFV+BLqAqo5dX3yndNhoJZmKRPgEg@mail.gmail.com>
References: <cover.1550508544.git.msuchanek@suse.de>
        <37df7fd81c3dee990bd7723f18c94713a0d842b6.1550679076.git.msuchanek@suse.de>
        <CAPig+cQZNOWvaa5H2PKOs149KvRtEYRzrdLvzvFRDo4Qxaecaw@mail.gmail.com>
        <20190220181605.60bbc28d@kitsune.suse.cz>
        <CAPig+cS4vZpyj4Cx=Q89v3xTrCG4WbtX8EhTfOT2RKytjV-HrA@mail.gmail.com>
        <CAPig+cT48d9JJyqVx0WvBiFV+BLqAqo5dX3yndNhoJZmKRPgEg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Feb 2019 04:27:21 -0500
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Wed, Feb 20, 2019 at 1:35 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Wed, Feb 20, 2019 at 12:16 PM Michal Suchánek <msuchanek@suse.de> wrote:  
> > > On Wed, 20 Feb 2019 11:55:46 -0500
> > > Eric Sunshine <sunshine@sunshineco.com> wrote:  
> > > > On Wed, Feb 20, 2019 at 11:17 AM Michal Suchanek <msuchanek@suse.de> wrote:  
> > > > > Another even rarer issue is that the file might be zero size because another
> > > > > process initializing a worktree opened the file but has not written is content
> > > > > yet.  
> > > >
> > > > Based upon the explanation thus far, I'm having trouble understanding
> > > > under what circumstances these race conditions can arise. Are you
> > > > trying to invoke Git commands in a particular worktree even as the
> > > > worktree itself is being created?  
> > >
> > > It's explained in the following paragraph. If you have multiple
> > > worktrees some *other* worktreee may be uninitialized.  
> >
> > I understand that, but setup.c:get_common_dir_noenv() is concerned
> > only with _this_ worktree -- the one in which the Git command is being
> > run -- so it's not clear if or how some other partially-initialized
> > worktree could have any impact. (And, I'm having trouble fathoming how
> > it could, which is why I'm asking these questions).  
> 
> I still can't see how setup.c:get_common_dir_noenv() could be
> responsible for the behavior you're describing of _any_ Git command
> erroring out due to _any_ worktree being incompletely-initialized.
> However, I can imagine "git worktree add" itself being racy and
> failing due to a missing or empty "commondir" file for some other
> worktree since that command _does_ consult other worktree entries when
> validating the "add" operation via
> builtin/worktree.c:validate_worktree_add() which calls
> get_worktrees(). If get_worktrees() is subject to that raciness
> problem, then "git worktree add" will inherit that undesirable
> raciness behavior (as will other "git worktree" commands which call
> get_worktrees(), such as "git worktree list").
> 
> > Is it possible that when you saw that error message, it actually arose
> > from some code other than setup.c:get_common_dir_noenv()?  
> 
> So, I'm suspecting get_worktrincludes both itees() or some function it calls (and so
> on) as the racy culprit.

Yes, that's my explanation for the situation as well.

Thanks

Michal
