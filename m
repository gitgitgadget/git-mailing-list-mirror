From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-init: set core.workdir when GIT_WORK_DIR is specified
Date: Sat, 17 Mar 2007 12:01:12 +0100
Message-ID: <20070317110112.GA31595@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 17 12:01:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSWf5-0001tt-3c
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 12:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbXCQLBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 07:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965404AbXCQLBU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 07:01:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:45291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965225AbXCQLBT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 07:01:19 -0400
Received: (qmail invoked by alias); 17 Mar 2007 11:01:17 -0000
X-Provags-ID: V01U2FsdGVkX1/HLVRZQB7HaYvNx2/IBm5l4QUIm03LuaTAlpH3uR
	fRMx3xtMbeVqa+
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42430>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> > git init will die with an error message before doing anything if the
> > value of GIT_WORK_DIR is no valid directory.  GIT_WORK_DIR is also
> > expanded to an absolute path for the config file and is shown to the
> > user (core.workdir = <path>).
> 
> No other configuration variable that is automatically set gives
> such an unwarranted noise to the standard output.
> 
> Applied with printf() removed.  Will cook further in 'pu', as I
> am seeing some questionable things that are queued in there
> already.

I did this because GIT_WORK_DIR is automatically expanded to an
absolute path if it is relative.  The user might do
    
    $ export GIT_DIR=/path/to/repo.git
    $ git --work-dir ../workdir init

but core.workdir will be /path/to/workdir (if there aren't any
symlinks in the path).

> diff --git a/cache.h b/cache.h
> index a4762ed..3bacc46 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -144,6 +144,7 @@ enum object_type {
>  };
>  
>  #define GIT_DIR_ENVIRONMENT "GIT_DIR"
> +#define GIT_WORKING_DIR_ENVIRONMENT "GIT_WORK_DIR"
>  #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
>  #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
>  #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
> @@ -164,6 +165,7 @@ extern char *get_graft_file(void);
>  
>  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
>  
> +extern int has_working_directory;
>  extern const char **get_pathspec(const char *prefix, const char **pathspec);
>  extern const char *setup_git_directory_gently(int *);
>  extern const char *setup_git_directory(void);
> 
> I think "has_working_directory" and "GIT_WORK_DIR" are a bit
> confusing, as everybody knows what a working directory is, and
> it is returned by `pwd`.  But that is obviously not what you
> mean by these words.
>
> We seem to use the word "working tree" in our documentation to
> differenciate the concept of "directory that corresponds to the
> toplevel of the tree structure represented by the index and a
> tree object" from the UNIXy concept of the "current working
> directory".

Ok, I didn't know about this differentiation, git grep 'working
directory' Documentation shows some places that should probable get
changed (git-diff-index.txt for example).
 
> No matter what that concept will end up being called, has_XXX
> does not sound right either.  Everybody has the working tree;
> the new mechanism is about having the working tree in unusual
> location, different from the conventional "attached directly
> above the repository" layout.  Perhaps "separate_working_tree"?

How about inside_working_tree?

