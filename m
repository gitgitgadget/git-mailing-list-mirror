From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-rebase-interactive: do not squash commits on
 abort
Date: Tue, 9 Sep 2008 16:17:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809091616200.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1220906569-26878-1-git-send-email-dpotapov@gmail.com> <7v7i9mdvyr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 16:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd3xy-00047U-GN
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 16:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbYIIOMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 10:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbYIIOMG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 10:12:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:50178 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751606AbYIIOMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 10:12:05 -0400
Received: (qmail invoked by alias); 09 Sep 2008 14:12:03 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 09 Sep 2008 16:12:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cUQw07hNc8WrZLBYercBUmgbePokuR7zPQ466S0
	S4RHAUsBtteOw5
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7v7i9mdvyr.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95387>

Hi,

On Mon, 8 Sep 2008, Junio C Hamano wrote:

> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > If git rebase interactive is stopped by "edit" command and then the user
> > said "git rebase --continue" while having some stage changes, git rebase
> > interactive is trying to amend the last commit by doing:
> >   git --soft reset && git commit
> >
> > However, the user can abort commit for some reason by providing an empty
> > log message, and that would leave the last commit undone, while the user
> > being completely unaware about what happened. Now if the user tries to
> > continue, by issuing "git rebase --continue" that squashes two previous
> > commits.
> >
> > Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> > ---
> >  git-rebase--interactive.sh |    7 +++++--
> >  1 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 929d681..5b2b1e5 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -429,12 +429,15 @@ do
> >  				die "Cannot find the author identity"
> >  			if test -f "$DOTEST"/amend
> >  			then
> > +				amend=$(git rev-parse --verify HEAD)
> >  				git reset --soft HEAD^ ||
> >  				die "Cannot rewind the HEAD"
> >  			fi
> >  			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> > -			git commit --no-verify -F "$DOTEST"/message -e ||
> > -			die "Could not commit staged changes."
> > +			git commit --no-verify -F "$DOTEST"/message -e || {
> > +				test -n "$amend" && git reset --soft $amend
> > +				die "Could not commit staged changes."
> > +			}
> >  		fi
> 
> Feels obviously correct from a cursory look, although I admit I haven't
> thought about other possible corner cases that this additional reset may
> fire when it shouldn't.  Dscho?

It might be safer to set the variable "amend" to empty before the "if".  
Other than that, I think that patch makes tons of sense.

Thanks,
Dscho
