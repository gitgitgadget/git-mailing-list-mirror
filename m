From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: keeping track of where a patch begins
Date: Wed, 21 Oct 2009 16:50:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910211623370.21460@xanadu.home>
References: <3a69fa7c0910210745r311cf18xf966f5c63650cde6@mail.gmail.com>
 <alpine.LFD.2.00.0910211402490.21460@xanadu.home>
 <7veiow4iqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: E R <pc88mxer@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:50:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0i8I-00038c-Hm
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 22:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbZJUUt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 16:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbZJUUt7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 16:49:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58211 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbZJUUt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 16:49:58 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRV002A7TVE0IB0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Oct 2009 16:50:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7veiow4iqc.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130963>

On Wed, 21 Oct 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > On Wed, 21 Oct 2009, E R wrote:
> >
> >> What solutions have you come up with to either to catch or prevent
> >> this from happening? It is possible to determine what node a branch
> >> started from?
> >
> > This can be determined by looking at the gitk output.
> >
> > Also 'git merge-base' can give you that node, given the main branch and 
> > the topic branch.  See documentation about git-merge-base.
> >
> > Then if you need to move a branch to another starting node, then 'git 
> > rebase' is what you need (again the git-rebase documentation is pretty 
> > detailed).
> 
> That is a correct way to diagnose the mistake and recover from it, but
> unfortunately it is a rather weak tool to identify the mistake in the
> first place.

Well... The "mistake" is probably going to be different depending on the 
work flow used.  I don't think there is a generic definition of such 
mistakes.

In this case, simply having

	if [ $(git merge-base $expected_branch_point $branch) != \
	     $(git rev-parse $expected_branch_point) ]; then
		(complain/refuse the merge of $branch)
	fi

should be quite sufficient as an enforcing proper branch policy.  Of 
course the $expected_branch_point is something that is determined 
outside of Git.

> A branch in git, as Randal often used to say on #git, is an illusion---it
> points only at the top and does not identify the bottom.
> 
> But it does _not_ have to stay that way at the Porcelain level.
> 
> Here is a rough sketch of one possible solution.  It is not fully thought
> out; the basic idea is probably sound but I did not try to exhaustively
> cover changes to various tools that are necessary to maintain the
> invariants this scheme requires.

I never came across a situation where such an elaborated scheme was 
needed to actually record and maintain that information, or could be 
really useful.  And some branches might be built on top of a sub-branch 
already, making the real branch's bottom the sub-branch's instead in a 
given context.  It all depends on the work flow and the convention used 
for a project.  And the tool has no way to figure that out (is this the 
real branch bottom or should it be one or more level down?), etc.

> We probably could kill the other bird in the nearby thread that wants to
> add a description to a branch, if this scheme is fully implemented

Well, I think we gain in flexibility by keeping those things separate 
though.  Blending data structures together is not always a good thing.

We have reflog data separate from the refs themselves, so I think that 
having .git/desc/refs/* containing simple text files would be good 
enough and simple to implement/use.


Nicolas