> diff --git a/environment.c b/environment.c
> index 0151ad0..7bf6a87 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -59,8 +59,15 @@ static void setup_git_env(void)
>  int is_bare_repository(void)
>  {
>  	const char *dir, *s;
> -	if (0 <= is_bare_repository_cfg)
> -		return is_bare_repository_cfg;
> +	/* definitely bare */
> +	if (is_bare_repository_cfg == 1)
> +		return 1;
> +	/* GIT_WORK_DIR is set, bare if cwd is outside */
> +	if (has_working_directory >= 0)
> +		return !has_working_directory;
> +	/* configuration says it is not bare */
> +	if (is_bare_repository_cfg == 0)
> +		return 0;

This only changes the behaviour if GIT_WORK_DIR is used.  In this case
is_bare_repository is true if either core.bare is true or we are not
in the specified working tree.  This will make commands which require
the working tree stop when they are not run below the working tree.
We could also use the old behaviour when the command is not run in the
specified working tree by using the cwd as working tree or guessing
based on the GIT_DIR name (see below).

Perhaps I'm also abusing is_bare_repository because the property
'bare' of a repository does not change if you are in- or outside of
the associated working tree.  But the comment for NOT_BARE says
"require working tree to be present", I'm not sure if 'present' means
'has one at all' or 'the command is run inside the working tree'.

I also noticed that handle_internal_command() will use
is_bare_repository() without calling git_config(git_default_config)
and therefore is_bare_repository() will always use the guessing
mechanism to find out if the repository is bare or not.  Therefore
GIT_DIR=/path/to/.git will use the cwd as working tree but
GIT_DIR=/path/to/foo.git will complain because git guesses it is bare
even though the config might say otherwise.

> This feels convoluted.  Both of these variables stay -1
> (uninitialized) when unknown, set to 0 if definite negative and
> set to 1 if definite positive, so it is unclear why you are
> checking only positive is_bare first, then the new setting and
> then negative is_bare later.  Wouldn't it be easier to
> understand if it were written like this?
> 
> 	/* if configuration says so, then we obey. */
> 	if (0 <= is_bare_repository_cfg)
> 		return is_bare_repository_cfg;
> 
> 	/*
>          * if separate working-tree is specified, then we _do_
>          * have the working tree and the repository is not bare.
>          */
> 	if (0 <= separate_working_tree_cfg)
>         	return !separate_working_tree_cfg;

See the explanation above.

> diff --git a/setup.c b/setup.c
> index a45ea83..208124f 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -192,28 +192,143 @@ int is_inside_git_dir(void)
>  	return inside_git_dir;
>  }
>  
> +static int stat_git_work_dir(struct stat *st)
> +{
[..]
> +	return 1;
> +}
> 
> Blech.  stat_* that returns 1 for success, 0 for wtf (perhaps
> meaning "n/a")?

You're right, the return value should be changed to follow the
conventions.

> I think naming this function "stat" is exposing too much
> implementation detail.  Can the name describe _why_ the caller
> may want to call this function, iow, to achieve what goal?  For
> example, "check_separate_working_tree()" that returns false when
> separate-working-tree feature is not used is easier to
> understand, I would say.  And as a side effect of checking, you
> would get stat info back that you can later use to dig into the
> working tree, but that is an implementation detail.

Well, the implementation detail of stat is quite important to the
(only) caller in this case.  But it also does other stuff (like
die'ing if the working directory does not exist) so you're right that
it is not obvious what this function does.  As we probably wont use
the stat information anymore (see below) this function will be
changed anyway and I'll try to find a better name if some helper
function like this stays in the code.

>  const char *setup_git_directory_gently(int *nongit_ok)
>  {
>  	static char cwd[PATH_MAX+1];
>  	const char *gitdirenv;
>  	int len, offset;
>  
> -	/*
> -	 * If GIT_DIR is set explicitly, we're not going
> -	 * to do any discovery, but we still do repository
> -	 * validation.
> -	 */
> 
> Isn't this comment still half-valid?  We never do "discovery";
> we however now allow the working tree to be specified explicitly
> as an option.

Perhaps something like this?

/*
 * If GIT_DIR is set explicitly we do repository validation and will
 * check for GIT_WORK_TREE as toplevel working tree.
 */

> +			if (stat(cwd, &st))
> +				die("Unable to stat '%s'", cwd);
> +			if (st_work.st_dev == st.st_dev &&
> +			    st_work.st_ino == st.st_ino)
> +				break;
[..]
> 
> Is it safe to assume that we can rely on st_dev/st_ino
> comparison?

That is the way many shells and pwd get the current working directory
keeping the symlinks in (this involves $PWD as reference path).  But
we probably don't need this, see below.

> Do we really need to do this?  Unless symlinks and automounts
> are involved, shouldn't git_work_dir be a substring of cwd and
> in that case can't you simply find the prefix with prefixcmp()?

It should work if we do getcwd() in the cwd and the specified working
tree.  Symlinks in the working tree pointing to another directory in
the working tree should work too and symlinks pointing outside are not
inside the working tree.

> I know doing that would not let you test the "is this inside
> git-dir" condition when GIT_DIR is relative path, but I suspect
> the user deserves it if he is dissociating the working tree from
> the usual repository location with the new mechanism, specify
> GIT_DIR with relative path _and_ chdir around into GIT_DIR.  I
> know you meant well, but the above feels rather scary code for
> dubious benefit.

With another getcwd() inside GIT_DIR we can probably check for this
too.
