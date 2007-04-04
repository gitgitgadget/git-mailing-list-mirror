From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH(amend)] introduce GIT_WORK_TREE environment variable
Date: Wed, 04 Apr 2007 15:34:48 -0700
Message-ID: <7vslbfydiv.fsf@assigned-by-dhcp.cox.net>
References: <20070328141505.GA16600@moooo.ath.cx>
	<20070404201313.GB22782@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 00:34:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZE48-00071t-7V
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 00:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbXDDWew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 18:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752387AbXDDWew
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 18:34:52 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58439 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbXDDWet (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 18:34:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404223449.BVXP1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 4 Apr 2007 18:34:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jAao1W00N1kojtg0000000; Wed, 04 Apr 2007 18:34:48 -0400
In-Reply-To: <20070404201313.GB22782@moooo.ath.cx> (Matthias Lederhofer's
	message of "Wed, 4 Apr 2007 22:13:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43784>

Matthias Lederhofer <matled@gmx.net> writes:

> GIT_WORK_TREE can be used with GIT_DIR to specify the working tree.
> As for GIT_DIR there is also the option `git
> --work-tree=GIT_WORK_TREE` which overrides the environment
> variable and a config setting core.worktree which is used as
> default value.

I haven't followed the latest code to see if it does what it
claims to in the log message (although I looked at the last
round briefly).

Most of my comments below are not objections but questions.

> setup_git_directory_gently() is rewritten and does the
> following now:
>
>   find the repository directory ($GIT_DIR, ".git" in parent
>   directories, ".")
>
>   read the configuration (core.bare and core.worktree are used)
>
>   if core.bare is not set assume the repository is not bare if a
>   working tree is specified or guess based on the name of the
>   repository directory

Sounds sane so far.

>   for a bare repository:
>     set GIT_DIR if it is not set already and stop (this wont change
>     the directory even if the repository was found as .git in a
>     parent directory)

If you have a normal non-bare layout repository and have
core.bare set (perhaps by mistake), currently we chdir(2) up to
the working tree root, but the new code doesn't.  Is it a
problem in practice?

If you have a truly bare repository (perhaps a one that is
serving the general public over gitweb), and you use GIT_DIR and
GIT_WORK_TREE to have a working tree elsewhere so that you can
hack on it, running a git command from a subdirectory would not
chdir(2) up to the root of the working tree.  I suspect that the
callers of setup_git_directory() would expect to see the same
"cd up to the root and return the prefix" behaviour.  Is this a
problem in practice?

>   for a non-bare repository:
>     if GIT_DIR is specified:
>       use GIT_WORK_TREE, core.worktree or "." as working tree
>     if the repository was found as .git in a parent directory:
>       use the parent directory of the .git directory as working tree

Sounds sane so far.

>     if the repository was found in ".":
>       use "." as working tree

I am not sure about this.

Is there ever a case that the repository (i.e. the directory
that has objects/, refs/, and HEAD) can also be a sane working
tree root?  Wouldn't it be saner to say this case is without any
working tree and fail commands that require a working tree?

>     set inside_git_dir and inside_working_tree based on getcwd() and
>     prefixcmp()

> is_bare_repository() is also changed to return true if the working
> directory is outside of the working tree.

What does this mean from operational perspective?  Suppose you
are using GIT_DIR and GIT_WORK_TREE to have a working tree that
is separate from your working area, and get interrupted and go
somewhere else (say "pushd /var/tmp").  Does this suddenly allow
"git fetch" into the repository to update the current branch
tip?  That does not sound right, but it might not be a good use
case to begin with.  I dunno, but I think is_bare_repository
should mean "I am treating this repository as a bare
repository".  That means I do not want to have "no-working-tree"
semantics applied to the repository operation, regardless of
where my $cwd happens to be, once I say GIT_WORK_TREE to name
which working tree I am using to work with that repository.

What problem are you solving with this is_bare_repository()
thing?  Could it be that you are working around problems with
the current callers that behave inappropriately, based on
is_bare_repository(), when they should really be checking
inside_work_tree() instead, perhaps?

>     - call setup_git_env() from setup_git_directory_gently() if needed

Calling setup_git_env() again would leak memory for
git_object_dir and friends, but I have a bigger worry about this
change.

If calling setup_git_env() explicitly after resetting GIT_DIR
and stuff in this code makes any difference, doesn't that mean
somebody else already called a function in environment.c (say,
get_refs_directory()) and also have already _acted_ on it
(e.g. calling get_packed_refs() which populates the list of refs
based on the old value of "$GIT_DIR/packed-refs")?  Calling the
function again would not undo/redo that, so maybe the calling
sequence into setup_git_env() needs to be made safer.

I think the only thing you care about in your "where is the repo
and where is the worktree" codepath are get_git_dir() and
is_bare_repository().  As a side effect of calling these
functions for your own purpose, you later have to call
setup_git_env() again to clean up, which is fine.  I would feel
better if there is an assert in setup_git_env that catches the
case where it is called for the second time even though the
first caller was something other than this repository/worktree
discovery code.

> diff --git a/environment.c b/environment.c
> index 713a011..769d409 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -60,8 +60,15 @@ void setup_git_env(void)
>  int is_bare_repository(void)
>  {
>  	const char *dir, *s;
> -	if (0 <= is_bare_repository_cfg)
> -		return is_bare_repository_cfg;
> +	/* definitely bare */
> +	if (is_bare_repository_cfg == 1)
> +		return 1;
> +	/* bare if cwd is outside of the working tree */
> +	if (inside_working_tree >= 0)
> +		return !inside_working_tree;
> +	/* configuration says it is not bare */
> +	if (is_bare_repository_cfg == 0)
> +		return 0;
>  
>  	dir = get_git_dir();
>  	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))

For example, calling this function from programs before calling
the repository/worktree discovery is an error, isn't it?  Can we
have a safety here to catch such a programming error?

> diff --git a/setup.c b/setup.c
> index a45ea83..794edcf 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -192,67 +192,168 @@ int is_inside_git_dir(void)
>  	return inside_git_dir;
>  }
>  
> +static char *git_work_tree;
> +
> +static int git_setup_config(const char *var, const char *value)
> +{
> +	if (git_work_tree && !strcmp(var, "core.worktree")) {
> +		strlcpy(git_work_tree, value, PATH_MAX);
> +	}
> +	return git_default_config(var, value);
> +}
> +

Other config functions do not pass already handled variables to
git_default_config().  You probably would care about core.bare
in your own code, so falling back to git_default_config() is
fine, although it may look wasteful.
