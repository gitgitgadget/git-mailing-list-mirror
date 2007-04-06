From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH(amend)] introduce GIT_WORK_TREE environment variable
Date: Fri, 6 Apr 2007 15:21:09 +0200
Message-ID: <20070406132109.GA5682@moooo.ath.cx>
References: <20070328141505.GA16600@moooo.ath.cx> <20070404201313.GB22782@moooo.ath.cx> <7vslbfydiv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 15:26:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZoNS-0002Mv-7M
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 15:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767621AbXDFNVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 09:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767622AbXDFNVP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 09:21:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:59771 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1767618AbXDFNVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 09:21:13 -0400
Received: (qmail invoked by alias); 06 Apr 2007 13:21:11 -0000
Received: from pD9EB9509.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.149.9]
  by mail.gmx.net (mp004) with SMTP; 06 Apr 2007 15:21:11 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19BCrBbEhtB2gLKQucS9xCtO0BTRTGQsRt/79sHaH
	VxNztW1oxZAdjT
Content-Disposition: inline
In-Reply-To: <7vslbfydiv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43912>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> 
> > is_bare_repository() is also changed to return true if the working
> > directory is outside of the working tree.
> 
> What does this mean from operational perspective?  Suppose you
> are using GIT_DIR and GIT_WORK_TREE to have a working tree that
> is separate from your working area, and get interrupted and go
> somewhere else (say "pushd /var/tmp").  Does this suddenly allow
> "git fetch" into the repository to update the current branch
> tip?  That does not sound right, but it might not be a good use
> case to begin with.  I dunno, but I think is_bare_repository
> should mean "I am treating this repository as a bare
> repository".  That means I do not want to have "no-working-tree"
> semantics applied to the repository operation, regardless of
> where my $cwd happens to be, once I say GIT_WORK_TREE to name
> which working tree I am using to work with that repository.
> 
> What problem are you solving with this is_bare_repository()
> thing?  Could it be that you are working around problems with
> the current callers that behave inappropriately, based on
> is_bare_repository(), when they should really be checking
> inside_work_tree() instead, perhaps?

Right, I am using is_bare_repository() as check for "has this
repository a usable working tree".

Currently:

    The core.bare setting is ignored during setup which leads to
    things like that:
        
        % git status
        fatal: git-status cannot be used without a working tree.
        % git runstatus
        # On branch master
        [..]

    So one command honors core.bare and another doesn't because even
    though runstatus has the NOT_BARE flag handle_internal_command()
    has not read the core.bare setting and just uses name based
    guessing.

    is_bare_repository() is used for two different checks at the
    moment:
    - should the user be protected from doing things with strange
      effects in repositories with a working tree (e.g. git fetch
      updating HEAD)
    - is there a working tree to be used (e.g. git add)

My patch:

    core.bare = true means that the repository may never be used with
    a working tree.

    is_bare_repository() checks for a usable working tree, this means
    it may return true for non-bare repositories when the cwd is not
    inside the working tree.  This allows a fetch to update HEAD when
    you're outside the working tree.

So the answer (you seem to suggest) to this problem is to split
is_bare_repository() into two functions, which sounds sane to me:
is_bare_repository():
    Check if it is allowed to do things which might cause problems if
    there is someone using this repository with a working tree.  This
    does not mean that there is a working tree available to use.
inside_work_tree():
    Check if there is a usable working tree (cwd is below the working
    tree).

With splitting is_bare_repository() it is no longer abused to check
for a working tree.  This raises the question what 'bare' is actually
supposed to mean:
(1) git may do operations on the repository which have strange effects
    if I'm using the repository with a working tree (e.g. update HEAD
    during a fetch)
(2) git may do (1) but also disallows to use the repository with a
working tree

With (1) it would be ok to let a user work with a repository that has
core.bare = true if she really wants to (e.g. by setting GIT_WORK_TREE
explicitly, details to be figured out later).
With (2) git should disallow the use of a working tree if core.bare = true.

One option to solve this is to make core.bare have three possible
values, so the user can decide if he wants (1) or (2).
    core.bare = true: no working tree allowed
    core.bare = false: don't allow git-fetch to update HEAD etc.
    core.bare = mixed: allow both
In the third case is_bare_repository() would be true and
inside_work_tree() would change depending on cwd and GIT_WORK_TREE
setting.  This would allow git fetch to update the current branch even
while inside the working tree.

But I'm not really sure about this yet, any comments?


> >   for a bare repository:
> >     set GIT_DIR if it is not set already and stop (this wont change
> >     the directory even if the repository was found as .git in a
> >     parent directory)
> 
> If you have a normal non-bare layout repository and have
> core.bare set (perhaps by mistake), currently we chdir(2) up to
> the working tree root, but the new code doesn't.  Is it a
> problem in practice?

If you refer to the user: see above.

For git itself: The caller can only note a difference if it tries to
figure out if the repository is bare or not before calling
setup_gdg (setup_git_directory_gently) or using something else than
is_bare_repository().  After calling setup_gdg everything is the same
as for any other bare repository with the current code: GIT_DIR is
exported and cwd has not been changed.

