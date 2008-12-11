From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] submodule: Allow tracking of the newest revision of a
 branch in a submodule
Date: Thu, 11 Dec 2008 12:42:53 -0800
Message-ID: <7vbpvicuk2.fsf@gitster.siamese.dyndns.org>
References: <1229009982-2701-1-git-send-email-git@fabian-franz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hjemli@gmail.com, j.sixt@viscovery.net
To: Fabian Franz <git@fabian-franz.de>
X-From: git-owner@vger.kernel.org Thu Dec 11 21:44:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAsOc-0004gs-R6
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 21:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755AbYLKUnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 15:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756699AbYLKUnG
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 15:43:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbYLKUnE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 15:43:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8294286F4E;
	Thu, 11 Dec 2008 15:43:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B646D86F4B; Thu,
 11 Dec 2008 15:42:55 -0500 (EST)
In-Reply-To: <1229009982-2701-1-git-send-email-git@fabian-franz.de> (Fabian
 Franz's message of "Thu, 11 Dec 2008 13:39:42 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4D4A6164-C7C4-11DD-AD63-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102825>

Fabian Franz <git@fabian-franz.de> writes:

> Submodules currently only allow tracking a specific revision
> and each update in a submodule leads to a new commit in the
> master repository. However some users may want to always track
> the newest revision of a specific (named) tag or branch or HEAD.
> For example the user might want to track a staging branch in all
> submodules.

I initially liked the direction this is going, but I think the above
rationale and the change to use 0{40} have impedance mismatch.  Your
change is not a good way to go about "some users may want".  I'll discuss
more on this below.

> To allow this the "--track|-t <branch>" parameter was added to
> git-submodule.sh, which is added to .gitmodules config file as
> well as "track" parameter. This creates a new local branch on
> checkout, which is tracking the remote branch in case the local
> branch does not yet exist.
>
> Technically the gitlink code was changed to always compare
> successful (so no changes) in case the sha1 is null. In that
> case no new commit is created when there are changes in the
> submodule.

"Technically" here sounds wrong.  I'd suggest dropping it, e.g. "Update
ce_compare_gitlink() so that it always reports a match if the commit
recorded in the index is a null SHA-1."

Because I also do not see a direct connection between "no new commit is
created" and "there are changes in the submodule", I think the last
sentence in the above paragraph of yours is misleading.  The user _can_
create A new commit in the superproject that records a different gitlink
from its parent commit, if (and only if) the user wishes to bind the
updated subproject's branch state to the new state of the superproject,
and that is done by adding the subproject status to the staging area with
"git add" (or use "git commit -a").

It seems to me that what you are really after is to let you change the
state of the subproject checkout in whatever way and have "git commit -a"
in the superproject ignore that change.

I wonder if you can just set "assume unchanged" bit for the subproject
gitlink in the index to achieve the same goal.

Or is there more to it?

> The submodule code is adding the file with 0000* on
> "add".
>
> Signed-off-by: Fabian Franz <git@fabian-franz.de>
> ---
>
> I like this and because of that the --branch is optional. I also like
> that so much, that we have decided against Google Repo.
>
> However I have both cases: Stable development, where I need one special
> version and "wild" development, where I always want the newest published
> one.

I do not think supporting both styles of development is a bad idea.

However, use of 0{40} in the index and the resulting commit object in the
superproject means that this is a project-wide decision, not your personal
preference.  It is not implausible that you would want to do a wild
expeeriment in your own clone of a project that uses the "Stable
development" approach (hence the upstream never would want to have 0{40}
gitlink in its commits).

For example, suppose the project uses "Stable development" approach, and
records the v1.0.0 of submodule at "sub/" in the superproject.  You are a
contributor to that project, and would want to help them futureproof the
superproject code to be forward compatible with the upcoming v1.2.0
release of the subproject.  What would you do?

 * have a clone of superproject, with v1.0.0 submodule bound at "sub/";

 * go to "sub/", fetch and checkout v1.2.0-rc2;

 * go up, build using the updated submodule, see many failures in
   supermodule build;

 * fix them up in a way that can work with both v1.0.0 and v1.2.0 of the
   submodule, while making commits in logical steps, in the supermodule.

And you do not want to record the fact that you used v1.2.0-rc2 of the
submodule at "sub/" in the commits you make in the supermodule, as you
would want to label these commits as "futureproof for upcoming submodule
v1.2.0".

But you cannot use your 0{40} trick, as sending that to the upstream of
the superproject would break their "Stable development" policy.

I wonder if you can just set "assume unchanged" bit for the subproject
gitlink in the index to achieve the same goal.  That would be a local
operation, the gitlink would still point at v1.0.0 version of submodule,
and "git commit -a" in the superproject won't make commits that flips
everybody else's copy to use v1.2.0-rc2 of submodule.

