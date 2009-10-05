From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Mon, 5 Oct 2009 23:08:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910052251190.4985@pacific.mpi-cbg.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de>
 <7vr5thacb4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:13:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muure-0006cn-BH
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 23:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbZJEVGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 17:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbZJEVGs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 17:06:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:54960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751035AbZJEVGr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 17:06:47 -0400
Received: (qmail invoked by alias); 05 Oct 2009 21:05:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 05 Oct 2009 23:05:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+//uh9Qji/YgTE1XAPxyRMpbTB/I1VRoJdah7c2Z
	6lCADifSmURuGC
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vr5thacb4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129591>

Hi,

On Mon, 5 Oct 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > +		if (prepare_revision_walk(&rev))
> >> > +			message = "(revision walker failed)";
> >> 
> >> If prepare_revision_walk() failed for whatever reason, can we trust
> >> fast_forward/fast_backward at this point?
> >
> > No, but it is not used in that case, either, because message is not NULL 
> > anymore.
> 
> It is used in that case a few lines below to decide if you add the third
> dot.  That's why I asked.

Well, fair enough.

The answer is: yes, we can still trust fast_forward/fast_backward, as 
there is no question that if the first merge base (which must be the only 
merge base by definition, in this case) is either "left" or "right", it is 
fast_forward or fast_backward, respectively.

So: no worries.

> > I have no idea why "submodule --summary" uses --first-parent, but 
> > personally, I would _hate_ it not to see the merged commits in the 
> > diff.
> >
> > For a summary, you might get away with seeing
> >
> > 	> Merge bla
> > 	> Merge blub
> > 	> Merge this
> > 	> Merge that
> >
> > but in a diff that does not cut it at all.
> 
> As long as bla/blub/this/that are descriptive enough, I do not see at all
> why you think "summary" is Ok and "diff" is not.  If your response were
> "it is just a matter of taste; to some people (or project) --first-parent
> is useful and for others it is not", I would understand it, and it would
> make sense to use (or not use) --first-parent consistently between this
> codepath and "submodule --summary", though.

You may be used to git.git's quality of naming the branches you merge.

Sadly, this is not the common case.

> > In any case, just to safe-guard against sick minds, I can add a check that 
> > says that left, right, and all the merge bases _cannot_ have any flags 
> > set, otherwise we output "(you should visit a psychiatrist)" or some such.
> 
> I wouldn't suggest adding such a kludge.  Being insulting to the user when
> we hit a corner case _we_ cannot handle does not help anybody, does it?

Well, I was a little exasperated when I wrote that that you want to handle 
that case.

But of course, I should heed Postel's law, and handle the case. Maybe say 
something like "(uses superproject's commits)".

> I see two saner options.  Doing this list walking in a subprocess so that
> you wouldn't have to worry about object flags at all in this case would
> certainly be easier; the other option obviously is to have a separate
> object pool ala libgit2, but that would be a much larger change.

The reason why I insist avoiding a subprocess is performance.  The same 
reason holds for a separate object pool: it would just impede the speed, 
AFAICT.

Besides, I vividly remember what happened to a patch I posted to be able 
to just clear the current object pool.  And I cannot imagine a patch 
introducing a second pool to be any less complicated.

If you really want the case I illustrated (that the submodule actually 
contains commits that already have been shown in the superproject) to be 
handled showing the correct submodule summary (and with --first-parent, I 
think you will agree that it is a summary, even if it is embedded in a 
diff), I could imagine calling a subprocess (for simplicity reasons) _iff_ 
left, right, or any of the merge bases has a flag set.

But I really, really, really want to avoid a fork() in the common case.  I 
do have some users on Windows, and I do have a few submodules in that 
project.  Having too many fork() calls there would just give Git a bad 
reputation.  And it has enough of that, it does not need more.

Ciao,
Dscho
