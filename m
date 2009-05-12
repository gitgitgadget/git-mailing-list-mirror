From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] topgit tg push feature
Date: Tue, 12 May 2009 07:13:34 +0200
Message-ID: <20090512051334.GA22757@pengutronix.de>
References: <20090505093448.GC16524@gmx.de> <20090507045904.GA2068@gmx.de> <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com> <20090507084355.GA11680@pengutronix.de> <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com> <20090509103625.GC13344@lapse.rw.madduck.net> <20090509190910.GA9655@gmx.de> <20090511032813.GA15540@gmx.de> <20090511195532.GA28340@pengutronix.de> <20090511210614.GA6118@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 07:13:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3kJE-00018x-Gd
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 07:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZELFNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 01:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbZELFNf
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 01:13:35 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54758 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZELFNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 01:13:34 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1M3kJ4-00013k-TK; Tue, 12 May 2009 07:13:34 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1M3kJ4-0005yT-PX; Tue, 12 May 2009 07:13:34 +0200
Content-Disposition: inline
In-Reply-To: <20090511210614.GA6118@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118870>

Hello Marc,

On Mon, May 11, 2009 at 11:06:14PM +0200, Marc Weber wrote:
> Thanks to Bert Wesarg, Uwe Kleine-K=F6nig and Martin f Krafft the
> patch is finally ready to be comitted (?) I included ukleineks last
> nitpicks.
>=20
> ukleinek, usage line: remote2 =3D just another remote location.
hhm, so you suggest that you can add more than one remote per -r option=
?
I wouldn't document even if it works now.

> diff --git a/.gitignore b/.gitignore
> index eb56446..2f6d991 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -21,6 +21,8 @@
>  /tg-import.txt
>  /tg-remote
>  /tg-remote.txt
> +/tg-push
> +/tg-push.txt
>  /tg
>  .*.swp
> =20
> diff --git a/README b/README
> index d2f095d..495c70b 100644
> --- a/README
> +++ b/README
> @@ -480,6 +480,12 @@ tg update
> =20
>  	TODO: tg update -a for updating all topic branches
> =20
> +tg push
> +~~~~~~~
> +	pushes a TopGit-controlled topic branch to a remote
> +	repository.  By default the remote gets all dependencies
> +	(both tgish and non-tgish) and bases pushed to.
> +
>  TODO: tg rename
> =20
> =20
> diff --git a/tg-push.sh b/tg-push.sh
> new file mode 100644
> index 0000000..5df5073
> --- /dev/null
> +++ b/tg-push.sh
> @@ -0,0 +1,78 @@
> +#!/bin/sh
> +# TopGit - A different patch queue manager
> +# GPLv2
> +
> +remotes=3D"$base_remote" # honor -r flag of the tg command
> +
> +## Parse options see README
> +
> +recurse_deps=3Dtrue
> +tgish_deps_only=3Dfalse
> +dry_run=3D
> +
> +while [ -n "$1" ]; do
> +	arg=3D"$1"; shift
> +	case "$arg" in
> +	--no-deps)
> +		recurse_deps=3Dfalse;;
> +	--dry-run)
> +		dry_run=3D--dry-run;;
> +	--tgish-only)
> +		tgish_deps_only=3Dtrue;;
> +	-h|--help)
> +		echo "Usage: tg [-r remote] push [--dry-run] [--no-deps] [--tgish-=
only] [-r "remote2 remote3"]* branch*"
> +		exit 0;;
> +	-r)
> +		remotes=3D"$remotes $1"
> +		shift
> +		;;
> +	*)
> +		branches=3D"$branches $arg";;
> +	esac
> +done
> +
> +if [ -z "$remotes" ]; then
> +	remotes=3D"$(git config topgit.remote 2>/dev/null)"
> +fi
This is obsolete with remotes=3D$base_remote above, right?

> +if [ -z "$remotes" ]; then
> +	die "no remote location given. Either use -r remote argument or set=
 topgit.remote"
> +fi
> +
> +if [ -z "$branches" ]; then
> +	branches=3D"$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
> +fi
> +
> +for name in $branches; do
> +	ref_exists "$name" || die "detached HEAD? Can't push $name"
> +done
> +
> +push_branch(){
> +	# if so desired omit non tgish deps
> +	$tgish_deps_only && [ -z "$_dep_is_tgish" ] && return 0
> +
> +	echo "$_dep"
> +	local base=3D"top-bases/$_dep"
> +	if ref_exists "$base"; then
> +		echo "top-bases/$_dep"
> +	else
> +		echo "warning, no base found $base" 1>&2
> +	fi
> +}
> +
> +for remote in $remotes; do
> +	for name in $branches; do
> +		list=3D"$(
> +			# deps
> +			if $recurse_deps; then
> +				no_remotes=3D1 recurse_deps push_branch "$name"
> +			fi
> +			# current branch
> +			_dep=3D"$name"
> +			_dep_is_tgish=3D1
> +			push_branch "$name"
> +		)"
> +		echo "pushing:"; echo $list
> +        git push $dry_run "$remote" $list
> +	done
> +done
> diff --git a/tg.sh b/tg.sh
> index 0804f73..7d98dbd 100644
> --- a/tg.sh
> +++ b/tg.sh
> @@ -136,6 +136,7 @@ branch_annihilated()
>  # of the whole function.
>  # If recurse_deps() hits missing dependencies, it will append
>  # them to space-separated $missing_deps list and skip them.
> +# set no_remotes to any value to omit remote dependencies (-> tg pus=
h)
>  recurse_deps()
>  {
>  	_cmd=3D"$1"; shift
> @@ -145,9 +146,8 @@ recurse_deps()
>  	_depsfile=3D"$(mktemp -t tg-depsfile.XXXXXX)"
>  	# Check also our base against remote base. Checking our head
>  	# against remote head has to be done in the helper.
> -	if has_remote "top-bases/$_name"; then
> +	has_remote "top-bases/$_name" && [ -z "$no_remotes" ] &&
>  		echo "refs/remotes/$base_remote/top-bases/$_name" >>"$_depsfile"
> -	fi
> =20
>  	# if the branch was annihilated, there exists no .topdeps file
>  	if ! branch_annihilated "$_name"; then
> @@ -366,6 +366,8 @@ help|--help|-h)
>  --hooks-path)
>  	# Internal command
>  	echo "@hooksdir@";;
> +eval)
> +	eval "$@";;
>  *)
>  	[ -r "@cmddir@"/tg-$cmd ] || {
>  		echo "Unknown subcommand: $cmd" >&2
hhhm, this hunk is new and unused.  Intended?

If it's OK for you I fix these up when commiting.  I will break out the
change to tg.sh as shown yesterday in irc.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
