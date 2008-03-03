From: Nicolas Pitre <nico@cam.org>
Subject: Re: git fetch: where are the downloaded objects stored?
Date: Mon, 03 Mar 2008 11:29:54 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0803031057140.2899@xanadu.home>
References: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
 <vpqskz82bm3.fsf@bauges.imag.fr>
 <4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com>
 <vpq63w325px.fsf@bauges.imag.fr>
 <4d8e3fd30803030740i18ca8db1y681b4f10797f8c83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 17:31:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWDYq-0002au-PD
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 17:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYCCQaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbYCCQaG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 11:30:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46352 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbYCCQaE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 11:30:04 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JX500JNUXTU6SF0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Mar 2008 11:29:54 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4d8e3fd30803030740i18ca8db1y681b4f10797f8c83@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75940>

On Mon, 3 Mar 2008, Paolo Ciarrocchi wrote:

> On Mon, Mar 3, 2008 at 4:21 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> > "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
> >
> > > "A merge is always between the current HEAD and one or more remote
> > > branch heads"
> >
> > I think this is just wrong. Would this be correct?
> 
> Sounds better than the original document,
> however I'm still having some problems in visualizing what happens
> when I type "git fetch" followed by "git merge".
> 
> > diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> > index 0c9ad7f..e46dea1 100644
> > --- a/Documentation/git-merge.txt
> > +++ b/Documentation/git-merge.txt
> > @@ -68,7 +68,7 @@ HOW MERGE WORKS
> >  ---------------
> >
> >  A merge is always between the current `HEAD` and one or more
> > -remote branch heads, and the index file must exactly match the
> > +branch heads (remote or local), and the index file must exactly match the

Yes, this is much better.  A merge may occur with any other branches, 
local or remote, or even with a tag, or any other random commit 
reference for that matter.

> When I run the command git fetch the objects are downloaded from the remote
> branch and locally stored in the objects database.
> Both the working tree and index are not touched by this operation.
> Is this correct?

Yes.  The fetch operation will figure out, with the remote machine, what 
is the set of objects that you already have and the set that you don't 
have so the remote machine will create and send you a pack of only the 
objects you're missing.  And the remote machine will also reduce it to 
deltas against objects that you already have when possible so the 
transferred pack is even smaller.  Once that pack has successfully been 
received, then the branch head for which this pack was requested will be 
updated to point at the latest commit for that branch.

> How can I look to what I just downloaded?
> Should I simply do a git diff?

If you have reflog enabled (it should be by default) then a good thing 
to remember is the @{1} notation.  For example, if the fetch updated the 
origin/master branch, then origin/master@{1} is what your origin/master 
was before being updated.  To see the difference between the previous 
and the current state of origin/master, you can do:

	git diff origin/master@{1}..origin/master

Or to see the list of new commits:

	git log origin/master@{1}..origin/master

	git log -p origin/master@{1}..origin/master

Etc.

This notation is a bit obnoxious and the re were suggestions about 
addind the equivalent origin/master@{1..} but that didn't materialize 
yet.

> Backing to the documentation, your proposal is:
>  A merge is always between the current `HEAD` and one or more
>  branch heads (remote or local), and the index file must exactly match the
> 
> In case of a git fetch + git merge the merge is between the current
> `HEAD` and the
> downloaded objects. Is correct to define it `branch heads`?

A merge doesn't happen between a branch and some objects.  Please don't 
see it that way.  Objects are at a lower level of abstraction.  What a 
fetch does is to make sure your version of a branch (say origin/master) 
matches the remote version of the branch "master" on server "origin".  
If you happen to already have all the needed objects already, then no 
objects will be transferred and only the branch reference will be 
updated.

The merge operation really works at the commit graph level in order to 
jointwo or more branches together. Objects associated to the involved 
branches are only checked so to make sure the merging of the specified 
branches does not create a conflict (and to fix it otherwise).  If a 
merge conflict is fixed (either manually or automatically) then new 
objects corresponding to the modified files are locally created but the 
previously existing objects remain unchanged.  But object handling 
during a merge is really a low level thing.

> Maybe (read it: for sure) I'm a bit confused by the git terminology
> but I really feel that
> other newbies are not easily understanding this process.

I suggest you have a look at the following article:

	http://eagain.net/articles/git-for-computer-scientists/ 

It is really well written, with the right level of vulgarization to make 
the Git concept really obvious very quickly.


Nicolas