>>I've reviewed the patch just from a shell code writer's point of view.
>
> Okay, I added your suggestions.

In the commentary section in your v2 patch, you said "However I see
problems on remove".  Has that issue been addressed?

> @@ -118,6 +118,10 @@ update::
>  If the submodule is not yet initialized, and you just want to use the
>  setting as stored in .gitmodules, you can automatically initialize the
>  submodule with the --init option.
> ++
> +If you used --track or set the "track" option in .gitmodules this will
> +automatically pull the newest updates from remote instead of tracking a
> +specific revision.

"automatically pull" in the sense that it always goes to the remote, fetch
and merge?  That sounds horribly broken.  You can never work disconnected?

> @@ -159,6 +163,10 @@ OPTIONS
>  --branch::
>  	Branch of repository to add as submodule.
>  
> +-t::
> +--track::
> +	Branch/Tag/HEAD of repository to track in a submodule.
> +

How does the branch parameter to the --track option interact with the
branch parameter to the --branch option?  Does an end user typically set
them to the same branch?  Or would these parameters almost always point at
different branchesof the remote repository?  What are the reasons for the
end user to choose one parameter value for the --branch option and a
different parameter value for the --track option?

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2f47e06..16df528 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> ...
> @@ -197,12 +203,14 @@ cmd_add()
>  		(unset GIT_DIR; cd "$path" && git checkout -f -q ${branch:+-b "$branch" "origin/$branch"}) ||
>  		die "Unable to checkout submodule '$path'"
>  	fi
> +	test -n "$track" && printf '160000 0000000000000000000000000000000000000000\t%s\n' "$path" | git update-index --index-info
>  

You have many overlong lines due to the 0{40} constant string in your
patch.  Have a

	null_sha1=0000000000000000000000000000000000000000

at the beginning of the script, and rewrite the above like this:

	test -n "$track" &&
                printf '160000 %s\t%s\n' "$null_sha1" "$path" |
                git update-index --index-info

or even like this:

	if test -n "$track"
        then
                printf '160000 %s\t%s\n' "$null_sha1" "$path" |
                git update-index --index-info
	fi

Use of $null_sha1 throughout the script will make things easier to read
and at the same time make it less error prone as well for "git submodule"
developers.

> @@ -345,11 +357,29 @@ cmd_update()
>  			then
>  				force="-f"
>  			fi
> +			pull=
> +			if [ "$sha1" = "0000000000000000000000000000000000000000" ]
> +			then
> +				track=$(git config submodule."$name".track)
> +				: ${track:="master"}

In the v2 patch this used to point at "HEAD".  What made you change your
mind?

> +				# if the local branch does not yet exist, create it
> +				( unset GIT_DIR; cd "$path"; git-show-ref --heads --tags -q "$track" || git branch --track "$track" "origin/$track" )

No error checking?

	(
        	unset GIT_DIR;
                cd "$path" &&
                git show-ref --heads --tags -q "$track" ||
                git branch --track "$track" "origin/$track"
	) || barf

The ';' after unset is intentional; some shells reports failure when you
unset an unset variable.

> +				sha1="$track"
> +				pull=1

I tend to prefer booleans in shell scripts spelled like boolean, e.g.

	pull=yes

> +			fi
> +
>  			(unset GIT_DIR; cd "$path" && git-fetch &&
>  				git-checkout $force -q "$sha1") ||
>  			die "Unable to checkout '$sha1' in submodule path '$path'"
>  
>  			say "Submodule path '$path': checked out '$sha1'"
> +
> +			if [ "$pull" = "1" ]
> +			then
> +				# Now pull new updates from origin
> +				( unset GIT_DIR; cd "$path"; git-pull ) || die "Unable to pull in submodule path '$path'"

No error checking?


> +			fi
> +
>  		fi
>  	done
>  }
> @@ -596,7 +626,8 @@ cmd_status()
>  		set_name_rev "$path" "$sha1"
>  		if git diff-files --quiet -- "$path"
>  		then
> -			say " $sha1 $path$revname"
> +			track=$(git config submodule."$name".track)
> +			say " $sha1 $path$revname${track:+ (tracking "$track")}"
>  		else
>  			if test -z "$cached"
>  			then
> diff --git a/read-cache.c b/read-cache.c
> index 8579663..0c14b68 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -137,6 +137,11 @@ static int ce_compare_gitlink(struct cache_entry *ce)
>  	 */
>  	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
>  		return 0;
> +
> +	// To be able to track newest revision
> +	if (is_null_sha1(ce->sha1))
> +		return 0;
> +

I think the comment is wrong, as it is not about newness at all.

	/* ignore changes in the submodule path */

would be more appropriate.
