From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 12:26:54 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908240144530.28290@iabervon.org>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home> <alpine.LFD.2.00.0908232320410.6044@xanadu.home> <7vocq5q0j7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 18:27:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfcNr-0005l6-3o
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 18:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbZHXQ0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 12:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbZHXQ0x
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 12:26:53 -0400
Received: from iabervon.org ([66.92.72.58]:47478 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbZHXQ0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 12:26:52 -0400
Received: (qmail 3525 invoked by uid 1000); 24 Aug 2009 16:26:54 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Aug 2009 16:26:54 -0000
In-Reply-To: <7vocq5q0j7.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126941>

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

This code is part of the original C implementation of fetch; I suspect the 
optimization was somehow in the shell version and made sense there, 
perhaps because there wasn't a quickfetch in the shell version or that 
there was some non-negligable per-ref cost in the code around there, since 
it was calling helper programs and such.

Anyway, I think it makes sense to remove the filtering from 
transport_fetch_refs(), like your patch does.

If it makes a difference for the actual protocol, fetch_refs_via_pack() 
could filter them at that stage.

	-Daniel
*This .sig left intentionally blank*
