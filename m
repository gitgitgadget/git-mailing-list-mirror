From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Mon, 18 Feb 2008 21:52:10 -0800
Message-ID: <7vprutlchh.fsf@gitster.siamese.dyndns.org>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 06:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRLPd-0000UT-VF
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 06:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYBSFwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 00:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYBSFwb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 00:52:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbYBSFw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 00:52:29 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A75F3E75;
	Tue, 19 Feb 2008 00:52:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 832DB3E71; Tue, 19 Feb 2008 00:52:19 -0500 (EST)
In-Reply-To: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon, 18 Feb 2008 21:07:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74377>

Jay Soffian <jaysoffian@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index fb6dae0..fd4904f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -378,11 +378,16 @@ apply.whitespace::
>  	as the '--whitespace' option. See linkgit:git-apply[1].
>  
>  branch.autosetupmerge::
> ...
> +	When setting up new branch <name> from existing branch
> +	<starting-point>, tells linkgit:git-branch[1] and
> +	linkgit:git-checkout[1] to configure branch.<name>.remote and
> +	branch.<name>.merge for use with linkgit:git-fetch[1] and
> +	linkgit:git-pull[1]. There are three valid settings: `false` -- no
> +	automatic setup; `true` -- automatic setup when <starting-poiint> is
> +	a remote branch; `always` -- automatic setup when <starting-point>
> +	is either a local or remote branch. The `--track` and `--no-track`
> +	options to linkgit:git-branch[1] and linkgit:git-checkout[1] always
> +	override this setting. The default is `true`.

Three issues.

 (1) "tells X and Y to configure" is bad.  We may later want to
     add a command that forks a new branch from an existing one,
     and you sure do want it to honor this variable.  Better not
     list the commands but tell the reader that it applies to
     the act of forking a new branch based on an existing one.

 (2) "configure X and Y" is bad.  We may later want to add new
     configuration variables to facilitate marking a branch that
     builds on top of another in addition to the existing remote
     and merge, and you sure do want them to be also set up
     appropriately.

 (3) "for use with X and Y" is bad.  We may later want to add
     new commands that you would use to work with a branch that
     builds on top of another, and you sure do want them to
     honor the configuration variables this automatically sets
     up.

So, how about...

        When creating a new branch starting at an existing 'upstream'
        branch, the new branch can be marked as building on top of the
        'upstream' branch, by setting a few configuration variables
        (e.g. branch.<name>.remote and branch.<name>.merge).  This can
        be explicitly asked for by giving `--track` (and turned off by
        giving `--no-track`) option to commands that create a new branch
        (e.g.  linkgit:git-branch[1]); this variable is consulted when
        neither option is given.  
+
When set to `true`, act as if `--track` is given only if 'upstream' is a
remote tracking branch.  When set to `always`, act as if `--track` is
given even if 'upstream' is a local branch.  When set to `false`, no
such extra configuration is made.  Defaults to `true`.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 7e8874a..3ad9dc0 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -11,9 +11,9 @@ SYNOPSIS
>  'git-branch' [--color | --no-color] [-r | -a]
>  	   [-v [--abbrev=<length> | --no-abbrev]]
>  	   [--contains <commit>]
> -'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
> -'git-branch' (-m | -M) [<oldbranch>] <newbranch>
> -'git-branch' (-d | -D) [-r] <branchname>...
> +'git-branch' [--track | --no-track] [-l] [-f] <newbranch> [<start-point>]
> +'git-branch' (-m | -M) [<branch>] <newbranch>
> +'git-branch' (-d | -D) [-r] <branch>...

Looks more-or-less unnecessary churn to me.  If you have to rename the
placeholders, I would say:

	git branch <branch> [<start-point>]
        git branch -m [<old>] <new>
        git branch -d <branch>

would be short, sweet and sufficient.

>  DESCRIPTION
>  -----------
> @@ -25,29 +25,25 @@ With `--contains <commit>`, shows only the branches that
>  contains the named commit (in other words, the branches whose
>  tip commits are descendant of the named commit).
>  
> -In its second form, a new branch named <branchname> will be created.
> -It will start out with a head equal to the one given as <start-point>.
> -If no <start-point> is given, the branch will be created with a head
> -equal to that of the currently checked out branch.
> +In its second form, a new branch named <newbranch> will be created.
> +It will start out with a head equal to <start-point>. If no
> +<start-point> is given, it is assumed to be the currently checked
> +out branch. The new branch may optionally be configured for use with
> +linkgit:git-pull[1] -- see `--track` and `--no-track` in the OPTIONS
> +section below.

