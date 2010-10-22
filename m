From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] make pack-objects a bit more resilient to repo corruption
Date: Fri, 22 Oct 2010 14:42:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010221427390.2764@xanadu.home>
References: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
 <20101022144600.GA5554@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:44:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9MbI-0002bK-55
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711Ab0JVSmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:42:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34428 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359Ab0JVSmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:42:11 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAP0031HFY3L0B0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Oct 2010 14:42:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20101022144600.GA5554@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159729>

On Fri, 22 Oct 2010, Jeff King wrote:

> On Fri, Oct 22, 2010 at 12:53:32AM -0400, Nicolas Pitre wrote:
> 
> > -		if (!src->data)
> > +		if (!src->data) {
> > +			if (src_entry->preferred_base) {
> > +				/* 
> > +				 * Those objects are not included in the
> > +				 * resulting pack.  Be resilient and ignore
> > +				 * them if they can't be read, in case the
> > +				 * pack could be created nevertheless.
> > +				 */
> > +				return 0;
> > +			}
> >  			die("object %s cannot be read",
> >  			    sha1_to_hex(src_entry->idx.sha1));
> > +		}
> 
> By converting this die() into a silent return, are we losing a place
> where git might previously have alerted a user to corruption? In this
> case, we can continue the operation without the object, but if we have
> detected corruption, letting the user know as soon as possible is
> probably a good idea.
> 
> In other words, should this instead be:
> 
>   warning("unable to read preferred base object: %s", ...);
>   return 0;

Well, this get called repeatedly, being within the inner part of the 
delta search loop.  So you might get that warning as many times as the 
delta window which is not that nice.  If anything a static flag to 
display the warning only once would be needed.  But you're pretty likely 
to have met that warning/error already from other operations, which is 
why I didn't bother.

> Or will some other part of the code already complained to stderr?

Some other part is likely to already have complained, through 
check_object() -> sha1_object_info().  But not necessarily in all cases.


Nicolas
