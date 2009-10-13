From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 13 Oct 2009 14:39:51 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910131358000.32515@iabervon.org>
References: <0016e68fd0123a175304754694b4@google.com> <200910122340.13366.trast@student.ethz.ch> <7vr5t89qiw.fsf@alter.siamese.dyndns.org> <200910130836.57011.trast@student.ethz.ch> <7vljjf226t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:42:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxmK5-0007GK-1Z
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760933AbZJMSk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757596AbZJMSk3
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:40:29 -0400
Received: from iabervon.org ([66.92.72.58]:40707 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760931AbZJMSk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:40:28 -0400
Received: (qmail 27206 invoked by uid 1000); 13 Oct 2009 18:39:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Oct 2009 18:39:51 -0000
In-Reply-To: <7vljjf226t.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130181>

On Tue, 13 Oct 2009, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> >> Or can't you go the other way, say
> >> 
> >> 	git checkout -t $remote_tracking
> >> 
> >> to create a local branch forking from the named remote tracking branch?
> >
> > Sure, but we already have that and we still failed to fix the users,
> > so FWIW, I think Dscho's right and we should try fixing the UI next.
> 
> What it means is that -t was a broken attempt to help the users at the UI
> level, and I can surely see that.
> 
> So we need the set of new rules, say, for 1.7.0 release.  A strawman?
> 
> Assume that these are the only refs that exist:
> 
>     refs/remotes/origin/{master,next,nitfol}
>     refs/remotes/xyzzy/{frotz,nitfol}
>     refs/heads/master
>     refs/tags/v1.0.0
> 
> #0. These will stay as is:
> 
>  $ git checkout mine               ;# switches to the branch
>  $ git checkout $any_committish^0  ;# detaches
> 
> #1. These used to detach, but will create a local branch
> 
>  $ git checkout origin/next        ;# as if with -t
>  $ git checkout xyzzy/frotz        ;# as if with -t (origin is not special)
>
> #2. These are allowed only when unambiguous and there is no local branch yet.
> 
>  $ git checkout next               ;# ok
>  $ git checkout frotz              ;# ok (origin is not special)
>  $ git checkout nitfol             ;# not ok (ambiguous and origin is not special)
> 
> #3. These used to detach, but what should we do?
> 
>  $ git checkout v1.0.0             ;# detach, or refuse???
>  $ git checkout origin/master      ;# detach, or refuse???
> 
> I can buy 0, 1, and 2, and I think it is a minor inconvenience if we
> started refusing to detach in case #3, as people who want to detach can
> always suffix ^0 or ~0 to make it a general committish.

I suspect that a very common pattern for people who follow trees for 
testing and such or who only develop in topic branches is:

$ git clone ...
$ git checkout origin/next
$ git fetch origin
$ git checkout origin/next

For people who use topic branches extensively:

$ git fetch origin
$ git checkout origin/next
(test, find issues, maybe make changes)
$ git checkout -b topic
$ git commit
(send changes)

Some people (IIRC, including Linus):

$ git checkout origin/next
(work)
$ git commit
$ git checkout -b topic

In all of these cases, the user will get a misleading "next" local branch; 
in Linus's case, this branch ends up with commits from a topic branch.

For that matter, even the intended user would have problems with your 
suggestion:

$ git clone ...

$ git checkout origin/next
(do some next stuff)
$ git checkout origin/master
(do some master stuff)
$ git checkout origin/next

On the second cycle, either git refuses or does something actively 
confusing to this user, and the user has to learn the difference between 
local branches and remote branches on the *second* cycle. IMHO, it's much 
better to make users learn things at the point when they don't think they 
know how to use the system, rather than when they think they understand it 
and are just trying to get things done.

	-Daniel
*This .sig left intentionally blank*
