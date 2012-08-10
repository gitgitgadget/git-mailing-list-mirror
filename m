From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 03:53:42 -0400
Message-ID: <20120810075342.GA30072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:54:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szk2f-0006Ze-1v
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 09:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509Ab2HJHxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 03:53:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60059 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754856Ab2HJHxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 03:53:49 -0400
Received: (qmail 27082 invoked by uid 107); 10 Aug 2012 07:53:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 03:53:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 03:53:42 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203206>

On Fri, Aug 03, 2012 at 12:19:16PM -0400, Jeff King wrote:

> Instead of having the client advertise a particular version
> number in the git protocol, we have managed extensions and
> backwards compatibility by having clients and servers
> advertise capabilities that they support. This is far more
> robust than having each side consult a table of
> known versions, and provides sufficient information for the
> protocol interaction to complete.
> 
> However, it does not allow servers to keep statistics on
> which client versions are being used. This information is
> not necessary to complete the network request (the
> capabilities provide enough information for that), but it
> may be helpful to conduct a general survey of client
> versions in use.
> 
> We already send the client version in the user-agent header
> for http requests; adding it here allows us to gather
> similar statistics for non-http requests.

Ugh, the jk/version-string topic breaks fetching from Google Code. With
my patch, the client unconditionally sends an "agent=foo" capability,
but the server does not like seeing the unknown capability and ends the
connection (I'm guessing with some kind of internal exception, since it
spews "Internal server error" over the protocol channel).

This is the right thing to do according to protocol-capabilities.txt,
which says:

  Client will then send a space separated list of capabilities it wants
  to be in effect. The client MUST NOT ask for capabilities the server
  did not say it supports.

  Server MUST diagnose and abort if capabilities it does not understand
  was sent.  Server MUST NOT ignore capabilities that client requested
  and server advertised.  As a consequence of these rules, server MUST
  NOT advertise capabilities it does not understand.

However, that is not how git-core behaves. Its server side will ignore
an unknown capability coming from the client (so not only is it more
lenient about what the client does, but it does not follow the "MUST"
directives in the second paragraph).

This isn't a huge deal for this topic; any server that is collecting the
data should be advertising anyway. The only ones who would miss out are
humans trying to debug client behavior via tcpdump or similar, when the
server side is an older version of git.

That's probably acceptable, given that the alternative is changing Google
Code's implementation, along with finding out how many other
implementations might have followed that spec strictly. We might or
might not want to loosen the "MUST" bits in that document, since git
itself does not follow them.

Here's a patch series that goes on top of jk/version-string:

  [1/4]: send-pack: fix capability-sending logic

This one is a minor bug fix in the same area.

  [2/4]: do not send client agent unless server does first

The actual fix.

  [3/4]: connect: learn to parse capabilities with values
  [4/4]: fetch-pack: mention server version with verbose output

A bonus feature. I'm not sure if they are worth doing or not. I'd
really expect somebody debugging a protocol issue to just use
GIT_TRACE_PACKET, and then they can read it straight from the packet
dump themselves.

-Peff
