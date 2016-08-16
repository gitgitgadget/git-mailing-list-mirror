Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91B21F859
	for <e@80x24.org>; Tue, 16 Aug 2016 16:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbcHPQia (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:38:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:56340 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752466AbcHPQia (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 12:38:30 -0400
Received: (qmail 17871 invoked by uid 109); 16 Aug 2016 16:31:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 16:31:48 +0000
Received: (qmail 27748 invoked by uid 111); 16 Aug 2016 16:31:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 12:31:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 12:31:45 -0400
Date:	Tue, 16 Aug 2016 12:31:45 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org
Subject: Re: upload-pack/ls-remote: showing non-HEAD symbolic refs?
Message-ID: <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
References: <20160816161838.klvjhhoxsftvkfmd@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160816161838.klvjhhoxsftvkfmd@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 09:18:39AM -0700, Josh Triplett wrote:

> Commit 5e7dcad771cb873e278a0571b46910d7c32e2f6c in September 2013 added
> support to upload-pack to show the symbolic target of non-HEAD symbolic
> refs.  However, commit d007dbf7d6d647dbcf0f357545f43f36dec46f3b in
> November 2013 reverted that, because it used a capability to transmit
> the information, and capabilities have a limited size (limited by the
> pkt-line format which can't send lines longer than 64k) and can't
> transmit an arbitrary number of symrefs.
> 
> (Incidentally, couldn't the same problem occur if the HEAD points to a
> long enough path to exceed 64k?

Yes. But it's a lot easier to say "your 64k symref is ridiculous; don't
do that" than it is to say "oh, you happened to have a lot of symrefs in
your repository, so we overflowed and failed".

Besides which, the whole protocol cannot handle refnames larger than
64k, so it's not a new problem.

> I'd like to be able to see the targets of non-HEAD symbolic refs for a
> repository (symbolic refs under refs/).  I'm interested in extending
> upload-pack to expose those somehow.  What seems like a sensible format
> to do so?
> 
> Would it make sense to advertise a new capability for symbolic ref
> targets, which would allow the client to send back a dedicated request
> for the targets of all symrefs?

It will definitely require a new capability. You cannot just send a
"\0symref=..." trailer after each ref, because older clients treat
multiple "\0" trailers as overwriting one another (so it essentially
overwrites the old capabilities).

Sadly you cannot use a capability to fix that, because all of this
happens before the client agrees to any capabilities (you can find
discussion of a "v2" protocol on the list which solves this, but it's
sort of languishing in the design phase).

So you are stuck introducing a new phase into the protocol, which is
probably rather tricky (especially with the http protocol, which is very
sensitive to extra round-trips). I guess the least-invasive way would be
to communicate the desires in the "want" phase, and then have the server
dump it out with the packfile. Like:

  - server claims "I support symref-wants" in the capability phase

  - during the negotiation phase, in addition to "want" and "have", the
    client may send "symref <ref>" packets. Probably <ref> should be a
    wildcard to avoid having to ask about each ref individually.

  - before outputting the packfile in the final phase, if any "symref"
    wants were sent by the client, the server dumps a list of "symref
    <from> <to>" packets, followed by a flush packet.

That should Just Work over the existing http protocol without requiring
an extra request.

-Peff
