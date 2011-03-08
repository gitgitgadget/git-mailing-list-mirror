From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git cat-file does not terminate
Date: Tue, 8 Mar 2011 16:14:23 -0500
Message-ID: <20110308211423.GB4594@sigill.intra.peff.net>
References: <4D70E340.3050309@tweerlei.de>
 <20110304154014.GE24660@m62s10.vlinux.de>
 <20110304160047.GA9662@sigill.intra.peff.net>
 <7vzkpa7qmp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Baumann <waste.manager@gmx.de>,
	Robert Wruck <wruck@tweerlei.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:14:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4Eh-0002uB-Hj
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab1CHVOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 16:14:25 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56776
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046Ab1CHVOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:14:25 -0500
Received: (qmail 4395 invoked by uid 107); 8 Mar 2011 21:14:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Mar 2011 16:14:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2011 16:14:23 -0500
Content-Disposition: inline
In-Reply-To: <7vzkpa7qmp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168695>

On Fri, Mar 04, 2011 at 09:16:30AM -0800, Junio C Hamano wrote:

> How prevalent is the problematic cygwin1.dll 1.7.8?  Also for how long did
> this bug exist, in other words, if we were to make a table of problematic
> versions, would we have only just a handful entries in it?  Also can we at
> runtime find out what version we are running?
> 
> The reason I am asking these questions is because I think, assuming that
> this would affect many unsuspecting Cygwin users, the best fix would be to
> add a hook in the compat/ layer that decides if MAX_WRITE_SIZE workaround
> is necessary at runtime, and do something like this:
> 
> 	ssize_t xwrite(int fd, const void *buf, size_t len)
>         {
>         	ssize_t nr;
>                 static size_t max_write_size = platform_max_write_size();
> 
>                 if (max_write_size && max_write_size < len)
>                 	len = max_write_size;
> 		...
> 	}

How are we doing the runtime test for platform max write?

If I read the original bug report correctly, the problem was that write
would actually write some bytes _and_ return -1, which is terrible. We
can detect "seems to be returning -1 over and over", but we can't handle
a misbehavior like writing and claiming not to have done so.

So I think the test needs to be "is our version of cygwin in the broken
list" and not "let's try a few different writes and see what works".

But it is still not clear to me how many versions have this bug. I think
the next stop is to show the cygwin developers a clear test-case and see
whether it's already fixed, and which versions show the behavior. They
should be able to get that information much more easily than us. I
really don't want to get involved in bisecting bugs in cygwin (according
to cygwin.com, it's kept in CVS. Blech).

Robert, can you try (or have you already tried) submitting a bug report
to Cygwin?

-Peff
