Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF492023C
	for <e@80x24.org>; Fri,  8 Jul 2016 06:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbcGHGo6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 02:44:58 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49996 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbcGHGo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 02:44:57 -0400
Received: from mfilter23-d.gandi.net (mfilter23-d.gandi.net [217.70.178.151])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 68983A80DB;
	Fri,  8 Jul 2016 08:44:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter23-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter23-d.gandi.net (mfilter23-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id FrFwg90GPh61; Fri,  8 Jul 2016 08:44:51 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 04165A80F0;
	Fri,  8 Jul 2016 08:44:50 +0200 (CEST)
Date:	Thu, 7 Jul 2016 23:44:49 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
Message-ID: <20160708064448.GA18043@x>
References: <20160708025948.GA3226@x>
 <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 07, 2016 at 09:34:02PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> > This could result in data loss, if a user expected that having an object
> > referenced from those places would protect it from pruning.
> 
> Yeah, luckily, nobody expects such.  I do not think any of our
> document says nothing other than HEAD like CHERRY_PICK_HEAD is
> reachability anchoring point; they are designed to be transient.

I can imagine at least one scenario that would result in data loss here:
git pull a URL (not referenced via any ref other than
FETCH_HEAD/MERGE_HEAD), get a merge conflict, get halfway through
resolving it, set that repository aside for a while, do something that
triggers a gc, then attempt to finish and commit.

Unlikely, but not impossible.  Same reason the reachability logic looks
at the index.

(I originally encountered this because I intended to add another
HEAD-like ref in .git, so I started investigating the logic around such
HEADs.)

> Because they are designed to be transient, I do not think there is
> any downside (other than the initial start-up cost) to including
> them in reachability computation.  Because they are meant to be
> transient, the objects anchored by them would be reachable from
> other anchoring points anyway.

That sounds reasonable.  And if they *do* end up taking any time to
traverse, it's because they weren't reachable from other anchoring
points, so taking the extra time to traverse them seems fine.

- Josh Triplett
