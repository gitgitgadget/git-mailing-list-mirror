From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Thu, 21 Oct 2010 10:08:17 +0100
Message-ID: <1287652097.9207.31.camel@wpalmer.simply-domain>
References: <20101018051702.GD22376@kytes>
	 <m3bp6pkrf0.fsf@localhost.localdomain>
	 <1287582160.2673.25.camel@wpalmer.simply-domain>
	 <201010202244.39728.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 11:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8r8h-0007BL-6q
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 11:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843Ab0JUJIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 05:08:23 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43106 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab0JUJIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 05:08:21 -0400
Received: by wwf26 with SMTP id 26so2301703wwf.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=4YjUfGzd0vRpXpcv0/hhnCThmcZTeCgVUNYHu0hzjCI=;
        b=sLdzvXXgSXRKQWfsZDDGQHiBsvQLRAgpg6FKb/YQ6cRcMfmhFFWX4Sjj1CqbJnAeFp
         9mPdU/88Dz0S4WzKO2pBWXJjFPWoz+eU8WfbjqSOYMyKUfJUEZz+eEsU4ou5uUTEgDx9
         JujAKHlSmVaBaM4m2Miq21Jac41mMjYzrtT28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=XgpLCDiTY1qpMLaL8bS5DIvUstW0FVuDoHyx2yiD9bbBwIJQZT7fclAii/oqiOCOOX
         o1V5tbtC5bvD2SX7TCtsl41gj5R09BXKmc18ukycCINzKIDWnAmJc/Qez5+lGMwtiayh
         T8Y6gNlZNzS5ZqVqN95R3KypcOO66A2b2FHfQ=
Received: by 10.227.20.16 with SMTP id d16mr718293wbb.156.1287652100295;
        Thu, 21 Oct 2010 02:08:20 -0700 (PDT)
Received: from [192.168.2.128] (09020403.dsl.redstone-isp.net [193.164.118.24])
        by mx.google.com with ESMTPS id x28sm846802weq.40.2010.10.21.02.08.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 02:08:19 -0700 (PDT)
In-Reply-To: <201010202244.39728.jnareb@gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159491>

On Wed, 2010-10-20 at 22:44 +0200, Jakub Narebski wrote:
> Because (from what I understand) revisions in Subversion are whole
> project all-branches snapshots, and because revision identifiers are
> monotonically incrementing numbers, there is no inherent notion of
> _parent_ of commit, like there is in Git.  (I think that was the reason
> why merge tracking was absent from Subversion until version 1.5, and
> why mergeinfo is per-file rather than per-commit/per-revision property).
> 

To clarify, I was saying that there is a "parent" of each SVN commit, in
the top-level sense. This can be easily converted into a "whole
repository" ("svnroot") tree in git. Of course, this isn't useful for
actual work, but it's a good middle-layer, from which other more-useful
things can be derived.

In terms of converting the svnroot git history into actual branches,
there are several options for mapping things. Ignoring merges for a
moment, we could (for example) notice when two trees (as in tree
objects) are very similar at some point in history, and decide that
those are probably branches. It's tedious, but still fairly simple, to
walk the history and build a new history consisting only of edits to a
subtree (even if the commit messages don't always make sense out of
context). It really doesn't matter one lick whether a single svn commit
touched multiple generated git commits.

Of course, "ignoring merges" is temporary and a total cop-out, but I
wouldn't for a moment pretend that converting svn branches into git
branches is difficult.

> 
> In Git commits store snapshot of top level of a project (contrary to
> revisions in Subversion being snapshot of top level of repository tree,
> all branches and tags in it).  Each commit in Git also stores its parent
> or parents.  Those commit-to-parent links make up DAG (Directed Acyclic
> Graph) of revisions.  Branches in Git reside in separate namespace,
> and are live pointers (like e.g. top pointer in stack implementations)
> to commits; commit that branch points to (the tip of branch) marks out
> subset of DAG of revisions: all descendants of given commits - this form
> a line of development i.e. branch.
> 
> What is important here is that commit is defined by the snapshot of
> top tree, and by its parents.  Different top tree and/or different
> parent(s) means that commit must be different.
> 
> 
> Now take a look at the situation described by Stephen Bash.  Lets
> assume that we have branches in our Subversion repository branches
> 'foo' and 'bar' that diverged at revision number 1, that revision
> 2 was only on branch 'foo', revision 3 was only on branch 'bar',
> and that revision 4 is mishandled edit of file across all branches.
> 
> Let's try to draw it on ASCII-art diagram (fixed-width font required).
> 
>   --- [1]-----[2]---|||---[ ]----|||----|||---[7]       <=== foo
>         \                 [4]
>          \----|||---[3]---[ ]----[5]----[6]             <=== bar
> 
> I marked by '|||' here that given revision doesn't change anything
> on given branch (in given subdirectory of repository tree).
> 
> Now, from what I understand of Subversion model, when one asks for
> history of branch 'foo' in Subversion, it would return all revisions
> that modify 'project/branch/foo' or 'branch/foo/project', and only
> those that modify it (similarly to how path limiting in 
> `git log <path>` works).  For branch 'foo' it would be revisions
> 1, 2, 4, 7; for branch 'bar' it would be revisions 1, 3, 4, 5, 6.
> 
> Am I understanding it correctly?

