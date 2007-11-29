From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Teach repack to optionally retain otherwise lost
 objects
Date: Thu, 29 Nov 2007 11:57:26 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711291146090.27959@racer.site>
References: <200711181225.52288.johannes.sixt@telecom.at>
 <7v3av3wg7h.fsf@gitster.siamese.dyndns.org> <200711182101.53936.johannes.sixt@telecom.at>
 <7v7ikfuxfk.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711290340470.27959@racer.site>
 <7vaboxy3va.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 12:58:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixi1q-00009h-UK
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 12:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761484AbXK2L5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 06:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762399AbXK2L5m
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 06:57:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:35985 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754610AbXK2L5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 06:57:41 -0500
Received: (qmail invoked by alias); 29 Nov 2007 11:57:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 29 Nov 2007 12:57:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ML3orOYBMcxjCKaKHxFV7vVrsO0vrJL0J3PNHpr
	7NX4482E1cfL34
X-X-Sender: gene099@racer.site
In-Reply-To: <7vaboxy3va.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66527>

Hi,

On Wed, 28 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	Besides, a completely different idea just struck me: before
> > 	repacking, .git/objects/pack/* could be _hard linked_ to the
> > 	forkee's object stores.  Then nothing in git-repack's code
> > 	needs to be changed.
> >
> > 	Oh, well.  I just wasted 1.5 hours.
> 
> Your 1.5 hours was spent wisely to come up with that idea ;-).

Thanks ;-)

> To make sure I understand your idea correctly, the procedure to repack a 
> repository in a fork-friendly way is:
> 
>  (1) find the project directly forked from you;
> 
>  (2) hardlink all packs under your object store to their object store;
> 
>  (3) repack -a -l and prune.

Yep.

> I think that would work as long as you do the above as a unit and handle
> one repository at a time.

Exactly.  See

http://repo.or.cz/w/repo.git?a=commitdiff;h=fba501deabd349afbe3b8bf89f385889889e04ac

for a tired proposal.

Note that "prune" is not (yet) an option, since it could possibly destroy 
objects which are needed in an ongoing push operation.

However, we could do exactly the same as with reflogs: introduce a grace 
period (with loose objects, we can use the ctime...)

> Otherwise I think you risk losing necessary objects when hierarchical 
> forks are involved.  E.g.  if you have a project X that has a fork Y 
> which in turn has fork Z.

Well, in theory you could also iterate over all projects and hard link the 
packs/objects of their alternates, and _then_ iterate and repack.  But it 
is simpler and more obvious in the case of repo.or.cz to do all in one 
iteration, because we can order the repository names easily so that 
forkees come first, _and_ we have an easy way to find out what are the 
forks of a project.

Ciao,
Dscho
