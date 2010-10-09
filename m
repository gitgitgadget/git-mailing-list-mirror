From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCHv2] provide global temporary directory
Date: Sat, 9 Oct 2010 23:53:02 +0200
Message-ID: <20101009215302.GR29673@pengutronix.de>
References: <d351f9124a96f212fe66ee85b4241753be94ab2b.1286660467.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 23:53:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4hLt-0001gE-Cz
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 23:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760461Ab0JIVxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 17:53:06 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55963 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607Ab0JIVxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 17:53:05 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P4hLj-0006ny-UJ; Sat, 09 Oct 2010 23:53:03 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P4hLi-0002Dw-RJ; Sat, 09 Oct 2010 23:53:02 +0200
Content-Disposition: inline
In-Reply-To: <d351f9124a96f212fe66ee85b4241753be94ab2b.1286660467.git.bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158629>

On Sat, Oct 09, 2010 at 11:41:47PM +0200, Bert Wesarg wrote:
> The standard procedure 'tmp=3Dmktemp; trap "rm $tmp" 0' was broken wi=
th the
> introduction of the pager. Which overwrites the trap itself to close =
and
> remove the pager fifo.
>=20
> Now tg provides a temp playground and all other temp files should be =
created
> inside this directory and only this directory will be removed with th=
e exit
> trap. setup_pager still overwrites the trap, but keeps the rm command=
 from
> the global temp directory. To simplify this the new function get_temp=
() is
> provided.
>=20
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  hooks/pre-commit.sh |    3 +--
>  tg-export.sh        |    3 +--
>  tg-info.sh          |    3 +--
>  tg-mail.sh          |    4 +---
>  tg-patch.sh         |    3 +--
>  tg-push.sh          |    3 +--
>  tg-summary.sh       |    3 +--
>  tg-update.sh        |    3 +--
>  tg.sh               |   27 +++++++++++++++++++--------
>  9 files changed, 27 insertions(+), 25 deletions(-)
>=20
> diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
> index 4f2f16f..848a929 100644 hooks/pre-commit.sh
> --- a/hooks/pre-commit.sh
> +++ b/hooks/pre-commit.sh
> @@ -95,9 +95,8 @@ BEGIN      { in_hunk =3D 0; }
>  	done
> =20
>  # check for repetitions of deps
> -depdir=3D"$(mktemp -t -d tg-depdir.XXXXXX)" ||
> +depdir=3D"$(get_temp -d tg-depdir)" ||
>  	die "Can't check for multiple occurrences of deps"
> -trap "rm -rf '$depdir'" 0
>  cat_file "(i):.topdeps" |
>  	while read dep; do
>  		[ ! -d "$depdir/$dep" ] ||
> diff --git a/tg-export.sh b/tg-export.sh
> index 6d82d55..921e933 100644 tg-export.sh
> --- a/tg-export.sh
> +++ b/tg-export.sh
> @@ -57,8 +57,7 @@ if [ -z "$branches" ]; then
>  fi
> =20
> =20
> -playground=3D"$(mktemp -d -t tg-export.XXXXXX)"
> -trap 'rm -rf "$playground"' EXIT
> +playground=3D"$(get_temp tg-export -d)"
> =20
> =20
>  ## Collapse driver
> diff --git a/tg-info.sh b/tg-info.sh
> index 7d6a34c..10e257e 100644 tg-info.sh
> --- a/tg-info.sh
> +++ b/tg-info.sh
> @@ -51,7 +51,7 @@ fi
>  git cat-file blob "$name:.topdeps" |
>  	sed '1{ s/^/Depends: /; n; }; s/^/         /;'
> =20
> -depcheck=3D"$(mktemp -t tg-depcheck.XXXXXX)"
> +depcheck=3D"$(get_temp tg-depcheck)"
>  missing_deps=3D
>  needs_update "$name" >"$depcheck" || :
>  if [ -n "$missing_deps" ]; then
> @@ -72,6 +72,5 @@ if [ -s "$depcheck" ]; then
>  else
>  	echo "Up-to-date."
>  fi
> -rm "$depcheck"
> =20
>  # vim:noet
> diff --git a/tg-mail.sh b/tg-mail.sh
> index 8167ade..dd4a95a 100644 tg-mail.sh
> --- a/tg-mail.sh
> +++ b/tg-mail.sh
> @@ -34,7 +34,7 @@ if [ -n "$in_reply_to" ]; then
>  fi
> =20
> =20
> -patchfile=3D"$(mktemp -t tg-mail.XXXXXX)"
> +patchfile=3D"$(get_temp tg-mail)"
> =20
>  $tg patch "$name" >"$patchfile"
> =20
> @@ -54,6 +54,4 @@ people=3D
>  # NOTE: git-send-email handles cc itself
>  eval git send-email $send_email_args "$people" "$patchfile"
> =20
> -rm "$patchfile"
> -
>  # vim:noet
> diff --git a/tg-patch.sh b/tg-patch.sh
> index 7bafdfe..68efcf0 100644 tg-patch.sh
> --- a/tg-patch.sh
> +++ b/tg-patch.sh
> @@ -51,7 +51,7 @@ echo
>  [ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$name"}=
 -- ".topmsg")" ] || echo '---'
