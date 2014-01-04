From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] submodule: Respect reqested branch on all clones
Date: Sat, 4 Jan 2014 23:09:15 +0100
Message-ID: <20140104220915.GA5697@book-mint>
References: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
 <dad947caba9e1c49d691ffccc868cfdce7d04e82.1388772192.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Jan 04 23:09:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzZPP-0000LQ-Vm
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 23:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbaADWJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 17:09:28 -0500
Received: from smtprelay02.ispgateway.de ([80.67.29.24]:55367 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbaADWJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jan 2014 17:09:27 -0500
Received: from [77.20.146.74] (helo=book-mint)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VzZPD-0003kf-SG; Sat, 04 Jan 2014 23:09:20 +0100
Content-Disposition: inline
In-Reply-To: <dad947caba9e1c49d691ffccc868cfdce7d04e82.1388772192.git.wking@tremily.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239947>

Hi,

On Fri, Jan 03, 2014 at 10:06:11AM -0800, W. Trevor King wrote:
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
> 
> On Fri, Jan 03, 2014 at 09:49:01AM +0100, Francesco Pretto wrote:
> > - there's a developer "update" user. He will clone the submodule
> > repository with an *attached* HEAD. Subsequent "merge" or "rebase"
> > update operations will keep the HEAD attached.
> 
> 'merge' and 'rebase' updates don't change the HEAD attachment.
> Branches stay branches and detached HEADs stay detached.  If you've
> moved away from the 'checkout' update mechanism, the only thing you
> still need is a way to get an initial checkout on a branch.  This
> should do it (I can add tests if folks like the general approach).
> 
>  git-submodule.sh | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2979197..e2e5a6c 100755
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
> @@ -306,7 +307,14 @@ module_clone()
>  	echo "gitdir: $rel/$a" >"$sm_path/.git"
>  
>  	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
> -	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")

Why should this line be removed? Is it not needed for correct
worktree <-> repo linking of submodules?

> +	(
> +		clear_local_git_env
> +		cd "$sm_path" &&
> +		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
> +		if test -n "$branch"; then
> +			git checkout -f -q -B "$branch" "origin/$branch" && echo "checked out $branch"
> +		fi
> +	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
>  }
>  
>  isnumber()
> @@ -469,16 +477,7 @@ Use -f if you really want to add it." >&2
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
> @@ -815,7 +814,7 @@ Maybe you want to use 'update --init'?")"
>  
>  		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
>  		then
> -			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
> +			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$branch" || exit
>  			cloned_modules="$cloned_modules;$name"
>  			subsha1=
>  		else
> @@ -861,7 +860,12 @@ Maybe you want to use 'update --init'?")"
>  			case ";$cloned_modules;" in
>  			*";$name;"*)
>  				# then there is no local change to integrate
> -				update_module= ;;
> +				if test -n "$branch"; then
> +					update_module="!git reset --hard -q"

Does that not put the user in danger of loosing changes?

I am wondering if we should maybe take a little different approach:

If submodule.<name>.branch is configured:

	git submodule update

will checkout the configured branch instead of the sha1? Maybe something like
this (untested):

diff --git a/git-submodule.sh b/git-submodule.sh
index 2677f2e..eca519a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -903,7 +903,13 @@ Maybe you want to use 'update --init'?")"
                                ;;
                        esac
 
-                       if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
+                       revision="$sha1"
+                       if test -n "$branch"
+                       then
+                               revision="$branch"
+                       fi
+
+                       if (clear_local_git_env; cd "$sm_path" && $command "$revision")
                        then
                                say "$say_msg"
                        elif test -n "$must_die_on_failure"


Then we do not need to write a command configuration into the local repository
configuration. If I understand the OP intention correctly, that should solve the
use-case.

Cheers Heiko
