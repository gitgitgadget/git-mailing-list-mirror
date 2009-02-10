From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 17:48:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
 <7vprhqnv0c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvnH-00083q-FV
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbZBJQrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 11:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbZBJQrk
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:47:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:37528 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751103AbZBJQrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:47:40 -0500
Received: (qmail invoked by alias); 10 Feb 2009 16:47:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 10 Feb 2009 17:47:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RSA1vPUARbJ3+ewDPMVjkWk3eM6KvkMAS9oduTO
	4HwBjAVq6LPKcB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vprhqnv0c.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109272>

Hi,

On Tue, 10 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> OK. I think if you are seeing performance benefits from a 2-character
> >> fanout, then we should standardize on that (do you have new performance
> >> numbers somewhere?).
> >
> > The thing is: Shawn is correct when he says that a tree object to hold the 
> > notes of all commits (which is not an unlikely scenario if you are 
> > thinking about corporate processes) would be huge.
> >
> >> The notes implementation is now in master. If it's about to change in an 
> >> incompatible way, how do you want to handle it? I'm wary of a quick 
> >> patch to change the format this late in the release cycle. We could hold 
> >> it back from 1.6.2. Alternatively, we could let it release with a "this 
> >> is probably going to change" warning.
> >> 
> >> I think I favor holding it back, but I am not picky.
> >
> > Yes, I am also in favor of holding it back.
> 
> I could do a revert on 'master' if it is really needed, but I found that
> the above reasoning is a bit troublesome.  The thing is, if a tree to hold
> the notes would be huge to be unmanageable, then it would still be huge to
> be unmanageable if you split it into 256 pieces.

The thing is, a tree object of 17 megabyte is unmanagably large if you 
have to read it whenever you access even a single node.  Having 256 trees 
instead, each of which is about 68 kilobyte is much nicer.

> I'd rather prefer to see us first try to find a way to optimze the tree 
> parser.  Maybe packv4 or Linus's binary search (which IIRC you declared 
> would not work --- I recall I once thought about it myself but I do not 
> recall what my conclusions were) play a role in it.

I declared it did not work, and showed an example here:

	http://article.gmane.org/gmane.comp.version-control.git/103297

Now, this example is so concocted that it is not even funny.  For example, 
it falls flat down for notes, as the names never contain spaces there.

I guess that we could detect possible false positives such as my example, 
by searching for NULs and spaces in the vicinity, and just search on if 
there is a salmon of a doubt left.

But the worst part about it: we'd still have to unpack the whole tree 
object to start bisecting (as described in said mail).

Ciao,
Dscho
