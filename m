From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] git-submodule: support 'rm' command.
Date: Mon, 25 Jun 2012 18:58:36 +0200
Message-ID: <4FE898BC.2020307@web.de>
References: <1340621820-19448-1-git-send-email-mgorny@gentoo.org> <1340621820-19448-2-git-send-email-mgorny@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 18:58:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjCcm-0003lv-2O
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 18:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325Ab2FYQ6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 12:58:47 -0400
Received: from mout.web.de ([212.227.17.11]:50970 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768Ab2FYQ6q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 12:58:46 -0400
Received: from [192.168.178.48] ([91.3.156.12]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MOj14-1SpF2N0YMw-005lMK; Mon, 25 Jun 2012 18:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <1340621820-19448-2-git-send-email-mgorny@gentoo.org>
X-Provags-ID: V02:K0:Fn5HvIJkQ2ypXr61t0RNn45nUxyiv39m5g26U2QQqWR
 JlvVVRcAI2QFrU8pFVKaC9B/2nbcp9iz7Fu1E5bMjY7Tg++IdZ
 cyILUVcg2iPLzjQ6CikqPIw3ThAESMqjdjPe8LYh7F/EkFiY9b
 lPaYzXudi2+TWLJQ9eVoCR0PGpPkKBFKGPspQK2Nu3+1WPiGiU
 tm1+3YEXFX05nIDd7X5fg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200584>

Am 25.06.2012 12:57, schrieb Micha=C5=82 G=C3=B3rny:
> Add an 'rm' command to git-submodule which provides means to
> (semi-)easily remove git submodules.
>=20
> Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
> ---
> Right now, it requires the submodule checkout to be removed manually
> first (so it does not remove unstaged commits), and just removes
> the index entry and module information from config.
>=20
> I based it on 'cmd_add' code trying to preserve the original coding
> standards.

I really like the goal of this patch but would prefer that "git rm"
learns how to remove submodules instead of adding more code to the
git-submodule.sh script.

Also it shouldn't be necessary for the user to remove the directory
by hand before running "git rm". At least all files recorded in the
submodule can be removed (and if the submodule uses a gitfile that
can be removed too). Then all that is left are untracked files the
user has to decide what to do with (which might be removed too when
running "git rm --recurse-submodules=3Duntracked").

>  Documentation/git-submodule.txt |   12 +++++++
>  git-submodule.sh                |   68 +++++++++++++++++++++++++++++=
+++++++++-
>  2 files changed, 79 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-subm=
odule.txt
> index fbbbcb2..293c1bf 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git submodule' [--quiet] add [-b branch] [-f|--force]
>  	      [--reference <repository>] [--] <repository> [<path>]
> +'git submodule' [--quiet] rm <path>...
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<pat=
h>...]
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
> @@ -104,6 +105,17 @@ together in the same relative location, and only=
 the
>  superproject's URL needs to be provided: git-submodule will correctl=
y
>  locate the submodule using the relative URL in .gitmodules.
> =20
> +rm::
> +	Remove and unregister the submodules at given paths.
> ++
> +This requires at least one <path> argument. The repository checkout
> +existing at that directory needs to be removed manually from
> +the filesystem prior to calling this command. Note that all local
> +changes will be lost.

Me thinks without -f a "git rm" should only then remove a submodule
if no local modifications exist and current HEAD is part of a remote
branch (so you can't loose unpushed commits by accident). If the
submodule uses a gitfile a local branch might be sufficient for that,
as the git directory lives on.

> ++
> +This command removes the submodule from the current git index,
> +the .gitmodules file and the local repository config.

It should not be removed from .git/config by default. The user may
have special settings there and the presence in .git/config shows
he cared about having the submodule checked out, which should not
be revoked by just removing the submodule from the work tree.
Unless he removes the config from there himself he should get back
a populated submodule when he checks out an earlier commit and says
"git submodule update".

>  status::
>  	Show the status of the submodules. This will print the SHA-1 of the
>  	currently checked out commit for each submodule, along with the
> diff --git a/git-submodule.sh b/git-submodule.sh
> index fbf2faf..88fd414 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -6,6 +6,7 @@
> =20
>  dashless=3D$(basename "$0" | sed -e 's/-/ /')
>  USAGE=3D"[--quiet] add [-b branch] [-f|--force] [--reference <reposi=
tory>] [--] <repository> [<path>]
> +   or: $dashless [--quiet] rm [--] <path>...
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<pa=
th>...]
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--for=
ce] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] =
[<path>...]
> @@ -308,6 +309,71 @@ Use -f if you really want to add it." >&2
>  }
> =20
>  #
> +# Remove submodules from the working tree, .gitmodules and the index
> +#
> +# $@ =3D submodule paths
> +#
> +cmd_rm()
> +{
> +	# parse $args after "submodule ... rm".
> +	while test $# -ne 0
> +	do
> +		case "$1" in
> +		--)
> +			shift
> +			break
> +			;;
> +		-*)
> +			usage
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +
> +	if test -z "$1"; then
> +		usage
> +	fi
> +
> +	while test $# -ne 0
> +	do
> +		sm_path=3D$1
> +		shift
> +
> +		# normalize path:
> +		# multiple //; leading ./; /./; /../; trailing /
> +		sm_path=3D$(printf '%s/\n' "$sm_path" |
> +			sed -e '
> +				s|//*|/|g
> +				s|^\(\./\)*||
> +				s|/\./|/|g
> +				:start
> +				s|\([^/]*\)/\.\./||
> +				tstart
> +				s|/*$||
> +			')
> +		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 ||
> +		die "$(eval_gettext "'\$sm_path' does not exist in the index")"
> +
> +		if test -e "$sm_path"
> +		then
> +			die "$(eval_gettext "'\$sm_path' needs to be removed manually fir=
st")"
> +		fi
> +
> +		git rm --cached "$sm_path" ||
> +		die "$(eval_gettext "Failed to remove submodule '\$sm_path'")"
> +
> +		git config -f .gitmodules --remove-section submodule."$sm_path" &&
> +		git add --force .gitmodules ||
> +		die "$(eval_gettext "Failed to unregister submodule '\$sm_path'")"
> +
> +		git config --remove-section submodule."$sm_path"
> +	done
> +}
> +
> +#
>  # Execute an arbitrary command sequence in each checked out
>  # submodule
>  #
> @@ -996,7 +1062,7 @@ cmd_sync()
>  while test $# !=3D 0 && test -z "$command"
>  do
>  	case "$1" in
> -	add | foreach | init | update | status | summary | sync)
> +	add | rm | foreach | init | update | status | summary | sync)
>  		command=3D$1
>  		;;
>  	-q|--quiet)
>=20
