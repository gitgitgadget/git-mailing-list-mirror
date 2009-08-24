From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 09:55:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908240946390.6044@xanadu.home>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home>
 <alpine.LFD.2.00.0908232320410.6044@xanadu.home>
 <7vocq5q0j7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 15:55:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfa1N-0005RB-Vh
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 15:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbZHXNzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 09:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZHXNzc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 09:55:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32722 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbZHXNzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 09:55:32 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOV00329VHDSYK0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 24 Aug 2009 09:44:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vocq5q0j7.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126926>

On Sun, 23 Aug 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > If all refs sent by the remote repo during a fetch are reachable 
> > locally, then no further conversation is performed with the remote. This 
> > check is skipped when the --depth argument is provided to allow the 
> > deepening of a shallow clone which corresponding remote repo has no 
> > changed.
> >
> > However, some additional filtering was added in commit c29727d5 to 
> > remove those refs which are equal on both sides.  If the remote repo has 
> > not changed, then the list of refs to give the remote process becomes 
> > empty and simply attempting to deepen a shallow repo always fails.
> >
> > Let's stop being smart in that case and simply send the whole list over
> > when that condition is met.  The remote will do the right thing anyways.
> >
> > Test cases for this issue are also provided.
> >
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> > ---
> 
> Thanks.  The fix looks correct (as usual with patches from you).
> 
> But it makes me wonder if this logic to filter refs is buying us anything.
> 
> >  	for (rm = refs; rm; rm = rm->next) {
> > +		nr_refs++;
> >  		if (rm->peer_ref &&
> >  		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
> >  			continue;
> 		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
> 		heads[nr_heads++] = rm;
> 	}
> 
> What is the point of not asking for the refs that we know are the same?

I could see the advantage if the number of refs is really huge.  Wasn't 
some converted repositories producing a lot of branches and/or tags 
significantly slowing down a fetch operation?  Granted that was long ago 
when that issue got "fixed" so the details are fuzzy to me.

> In other words, what breaks (not necessarily in the correctness sense, but
> also in the performance sense) if we get rid of this filtering altogether?

If you really want to get rid of that filtering, I'd still do it in a 
separate patch.  That way if any issue appears because of that then 
bissection will point directly to that removal alone.


Nicolas
