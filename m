From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] make pack-objects a bit more resilient to repo corruption
Date: Fri, 22 Oct 2010 14:54:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010221451340.2764@xanadu.home>
References: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
 <20101022144600.GA5554@sigill.intra.peff.net>
 <1287761064.31218.37.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:55:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Mlo-0005yt-HL
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758940Ab0JVSyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:54:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41329 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab0JVSyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:54:41 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAP006V8GJ41LE0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Oct 2010 14:54:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1287761064.31218.37.camel@drew-northup.unet.maine.edu>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159732>

On Fri, 22 Oct 2010, Drew Northup wrote:

> 
> On Fri, 2010-10-22 at 10:46 -0400, Jeff King wrote:
> > On Fri, Oct 22, 2010 at 12:53:32AM -0400, Nicolas Pitre wrote:
> > 
> > > -		if (!src->data)
> > > +		if (!src->data) {
> > > +			if (src_entry->preferred_base) {
> > > +				/* 
> > > +				 * Those objects are not included in the
> > > +				 * resulting pack.  Be resilient and ignore
> > > +				 * them if they can't be read, in case the
> > > +				 * pack could be created nevertheless.
> > > +				 */
> > > +				return 0;
> > > +			}
> > >  			die("object %s cannot be read",
> > >  			    sha1_to_hex(src_entry->idx.sha1));
> > > +		}
> > 
> > By converting this die() into a silent return, are we losing a place
> > where git might previously have alerted a user to corruption? In this
> > case, we can continue the operation without the object, but if we have
> > detected corruption, letting the user know as soon as possible is
> > probably a good idea.
> > 
> > In other words, should this instead be:
> > 
> >   warning("unable to read preferred base object: %s", ...);
> >   return 0;
> > 
> > Or will some other part of the code already complained to stderr?
> > 
> > -Peff
> 
> Agreed. If it broke we should probably tell the user--even if we can't
> do much useful about it other than attempt to recover by continuing.

Please don't misinterpret this case.  As far as this change is 
concerned, nothing is actually "broken".  The operation _will_ still 
succeed.  The repository may be broken, but in this case we can do 
without the broken object.  In those cases where the object is really 
needed the original die() is still in place.


Nicolas
