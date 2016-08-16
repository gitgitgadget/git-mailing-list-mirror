Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0113D1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 20:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbcHPUb4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:31:56 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46696 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbcHPUby (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:31:54 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2AC6017209D;
	Tue, 16 Aug 2016 22:31:50 +0200 (CEST)
Date:	Tue, 16 Aug 2016 13:31:50 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: upload-pack/ls-remote: showing non-HEAD symbolic refs?
Message-ID: <20160816203150.GA16774@cloud>
References: <20160816161838.klvjhhoxsftvkfmd@x>
 <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
 <20160816173444.rpqlpsz2ognvlufy@x>
 <20160816182852.inyqzplee5m3wzt6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160816182852.inyqzplee5m3wzt6@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 02:28:52PM -0400, Jeff King wrote:
> On Tue, Aug 16, 2016 at 10:34:44AM -0700, Josh Triplett wrote:
> 
> > > Sadly you cannot use a capability to fix that, because all of this
> > > happens before the client agrees to any capabilities (you can find
> > > discussion of a "v2" protocol on the list which solves this, but it's
> > > sort of languishing in the design phase).
> > 
> > As a potential 1.1 version, which could work in a backward-compatible
> > way with existing servers and no additional round-trip: what if, in the
> > smart HTTP protocol, the client advertised client capabilities with an
> > additional HTTP header (e.g.  "Git-Client-Caps: symrefs othershiny
> > featurenames"?  git-http-backend could then pass those capabilities to
> > git-upload-pack (--client-caps='...'), which could take them into
> > account in the initial response?
> > 
> > That wouldn't work as a single-pass approach for SSH, since the client
> > can't know if the server's upload-pack supports --client-caps, but it
> > would work for the smart HTTP protocol.
> 
> You can dig up the discussion on the list under the name "protocol v2",
> but basically yes, that approach has been considered. It's a little
> gross just because it leaves other protocols behind http (and it is not
> necessarily a good idea to push people into http, because it has some
> fundamental drawbacks over the other protocols because of its
> half-duplex nature).

I looked through the "protocol v2" threads, but couldn't find any
discussions of using HTTP headers.  I found some mentions of using
additional query parameters on the git-upload-pack request, which would
break compatibility with existing servers (they won't just ignore the
extra parameter).

--client-caps could work for SSH as well, it just requires an extra
round-trip to check for --client-caps.  Call git-upload-pack
--supports-client-caps, ignore any output (which with current git will
consist of a usage message), see if it returns a 0 exit code, if so,
call git-upload-pack --client-caps='...', and if not just call
git-upload-pack.  (A new git-upload-pack-2 binary would also work, but
that seems like overkill.)  I don't see any way around the extra round
trip here that would preserve backward compatibility with existing SSH
servers (which may force clients to *only* run exactly the command
"git-upload-pack" and nothing else).

Another possibility, which would work for both HTTPS and
git-protocol-over-TLS, would be to use ALPN.

git:// , however, would require a new service name, and that service
would have to accept client caps in-band.  That doesn't seem nearly as
important to support, though.  And that approach doesn't seem preferable
for HTTP, which would require modification to server configuration to
support the new path rather than an HTTP header to the existing path.
