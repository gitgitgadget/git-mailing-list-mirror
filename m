From: Jeff King <peff@peff.net>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 7 May 2006 03:56:31 -0400
Message-ID: <20060507075631.GA24423@coredump.intra.peff.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org> <e3fqb9$hed$1@sea.gmane.org> <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org> <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com> <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net> <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 07 09:56:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fce8C-0004mH-CV
	for gcvg-git@gmane.org; Sun, 07 May 2006 09:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWEGH4e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 03:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWEGH4e
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 03:56:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:49608 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751183AbWEGH4d (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 03:56:33 -0400
Received: (qmail 19124 invoked from network); 7 May 2006 07:56:32 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 7 May 2006 07:56:32 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun,  7 May 2006 03:56:31 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19694>

On Sun, May 07, 2006 at 06:08:03PM +1200, Martin Langhoff wrote:

> >> And in any case commits and trees are lightweight and compress well...
> >Commit maybe, but is this based on a hard fact?
> No hard facts here :( but I think it's reasonable to assume that the
> trees delta/compress reasonably well, as a given commit will change
> just a few entries in each tree.

A few hard facts (using Linus' linux-2.6 tree):
  - original packsize: 120996 kilobytes
  - unpacked: 233338 objects, 1417476 kilobytes
    This is an 11.7:1 compression ratio (of course, much of this is
    wasted space from the 4k block size in the filesystem)
  - There were 87915 total blob objects, of which 19321 were in the
    current tree. I removed all non-current blobs to produce a "shallow"
    tree.
  - The shallow tree unpacked: 164744 objects, 761960 kilobytes
    IOW, about half of the unpacked disk usage was old blobs.
  - Shallow commit/tree/tag objects packed (using 1.3.1
    git-pack-objects):
      Total 164744, written 164744 (delta 92322), reused 0 (delta 0)
      size: 108088
    The compression ratio here is only 7.0:1
  - Total savings by going shallow: 10.7%

So basically, trees and commits DON'T compress as well as historical
blobs (potentially because git-pack-objects isn't currently optimized
for this -- I haven't checked). As a result, we're saving only 10% by
going shallow instead of a potential 50%.

-Peff
