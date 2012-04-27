From: Jeff King <peff@peff.net>
Subject: Re: Compiling git with -Werror
Date: Fri, 27 Apr 2012 06:07:31 -0400
Message-ID: <20120427100731.GC19918@sigill.intra.peff.net>
References: <4F9A6AB0.1050504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 27 12:07:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNi5c-0001Nx-L7
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 12:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759485Ab2D0KHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 06:07:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47876
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759189Ab2D0KHd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 06:07:33 -0400
Received: (qmail 27355 invoked by uid 107); 27 Apr 2012 10:07:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Apr 2012 06:07:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Apr 2012 06:07:31 -0400
Content-Disposition: inline
In-Reply-To: <4F9A6AB0.1050504@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196464>

On Fri, Apr 27, 2012 at 11:45:20AM +0200, Michael Haggerty wrote:

> I like to develop with errors and warnings turned up as strict as
> possible.  For example, I would like to use
> 
>     CFLAGS="-g -O2 -Wall -Werror -Wdeclaration-after-statement"

That's more or less how I compile git.

> I thought this would be as simple as
> 
>     git clean -fdx
>     make configure
>     ./configure CFLAGS="-g -O2 -Wall -Werror -Wdeclaration-after-statement"

I don't use our autoconf at all, though. I put settings like that into
config.mak, which gets sourced by the Makefile (right after
config.mak.autogen, which is what configure produces).

> The cause of the problem is that the CFLAGS variable is used by
> ./configure when it is running its tests, and some of the tests don't
> work correctly (they produce results that are not correct for the
> platform) when run with the strict CFLAGS.
> [...]
> Is there some other mechanism to set strict CFLAGS parameters for the
> build without confusing ./configure?

Try putting "CFLAGS += -Werror" in config.mak.

> Is this a bug in how the git project is using autoconf?
> 
> Is it a bug in autoconf itself?

I think autoconf. Our configure input is just using
AC_CHECK_FUNC(strtok_r) to generate the test.  Which would mean that
it's a bad interaction of autoconf's code and your CFLAGS. So I would be
surprised if other packages didn't have similar problems.

And indeed, googling for 'autoconf cflags "-Werror"' turns up:

  http://lists.gnu.org/archive/html/bug-autoconf/2012-03/msg00070.html

Summary: don't do that. We could add a special option to turn on
warnings, but given how easy the config.mak trick above is, I don't know
that it's necessary.

-Peff
