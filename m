From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Thu, 26 Feb 2009 00:24:42 +0100
Message-ID: <20090225232442.GC4573@raven.wolf.lan>
References: <20090224223412.GA4573@raven.wolf.lan> <49A50EB2.80300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 00:32:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcTEj-0001EN-0a
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 00:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758863AbZBYXax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 18:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756380AbZBYXaw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 18:30:52 -0500
Received: from quechua.inka.de ([193.197.184.2]:59134 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755441AbZBYXaw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 18:30:52 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LcTDF-0005Ax-BV; Thu, 26 Feb 2009 00:30:49 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 23ECB2CA93; Thu, 26 Feb 2009 00:24:42 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <49A50EB2.80300@drmicha.warpmail.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111512>

Thanks for your fast response, Michael!

On Wed, Feb 25, 2009 at 10:26:10AM +0100, Michael J Gruber wrote:
> Josef Wolf venit, vidit, dixit 24.02.2009 23:34:
> > I have set up a repository hierarchy like this:
> > 
> > 
> >          subversion-repos
> >                 |
> >            git-svn-repos
> >           /     |     \
> >       clone1  clone2  clone3
[ ... ]
> > And here is my first problem: every time I push to git-svn-repos, its
> > working tree gets out of sync, because pushing don't update the tree.
> > So every time I push, "git status" shows me local modifications which
> > are actually outdated files.  I thought I could use a bare repository
> > to avoid this problem, but git-svn refuses to work on a bare repos.
> > So here's my first question: Any ideas how to get around this?
> 
> Recent enough git should even warn you against doing that, "that" being
> pushing into checked out branches.
> 
> Your diagram above is missing important info, namely which branches you
> are pushing into. But the problem indicates that you are pushing into a
> checked out branch.

Yeah, although I have read countless tutorials/howtos/blogs, I have still
not managed to setup my mental mode in a way compatible with git.  Guess
subversion has carved my brains for too long a time ;-)

> git-svn can't operate on bare repos beacuse rebasing needs a worktree.

Hmm, is this required by the design or is that just an implementation
detail (which, at least in theory, could be re-factored away)?

> > Any ideas how to clean up from the situation?  And how to avoid this
> > problem in the future?
> 
> In your git-svn-repo you need more branches in order to do the
> integration work:
> 
> From your clones, push into branches like remotes/incoming/clone1 or
> remotes/clone1/master etc. on your git-svn-repo. Using remote branches
> there makes sure they will never be checked out.

OK, makes sense.  But there's a drawback: this way I need to keep track
within git-svn-repos which clones exist.  The intent of git-svn-repos
was to provide a central git interface to the subversion-repos for
other developers.  And I'd rather not want to track manually all the
clones/branches they create.

> Then, on git-svn-repo, you need to integrate the incoming clone branches
> with the svn branches:
> 
> - rebase master first using git svn rebase
> - If this fetches new revisions from svn it means that your clones were
> not up to date. Decide now whether you want to rebase your clones first
> and resolve any possible conflicts there (i.e.: git fetch on the clones,
> rebase your changes on top, git push to incoming) or want to continue here.
> - Integrate the incoming clone branches on top of master. If git svn
> fetched new revisions in the previous step then master can't be fast
> forwarded to the incoming clone branch tip. You'll have to cherry-pick
> or use format-patch|am.
> - Now dcommit.

I am not sure I completely understand the details how to setup the
repositories.  Can you please provide an example?

However, I think I got some understanding of the basic workflow.
And IMHO, there's one catch: to synchronize, I need to tightly
coordinate the work on git-svn-repos with the work on its clones.  The
clones are not reachable most of the time, so tightly coordinating
would slow down the flow of changesets extremely.

Maybe things can be improved by introducing one more hierarchy:
 
          subversion-repos
                 |
            git-svn-repos
                 |
           bare-git-repos
           /     |     \
       clone1  clone2  clone3

or something?  bare-git-repos would make it possible for the clones
to push their work, and I have no longer to keep track of all the
clones, right?  For the merge work within git-svn-repos, only
bare-git-repos need to be available, so missing clones would not slow
down the flow of changesets.

> AFAICS, the problem in a git-svn workflow is always svn's missing merge
> capabilities whenever svn and git development diverge, such as when your
> clones develop on top of a svn revision which is not current any more.

I don't see why svn's merge capabilities affect merges done within
git-svn-repos (or even within its clones).  And in fact, in the example
I described, the merge _was_ actually done within one of the clones.
And the merged data arrived in the svn repos correctly.  The conflict
happens at the time the changesets go the way back with "git svn rebase"
At that time, git-svn tries to apply the changesets within its .dotest
directory.  Because they already were applied when they came from the
clone, we got a collision.

I am pretty sure I am missing something important.  But AFAICS, git-svn
should not try to apply the changesets it has sent itself to svn,
because those changesets are already applied.  Normally, you would get
only some "already applied" warning.  But in the case when hunks are
overlapping, this leads to a conflict.

> Somewhere the integration work has to done, and it will involve a
> rebase. I think it's easier to do the rebase on the clone because it's
> "pure git" there, i.e.: If git-svn fetches new stuff go back and do the
> work on the clone. The only problem is if this is a quickly moving target.

Well, and the second problem is that most of the clones are not (and
should not) be under my control.  So I can not simply go to the clone to
do the integration work there.

> P.S.: Uh, did somebody say cleanup? Who made the mess? ;)

Guess, that's me.  That's why I asked _how_ to cleanup ;-)
