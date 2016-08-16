Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE981F859
	for <e@80x24.org>; Tue, 16 Aug 2016 20:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbcHPUeh (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:34:37 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40195 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbcHPUef (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:34:35 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A69BCA80C6;
	Tue, 16 Aug 2016 22:34:21 +0200 (CEST)
Date:	Tue, 16 Aug 2016 13:34:20 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Stefan Beller <sbeller@google.com>
Cc:	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: upload-pack/ls-remote: showing non-HEAD symbolic refs?
Message-ID: <20160816203420.GB16774@cloud>
References: <20160816161838.klvjhhoxsftvkfmd@x>
 <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
 <20160816173444.rpqlpsz2ognvlufy@x>
 <20160816182852.inyqzplee5m3wzt6@sigill.intra.peff.net>
 <CAGZ79kZ7dzh6AhQRQZsEFdWB4MQxW431yfDuEXao=k_meNE8Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ7dzh6AhQRQZsEFdWB4MQxW431yfDuEXao=k_meNE8Nw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 11:50:11AM -0700, Stefan Beller wrote:
> On Tue, Aug 16, 2016 at 11:28 AM, Jeff King <peff@peff.net> wrote:
> > On Tue, Aug 16, 2016 at 10:34:44AM -0700, Josh Triplett wrote:
> >
> >> > Sadly you cannot use a capability to fix that, because all of this
> >> > happens before the client agrees to any capabilities (you can find
> >> > discussion of a "v2" protocol on the list which solves this, but it's
> >> > sort of languishing in the design phase).
> >>
> >> As a potential 1.1 version, which could work in a backward-compatible
> >> way with existing servers and no additional round-trip: what if, in the
> >> smart HTTP protocol, the client advertised client capabilities with an
> >> additional HTTP header (e.g.  "Git-Client-Caps: symrefs othershiny
> >> featurenames"?  git-http-backend could then pass those capabilities to
> >> git-upload-pack (--client-caps='...'), which could take them into
> >> account in the initial response?
> >>
> >> That wouldn't work as a single-pass approach for SSH, since the client
> >> can't know if the server's upload-pack supports --client-caps, but it
> >> would work for the smart HTTP protocol.
> >
> > You can dig up the discussion on the list under the name "protocol v2",
> > but basically yes, that approach has been considered. It's a little
> > gross just because it leaves other protocols behind http (and it is not
> > necessarily a good idea to push people into http, because it has some
> > fundamental drawbacks over the other protocols because of its
> > half-duplex nature).
> 
> Some more thoughts on protocol v2 (the good parts to be attributed to
> jrnieder@gmail.com):
> 
> * In case of http we can use the http header and know information
>   about the client, i.e. if it may support the following ideas:
> 
> * Instead of introducing a new protocol we introduce a capability\
>   "resend-ref-advertisement" and only advertise very few refs (e.g.
>   only the branches, not the pending changes in case of Gerrit)
> 
> * The client can then ignore the refs advertisement and ask for a resend
>   of the refs with more specification,
>   e.g. "want refs/heads/*", so allowing more than just sha1s in the
>   want line but complex things like branch patterns.

That seems like something a client could advertise via client
capabilities.  For instance, if the client doesn't want the initial refs
list, only the server capabilities, it could say "capsonly".  (It might
also be reasonable to cache the knowledge that a server supports client
capabilities, though not any specific capability.)