Sounds right to me

> 
> 
> Now in Git we don't have 'project/branch/foo/xxx', we have only
> top tree of a project.  Therefore we cannot represent revision
> 4 as single git commit.  To have similar situation, i.e. commits
> 1, 2, 4', 7 on branch 'foo', and commits 1, 3, 4'', 5, 6 on branch
> 'bar', we would have to have the following graph of revisions
> 
> 
>   --- 1--<--2--<--4'---<--7            <=== foo
>        \
>         -<--3--<--4''--<--5--<--6      <=== bar
> 
> I uses --<-- here to denote that it is actual directed link.
> 
> Commits 4' and 4'' can have different trees, and have different 
> parents.
> 
> 
> So to have the same results for 'svn log' when on branchs 'foo' and
> 'bar' (however you switch branches in subversion), or 
> 'svn log <foo URL>' and 'svn log <bar URL>' like for 'git log foo'
> and 'git log bar' in the [mishandling] situation described above
> you have to map single all-branches revision 4 in Subversion into
> two commits 4' and 4'' in Git.
> 
> 
> Please correct me if I am wrong about Subversion model.

Also correct. One SVN commit would logically map to several git commits.
It's best to think in terms of:
([svn commit] + [svn path]) -> [git commit] (or git tag, if we can get
the heuristics right)

> 
> > 
> > The difference of course is that the "name" of an svn revision stays the
> > same even if aspects of that revision (for example, the commit message)
> > are changed, while the "name" of a git commit is dependent on everything
> > that makes up a commit. In git terms, changing a commit message is
> > considered to be history rewriting, whereas in svn terms it is merely
> > something which happens occasionally as part of regularly maintained
> > repository.
> > 
> > the git Philosophy is ingrained in its object model: If you change
> > something which led to a state, you change the state itself. I don't
> > think there should be an attempt to work-around that philosophy when
> > talking to external repositories. That is to say: if a commit message
> > (or other revprop) in history changes, we want to treat it as if we were
> > recovering from an upstream rebase. Of course, a problem in that could
> > very well be "how would we know about it?", which is a good question,
> > but one not directly related to [revision+directory]<->[commit]
> > mappings, afaik ;)
> 
> Better solution, actually proposed in separate subthread, is to make use
> of new 'git replace' / 'refs/replaces/*' feature in Git, creating 
> replacement for revision which changed some property retroactively...

I'm not entirely familiar with the git replace mechanism, but wouldn't
that mean that repository git-A (cloned from SVN before the property
change) and repository git-B (cloned from SVN after the property change)
would be unable to merge with each-other?
In my mind, if it would be a rebase when it happens in git-land, it
should be a rebase when it happens in
mechanism-to-make-external-repository-act-just-like-git land.

> 
> ...if Subversion actually offer any way to ask for changed properties.
> Thankfully from what I understand from comments in this thread this
> feature of being able to change revision properties like commit message
> or authorship is by default turned off in Subversion.
> 

Any sufficiently large SVN-tracked project will use all of SVN's
features, whether the maintainer remembers or not ;)

Certainly it could be a "few and far between" thing, which doesn't need
to be handled to get going / usable (especially since creating a fresh
clone is so much faster than with git-svn). I don't know the internals
of SVN beyond what was mentioned in the manual 5 or so years ago, but I
assume you'd need to pretty much iterate over the entire history in
either a slow, git-svn like manner, or a wasteful, "download everything
to check a few things" manner, just in order to check that your
properties are up-to-date. Perhaps I'm thinking of these things wrongly,
and there's actually a simple log-based mechanism for checking such
things which would be fast enough to work into regular git-gc-ish
maintenance.