> If you have a truly bare repository (perhaps a one that is
> serving the general public over gitweb), and you use GIT_DIR and
> GIT_WORK_TREE to have a working tree elsewhere so that you can
> hack on it, running a git command from a subdirectory would not
> chdir(2) up to the root of the working tree.  I suspect that the
> callers of setup_git_directory() would expect to see the same
> "cd up to the root and return the prefix" behaviour.  Is this a
> problem in practice?

Callers of setup_git_directory() should not check if GIT_WORK_TREE is
set and if the cwd is below this directory (which is required to use
the tree) but use is_bare_repository() and inside_work_tree().  The
former should return true, the latter should return false, so the
caller clearly knows that there is no working tree to use and
therefore there is especially no prefix.


> >     if the repository was found in ".":
> >       use "." as working tree
> 
> I am not sure about this.
> 
> Is there ever a case that the repository (i.e. the directory
> that has objects/, refs/, and HEAD) can also be a sane working
> tree root?  Wouldn't it be saner to say this case is without any
> working tree and fail commands that require a working tree?

Right, I can't think of any case where this helps.  I think I tried to
follow the old code but missed that if the directory is named .git it
is found as .git directory in .. and if it is named otherwise it is
bare because its name is not ending in /.git.

> >     - call setup_git_env() from setup_git_directory_gently() if needed
> 
> Calling setup_git_env() again would leak memory for
> git_object_dir and friends, but I have a bigger worry about this
> change.
> 
> If calling setup_git_env() explicitly after resetting GIT_DIR
> and stuff in this code makes any difference, doesn't that mean
> somebody else already called a function in environment.c (say,
> get_refs_directory()) and also have already _acted_ on it
> (e.g. calling get_packed_refs() which populates the list of refs
> based on the old value of "$GIT_DIR/packed-refs")?  Calling the
> function again would not undo/redo that, so maybe the calling
> sequence into setup_git_env() needs to be made safer.
> 
> I think the only thing you care about in your "where is the repo
> and where is the worktree" codepath are get_git_dir() and
> is_bare_repository().  As a side effect of calling these
> functions for your own purpose, you later have to call
> setup_git_env() again to clean up, which is fine.  I would feel
> better if there is an assert in setup_git_env that catches the
> case where it is called for the second time even though the
> first caller was something other than this repository/worktree
> discovery code.

You mean for the third time (first: git_get_dir() from git_config(),
second: setup_gdg, third: someone who should not call setup_git_env)?

I think we could also work around to use setup_git_env() at all: the
guessing part of is_bare_repository() could be moved out of
is_bare_repository() and there could be an additional git_config()
function taking the path to the repository as argument.

> > diff --git a/environment.c b/environment.c
> > index 713a011..769d409 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -60,8 +60,15 @@ void setup_git_env(void)
> >  int is_bare_repository(void)
> >  {
> >  	const char *dir, *s;
> > -	if (0 <= is_bare_repository_cfg)
> > -		return is_bare_repository_cfg;
> > +	/* definitely bare */
> > +	if (is_bare_repository_cfg == 1)
> > +		return 1;
> > +	/* bare if cwd is outside of the working tree */
> > +	if (inside_working_tree >= 0)
> > +		return !inside_working_tree;
> > +	/* configuration says it is not bare */
> > +	if (is_bare_repository_cfg == 0)
> > +		return 0;
> >  
> >  	dir = get_git_dir();
> >  	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
> 
> For example, calling this function from programs before calling
> the repository/worktree discovery is an error, isn't it?  Can we
> have a safety here to catch such a programming error?

Right, before setup_gdg is_bare_repository() will only guess based on
the name, with core.bare being used by setup_gdg this guessing should
not be used if there is more accurate information after calling
setup_gdg.

You mean something like assert(inside_work_tree >= 0); to check if
setup_gdg was called yet?  I didn't see such checks in the git source
yet but I like it, it is better to have an error message pointing at
the bug instead of strange behaviour which may result in a bug.

> > diff --git a/setup.c b/setup.c
> > index a45ea83..794edcf 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -192,67 +192,168 @@ int is_inside_git_dir(void)
> >  	return inside_git_dir;
> >  }
> >  
> > +static char *git_work_tree;
> > +
> > +static int git_setup_config(const char *var, const char *value)
> > +{
> > +	if (git_work_tree && !strcmp(var, "core.worktree")) {
> > +		strlcpy(git_work_tree, value, PATH_MAX);
> > +	}
> > +	return git_default_config(var, value);
> > +}
> > +
> 
> Other config functions do not pass already handled variables to
> git_default_config().  You probably would care about core.bare
> in your own code, so falling back to git_default_config() is
> fine, although it may look wasteful.

Right, this should be:
+	if (!strcmp(var, "core.worktree")) {
+		if (git_work_tree)
+			strlcpy(git_work_tree, value, PATH_MAX);
+		return 0;
+	}

setup_gdg has to be called before calling git_config(), I think we
should do one of
(1) setup_gdg calls git_default_config()
    we can probably get rid of all those
      git_config(git_default_config);
    and
      return git_default_config(var, value);
(2) setup_gdg extracts only core.{bare,worktree} and does not call
    git_default_config()

I'm in favor of the first one: all commands can rely on the default
configuration values to be loaded and I don't see a disadvantage yet.
