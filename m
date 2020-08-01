Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CAAC433DF
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 07:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908842071E
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 07:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgHAHPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 03:15:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHAHPX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 03:15:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78A52AE38;
        Sat,  1 Aug 2020 07:15:35 +0000 (UTC)
Date:   Sat, 1 Aug 2020 09:15:20 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fmt-merge-msg: selectively suppress "into
 <branch>"
Message-ID: <20200801071520.GD32107@kitsune.suse.cz>
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
 <20200730180237.1392480-1-gitster@pobox.com>
 <20200731004202.GA240563@coredump.intra.peff.net>
 <xmqqy2n04ezk.fsf@gitster.c.googlers.com>
 <20200731022217.GA825094@coredump.intra.peff.net>
 <20200731200306.GB3409@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731200306.GB3409@syl.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 04:03:06PM -0400, Taylor Blau wrote:
> On Thu, Jul 30, 2020 at 10:22:17PM -0400, Jeff King wrote:
> > On Thu, Jul 30, 2020 at 07:04:15PM -0700, Junio C Hamano wrote:
> >
> > > You'd rather want to "lie" about the destination branch while
> > > redoing these merges, perhaps with
> > >
> > > 	$ git merge --pretend-dest=jch topic-name
> > >
> > > with your HEAD detached, and tell fmt-merge-msg to pretend that the
> > > merge is being made into jch branch.  And that is outside the scope
> > > of this patch, though it might be a good #leftoverbits candidate.
> >
> > Since nobody really asked for it, it may make sense to wait for such a
> > feature. After all, this is the just the starting text we put into the
> > merge message. You are always free to add the pretend branch yourself in
> > the editor.
> >
> > > >   - should "master" be in the list even if you configure a value? That
> > > >     would do the wrong thing if you have a non-integration master, but
> > > >     that seems unlikely. And it would do the right thing if somebody
> > > >     later puts "main" in merge.suppressDest, but still occasionally
> > > >     works with "master" repos (where "right" is defined as "what they
> > > >     probably wanted", but it is perhaps a bit magical).
> > >
> > > If you configure, you can configure it fully without manually
> > > clearing first.  If you do not configure, you get a backward
> > > compatible default.  I think that is the only sensible semantics.
> > >
> > > Besides, I thought we were aiming to make 'master' less special.
> > > When a user already has a concrete list of things to use shorter
> > > merge title for, why should 'master' be magically added to the list
> > > and force the user to explicitly clear it?  I do not think that
> > > makes much sense.
> >
> > It's magic-ness would be purely for backwards compatibility. IMHO
> > maintaining exact behavior with respect to this particular case was not
> > a big deal, but clearly Linus disagrees. But the "do the right thing
> > above" I mentioned above is "do the right thing even if the user _did_
> > switch their config to a new name, but forgot that they sometimes are
> > working with old repos". So it is perhaps an even weaker reason.
> 
> I think that you could do this without treating 'master' as specially by
> making 'merge.suppressDest' contain the value of 'init.defaultBranch'
> (unless set otherwise).
> 
> This gets tricky when the fall-back value for 'init.defaultBranch'
> changes, though. If it were to go from 'master' -> 'main', you'd want to
> have both of those defaults in your 'merge.suppressDest' list, to avoid
> breaking clients who still use 'master' (and expect 'into master' not to
> show up in their merges).
> 
> So, I guess the rule would be: 'merge.suppressDest' contains the value
> of 'init.defaultBranch' (or its default value) along with any previous
> default values for 'init.defaultBranch', unless specified otherwise.
> 

IMHO this is way better than spome magic variable that you ahve to
assign magic value for it to have teh value you assign. Seen this in
systemd and it is not very nice to deal with.

Thanks

Michal
