From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] submodule: change submodule.<name>.branch default from
 master to HEAD
Date: Mon, 31 Mar 2014 21:35:07 +0200
Message-ID: <5339C36B.5020502@web.de>
References: <20140328030556.GD25485@odin.tremily.us> <c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:35:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhzO-0005kG-SE
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbaCaTfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 15:35:13 -0400
Received: from mout.web.de ([212.227.17.11]:55325 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaCaTfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 15:35:11 -0400
Received: from [192.168.178.41] ([79.193.64.198]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MP2Sl-1WRhaF3wDX-006KdK; Mon, 31 Mar 2014 21:35:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Dv+FJ8klo/KIr1otej4f7czDg4pnzsyltKh3hBftJ0CRoClu9/H
 n2FJ8ATmAfN4hUtZVXsgnAipA1Embr/awtFwf5n2WQ6WOdYvKdzl1WlkTcFRUl54AXlqKWq
 Cj7RuzKt3PpuoasXZwbhYxuUZ7lvnfJVaR/CDEhUzd1B/8AcHUNZoTT8TDi1UdHp5Yituym
 fHTO5xFuAHuAgzst8USQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245517>

Am 28.03.2014 04:36, schrieb W. Trevor King:
> gitmodule(5) mentioned 'master' as the default remote branch, but
> folks using checkout-style updates are unlikely to care which upstream
> branch their commit comes from (they only care that the clone fetches
> that commit).  If they haven't set submodule.<name>.branch, it makes
> more sense to mirror 'git clone' and use the subproject's HEAD than to
> default to 'master' (which may not even exist).
> 
> After the initial clone, subsequent updates may be local or remote.
> Local updates (integrating gitlink changes) have no need to fetch a
> specific remote branch, and get along just fine without
> submodule.<name>.branch.  Remote updates do need a remote branch, but
> HEAD works as well here as it did for the initial clone.
> 
> Reported-by: Johan Herland <johan@herland.net>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
> This still needs tests, but it gets through the following fine:
> 
>   rm -rf superproject subproject &&
>   mkdir subproject &&
>   (cd subproject &&
>    git init &&
>    echo 'Subproject' > README &&
>    git add README &&
>    git commit -m 'Subproject commit' &&
>    git branch -m master next
>   ) &&
>   mkdir superproject &&
>   (cd superproject &&
>    git init &&
>    git submodule add ../subproject submod &&
>    git commit -am 'Add submod'
>   )
>   (cd subproject &&
>    echo 'work work work' >> README &&
>    git commit -am 'Subproject commit 2'
>   ) &&
>   (cd superproject &&
>    git submodule update --remote &&
>    git commit -am 'Add submod'
>   )
> 
> The main drawback to this approach is that we're changing a default,
> but I agree with John's:
> 
> On Fri, Mar 28, 2014 at 12:21:23AM +0100, Johan Herland wrote:
>> I expect in most cases where "origin/master" happens to be the Right
>> Answer, using the submodule's upstream's HEAD will yield the same
>> result.
> 
> so the default-change may not be particularly intrusive.

I'd prefer a solution that doesn't change any defaults for the
checkout use case (again). Maybe it is a better route to revert
this series, then add tests describing the current behavior for
checkout submodules as a next step before adding the branch mode
for rebase and merge users again?

> Cheers,
> Trevor
> 
>  Documentation/git-submodule.txt |  2 +-
>  Documentation/gitmodules.txt    |  5 +++--
>  git-submodule.sh                | 11 ++++++++---
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 46c1eeb..c485a17 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -284,7 +284,7 @@ OPTIONS
>  	the superproject's recorded SHA-1 to update the submodule, use the
>  	status of the submodule's remote-tracking branch.  The remote used
>  	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
> -	The remote branch used defaults to `master`, but the branch name may
> +	The remote branch used defaults to `HEAD`, but the branch name may
>  	be overridden by setting the `submodule.<name>.branch` option in
>  	either `.gitmodules` or `.git/config` (with `.git/config` taking
>  	precedence).
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index f539e3f..1aecce9 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -53,8 +53,9 @@ submodule.<name>.update::
>  
>  submodule.<name>.branch::
>  	A remote branch name for tracking updates in the upstream submodule.
> -	If the option is not specified, it defaults to 'master'.  See the
> -	`--remote` documentation in linkgit:git-submodule[1] for details.
> +	If the option is not specified, it defaults to the subproject's
> +	HEAD.  See the `--remote` documentation in linkgit:git-submodule[1]
> +	for details.
>  +
>  This branch name is also used for the local branch created by
>  non-checkout cloning updates.  See the `update` documentation in
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 6135cfa..5f08e6c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -819,8 +819,8 @@ cmd_update()
>  		name=$(module_name "$sm_path") || exit
>  		url=$(git config submodule."$name".url)
>  		config_branch=$(get_submodule_config "$name" branch)
> -		branch="${config_branch:-master}"
> -		local_branch="$branch"
> +		branch="${config_branch:-HEAD}"
> +		local_branch="$config_branch"
>  		if ! test -z "$update"
>  		then
>  			update_module=$update
> @@ -860,7 +860,12 @@ Maybe you want to use 'update --init'?")"
>  
>  		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
>  		then
> -			start_point="origin/${branch}"
> +			if test -n "$config_branch"
> +			then
> +				start_point="origin/$branch"
> +			else
> +				start_point=""
> +			fi
>  			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$start_point" "$local_branch" || exit
>  			cloned_modules="$cloned_modules;$name"
>  			subsha1=
> 
