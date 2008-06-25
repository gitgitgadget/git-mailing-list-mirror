From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 15:17:29 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806251421520.19665@iabervon.org>
References: <20080625023352.GC20361@mit.edu> <willow-jeske-01l6@3PlFEDjCVAh-01l6@3N@FEDjCXZO> <willow-jeske-01l6Cy0dFEDjCVqc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: David Jeske <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBaVg-0001Za-6z
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbYFYTRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbYFYTRc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:17:32 -0400
Received: from iabervon.org ([66.92.72.58]:54595 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbYFYTRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:17:31 -0400
Received: (qmail 2544 invoked by uid 1000); 25 Jun 2008 19:17:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jun 2008 19:17:29 -0000
In-Reply-To: <willow-jeske-01l6Cy0dFEDjCVqc>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86325>

On Wed, 25 Jun 2008, David Jeske wrote:

> Yes, so I'd have the same thing, except instead of a remote repository, it
> would be a pattern of the branch namespace, such as /origin/users/jeske/*. It
> doesn't seem like the current remote tracking branch stuff can do this, but it
> would be easy to provide a client wrapper that would. Users who tracked the
> whole repository would just get everything, which is also fine. Maybe a client
> patch to make this better would be accepted.

Git actually has good support for large numbers of repositories sharing 
the same object storage. It's actually more efficient (in terms of 
server load) to have thousands of repositories with the same contents than 
one repository with thousands of branches.

> > > (c) grant and enforce permission for certain users to submit _merges
> > > only_ onto certain sub-portions of the "well-named branches"
> >
> > This is the wierd one. *** Why ***? There is nothing magical about
> > merges; all a merge is a commit that contains more than one parent.
> > You can put anything into a merge, and in theory the result of a merge
> > could have nothing to do with either parent. It would be a very
> > perverse merge, but it's certainly possible. So what's the point of
> > trying to enforce rules about "merges only"?
> 
> I'll explain why I wrote this, but I admit it's a strange roundabout way to get
> what I was hoping for. I hope there is a better way. One better way is to just
> change the client, but I was hoping not to have to do that. let me explain..
> 
> Think about using CVS. user does "cvs up; hack hack hack; cvs commit (to
> server)". In git, this workflow is "git pull; hack; commit; hack; commit; git
> push (to server)". I want those interum "commits" to share the changes with the
> server. I want to change this to "git pull; hack; commit-and-share; hack;
> commit-and-share; git-push (to shared branch tag)"
> 
> It would be nice if "commit-and-share" could just use "git-push". However,
> because users are going to do this habitually every commit, probably through a
> script or merged command, I didn't want users who are accidentally working
> directly in the master to accidentally fast-forward origin/master. (everyone
> seems to discourage working on master anyhow). I was hoping to enforce this
> only with server policy, so any git client works. That leaves me with the
> challenge of figuring out which commits on origin/master are actually intended
> to move the pointer, and which are accidents because someone forgot to branch
> before hacking in their client. One simple way to do this is to require any
> origin/master commit to have two children, one on the master, one somewhere
> else. If you have a commit that is directly hanging off of master in this
> design, you are doing the wrong thing. The server would tell you to "git
> checkout master; git branch -b mymaster; git reset origin/master; git push".
> This would put their local changes onto their private branch where they should
> be. When they wanted to do the equivilant of "cvs commit;" or current "git
> push;", they would do a merge to the master, and push again. The server would
> allow it, because it sees the merge.

You have a fundamental misconception about git's data model. A commit 
doesn't have a particular branch it is on. There is only the DAG, where 
each node is a commit that is structured identically to all of the other 
commits. Branches pick out particular nodes in the DAG at particular 
times.

You can even think of there being a single theoretical universal DAG, 
independant of the actual development that gets done, and developers work 
to find the interesting portions, which are ones that contain trees that 
contain working code and useful messages and history that is informative. 
And they use branches to hold references to worthwhile parts of the DAG, 
and not (as in systems like SVN) to partition the DAG, which makes no 
reference to branches.

It therefore doesn't make any sense to ask if a commit is directly hanging 
off of master. If your local branch is up to date, and you commit, your 
commit's parent is the current master. If you now check out master and 
merge your local branch, master gets the same (non-merge) commit.

> I recognize this is a bit strange. I'd love to have a better solution, but this
> is the solution I can think of which only involves server enforcement.

You fundamentally can't do what you want with only server enforcement, 
because git doesn't provide the history of what local operations were used 
to prepare to ask the server to change something. It fundamentally can't, 
because there's no room in its data model of changes to hold that, and 
because its design is to allow flexibility in this preparation.

> Other solutions I thought of would all require client changes that would 
> change everyone's behavior. The candidate I liked best was: disallowing 
> changes to tracking branches, including master, probably by implicitly 
> creating a branch on commit to a tracking branch... However, I don't get 
> the impression this will fit into current git very well, because users 
> would need to turn their current "git push", into a "git merge 
> master;git push"

Git prevents you from committing to tracking branches at all. Any branch 
you can commit to is inherently a local branch, because that's what it 
means for a branch to be local. The "push" operation updates a remote 
branch from a local branch.

Now, what might be good would be to introduce a type of ref that you can 
update with "merge" but not with "commit". Of course, this has to be 
client-side, because the final state doesn't depend on whether you commit 
in a temporary branch and merge into a publishing branch or commit 
directory in the publishing branch.

	-Daniel
*This .sig left intentionally blank*
