From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] clone: allow --no-local to turn off local
 optimizations
Date: Wed, 30 May 2012 19:21:16 -0400
Message-ID: <20120530232116.GA5007@sigill.intra.peff.net>
References: <20120530110305.GA13445@sigill.intra.peff.net>
 <20120530111016.GB15550@sigill.intra.peff.net>
 <7vzk8pziuk.fsf@alter.siamese.dyndns.org>
 <20120530215912.GC3237@sigill.intra.peff.net>
 <7vmx4pxqua.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 01:21:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZsCh-0001V7-MN
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 01:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab2E3XVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 19:21:19 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36636
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635Ab2E3XVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 19:21:19 -0400
Received: (qmail 11585 invoked by uid 107); 30 May 2012 23:21:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 19:21:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 19:21:16 -0400
Content-Disposition: inline
In-Reply-To: <7vmx4pxqua.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198849>

On Wed, May 30, 2012 at 03:10:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Similarly, I find it a little odd that "git clone file:///foo.git" will
> > actually find a file named "file:/foo.git" before checking the URL (IOW,
> > the argument is a path first, and then fallback to URL). I suspect
> > nobody actually cares about either, as they are very unlikely corner
> > cases.
> 
> Yeah, if anything, I would have expected --no-local to mean "I might
> have a local file that happens to be the same as this URL, but I am
> not cloning from there; just go straight to the URL using transports".

But that would not be the opposite of "--local", which you have just
argued is not about interpreting the URL syntax at all, but is about
turning off the local optimization code path when the origin repo is
local.

Interestingly, it seems that we don't handle this case well at all,
anyway. We notice that "file:///foo.git" is resolvable as a path, set
is_local, and set the path to "$PWD/file:///foo.git". But we still feed
that to the transport code to get the list of refs (just not to fetch
them). And the transport code barfs and says "I don't understand the URL
scheme $PWD/file".

So I'm not sure what the actual rules were meant to be, and if we
actually follow them. Or whether there are even intentional rules, and
it is not "what happens to work". Again, these are such silly corner
cases that I suspect it is simply the case that nobody has run into them
or cared.

-Peff
