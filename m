From: "David Jeske" <jeske@willowmail.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 19:37:55 -0000
Message-ID: <43260.7826347978$1214426654@news.gmane.org>
References: <20080625133458.GE20361@mit.edu>
	<willow-jeske-01l6@3PlFEDjCVAh-01l6OB5yFEDjCYe3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:44:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbqY-0007GB-AK
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYFYUnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbYFYUnJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:43:09 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60610 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752211AbYFYUnI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:43:08 -0400
Received: (qmail 3442 invoked by uid 90); 25 Jun 2008 20:43:01 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Wed, 25 Jun 2008 19:37:55 -0000
In-Reply-To: <20080625133458.GE20361@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86343>

Thanks for the info about shared object storage for shared repositories. That's
great, and looks like a good implementation method.

Previously I was thinking in terms of making a different server to change
behavior. However, I think the comments I've read are shifting my mindset
towards making a client-wrapper. I want to provide a system [wrapper] without
the user-burden of thinking about three repositories (local, my-public,
shared-public). Doing this as a wrapper has other benefits, like the fact that
users can treat services like repo.or.cz as the "networked filesystem of their
version control system", so I like it.

I have a model for the operations of this wrapper below.

-- Theodore Tso wrote:
> [snip] sharing in-progress work is highly overrated.

_Seeing_ unfinished changes is overrated. However, so is managing multiple
repositories and managing which data is shared.

I think my new wrapper approach below eliminates this overly-aggressive sharing
while still reducing complexity for the average user.

> So the way I would do things is to simply encourage people to do start
> their work by branching off of an up-to-date master branch, but *not*
> do any git pulls or git pushes.

You confused me here. If their repo.or.cz private repository is their only way
of sharing (because their home directory is inaccessible and emailing patches
is cumbersome), how do they exchange their own changes without pushing? Even in
a short time on git mailing list I see mini-unfinished-patches being posted.

> [ description of commit rewriting, rebase, push ]

The method you describe is burdening all users with learning a bunch of new
concepts to do things that are unnecessary micromanagement for their needs. I'd
prefer to give my users many of the benefits of DVCS/git with a
command/argument set 1/20th the size and a much simpler mental model.

Most of the software we're all using was developed while working with
centralized source control, where people just hack and commit and those commits
are not even known-working. They don't bother with patch/commit rewriting and
management, and it works out just fine. I can see how that finer granularity
may be valuable for linux kernel coordinators. However, most projects don't
need to bother with all that, and even in the ones that do, most of their
contributors don't.

Despite the success of centralized revision control, distributed source control
revision models have some very attractive features which can add efficiency to
a shared-central-repo model without straying far from the familiar (cvs up;
hack; hack; cvs up; cvs commit;) workflow. I read some commentary from Linus
that compared git to a 'filesystem', and that's what I see.. a really awesome
underlying set of mechanisms for implementing SCM.. I'm trying to understand
how to layer an easy to use SCM system on top if it.

Some 'git' users might say the right thing to do is do a different project, but
I think, just like with the filesystem-analogy, there is significant benefit to
sharing a single repository model so a simple source control system can then be
used in powerful ways by powerful users. This is similar to the direction "eg"
(easy git) is heading, but more extreme and extending to the server.

In fact, it seems like we might be better off if all of these source control
user-interfaces (cvs, perforce, git, eg, mercurial, etc. etc.) could be written
on top of a version-control-api that they shared. Witness the similar
implementation strategies of this modern rash of DVCS systems.

--------------------------------------------------------------

I'll try to explain my wrapper model in terms of an example... Imagine I'm
going to deliver a "cvs drop in replacement", ncvs, that mostly keeps the cvs
mental model, but is implemented underneath using git and just works better
than cvs (yet is simpler than git). I'll use the exact cvs command parameters
for illustration, but I wouldn't plan to do this. Notice how each ncvs command
uses many git commands. It's possible these things should be done in terms of
plumbing instead of porcelain to reduce dependence on git changes, but it's
more concise to express them as porcelain.

>From the earlier feedback, there are now two repositories, one is considered
the "shared-root" while the other is the "user" repository.

(1) make "cvs update" safe, make it easy to see granular comments for things
you have not pushed

CVS users do potentially destructive merges all the time. Despite the way we
use terminology, working files ARE a branch, and "cvs up" IS a merge. That
merge can require edits to resolve, and after those edits are complete, the
previous state is NOT recoverable. There is no reason for this. We can easily
save the delta by just making "cvs up" equal "git commit; git pull;", or
alternately, "git stash; git pull; git apply;".

