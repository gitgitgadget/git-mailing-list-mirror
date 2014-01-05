From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Sun, 5 Jan 2014 20:48:50 +0100
Message-ID: <20140105194850.GA2994@book.hvoigt.net>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com> <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Jan 05 20:49:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzth3-0000sC-HU
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 20:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbaAETtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 14:49:00 -0500
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:52491 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaAETs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 14:48:59 -0500
Received: from [77.20.146.74] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vztgs-0001yr-Q9; Sun, 05 Jan 2014 20:48:55 +0100
Content-Disposition: inline
In-Reply-To: <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239968>

On Sun, Jan 05, 2014 at 08:17:00AM -0800, W. Trevor King wrote:
> From: "W. Trevor King" <wking@tremily.us>
> 
> The previous code only checked out the requested branch in cmd_add.
> This commit moves the branch-checkout logic into module_clone, where
> it can be shared by cmd_add and cmd_update.  I also update the initial
> checkout command to use 'rebase' to preserve branches setup during
> module_clone.
> 
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
> Changes since v1:
> * Fix a 'reqested' -> 'requested' typo in the subject/summary.
> * Restore a post-clone 'git checkout -f -q' for the empty-branch case
>   in module_clone().
> * Distinguish between $branch (which defaults to 'master') and a new
>   $config_branch (which defaults to empty) in cmd_update
> 
> After these fixes, all the existing submodule tests pass.  If we want
> to merge this, we'd still want new tests that demonstrate the new
> functionality.

I think this patch is going in the right direction. Making add() and
update() do the same is the right thing to do.

I would still like a complete description of Francesco's use case
though. Francesco: Could you give us a short description about what
exactly is your use-case? And please ignore all technical details how we
are going to implement this. I would like to know how, in an ideal
world, you would expect git to behave. Do you really only care about

	git submodule add

and the *initial*

	git submodule update

?

What happens if a developer already has the submodule and wants to work
on a feature?

> On Sun, Jan 05, 2014 at 04:53:12AM +0100, Francesco Pretto wrote:
> > If I understand it correctly, looking at your intervention in
> > module_clone and cmd_update, when "submodule.<module>.branch" is set
> > during "update" the resulting first clone will always be a branch
> > checkout (cause $branch is filled with "branch" property).
> 
> That's correct.
> 
> > I believe this will break a lot of tests,
> 
> Thanks for prompting me to run the tests.  This v2 now passes all of
> the current submodule tests, and the functionality actually matches my
> earlier descriptions of it ;).
> 
> > as the the documentation says that in this configuration the HEAD
> > should be detached.
> 
> The current Documentation/git-submodule.txt has:
> 
>   update::
>     Update the registered submodules, i.e. clone missing submodules
>     and checkout the commit specified in the index of the containing
>     repository.  This will make the submodules HEAD be detached unless
>     `--rebase` or `--merge` is specified or the key
>     `submodule.$name.update` is set to `rebase`, `merge` or `none`.
> 
> It's not clear if this refers to the initial-clone update, future
> post-clone updates, or both.  Ideally, the behavior should be the
> same, but in the initial-clone case we don't have an existing
> checked-out branch to work with.

I do not think that its actually important to end up with a detached
HEAD. The documentation just states it because in most cases there is no
other option. But I do not think anything will break if a branch points
to the exact sha1 we would checkout and we checkout the branch instead.

> > Also it could break some users that rely on the current behavior.
> 
> The current code always has a detached HEAD after an initial-clone
> update, regardless of submodule.<name>.update, which doesn't match
> those docs either.  Adding a check to only checkout
> submodule.<name>.branch if submodule.<name>.update was 'rebase',
> 'merge', or 'none' would be easy, but I don't think that makes much
> sense.  I can't see any reason for folks who specify
> submodule.<name>.branch to prefer a detached HEAD over a local branch
> matching the remote branch's name.  If they prefer checkout updates,
> the first such update will return them to a detached HEAD.  If they
> prefer merge/rebase updates, future updates will keep them on the same
> branch.  All my commit does is setup that initial branch for folks who
> get the submodule via 'update', in the same way it's currently setup
> for folks who get the submodule via 'add'.

I like your goal of putting this logic into one place. But a few things
still could be improved IMO.

>  git-submodule.sh | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2979197..167d4fa 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -253,6 +253,7 @@ module_clone()
>  	url=$3
>  	reference="$4"
>  	depth="$5"
> +	branch="$6"
>  	quiet=
>  	if test -n "$GIT_QUIET"
>  	then
> @@ -306,7 +307,15 @@ module_clone()
>  	echo "gitdir: $rel/$a" >"$sm_path/.git"
>  
>  	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
> -	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
> +	(
> +		clear_local_git_env
> +		cd "$sm_path" &&
> +		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
> +		case "$branch" in
> +		'') git checkout -f -q ;;
> +		?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> +		esac
> +	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
>  }
>  
>  isnumber()
> @@ -469,16 +478,7 @@ Use -f if you really want to add it." >&2
>  				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
>  			fi
>  		fi
> -		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
> -		(
> -			clear_local_git_env
> -			cd "$sm_path" &&
> -			# ash fails to wordsplit ${branch:+-b "$branch"...}
> -			case "$branch" in
> -			'') git checkout -f -q ;;
> -			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> -			esac
> -		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
> +		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" "$branch" || exit
>  	fi
>  	git config submodule."$sm_name".url "$realrepo"
>  
> @@ -787,7 +787,8 @@ cmd_update()
>  		fi
>  		name=$(module_name "$sm_path") || exit
>  		url=$(git config submodule."$name".url)
> -		branch=$(get_submodule_config "$name" branch master)
> +		config_branch=$(get_submodule_config "$name" branch)
> +		branch="${config_branch:-master}"
>  		if ! test -z "$update"
>  		then
>  			update_module=$update
> @@ -815,7 +816,7 @@ Maybe you want to use 'update --init'?")"
>  
>  		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
>  		then
> -			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
> +			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$config_branch" || exit

In the simple case (update=checkout, no branch specified) with the new
checkout branch stuff in module_clone() this code here ends up calling
checkout twice.  First for master and then here later with the sha1.
This feels a little bit double. I would prefer if we skip the checkout
in module_clone() if its not necessary.

How about we move the whole "what to checkout"-decision into one place
instead of having it in update() and moving it from add() into
module_clone() ?

Previously there was not much in add() regarding checkout but since it
seems to grow (and now parts need to be shared between add() and
update()). I would like it if we could move that code into one central
location.

>  			cloned_modules="$cloned_modules;$name"
>  			subsha1=
>  		else
> @@ -861,7 +862,12 @@ Maybe you want to use 'update --init'?")"
>  			case ";$cloned_modules;" in
>  			*";$name;"*)
>  				# then there is no local change to integrate
> -				update_module= ;;
> +				if test -n "$config_branch"; then
> +					update_module="!git reset --hard -q"

If we get here the checkout has already been done. Shouldn't this rather
specify a noop. I.E. like

	update_module="!true"

?

Cheers Heiko
