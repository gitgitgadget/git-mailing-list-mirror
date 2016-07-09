Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731591F744
	for <e@80x24.org>; Sat,  9 Jul 2016 05:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546AbcGIFXX (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 01:23:23 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40175 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506AbcGIFXV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 01:23:21 -0400
Received: from mfilter44-d.gandi.net (mfilter44-d.gandi.net [217.70.178.175])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id AE10B1720A5;
	Sat,  9 Jul 2016 07:23:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter44-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter44-d.gandi.net (mfilter44-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id uh1-C_xDB1UM; Sat,  9 Jul 2016 07:23:18 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1C7E1172094;
	Sat,  9 Jul 2016 07:23:15 +0200 (CEST)
Date:	Fri, 8 Jul 2016 22:23:14 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
Message-ID: <20160709052314.GC23426@x>
References: <20160708025948.GA3226@x>
 <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
 <20160708064448.GA18043@x>
 <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
 <20160708192504.GL19871@thunk.org>
 <CAPc5daWDi1P-xFaEYf1zzz7m3g9wengQPjRzxhgu6jVM9AKtyQ@mail.gmail.com>
 <20160708235053.GA26097@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160708235053.GA26097@thunk.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 07:50:53PM -0400, Theodore Ts'o wrote:
> On Fri, Jul 08, 2016 at 01:30:06PM -0700, Junio C Hamano wrote:
> > 
> > I can imagine I'd start hacking on a project that I rarely touch, give up
> > resolving a "git pull" from an unconfigured place (hence, some stuff is
> > only reachable from FETCH_HEAD), and after 2*N days, come back
> > to the repository and find that I cannot continue working on it.
> 
> Sure, but that's something that could happen today, and no one has
> really complained, have they?

Until now. :)

> > Turning the rule to "*_HEAD we know about, and those we don't that
> > are young" would not change the situation, as I may be depending on
> > some third-party tool that uses its OWN_HEAD just like we use
> > FETCH_HEAD in the above example.
> > 
> > So I dunno if that is a good solution. If we are going to declare that
> > transient stuff will now be kept, i.e. keeping them alive is no longer
> > end user's responsibility, then probably we should make it end user's
> > responsibility to clean things up.
> 
> Well, the question is what does "transient" stuff really mean?  If we
> keep them forever, then are they really any different from stuff under
> refs/heads?

No, they're not.  And I don't think they should be; HEAD itself is *not*
transient, as a detached HEAD can reference valuable non-transient
objects.

In an ideal world, HEAD and all other such refs would live somewhere
under refs, to avoid the special case.

> Maybe pester the user if there is stale *_HEAD files, but don't
> actually get rid of the objects?

Why pester at all?  Just leave them, and if the user has large objects
they don't care about and wants to decrease the size of the repository,
they can follow the advice from the git-gc manpage: "If you are
expecting some objects to be collected and they aren’t, check all of
those locations and decide whether it makes sense in your case to remove
those references."  (Where "those locations" will need to expand to
mention "*HEAD".)

(Also, I'd suggest "*HEAD", possibly limited to characters matching
[-_A-Z], rather than "*_HEAD".)

- Josh Triplett
