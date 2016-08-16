Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B67DA1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 17:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbcHPRex (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 13:34:53 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44410 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbcHPRew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 13:34:52 -0400
Received: from mfilter20-d.gandi.net (mfilter20-d.gandi.net [217.70.178.148])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 6E14CFB8BC;
	Tue, 16 Aug 2016 19:34:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter20-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter20-d.gandi.net (mfilter20-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id DmVee8e6Y-kv; Tue, 16 Aug 2016 19:34:47 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EE13FFB882;
	Tue, 16 Aug 2016 19:34:46 +0200 (CEST)
Date:	Tue, 16 Aug 2016 10:34:44 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: upload-pack/ls-remote: showing non-HEAD symbolic refs?
Message-ID: <20160816173444.rpqlpsz2ognvlufy@x>
References: <20160816161838.klvjhhoxsftvkfmd@x>
 <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 12:31:45PM -0400, Jeff King wrote:
> On Tue, Aug 16, 2016 at 09:18:39AM -0700, Josh Triplett wrote:
> 
> > Commit 5e7dcad771cb873e278a0571b46910d7c32e2f6c in September 2013 added
> > support to upload-pack to show the symbolic target of non-HEAD symbolic
> > refs.  However, commit d007dbf7d6d647dbcf0f357545f43f36dec46f3b in
> > November 2013 reverted that, because it used a capability to transmit
> > the information, and capabilities have a limited size (limited by the
> > pkt-line format which can't send lines longer than 64k) and can't
> > transmit an arbitrary number of symrefs.
> > 
> > (Incidentally, couldn't the same problem occur if the HEAD points to a
> > long enough path to exceed 64k?
> 
> Yes. But it's a lot easier to say "your 64k symref is ridiculous; don't
> do that" than it is to say "oh, you happened to have a lot of symrefs in
> your repository, so we overflowed and failed".
> 
> Besides which, the whole protocol cannot handle refnames larger than
> 64k, so it's not a new problem.

Absolutely agreed.  I mentioned it only because if a server provided any
mechanism to send it symbolic ref targets, this could lead to a
situation where you could push a repository that you could not
subsequently pull.  Depending on the protocols involved, that could
potentially require manual admin intervention, or could even result in a
DoS.

Not something that can arise with git itself, as send-pack/receive-pack
doesn't support sending symbolic ref targets, but I could imagine a
server doing so to allow setting HEAD.

> > I'd like to be able to see the targets of non-HEAD symbolic refs for a
> > repository (symbolic refs under refs/).  I'm interested in extending
> > upload-pack to expose those somehow.  What seems like a sensible format
> > to do so?
> > 
> > Would it make sense to advertise a new capability for symbolic ref
> > targets, which would allow the client to send back a dedicated request
> > for the targets of all symrefs?
> 
> It will definitely require a new capability. You cannot just send a
> "\0symref=..." trailer after each ref, because older clients treat
> multiple "\0" trailers as overwriting one another (so it essentially
> overwrites the old capabilities).
> 
> Sadly you cannot use a capability to fix that, because all of this
> happens before the client agrees to any capabilities (you can find
> discussion of a "v2" protocol on the list which solves this, but it's
> sort of languishing in the design phase).

As a potential 1.1 version, which could work in a backward-compatible
way with existing servers and no additional round-trip: what if, in the
smart HTTP protocol, the client advertised client capabilities with an
additional HTTP header (e.g.  "Git-Client-Caps: symrefs othershiny
featurenames"?  git-http-backend could then pass those capabilities to
git-upload-pack (--client-caps='...'), which could take them into
account in the initial response?

That wouldn't work as a single-pass approach for SSH, since the client
can't know if the server's upload-pack supports --client-caps, but it
would work for the smart HTTP protocol.

> So you are stuck introducing a new phase into the protocol, which is
> probably rather tricky (especially with the http protocol, which is very
> sensitive to extra round-trips). I guess the least-invasive way would be
> to communicate the desires in the "want" phase, and then have the server
> dump it out with the packfile. Like:
> 
>   - server claims "I support symref-wants" in the capability phase
> 
>   - during the negotiation phase, in addition to "want" and "have", the
>     client may send "symref <ref>" packets. Probably <ref> should be a
>     wildcard to avoid having to ask about each ref individually.
> 
>   - before outputting the packfile in the final phase, if any "symref"
>     wants were sent by the client, the server dumps a list of "symref
>     <from> <to>" packets, followed by a flush packet.
> 
> That should Just Work over the existing http protocol without requiring
> an extra request.

It'd require one extra request for git ls-remote, which normally doesn't
need the second round-trip, but that still seems reasonable.
