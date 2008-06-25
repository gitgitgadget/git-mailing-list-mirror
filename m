From: "David Jeske" <jeske@willowmail.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 05:20:49 -0000
Message-ID: <10634.0258535512$1214372002@news.gmane.org>
References: <20080625023352.GC20361@mit.edu>
	<willow-jeske-01l6@3PlFEDjCVAh-01l6@3N@FEDjCXZO>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBNd2-0005Pr-Bb
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbYFYFcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 01:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbYFYFcQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 01:32:16 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60377 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753256AbYFYFcP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 01:32:15 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Jun 2008 01:32:15 EDT
Received: (qmail 26322 invoked by uid 90); 25 Jun 2008 05:25:24 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Wed, 25 Jun 2008 05:20:49 -0000
In-Reply-To: <20080625023352.GC20361@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86232>

-- Theodore Tso wrote:
> Up to here, you can do this all with repo.or.cz, and/or github; you
> just give each developer their own repository, which they are allowed
> to push to, and no once else. Within their own repository they can
> make changes to their branches, so that all works just fine.

Yup. That's one of the reasons git is so attractive. There is some good stuff
under "here" though....

> > (a) safely "share" every DAG, branch, and tag data in their
> > repository to a well-connected server, into an established
> > namespace, while only changing branches and tags in their
> > namespace. This will allow all users to see the changes of other
> > users, without needing direct access to their trees (which are
> > inaccessible behind firewalls). [1]
>
> Right, so thats github and/or git.or.cz. Each user gets his/her own
> repository, but thats a very minor change. Not a big deal.

...most notably, all their DAGs in a single repository to save space is
important. Thousands of copies of thousands of repositories adds up. Especially
when most of the users who want to commit something probably commit <1-10k of
unique stuff. Seems pretty easy to change though. git.or.cz and github will
both be wanting this eventually.

The other big one is ACLs in 'well named' repositories, so multiple people can
safely be allowed to add changes to them, without giving them ability to blow
away the repository. I can see this isn't the way all git users work, but at
least a few users working this way now with shared push repositories. This is
just making it 'safer'. Also seems pretty easy to do.

> > (b) fetch selected DAG, branch, and tag data of others to their tree, to
see
> > the changes of others (whether merged with head or not) while disconnected
or
> > remote.
>
> This is also easy; you just establish remote tracking branches. I
> have a single shell scripted command, git-get-all, which pulls from
> all of the repositories I am interested in into various remote
> tracking branches so while I am disconnected, I can see what other
> folks have done on their trees.

Yes, so I'd have the same thing, except instead of a remote repository, it
would be a pattern of the branch namespace, such as /origin/users/jeske/*. It
doesn't seem like the current remote tracking branch stuff can do this, but it
would be easy to provide a client wrapper that would. Users who tracked the
whole repository would just get everything, which is also fine. Maybe a client
patch to make this better would be accepted.

> > (c) grant and enforce permission for certain users to submit _merges
> > only_ onto certain sub-portions of the "well-named branches"
>
> This is the wierd one. *** Why ***? There is nothing magical about
> merges; all a merge is a commit that contains more than one parent.
> You can put anything into a merge, and in theory the result of a merge
> could have nothing to do with either parent. It would be a very
> perverse merge, but it's certainly possible. So what's the point of
> trying to enforce rules about "merges only"?

I'll explain why I wrote this, but I admit it's a strange roundabout way to get
what I was hoping for. I hope there is a better way. One better way is to just
change the client, but I was hoping not to have to do that. let me explain..

Think about using CVS. user does "cvs up; hack hack hack; cvs commit (to
server)". In git, this workflow is "git pull; hack; commit; hack; commit; git
push (to server)". I want those interum "commits" to share the changes with the
server. I want to change this to "git pull; hack; commit-and-share; hack;
commit-and-share; git-push (to shared branch tag)"

It would be nice if "commit-and-share" could just use "git-push". However,
because users are going to do this habitually every commit, probably through a
script or merged command, I didn't want users who are accidentally working
directly in the master to accidentally fast-forward origin/master. (everyone
seems to discourage working on master anyhow). I was hoping to enforce this
only with server policy, so any git client works. That leaves me with the
challenge of figuring out which commits on origin/master are actually intended
to move the pointer, and which are accidents because someone forgot to branch
before hacking in their client. One simple way to do this is to require any
origin/master commit to have two children, one on the master, one somewhere
else. If you have a commit that is directly hanging off of master in this
design, you are doing the wrong thing. The server would tell you to "git
checkout master; git branch -b mymaster; git reset origin/master; git push".
This would put their local changes onto their private branch where they should
be. When they wanted to do the equivilant of "cvs commit;" or current "git
push;", they would do a merge to the master, and push again. The server would
allow it, because it sees the merge.

I recognize this is a bit strange. I'd love to have a better solution, but this
is the solution I can think of which only involves server enforcement. Other
solutions I thought of would all require client changes that would change
everyone's behavior. The candidate I liked best was: disallowing changes to
tracking branches, including master, probably by implicitly creating a branch
on commit to a tracking branch... However, I don't get the impression this will
fit into current git very well, because users would need to turn their current
"git push", into a "git merge master;git push"

I'm interested in other ideas to address this.

I know that all of what I wrote above seems strange if you don't buy into the
design assumptions. That it's critical to share a single server-repository,
that it's critical to have a shared 'well known' branch that only trusts
clients to add new changes to, etc.. However, these are important.
