Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1117A2018E
	for <e@80x24.org>; Sat,  9 Jul 2016 14:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541AbcGIOJk (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 10:09:40 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53336 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbcGIOJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 10:09:39 -0400
Received: from mfilter44-d.gandi.net (mfilter44-d.gandi.net [217.70.178.175])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 04042A80D1;
	Sat,  9 Jul 2016 16:09:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter44-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter44-d.gandi.net (mfilter44-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id kb8-yrig5cRd; Sat,  9 Jul 2016 16:09:34 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 24EF2A80BE;
	Sat,  9 Jul 2016 16:09:32 +0200 (CEST)
Date:	Sat, 9 Jul 2016 07:09:31 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
Message-ID: <20160709140931.GA3185@x>
References: <20160708025948.GA3226@x>
 <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
 <20160708064448.GA18043@x>
 <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607090928500.6426@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607090928500.6426@virtualbox>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 09, 2016 at 09:35:24AM +0200, Johannes Schindelin wrote:
> On Fri, 8 Jul 2016, Junio C Hamano wrote:
> > Josh Triplett <josh@joshtriplett.org> writes:
> > 
> > > That sounds reasonable.  And if they *do* end up taking any time to
> > > traverse, it's because they weren't reachable from other anchoring
> > > points, so taking the extra time to traverse them seems fine.
> > 
> > The only thing that is hard is to clearly define _what_ are the new
> > anchoring points.
> > 
> > It cannot be "anything directly under .git that has all-caps name
> > that ends with _HEAD".  The ones we write we know are going to be
> > removed at some point in time (e.g. "git reset", "git bisect reset",
> > "git merge --abort", etc.).  We do not have any control on random
> > ones that the users and third-party tools leave behind, holding onto
> > irrelevant objects forever.
> 
> Please note that bisect already uses the (transient) refs/bisect/
> namespace. So I do not think we need to take specific care of the
> BISECT_* files.
> 
> If we had thought of it back then, we could have used such a transient
> namespace also for FETCH_HEAD, CHERRY_PICK_HEAD and also for detached
> HEADs (which we should have called "unnamed branches").
> 
> Now, how about special-casing *just* these legacy files in gc: HEAD,
> FETCH_HEAD, MERGE_HEAD and CHERRY_PICK_HEAD? Any new transient refs should
> live in the refs/ namespace, which is already handled.

That seems workable as well; in that case, we should also document this
(in the git-gc manpage at a minimum), and explicitly suggest creating
refs in refs/ but outside of refs/heads/ and refs/tags/, rather than
directly in .git/.

> BTW this issue is getting much more problematic when you have a lot of
> worktrees, some of which operate on detached HEADs. Which I do.
> 
> Ciao,
> Dscho
