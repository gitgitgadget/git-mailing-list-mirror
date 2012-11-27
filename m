From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v4 3/4] git-submodule update: Add --branch option
Date: Tue, 27 Nov 2012 19:51:42 +0100
Message-ID: <20121127185142.GB4185@book.hvoigt.net>
References: <cover.1353962698.git.wking@tremily.us> <95edff1c97c513c555652014f9c2bbf61c8e7560.1353962698.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Nov 27 19:52:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdQGN-0001xH-Hc
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 19:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab2K0Svw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 13:51:52 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:38347 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab2K0Svv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 13:51:51 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TdQFz-0004EI-J4; Tue, 27 Nov 2012 19:51:44 +0100
Content-Disposition: inline
In-Reply-To: <95edff1c97c513c555652014f9c2bbf61c8e7560.1353962698.git.wking@tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210584>

On Mon, Nov 26, 2012 at 04:00:18PM -0500, W. Trevor King wrote:
> From: "W. Trevor King" <wking@tremily.us>
>=20
> This allows users to checkout the current
> superproject-recorded-submodule-sha as a branch, avoiding the detache=
d
> head state that the standard submodule update creates.  This may be
> useful for the existing --rebase/--merge workflows which already avoi=
d
> detached heads.
>=20
> It is also useful if you want easy tracking of upstream branches.  Th=
e
> particular upstream branch to be tracked is configured locally with
> .git/modules/<name>/config.  With the new option =C6var's suggested
>=20
>   $ git submodule foreach 'git checkout $(git config --file $toplevel=
/.gitm
> odules submodule.$name.branch) && git pull'
>=20
> reduces to a
>=20
>   $ git submodule update --branch
>=20
> after each supermodule .gitmodules edit, and a
>=20
>   $ git submodule foreach 'git pull'
>=20
> whenever you feel like updating the submodules.  Your still on you're
> own to commit (or not) the updated submodule hashes in the
> superproject's .gitmodules.
>=20
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/git-submodule.txt | 20 +++++++++++------
>  git-submodule.sh                | 48 +++++++++++++++++++++++++++++--=
--------
>  t/t7406-submodule-update.sh     | 50 +++++++++++++++++++++++++++++++=
+++++++++-
>  3 files changed, 98 insertions(+), 20 deletions(-)
>=20
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-subm=
odule.txt
> index d0b4436..34392a1 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	      [-f|--force] [--reference <repository>] [--] <repository> [<p=
ath>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<pat=
h>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> -'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
> +'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--branch]=
 [--rebase]
>  	      [--reference <repository>] [--merge] [--recursive] [--] [<pat=
h>...]
>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-=
limit) <n>]
>  	      [commit] [--] [<path>...]
> @@ -136,11 +136,11 @@ init::
> =20
>  update::
>  	Update the registered submodules, i.e. clone missing submodules and
> -	checkout the commit specified in the index of the containing reposi=
tory.
> -	This will make the submodules HEAD be detached unless `--rebase` or
> -	`--merge` is specified or the key `submodule.$name.update` is set t=
o
> -	`rebase`, `merge` or `none`. `none` can be overridden by specifying
> -	`--checkout`.
> +	checkout the commit specified in the index of the containing
> +	repository.  This will make the submodules HEAD be detached unless
> +	`--branch`, `--rebase`, `--merge` is specified or the key
> +	`submodule.$name.update` is set to `branch`, `rebase`, `merge` or
> +	`none`. `none` can be overridden by specifying `--checkout`.
>  +
>  If the submodule is not yet initialized, and you just want to use th=
e
>  setting as stored in .gitmodules, you can automatically initialize t=
he
> @@ -207,7 +207,13 @@ OPTIONS
> =20
>  -b::
>  --branch::
> -	Branch of repository to add as submodule.
> +	When used with the add command, gives the branch of repository to
> +	add as submodule.
> ++
> +When used with the update command, checks out a branch named
> +`submodule.<name>.branch` (as set by `--local-branch`) pointing at t=
he
> +current HEAD SHA-1.  This is useful for commands like `update
> +--rebase` that do not work on detached heads.

Since you are reusing this option for update it further convinces me
that reusing it for add makes sense and simplifies the logic for users.

I think an optional argument for --branch would be nice in the update
case:

	$ git submodule update --branch=3Dmaster

would then allow a user that has not configured anything (except the
branch tracking info in the submodule of course) to pull all submodules
master branches.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index c51b6ae..28eb4b1 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -627,7 +631,7 @@ Maybe you want to use 'update --init'?")"
>  			die "$(eval_gettext "Unable to find current revision in submodule=
 path '\$sm_path'")"
>  		fi
> =20
> -		if test "$subsha1" !=3D "$sha1" -o -n "$force"
> +		if test "$subsha1" !=3D "$sha1" -o -n "$force" -o "$update_module"=
 =3D "branch"

As said before I think separating your code from the current update
logic will simplify the handling below.

>  		then
>  			subforce=3D$force
>  			# If we don't already have a -f flag and the submodule has never =
been checked out
> @@ -650,16 +654,21 @@ Maybe you want to use 'update --init'?")"
>  			case ";$cloned_modules;" in
>  			*";$name;"*)
>  				# then there is no local change to integrate
> -				update_module=3D ;;
> +				case "$update_module" in
> +					rebase|merge)
> +						update_module=3D
> +						;;
> +				esac
> +				;;
>  			esac
> =20
>  			must_die_on_failure=3D
>  			case "$update_module" in
>  			rebase)
>  				command=3D"git rebase"
> -				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodul=
e path '\$sm_path'")"
> +				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodul=
e path '\$sm_path'")"=09
>  				say_msg=3D"$(eval_gettext "Submodule path '\$sm_path': rebased i=
nto '\$sha1'")"
> -				must_die_on_failure=3Dyes
> +			must_die_on_failure=3Dyes

Please always cleanup whitespace changes.

>  				;;
>  			merge)
>  				command=3D"git merge"
> @@ -674,15 +683,30 @@ Maybe you want to use 'update --init'?")"
>  				;;
>  			esac
> =20
>  			then
> -				die_with_status 2 "$die_msg"
> -			else
> -				err=3D"${err};$die_msg"
> -				continue
> +				if (clear_local_git_env; cd "$sm_path" &&
> +					git branch -f "$branch" "$sha1" &&
> +					git checkout "$branch")

You wrote in earlier emails that you wanted to protect the user from
non-fastforward changes. So I would expect a

	$ git pull --ff-only

here and the setup of that in the initialization of the submodule.

BTW, I am more and more convinced that an automatically manufactured
commit on update with --branch should be the default. What do other
think? Sascha raised a concern that he would not want this, but as far =
as
I understood he let the CI-server do that so I see no downside to
natively adding that to git. People who want to manually craft those
commits can still amend the generated commit. Since this is all about
helping people keeping their submodules updated why not go the full way=
?

Cheers Heiko
