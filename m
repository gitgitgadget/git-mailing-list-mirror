From: Nicolas Pitre <nico@cam.org>
Subject: Re: Fetching SHA id's instead of named references?
Date: Mon, 06 Apr 2009 22:34:36 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904062214170.6741@xanadu.home>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
 <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
 <20090406144047.GE23604@spearce.org>
 <33f4f4d70904060922t5c868ec0x89ed5891cf4b19c2@mail.gmail.com>
 <alpine.LFD.2.00.0904061245111.6741@xanadu.home>
 <33f4f4d70904061640j1b03c499x1765da1a72a411f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_n+ua4ra6A4NeQ15HqURFzg)"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 04:36:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr1BE-0001jH-SA
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 04:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbZDGCfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 22:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbZDGCfA
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 22:35:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42409 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbZDGCe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 22:34:59 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHP00IAXLRZ9PW0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Apr 2009 22:33:35 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <33f4f4d70904061640j1b03c499x1765da1a72a411f3@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115901>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_n+ua4ra6A4NeQ15HqURFzg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Tue, 7 Apr 2009, Klas Lindberg wrote:

> On Mon, Apr 6, 2009 at 6:55 PM, Nicolas Pitre <nico@cam.org> wrote:
> 
> > Why can't you simply fetch the remote from its branch tip and then
> > figure out / checkout the particular unnamed reference you wish locally?
> 
> It is a pretty sane thing to do, but it makes me a bit nervous that
> branches are not immutable. Let's say I decide on a manifest format
> where each tree is listed as a branch name plus the current SHA key on
> that branch. The branch name is needed to enable fetch, but if the
> branch is later renamed because of a change in naming policy, or its
> name simply reused to refer to something completely different (*),
> then there is no guarantee that the SHA key is reachable through that
> branch name.

In git terms, this is called "history rewriting".  And you really don't 
want to do that if your repository is pulled by other people, unless 
there is an explicit statement about that fact.

Still, if you fetch all branches from the remote (which is the default 
behavior anyway), then the branch you're interested in will always 
contain the particular commit you're looking for, regardless of the name 
of the branch.  While it is true that branches may not be immutable, any 
commit they collectively refer to still are immutable.

If the remote has deleted the only branch through which your particular 
commit of interest was reachable, then of course pulling all branches 
from the remote won't hhelp you.  But nor would a fetch with the 
particular commit's SHA1 because it may well have been pruned from the 
remote repository at that point.

> (*) These situations cannot be discounted in an organization with,
> say, a few thousand employees and several tens of really big projects
> with considerable overlap. I have to take into account that the right
> hand may not know what the left hand is doing all the time.

Thing is, with the distributed nature of git, nothing prevents you from 
keeping a local version of the commit you're interested in.  Unlike with 
a central repository where someone else might delete a branch you need, 
with git you will still have access to that particular commit locally 
regardless if the remote repository has deleted it or not.

> > Unlike with CVS/SVN, you don't need anything from the remote if you want
> > to checkout an old version. In particular, there is no need for you to
> > only fetch that old version from the remote.  You just fetch everything
> > from the remote and then checkout the particular old version you wish.
> 
> Please consider when you have to recreate some particular forest that
> you never worked on before, but now you have to fetch and recreate a 3
> year old version so that you can work on that critical error report.
> And I may really not want to fetch everything. Some projects are just
> very very big.

There is nothing a tool can do for you if someone is determined to be 
stupid with it.  In other words, don't delete a branch if it contains 
important stuff.  You may rename it if you wish.  And if you don't want 
to fetch everything then you may always find out about the right branch 
to pull with "git branch --contains <SHA1>".

> I think that what I would need is either
> 
>  * Immutable tags, or
>  * A way to maintain sets of indestructible commits based on SHA id's
> and a way to fetch them without going through a named reference.
> 
> The second option seems better because it would allow for recursion on
> submodules and it doesn't pollute the tag name space.

Maybe.  But as others already explained, there are technical reasons 
that makes such a solution undesirable.


Nicolas

--Boundary_(ID_n+ua4ra6A4NeQ15HqURFzg)--
