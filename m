From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH v2] tg-patch: use pretty_tree
Date: Tue, 5 Oct 2010 22:01:59 +0200
Message-ID: <20101005200159.GZ11737@pengutronix.de>
References: <AANLkTikXT=rzOJTTcNOsWkXctKOM3FzQ9ycVtOprLHGh@mail.gmail.com> <1286305486-28607-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:02:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Die-0003gc-Dv
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698Ab0JEUCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 16:02:05 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35832 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab0JEUCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:02:04 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P3Di6-0003ze-Tr; Tue, 05 Oct 2010 22:02:02 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P3Di3-0007Jy-LI; Tue, 05 Oct 2010 22:01:59 +0200
Content-Disposition: inline
In-Reply-To: <1286305486-28607-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158229>

On Tue, Oct 05, 2010 at 09:04:46PM +0200, Bert Wesarg wrote:
> This applies the same treatment to tg-patch like tg-files got in v2.
>=20
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>=20
> ---
>=20
> Basing the decision whether to use the ui diff or the porcelain diff-=
tree
> is probably very unorthodox, but also makes sense, doesn't it?
Uuuuuh, I'd feel better with git diff-tree --color=3Dauto.  Why did you
decide against that?

> Changes:
>  v2:
>   * apply suggestions from Uwe made to tg-files here too
>   * the running pager decides whether we use the ui diff or the porce=
lain
>     diff-tree
>=20
>  tg-patch.sh |   67 +++++++++++++++++++++++++++++++++----------------=
---------
>  1 files changed, 38 insertions(+), 29 deletions(-)
>=20
> diff --git a/tg-patch.sh b/tg-patch.sh
> index 7bafdfe..e88985a 100644 tg-patch.sh
> --- a/tg-patch.sh
> +++ b/tg-patch.sh
> @@ -4,24 +4,18 @@
>  # GPLv2
> =20
>  name=3D
> -
>  topic=3D
> -diff_opts=3D
> -diff_committed_only=3Dyes	# will be unset for index/worktree
> -
> +topic_for_pretty_tree=3D
> =20
>  ## Parse options
> =20
>  while [ -n "$1" ]; do
>  	arg=3D"$1"; shift
>  	case "$arg" in
> -	-i)
> -		topic=3D'(i)'
> -		diff_opts=3D"$diff_opts --cached";
> -		diff_committed_only=3D;;
> -	-w)
> -		topic=3D'(w)'
> -		diff_committed_only=3D;;
> +	-i|-w)
> +		[ -z "$topic" ] || die "-i and -w are mutually exclusive"
> +		topic=3D"(${arg#-})"
> +		topic_for_pretty_tree=3D"$arg";;
>  	-*)
>  		echo "Usage: tg [...] patch [-i | -w] [NAME]" >&2
>  		exit 1;;
> @@ -32,8 +26,8 @@ while [ -n "$1" ]; do
>  done
> =20
> =20
> -[ -n "$name"  -a  -z "$diff_committed_only" ]  &&
> -	die "-i/-w are mutually exclusive with NAME"
> +[ -n "$name" -a -n "$topic" ] &&
> +	die "$topic are mutually exclusive with NAME"
> =20
>  [ -n "$name" ] || name=3D"$(git symbolic-ref HEAD | sed 's#^refs/\(h=
eads\|top-bases\)/##')"
>  base_rev=3D"$(git rev-parse --short --verify "refs/top-bases/$name" =
2>/dev/null)" ||
> @@ -46,22 +40,37 @@ base_rev=3D"$(git rev-parse --short --verify "ref=
s/top-bases/$name" 2>/dev/null)"
> =20
>  setup_pager
> =20
> -cat_file "$topic:.topmsg"
> -echo
> -[ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$name"}=
 -- ".topmsg")" ] || echo '---'
> -
> -# Evil obnoxious hack to work around the lack of git diff --exclude
> -git_is_stupid=3D"$(mktemp -t tg-patch-changes.XXXXXX)"
> -git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+"=
$name"} -- |
> -	fgrep -vx ".topdeps" |
> -	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail ra=
ndomly?
> -if [ -s "$git_is_stupid" ]; then
> -	cd "$root_dir"
> -	cat "$git_is_stupid" | xargs git diff -a --patch-with-stat $diff_op=
ts "$base_rev" ${diff_committed_only:+"$name"} --
> -else
> -	echo "No changes."
> -fi
> -rm "$git_is_stupid"
> +# put out the commit message
> +# and put an empty line out, if the last one in the message was not =
an empty line
> +# and put out "---" if the commit message does not have one yet
> +cat_file "$topic:.topmsg" |
> +	awk '
> +/^---/ {
> +    has_3dash=3D1;
> +}
> +       {
> +    need_empty =3D 1;
> +    if ($0 =3D=3D "")
> +        need_empty =3D 0;
> +    print;
> +}
> +END    {
> +    if (need_empty)
> +        print "";
> +    if (!has_3dash)
> +        print "---";
> +}
> +'
> +
> +b_tree=3D$(pretty_tree "$name" -b)
> +t_tree=3D$(pretty_tree "$name" $topic_for_pretty_tree)
> +
> +# use the ui diff command when the pager is active
> +diff_command=3Ddiff
> +[ "x$GIT_PAGER_IN_USE" =3D "x1" ] ||
> +	diff_command=3Ddiff-tree
> +
> +git $diff_command -p --stat $b_tree $t_tree
> =20
>  echo '-- '
>  echo "tg: ($base_rev..) $name (depends on: $(cat_file "$topic:.topde=
ps" | paste -s -d' '))"
> --=20
> tg: (aaf1181..) bw/tg-patch-pretty_tree (depends on: bw/files)
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
