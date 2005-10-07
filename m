From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Fri, 7 Oct 2005 13:41:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510071323070.23242@iabervon.org>
References: <20051005214447.GF15593@reactrix.com> <Pine.LNX.4.63.0510061550510.23242@iabervon.org>
 <20051007000041.GH15593@reactrix.com> <Pine.LNX.4.63.0510071149550.23242@iabervon.org>
 <7v8xx55kia.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 19:39:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENw9t-0004Fd-Eo
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 19:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbVJGRhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 13:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVJGRhE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 13:37:04 -0400
Received: from iabervon.org ([66.92.72.58]:39181 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030489AbVJGRhB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 13:37:01 -0400
Received: (qmail 7007 invoked by uid 1000); 7 Oct 2005 13:41:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Oct 2005 13:41:49 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xx55kia.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9809>

On Fri, 7 Oct 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> > It should be fine to download objects and a pack that contains them at the 
> >> > same time, although there's currently a check in fetch.c which should be 
> >> > removed, so that it will call fetch() for an object if the object appears 
> >> > between the prefetch() and the fetch().
> >> 
> >> Can you provide a patch, or point me toward the right place to make that
> >> change?
> >
> > It's line 168 of fetch.c; the "!has_sha1_file(obj->sha1)" part should go 
> > away.
> 
> The check was added in 029f6de377c7e0484f5c4cf070934599580f1784
> because back then calling fetch() on an object that we already
> had had a funny interaction with what http-fetch.c did.  I
> suspect that Nick's curl-multi changes made it unnecessary, but
> you should double check for other transports.

Hmm; my intended convention was that fetch() would always be called if 
prefetch() was called, even if something had happened to make it appear in 
between (e.g., prefetch() causing it to be fetched or a different call to 
fetch() speculatively also getting it).

The ssh transport actually wants to not have the check (if the object 
appears out of nowhere after we request it, we still want to read it out 
of the connection). 

The local transport probably ought to have the check added on line 169 of 
local-fetch.c

In general, transports need to deal with this case themselves, because the 
core code doesn't know if they started something in prefetch() than needs 
to get finished in fetch().

	-Daniel
*This .sig left intentionally blank*