Drop all the changes except for the last sentence.

>  Note that this will create the new branch, but it will not switch the
>  working tree to it; use "git checkout <newbranch>" to switch to the
> -new branch.
> +new branch. (As a shortcut consider using "git checkout [--track | 
> +--notrack ] -b <newbranch>" instead.)

Hinting an alternative is good but is too verbose.

	"git checkout -b" can be used to create and switch in one step.

would be short, sweet and sufficient.

> -When a local branch is started off a remote branch, git sets up the
> -branch so that linkgit:git-pull[1] will appropriately merge from that
> -remote branch.  If this behavior is not desired, it is possible to
> -disable it using the global `branch.autosetupmerge` configuration
> -flag.  That setting can be overridden by using the `--track`
> -and `--no-track` options.

Why remove this?

> @@ -105,38 +101,31 @@ OPTIONS
>  	Display the full sha1s in output listing rather than abbreviating them.
>  
>  --track::
> -	Set up configuration so that git-pull will automatically
> -	retrieve data from the remote branch.  Use this if you always
> -	pull from the same remote branch into the new branch, or if you
> -	don't want to use "git pull <repository> <refspec>" explicitly.
> -	This behavior is the default.  Set the
> -	branch.autosetupmerge configuration variable to false if you
> -	want git-checkout and git-branch to always behave as if
> -	'--no-track' were given.
> +	Set up the new branch's configuration so that linkgit:git-pull[1]
> +	will appropriately merge from the start point when run without

"from the start point" is misleading.

> +	arguments while in the new branch. `--track` is the default behavior
> +	when the start point is a remote branch. See the documentation for
> +	the `branch.autosetupmerge` configuration variable in
> +	linkgit:git-config[1] for how to modify the default.

How about

	When <start-point> is a name of an existing branch (either local
	or remote tracking branch), treat the <start-point> branch as
	the upstream branch for the new branch (i.e. the new branch is
	marked to build on top of the branch) by setting a few extra
	configuration variables to cause "git pull" without repository
	and refspec parameters to fetch and merge (or rebase) from the
	upstream branch.  By default, this happens when forking from a
	remote tracking branch without this option.  This default can be 
	modified by the `branch.autosetupmerge` configuration variable.

By the way, I think the existing code is buggy.  When you say:

	$ git branch --track new $(git rev-parse --verify HEAD~12)

the command should barf, saying "Starting point is not a branch; it
is impossible to set up a tracking information", perhaps without even
creating the "new" branch.  Instead, it silently creates a new branch.

>  --no-track::
> +	Ignore the `branch.autosetupmerge` configuration variable. The new
> +	branch will not be setup for automatic merging.

This is much better than the original text.

>  <start-point>::
>  	The new branch will be created with a HEAD equal to this.  It may
> -	be given as a branch name, a commit-id, or a tag.  If this option
> -	is omitted, the current branch is assumed.
> +	be given as a branch name, a commit-id, or a tag.  Defaults
> +	to the current HEAD.

I do not think this is what _you_ want (although I do not personally
care).  Defaulting to HEAD means <start-point> is not a name of the
branch in such a case.  I suspect that you would want this to create a
new branch that follows your current branch (assuming your HEAD is not
detached):

	$ git branch --track new

wouldn't you?

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index b4cfa04..fd862b4 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -8,25 +8,27 @@ git-checkout - Checkout and switch to a branch
>  SYNOPSIS
>  --------
>  [verse]
> -'git-checkout' [-q] [-f] [[--track | --no-track] -b <new_branch> [-l]] [-m] [<branch>]
> +'git-checkout' [-q] [-f] [-m] <branch>
> +'git-checkout' [-q] [-f] [-m] [-l] [--track | --no-track] -b <newbranch> [<start-point>]
>  'git-checkout' [<tree-ish>] <paths>...
>
>  DESCRIPTION
>  -----------
>  
> -When <paths> are not given, this command switches branches by
> -updating the index and working tree to reflect the specified
> -branch, <branch>, and updating HEAD to be <branch> or, if
> -specified, <new_branch>.  Using -b will cause <new_branch> to
> -be created; in this case you can use the --track or --no-track
> -options, which will be passed to `git branch`.
> +It its first form this command switches branches by updating the
> +index and working tree to reflect <branch> and updating HEAD to
> +<branch>.

Now this is getting tiresome.  The rewrite might be a good change for
readability but this does not have anything to do with --track.  The
review process of such a rewrite should be done as an independent
topic.

I give up (for now).
