From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/5] update-ref: test handling large transactions
 properly
Date: Thu, 22 Jan 2015 08:07:47 -0500
Message-ID: <20150122130746.GD19681@peff.net>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
 <1421893929-7447-2-git-send-email-sbeller@google.com>
 <54C0D6F9.1000808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	gitster@pobox.com, loic@dachary.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 22 14:07:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEHUG-00076f-UH
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 14:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbbAVNHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 08:07:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:37291 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750803AbbAVNHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 08:07:48 -0500
Received: (qmail 17715 invoked by uid 102); 22 Jan 2015 13:07:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 07:07:47 -0600
Received: (qmail 9048 invoked by uid 107); 22 Jan 2015 13:08:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 08:08:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2015 08:07:47 -0500
Content-Disposition: inline
In-Reply-To: <54C0D6F9.1000808@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262830>

On Thu, Jan 22, 2015 at 11:54:49AM +0100, Michael Haggerty wrote:

> > +run_with_limited_open_files () {
> > +	(ulimit -n 32 && "$@")
> > +}
> 
> Regarding the choice of "32", I wonder what is the worst-case number of
> open file descriptors that are needed *before* counting the ones that
> are currently wasted on open loose-reference locks. On Linux it seems to
> be only 4 with my setup:
> 
>     $ (ulimit -n 3 && git update-ref --stdin </dev/null)
>     bash: /dev/null: Too many open files
>     $ (ulimit -n 4 && git update-ref --stdin </dev/null)
>     $
> 
> This number might depend a little bit on details of the repository, like
> whether config files import other config files. But as long as the
> "background" number of fds required is at least a few less than 32, then
> your number should be safe.
> 
> Does anybody know of a platform where file descriptors are eaten up
> gluttonously by, for example, each shared library that is in use or
> something? That's the only think I can think of that could potentially
> make your choice of 32 problematic.

It's not just choice of platform. There could be inherited descriptors
in the environment (e.g., the test suite is being run by a shell that
keeps a pipe to CI server open, or something). And the test suite itself
uses several extra descriptors for hiding and showing output.

I think this is the sort of thing that we have to determine with a mix
of guessing and empiricism.  4 is almost certainly too low. 32 looks
"pretty big" in practice but not so big that it will make the test slow.
I think our best bet is probably to ship it and see if anybody reports
problems while the patch cooks.  Then we can bump the number (or find a
new approach) as necessary.

-Peff
