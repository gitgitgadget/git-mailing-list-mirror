From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Mon, 6 Feb 2012 05:16:30 -0500
Message-ID: <20120206101630.GA5394@sigill.intra.peff.net>
References: <20120206062713.GA9699@sigill.intra.peff.net>
 <4F2FA330.7020803@alum.mit.edu>
 <20120206100622.GC4300@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 06 11:16:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuLck-0004jf-8g
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 11:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab2BFKQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 05:16:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58743
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939Ab2BFKQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 05:16:33 -0500
Received: (qmail 26488 invoked by uid 107); 6 Feb 2012 10:23:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 05:23:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 05:16:30 -0500
Content-Disposition: inline
In-Reply-To: <20120206100622.GC4300@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190061>

On Mon, Feb 06, 2012 at 05:06:22AM -0500, Jeff King wrote:

> > If that is the goal, all you have to record is the "include stack"
> > context that caused the currently-being-included file to be read and
> > make sure that the currently-being-included file didn't appear earlier
> > on the stack.  The fact that the same file was included earlier (but
> > not as part of the same include chain) needn't be considered an error.
> 
> I considered this, but decided the complexity wasn't worth it,
> especially because getting it accurate means cooperation from
> git_config_from_file, which otherwise doesn't know or care about this
> mechanism. Instead I keep a simple depth counter and barf at a
> reasonable maximum, printing the "from" and "to" files. Yes, it's not
> nearly as elegant as keeping the whole stack, but I really don't expect
> people to have complex super-deep includes, nor for it to be difficult
> to hunt down the cause of a cycle.

Oh, one other thing: to detect cycles, you have to use a canonical
version of the filename for comparisons. That makes the existing stack
that git_config_from_file keeps useless. Using real_path is hard,
because it will die() if some path components don't exist. Using
absolute_path is a reasonable compromise, but it can actually miss some
cycles if they involve symbolic links.

Not insurmountable if you can accept teaching git_config_from_file to
real_path() each file it reads. But again, it ends up getting complex
for IMHO not much gain. A stupid depth counter can't show you a stack
trace (and it may have false positives), but it's dirt simple and
probably good enough.

-Peff