: "ncvs up" ->
:
: git stash; git pull; git apply;
: git diff --stat <baseof:current branch> - un-pushed filenames
: git-show-branch <current branch> - un-pushed comments

Question: when I say "baseof:current branch", I mean "the common-ancestor
between my local-repo tracking branch and the remote-repo branch it's
tracking". How do I find that out?

Adding "git diff --stat <baseof:current branch>" helps keep us aware of what
changes are in our local repo. Any files not pushed up to the branch head on
the server are seen. Likewise with "git-show-branch <current branch>" (which
somehow is not the same as git-show-branch --current).

(2) make "planned ahead of time" branches cheap to make

"cvs up" is the easiest merge in cvs, therefore, separate sets of checked out
working files become the most common form of branching in cvs. They are
basically personal work branches that you can't commit on, and can't
collaborate on. I've seen developers with cvs working directories weeks or
months old because that's an easier way to work on different ideas than
creating a branch and checking them in. DVCS fixes this, by making branches
cheap to make, and by making all branch merges closer to the simplicity of
cvs's easy branch merge "cvs up". However, I don't need to burden the user with
the extra complexity and workload of the default being local branches, which
they then need to do more work to share. I want branches to be shared by
default.

: "ncvs tag -b --shared $branch" ->
:
: [ create a branch on the "shared root" repo, pointing
:   to where I am in my local tree, if I have permission ]
:  git branch --track $branch origin/$branch

: "ncvs tag -b mybranch
:
: [ create a branch on my "user" repo, pointing to where I am
in my local tree, if I have permission ]
: git branch --track $mybranch my-origin/$branch

Question: I'm not sure what commands to use above. How do I create a branch on
a remote repo when I'm on my local machine, without sshing to it?

The advantages of git's repository over cvs's repository in this use-case are
not created because the branch is on the local machine. In fact, we also
created it on the server. The benefit comes from the git revision storage model
being faster and BETTER.

Then to switch our working pointer to this branch, we might do:

: "ncvs up -r mybranch" ->
:
: git stash; git checkout mybranch; git pull;
: git stash show --relevant --recent;

Our "safe update" automatically saved away any local directory changes before
switching off to the branch (if there were any). Our "stash show" is there
always to show us if any stashes hang off a recent parent of the tree we just
switched to, but it only shows them if they are hanging off this tree, and only
if they are recent. If there is, we might want to look at or grab it, or we
might just ignore it and not care.

(3) allow users to commit their 'final' changes to others (only on the branch
they are on)

: "ncvs commit" -> "git commit; git push <only this branch>;"

Question: how do I only push the branch I'm on? "eg" says it does this, but
from a quick look at the code, it wasn't obvious to me how.

Developers who are plenty happy with their existing model of never saving local
changes, can continue doing what they are doing. This makes the ability to save
local changes an added benefit to the users like me that want to do it, instead
of an extra burden to the other users. It also simplifies the issue of which
changes are pushed to the server and which are not, because pushing is managed
by "git push <only this branch>", not by creating and managing local and remote
branch names separately. (easy git took the same approach with push)

(4) Allow users to save interim changes, without ahead of time planning, ahead
of time nameing, and hopefully, without naming at all.

Saving interim changes in a cvs working tree before merging with head is not
cheap. Making my own branch tag isn't too hard, but it takes a long time on a
big tree. Ironically, perforce made branching mechanism faster while making the
cognitive load of branch hing much higher.

: "ncvs save" -> "git commit -a"
:
: "ncvs stash [$name]" ->
:
: $currentbranch = `git branch`
: $base-ish = '<baseof: current branch>'
: git stash;
: git branch -m $currentbranch $name;
: git checkout $baseish;
: git branch $currentbranch

This "ncvs stash" is acknowledging the value of the "git stash" idea, while
also recognizing that when I'm using "git commit" regularly, I don't have
anything in the working set! I really want to stash the changes made since
"origin/<branchname>" and return there with my local <branchname>. This is
really after the fact branch creation. If no $name is supplied, then it can
auto-generate one like stash does.

(5) make it obvious there is a difference between local and remote changes, but
make it easy to diff against remote before "ncvs commit;"

: "ncvs diff" ->
:
: echo -n "since commit(-C): "  \
:   `git diff --shortstat <baseof:current branch>`; \
:   echo
: echo -n "since save(-S): " \
:   `git diff`; echo
:
: "ncvs diff -S" -> "git diff"
: "ncvs diff -C" -> "git diff <baseof:current branch>
--------------------------------------------------------------

I'm primarily trying to understand how to map my model to git.
Continued thanks for the discussion and help.