> =20
>  # Evil obnoxious hack to work around the lack of git diff --exclude
> -git_is_stupid=3D"$(mktemp -t tg-patch-changes.XXXXXX)"
> +git_is_stupid=3D"$(get_temp tg-patch-changes)"
>  git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+"=
$name"} -- |
>  	fgrep -vx ".topdeps" |
>  	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail ra=
ndomly?
> @@ -61,7 +61,6 @@ if [ -s "$git_is_stupid" ]; then
>  else
>  	echo "No changes."
>  fi
> -rm "$git_is_stupid"
> =20
>  echo '-- '
>  echo "tg: ($base_rev..) $name (depends on: $(cat_file "$topic:.topde=
ps" | paste -s -d' '))"
> diff --git a/tg-push.sh b/tg-push.sh
> index 199d738..a928fba 100644 tg-push.sh
> --- a/tg-push.sh
> +++ b/tg-push.sh
> @@ -45,8 +45,7 @@ for name in $branches; do
>  	ref_exists "$name" || die "detached HEAD? Can't push $name"
>  done
> =20
> -_listfile=3D"$(mktemp -t tg-push-listfile.XXXXXX)"
> -trap "rm -f \"$_listfile\"" 0
> +_listfile=3D"$(get_temp tg-push-listfile)"
> =20
>  push_branch()
>  {
> diff --git a/tg-summary.sh b/tg-summary.sh
> index af16888..612bd27 100644 tg-summary.sh
> --- a/tg-summary.sh
> +++ b/tg-summary.sh
> @@ -55,10 +55,9 @@ EOT
>  fi
> =20
>  if [ -n "$sort" ]; then
> -	tsort_input=3D`mktemp`
> +	tsort_input=3D"$(get_temp tg-summary-sort)"
>  	exec 4>$tsort_input
>  	exec 5<$tsort_input
> -	rm $tsort_input
>  fi
> =20
>  ## List branches
> diff --git a/tg-update.sh b/tg-update.sh
> index b256c7c..5162c52 100644 tg-update.sh
> --- a/tg-update.sh
> +++ b/tg-update.sh
> @@ -27,7 +27,7 @@ base_rev=3D"$(git rev-parse --short --verify "refs/=
top-bases/$name" 2>/dev/null)"
> =20
>  ## First, take care of our base
> =20
> -depcheck=3D"$(mktemp -t tg-depcheck.XXXXXX)"
> +depcheck=3D"$(get_temp tg-depcheck)"
>  missing_deps=3D
>  needs_update "$name" >"$depcheck" || :
>  [ -z "$missing_deps" ] || die "some dependencies are missing: $missi=
ng_deps"
> @@ -96,7 +96,6 @@ if [ -s "$depcheck" ]; then
>  else
>  	info "The base is up-to-date."
>  fi
> -rm "$depcheck"
> =20
>  # Home, sweet home...
>  # (We want to always switch back, in case we were on the base from f=
ailed
> diff --git a/tg.sh b/tg.sh
> index 8264a3b..3805eeb 100644 tg.sh
> --- a/tg.sh
> +++ b/tg.sh
> @@ -150,7 +150,7 @@ recurse_deps()
>  	_name=3D"$1"; # no shift
>  	_depchain=3D"$*"
> =20
> -	_depsfile=3D"$(mktemp -t tg-depsfile.XXXXXX)"
> +	_depsfile=3D"$(get_temp tg-depsfile)"
>  	# If no_remotes is unset check also our base against remote base.
>  	# Checking our head against remote head has to be done in the helpe=
r.
>  	if test -z "$no_remotes" && has_remote "top-bases/$_name"; then
> @@ -183,7 +183,6 @@ recurse_deps()
>  		eval "$_cmd"
>  	done <"$_depsfile"
>  	missing_deps=3D"${missing_deps# }"
> -	rm "$_depsfile"
>  	return $_ret
>  }
> =20
> @@ -334,19 +333,28 @@ setup_pager()
>  	# now spawn pager
>  	export LESS=3D"${LESS:-FRSX}"	# as in pager.c:pager_preexec()
> =20
> -	_pager_fifo_dir=3D"$(mktemp -t -d tg-pager-fifo.XXXXXX)"
> -	_pager_fifo=3D"$_pager_fifo_dir/0"
> -	mkfifo -m 600 "$_pager_fifo"
> +	# setup_pager should be called only once per command
> +	pager_fifo=3D"$tg_tmp_dir/pager"
> +	mkfifo -m 600 "$pager_fifo"
> =20
> -	"$TG_PAGER" < "$_pager_fifo" &
> -	exec > "$_pager_fifo"		# dup2(pager_fifo.in, 1)
> +	"$TG_PAGER" < "$pager_fifo" &
> +	exec > "$pager_fifo"		# dup2(pager_fifo.in, 1)
> =20
>  	# this is needed so e.g. `git diff` will still colorize it's output=
 if
>  	# requested in ~/.gitconfig with color.diff=3Dauto
>  	export GIT_PAGER_IN_USE=3D1
> =20
>  	# atexit(close(1); wait pager)
> -	trap "exec >&-; rm \"$_pager_fifo\"; rmdir \"$_pager_fifo_dir\"; wa=
it" EXIT
> +	# deliberately overwrites the global EXIT trap
> +	trap "exec >&-; rm -rf \"$tg_tmp_dir\"; wait" EXIT
> +}
> +
> +# get_temp NAME [-d]
I like your patch in general, but would prefer to have

	# get_temp [-d] NAME

> +# creates a new temporary file (or directory with -d) in the global
> +# temporary directory $tg_tmp_dir with pattern prefix NAME
> +get_temp()
> +{
> +	mktemp ${2-} "$tg_tmp_dir/$1.XXXXXX"
Does the - makes any difference?  If yes, is it portable (enough)?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
