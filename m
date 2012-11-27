From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 2/4] git-submodule init: Record submodule.<name>.branch
 in repository config.
Date: Wed, 28 Nov 2012 00:19:04 +0100
Message-ID: <50B54A68.60309@web.de>
References: <20121123175402.GH2806@odin.tremily.us> <cover.1353962698.git.wking@tremily.us> <6734714e90064b3932126565e3027d7edcf45d51.1353962698.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdURH-0001Pu-RX
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963Ab2K0XTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:19:16 -0500
Received: from mout.web.de ([212.227.17.11]:50324 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755051Ab2K0XTO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:19:14 -0500
Received: from [192.168.178.41] ([91.3.157.209]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MNLNt-1Tb1an1hA9-0070Tu; Wed, 28 Nov 2012 00:19:08
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <6734714e90064b3932126565e3027d7edcf45d51.1353962698.git.wking@tremily.us>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:ZaARGWm9vAKUD0yy55QDoTzgvhEbqgNnB8aQT137s76
 PaZTAEXzNfvbau0AyewUkJQzFHCJt5MfGclUH90u1lB6hU77r6
 FTo/e9Ue2xUzCbwikUO7Pvg0AWZXr2uCLo5tV9awM+QmTWuFco
 t8OKVCMOvRWq494Gx4JVdyV3EqO+NI4Qf3qyxXi8opQpCnB3jF
 Fvn/gXuRbC5AaPLcmDYwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210627>

Am 26.11.2012 22:00, schrieb W. Trevor King:
> From: "W. Trevor King" <wking@tremily.us>
> 
> This allows users to override the .gitmodules value with a
> per-repository value.

Your intentions makes lots of sense, but your patch does more than
that. Copying the branch setting into .git/config sets the initial
branch setting into stone. That makes it impossible to have a branch
"foo" in the superproject using a branch "bar" in a submodule and
another superproject branch "frotz" using branch "nitfol" for the
same submodule. You should use the branch setting from .git/config
if present and fall back to the branch setting from .gitmodules if
not, which would enable the user to have her own setting if she
doesn't like what upstream provides but would still enable others
to follow different submodule branches in different superproject
branches.

> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/config.txt   |  9 +++++----
>  git-submodule.sh           |  7 +++++++
>  t/t7400-submodule-basic.sh | 18 ++++++++++++++++++
>  3 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 11f320b..1304499 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1994,10 +1994,11 @@ status.submodulesummary::
>  submodule.<name>.path::
>  submodule.<name>.url::
>  submodule.<name>.update::
> -	The path within this project, URL, and the updating strategy
> -	for a submodule.  These variables are initially populated
> -	by 'git submodule init'; edit them to override the
> -	URL and other values found in the `.gitmodules` file.  See
> +submodule.<name>.branch::
> +	The path within this project, URL, the updating strategy, and the
> +	local branch name for a submodule.  These variables are initially
> +	populated by 'git submodule init'; edit them to override the URL and
> +	other values found in the `.gitmodules` file.  See
>  	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
>  
>  submodule.<name>.fetchRecurseSubmodules::
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 6eed008..c51b6ae 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -505,6 +505,13 @@ cmd_init()
>  		test -n "$(git config submodule."$name".update)" ||
>  		git config submodule."$name".update "$upd" ||
>  		die "$(eval_gettext "Failed to register update mode for submodule path '\$sm_path'")"
> +
> +		# Copy "branch" setting when it is not set yet
> +		branch="$(git config -f .gitmodules submodule."$name".branch)"
> +		test -z "$branch" ||
> +		test -n "$(git config submodule."$name".branch)" ||
> +		git config submodule."$name".branch "$branch" ||
> +		die "$(eval_gettext "Failed to register branch for submodule path '\$sm_path'")"
>  	done
>  }
>  
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index fc08647..3dc8237 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -236,6 +236,24 @@ test_expect_success 'submodule add --local-branch=<name> --branch' '
>  	)
>  '
>  
> +test_expect_success 'init should register submodule branch in .git/config' '
> +	(
> +		cd addtest &&
> +		git submodule init &&
> +		test "$(git config submodule.submod-follow.branch)" = "final"
> +	)
> +'
> +
> +test_expect_success 'local config should override .gitmodules branch' '
> +	(
> +		cd addtest &&
> +		rm -fr submod-follow &&
> +		git config submodule.submod-follow.branch initial
> +		git submodule init &&
> +		test "$(git config submodule.submod-follow.branch)" = "initial"
> +	)
> +'
> +
>  test_expect_success 'setup - add an example entry to .gitmodules' '
>  	GIT_CONFIG=.gitmodules \
>  	git config submodule.example.url git://example.com/init.git
> 
