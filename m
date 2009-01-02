From: Jeff King <peff@peff.net>
Subject: Re: how to track the history of a line in a file
Date: Fri, 2 Jan 2009 16:26:56 -0500
Message-ID: <20090102212655.GA24082@coredump.intra.peff.net>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Jan 02 22:28:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIrZ7-0006c6-T5
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 22:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111AbZABV1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758087AbZABV07
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:26:59 -0500
Received: from peff.net ([208.65.91.99]:2813 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756943AbZABV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:26:59 -0500
Received: (qmail 19598 invoked by uid 111); 2 Jan 2009 21:26:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 02 Jan 2009 16:26:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jan 2009 16:26:56 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104416>

On Fri, Jan 02, 2009 at 02:13:32PM -0800, david@lang.hm wrote:

> I have a need to setup a repository where I'm storing config files, and I  
> need to be able to search the history of a particular line, not just when  
> the last edit of the line was (which is what I see from git blame)

As you figured out, the "manual" way is to just keep reblaming from the
parent of each blame. Recent versions of "git gui blame" have a "reblame
from parent" option in the context menu which makes this a lot less
painful.

> 57f8f7b6 (Linus Torvalds 2008-10-23 20:06:52 -0700 3) SUBLEVEL = 28
>
> what I would want it to show would be a list of the commits that have  
> changed this line.

The tricky thing here is what is "this line"? Using the line number
isn't right, since it will change based on other content coming in and
out of the file. You can keep drilling down by reblaming parent commits,
but remember that each time you do that you are manually looking at the
content and saying "Oh, this is the line I am still interested in." So I
a script would have to correlate the old version and new version of the
line and realize how to follow the "interesting" thing.

In your case, I think you want to see any commit in Makefile which
changed a line with SUBLEVEL in it. Which is maybe easiest done as:

  git log -z -p Makefile |
    perl -0ne 'print if /\n[+-]SUBLEVEL/' |
    tr '\0' '\n'

and is pretty fast. But obviously we're leveraging some content-specific
knowledge about what's in the Makefile.

-Peff
