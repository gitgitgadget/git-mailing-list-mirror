From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] sort_in_topological_order(): avoid setting a commit
 flag
Date: Wed, 23 Jul 2008 20:33:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807232014260.8986@racer>
References: <alpine.DEB.1.00.0807230148130.8986@racer> <alpine.DEB.1.00.0807230150480.8986@racer> <7vprp4ctkp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pasky@suse.cz, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLk6v-0003zM-Ng
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbYGWTdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754048AbYGWTdx
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:33:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:46621 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753091AbYGWTdw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:33:52 -0400
Received: (qmail invoked by alias); 23 Jul 2008 19:33:51 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp057) with SMTP; 23 Jul 2008 21:33:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Smx4QSs8SL9S1A4EF+fb3euu5ZiyT6CcHKGWGxE
	EzPJyU0cQkWF1K
X-X-Sender: gene099@racer
In-Reply-To: <7vprp4ctkp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89754>

Hi,

On Wed, 23 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > @@ -494,7 +493,8 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
> >  			 * when all their children have been emitted thereby
> >  			 * guaranteeing topological order.
> >  			 */
> > -			if (!--parent->indegree) {
> > +			if (--parent->indegree == 1) {
> > +				parent->indegree = 0;
> >  				if (!lifo)
> >  					insert_by_date(parent, &work);
> >  				else
> > @@ -505,7 +505,6 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
> >  		 * work_item is a commit all of whose children
> >  		 * have already been emitted. we can emit it now.
> >  		 */
> > -		commit->object.flags &= ~TOPOSORT;
> >  		*pptr = work_item;
> >  		pptr = &work_item->next;
> >  	}
> 
> These two hunks look suspicious.
> 
> The "tips" used to enter that while() loop with zero indegree, its 
> parents examined and then entered the final list pointed by pptr with 
> the toposort scratch variables removed and indegree set to zero.  Now 
> with the new +1 based code, they enter the while() loop with 1 indegree, 
> and enter the final list with indegree set to 1.

Almost correct.  The way I did it the if() is entered with indegree == 
1, but is set indegree to 0 right away.

I did it this way because of these two lines before the if():

                        if (!parent->indegree)
                                continue;

These are the replacement for the previous

			if (!(parent->object.flags & TOPOSORT))
                                continue;

Now, if indegree was not set to 0, that if () would not trigger, but in 
the next one (the first hunk you quoted), indegree was decremented and 
failed the test == 1.

However, that is correct only by pure chance; I certainly missed that.  
The correct fix according to my thinking would be to set the indegree to 0 
when the tips are inserted, too.

> A parent that has only one child that is "tip" is discovered in the 
> while() loop, its indegree decremented (so it goes down to zero in the 
> original code and 1 in yours) and enters work queue to be processed.  
> It used to have the toposort scratch variable removed in the second hunk 
> above, but that is done in the first hunk in your version.
> 
> So after this patch, indegree will be all zero for non-tip commits but
> will be one for tip commits.  Is this intended?

No.

> I'd suggest dropping the "parent->indegree = 0" assignment and turn the
> second hunk into "commit->indgree = 0" assignment.

Yeah, that is much simpler.

Thanks,
Dscho
