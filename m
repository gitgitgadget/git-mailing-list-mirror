From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 3/3] upload-archive: use start_command instead of fork
Date: Thu, 7 Jul 2011 18:44:27 -0400
Message-ID: <20110707224427.GB23273@sigill.intra.peff.net>
References: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
 <1310038989-5724-4-git-send-email-kusmabite@gmail.com>
 <20110707191528.GD12044@sigill.intra.peff.net>
 <CABPQNSYZqpfGwgQXqk4YFBXhSHTen1w7m2hwaF7YDsZmsaYY5Q@mail.gmail.com>
 <20110707222726.GA23424@sigill.intra.peff.net>
 <CABPQNSbUx3Z-JCsr1rpjqEvKHSoOLnRP3f7pN6cMfNEiNoZBhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 00:44:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QexJC-0002Rk-Gy
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 00:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab1GGWo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 18:44:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53326
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab1GGWo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 18:44:29 -0400
Received: (qmail 3346 invoked by uid 107); 7 Jul 2011 22:44:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Jul 2011 18:44:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2011 18:44:27 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSbUx3Z-JCsr1rpjqEvKHSoOLnRP3f7pN6cMfNEiNoZBhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176787>

On Fri, Jul 08, 2011 at 12:37:48AM +0200, Erik Faye-Lund wrote:

> > Yeah, exactly. The current code is already using dup2 in the same way.
> 
> It does, but I'm not entirely sure how dup2 works when start_async is
> implemented with threads. Won't cause the multiplexer to fail (the
> multiplexer and the archive-thread needs different stdouts), because
> file descriptors are process-resources, and not thread-resources?

Oh, right. I'm being a moron. Sorry.

> I guess I could dup stdout/stderr before dup2'ing, and have the
> multiplexer write to explicitly to the duped fds. It's starting to
> sound very confusing to my ears, but perhaps it's the best option
> still ;)

Yes, you would have to dup stdout in the muxer to a new fd, then write
to that explicitly. And then you would be free to dup the write half of
the async pipe to stdout. It's not all that complicated, but maybe it is
simpler and more obvious (especially to a later reader of the code) to
just run a separate command.

-Peff
