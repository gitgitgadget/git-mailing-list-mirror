From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Tue, 7 Oct 2008 11:35:43 -0400
Message-ID: <20081007153543.GA26531@coredump.intra.peff.net>
References: <20081005214114.GA21875@coredump.intra.peff.net> <20081005214336.GC21925@coredump.intra.peff.net> <48EB7D74.40302@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 17:46:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnEcL-00006N-Og
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 17:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbYJGPfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 11:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbYJGPfq
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 11:35:46 -0400
Received: from peff.net ([208.65.91.99]:4416 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbYJGPfq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 11:35:46 -0400
Received: (qmail 2377 invoked by uid 111); 7 Oct 2008 15:35:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 07 Oct 2008 11:35:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2008 11:35:43 -0400
Content-Disposition: inline
In-Reply-To: <48EB7D74.40302@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97717>

On Tue, Oct 07, 2008 at 05:17:08PM +0200, Johannes Sixt wrote:

> > However, there is at least one conflicting situation: there
> > is no way to say "use the regular rules to determine whether
> > this file is binary, but if we do diff it textually, use
> > this funcname pattern." That is, currently setting diff=foo
> > indicates that the file is definitely text.
> 
> I don't get your point. Can you provide an example?

Let's say I have a subdirectory of files, some of which are binary. But
for those that _aren't_ binary, I want to use a particular funcname
pattern. So I do this:

  echo '* diff=foo' >subdir/.gitattributes
  git config diff.foo.funcname some-regex

Under the old behavior, I have just claimed all of the subdir as text.
But that's not necessarily what I wanted.

In practice, this doesn't happen much, because funcname tends to follow
the file extension, as does binary-ness. So you get "*.java diff=java",
and you really would be insane to have binary files named *.java. But I
think it makes the concept clearer to explain, and the code simpler, if
the various facets of a diff driver are orthogonal. In particular, I
think this makes things cleaner for adding new driver properties in the
future.

As to your complaint (which I think is valid)...

> The reason why I'd like to understand the issue is because I like the
> diff.foo.textconv that you introduce in patch 4/4, but I dislike that I
> have to set diff.foo.binary to false in order to use the textconv. So, why
> is this .binary needed?

I think this .binary is something we can and should get rid of; as it
stands now, you always end up having to set it along with .textconv. I
have considered two ways:

  - because textconv is for converting binary to text for diffing, the
    result should always be text. So whenever we do the conversion, we
    should note that it is no longer binary, and automatically treat the
    result as a text diff. So in this case, we are explicitly saying
    that binaryness is _not_ orthogonal to this property of the diff
    driver.

  - textconv should arguably just be "canonicalize" or similar. That is,
    there is no reason you couldn't take something like text XML and
    canonicalize it for a more readable diff. Or even canonicalize a
    binary file to get a smaller or more sensible binary diff, if you
    wanted to.

    In that case, I think the right thing is to set it back to "unknown,
    check the file contents" if .binary is not set. So you really are
    saying "this is just a conversion, treat the canonicalized contents
    exactly as you would have treated the actual contents, including
    binary detection magic".

And both of those obviously involve changes to patch 4/4.

-Peff
