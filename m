From: Mike Hommey <mh@glandium.org>
Subject: Re: fast-import deltas
Date: Tue, 1 Apr 2014 22:07:03 +0900
Message-ID: <20140401130703.GA1479@glandium.org>
References: <20140401102554.GA32231@glandium.org>
 <20140401114502.GA15549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 01 15:09:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUyR8-00041Q-J2
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 15:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbaDANHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 09:07:24 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:48112 "EHLO
	zenigata.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751937AbaDANHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 09:07:17 -0400
Received: from glandium by zenigata.glandium.org with local (Exim 4.82)
	(envelope-from <glandium@glandium.org>)
	id 1WUyP9-0000QD-QV; Tue, 01 Apr 2014 22:07:03 +0900
Content-Disposition: inline
In-Reply-To: <20140401114502.GA15549@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245587>

On Tue, Apr 01, 2014 at 07:45:03AM -0400, Jeff King wrote:
> On Tue, Apr 01, 2014 at 07:25:54PM +0900, Mike Hommey wrote:
> 
> > I am currently prototyping a "native" mercurial remote handler for git,
> 
> For my own curiosity, how does this differ from what is in
> contrib/remote-helpers/git-remote-hg?

contrib/remote-helpers/git-remote-hg does a local mercurial clone before
doing the git conversion. While this is not really a problem for most
mercurial projects, it tends to be slow with big ones, like the firefox
source code. What I'm aiming at is something that can talk directly to a
remote mercurial server.

> > Would adding a fast-import command to handle deltas be considered useful
> > for git? If so, what kind of format would be suitable?
> 
> It breaks fast-import's "lowest common denominator" data model that is
> just passing commits and their contents over the stream. But we already
> do that in other cases for the sake of performance. I think the
> important thing is that the alternate formats are optional and enabled
> by the caller with command-line options.
> 
> That being said, I foresee a few complications:
> 
>   1. Git needs to know the sha1 of the full object. So unless the
>      generating script knows that ahead of time, git has to expand the
>      delta immediately anyway (this could still be a win if we end up
>      using a good delta from elsewhere rather than doing our own delta
>      search, but I suspect it's not so big a win as if we can just blit
>      the delta straight to disk).

Good point. That could quickly become a problem with long delta chains.

>   2. Git does not store on-disk deltas between objects that are not in
>      the same packfile. So you'd only be able to delta against an object
>      that came in the same stream (or you'd have to "fix" the packfile
>      on disk by adding an extra copy of the delta base, but that
>      probably eliminates any savings).

Arguably, this would make the most difference on initial clone of big
projects, or large incremental updates (like, after a few weeks), which
would use a single pack anyways.

> As for format, I believe that git is basically xdelta under the hood, so
> you'd want either that or something that can be trivially converted to
> it.

It seems to me fast-import keeps a kind of human readable format for its
protocol, i wonder if xdelta format would fit the bill. That being said,
I also wonder if i shouldn't just try to write a pack on my own...

Cheers,

Mike
