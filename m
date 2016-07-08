Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6C82070D
	for <e@80x24.org>; Fri,  8 Jul 2016 20:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbcGHU3X (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 16:29:23 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44295 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbcGHU3V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 16:29:21 -0400
Received: from mfilter40-d.gandi.net (mfilter40-d.gandi.net [217.70.178.171])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id C510FA80C6;
	Fri,  8 Jul 2016 22:29:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter40-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter40-d.gandi.net (mfilter40-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id b_IP5n19LqhX; Fri,  8 Jul 2016 22:29:18 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2EAE6A80BF;
	Fri,  8 Jul 2016 22:29:16 +0200 (CEST)
Date:	Fri, 8 Jul 2016 13:29:15 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
Message-ID: <20160708202650.GA25024@x>
References: <20160708025948.GA3226@x>
 <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
 <20160708064448.GA18043@x>
 <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 10:14:33AM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > That sounds reasonable.  And if they *do* end up taking any time to
> > traverse, it's because they weren't reachable from other anchoring
> > points, so taking the extra time to traverse them seems fine.
> 
> The only thing that is hard is to clearly define _what_ are the new
> anchoring points.
> 
> It cannot be "anything directly under .git that has all-caps name
> that ends with _HEAD".  The ones we write we know are going to be
> removed at some point in time (e.g. "git reset", "git bisect reset",
> "git merge --abort", etc.).  We do not have any control on random
> ones that the users and third-party tools leave behind, holding onto
> irrelevant objects forever.

"We don't understand it, so it must not be important" does not seem like
a safe approach.  An object matching "[_A-Z]*HEAD" might act more like a
detached HEAD, referencing objects the user wants to hold onto
permanently.  And even FETCH_HEAD might point to objects the user
expected to stick around until they chose to ignore them; what makes
FETCH_HEAD a less legitimate head to work with than refs/heads/scratch?
(Or, for that matter, what about an ugly merge in MERGE_HEAD that the
user put off until after a vacation?)

The only downside of "holding onto irrelevant objects forever" is
storage space, which the user can easily reclaim by removing HEADs they
don't want.  The downside of pruning objects the user wanted is data
loss.  Why not just mark all those objects as roots for reachability
permanently, and let the user remove them if they want to prune those
objects?

- Josh Triplett
