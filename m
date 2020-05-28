Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4011C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF662207BC
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407226AbgE1UZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 16:25:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:60882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407204AbgE1UZo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 16:25:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6A36BAD5D;
        Thu, 28 May 2020 20:25:39 +0000 (UTC)
Date:   Thu, 28 May 2020 22:25:38 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Assessing about commit order in upstream Linux
Message-ID: <20200528202538.GK25173@kitsune.suse.cz>
References: <20200526065320.GA18107@lxhi-065.adit-jv.com>
 <xmqqr1v6oh6y.fsf@gitster.c.googlers.com>
 <20200526171443.GE25173@kitsune.suse.cz>
 <20200528181226.GB9275@lxhi-065.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528181226.GB9275@lxhi-065.adit-jv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 08:12:26PM +0200, Eugeniu Rosca wrote:
> Hi Michal,
> 
> On Tue, May 26, 2020 at 07:14:43PM +0200, Michal Suchánek wrote:
> > On Tue, May 26, 2020 at 08:21:25AM -0700, Junio C Hamano wrote:
> > > Eugeniu Rosca <erosca@de.adit-jv.com> writes:
> > > 
> > > > So, the two approaches lead to different results. If you see any false
> > > > assumption or mistaken belief, could you please pinpoint that? TIA.
> > > 
> > > Perhaps the assumption/belief that the set of commits in a history
> > > can be totally ordered is the issue?  When multiple people work
> > > together on a project, especially in a project where "pull --no-ff"
> > > is not enforced, there can exist only partial order among them?
> > > 
> > As in if you have history with two branches
> > 
> >    D
> >   / \
> >  B   C
> >   \ /
> >    A
> > 
> > commits B and C are not comparable. They are both between A and D but
> > the order of B and C is arbitrary. Different renderings of the history
> > may choose different order of B and C. This is a simle example. Linux
> > history is a spaghetti of tens of branches.
> 
> While in theory 'B' and 'C' might look equivalent, IMHO in practice
> there is a clear distinction between the two. It's commonly known that
> Git refers to 'B' as the 'first parent' of 'D'. Git also provides means
> to identify such first parents via 'git log --first-parent'.
> 
> A fun fact about first parents is that, unless Linus is on vacation
> and hands over his responsibilities to GKH, you will be quite
> confident that 'git log --first-parent linux/master' will list
> stuff committed by Linus himself. That's why (I bet) in the minds
> of people involved in Linux development, the diagram looks like:
> 
>     D
>     | \
>     B  C
>     | /
>     A
And that's not the case. Commits B and C will typically com from
different subsystems, and are truly interchangeable. These subsystems,
again, will have number of separate branches that are merged together
before they are submitted to Linus. Often a feature requires cross-merge
between different subsystems which further complicates the history. Even
if B is a commit authored by Linus and you can infer from that it's on
the master branch it says nothing about order of B and C. They are
still not comparable. And you may still need to reconcile the changes in
B and C in D and whatever order you choose for backporting them you will
need to reflect D in both B and C in the conflicting case.

HTH

Michal
