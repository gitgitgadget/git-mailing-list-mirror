From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH v3] tg-files: list files changed by the topic
	branch
Date: Tue, 5 Oct 2010 09:17:23 +0200
Message-ID: <20101005071723.GG11737@pengutronix.de>
References: <AANLkTinv40O_gdMdEbTOV6LQKBNjksAGKMOtewwauMjP@mail.gmail.com> <1286216867-14701-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 09:17:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P31mG-0001i8-3T
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 09:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610Ab0JEHR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 03:17:26 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58183 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942Ab0JEHRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 03:17:25 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P31m8-0005OA-KC; Tue, 05 Oct 2010 09:17:24 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P31m7-0003Kf-B2; Tue, 05 Oct 2010 09:17:23 +0200
Content-Disposition: inline
In-Reply-To: <1286216867-14701-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158168>

Hello,

On Mon, Oct 04, 2010 at 08:27:47PM +0200, Bert Wesarg wrote:
> this could also be a --name-only option to tg-patch. But I Like the
> similarity to 'quilt files'.
>=20
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>=20
> ---
>=20
>  Changes:
>   v3:
>    * use --index-output=3D option in read-tree
>    * use $git_dir instead of $root_dir/.git
>    * bring back the y
>   v2:
>    * work on trees
>=20
>  .gitignore                 |    2 +
>  README                     |    8 +++++++
>  contrib/tg-completion.bash |    1 +
>  tg-export.sh               |    9 --------
>  tg-files.sh                |   43 ++++++++++++++++++++++++++++++++++=
++++
>  tg.sh                      |   49 ++++++++++++++++++++++++++++++++++=
++++++++++
>  6 files changed, 103 insertions(+), 9 deletions(-)
>=20
> diff --git a/.gitignore b/.gitignore
> index 0342e09..0dc4d0e 100644 .gitignore
> --- a/.gitignore
> +++ b/.gitignore
> @@ -22,6 +22,8 @@
>  /tg-depend.txt
>  /tg-export
>  /tg-export.txt
> +/tg-files
> +/tg-files.txt
>  /tg-import
>  /tg-import.txt
>  /tg-info
> diff --git a/README b/README
> index f103d92..46f564a 100644 README
> --- a/README
> +++ b/README
> @@ -272,6 +272,14 @@ tg depend
> =20
>  	TODO: Subcommand for removing dependencies, obviously
> =20
> +tg files
> +~~~~~~~~
> +	List files changed by the current or specified topic branch.
> +
> +	Options:
> +	  -i		list files based on index instead of branch
> +	  -w		list files based on working tree instead of branch
> +
>  tg info
>  ~~~~~~~
>  	Show a summary information about the current or specified
> diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
> index 0ee233c..38567d0 100755 contrib/tg-completion.bash
> --- a/contrib/tg-completion.bash
> +++ b/contrib/tg-completion.bash
> @@ -467,6 +467,7 @@ _tg ()
>  	delete)      _tg_delete ;;
>  	depend)      _tg_depend ;;
>  	export)      _tg_export ;;
> +	files)       _tg_patch ;;
>  	help)        _tg_help ;;
>  	import)      _tg_import ;;
>  	info)        _tg_info ;;
> diff --git a/tg-export.sh b/tg-export.sh
> index 6d82d55..4b0148c 100644 tg-export.sh
> --- a/tg-export.sh
> +++ b/tg-export.sh
> @@ -63,15 +63,6 @@ trap 'rm -rf "$playground"' EXIT
> =20
>  ## Collapse driver
> =20
> -# pretty_tree NAME
> -# Output tree ID of a cleaned-up tree without tg's artifacts.
> -pretty_tree()
> -{
> -	git ls-tree --full-tree "$1" \
> -	| awk -F '	' '$2 !~ /^.top/' \
> -	| git mktree
> -}
> -
>  create_tg_commit()
>  {
>  	name=3D"$1"
> diff --git a/tg-files.sh b/tg-files.sh
> new file mode 100644
> index 0000000..b88940a tg-files.sh
> --- /dev/null
> +++ b/tg-files.sh
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +# TopGit - A different patch queue manager
> +# (c) Petr Baudis <pasky@suse.cz>  2008
> +# GPLv2
> +
> +name=3D
> +topic=3D
> +
> +
> +## Parse options
> +
> +while [ -n "$1" ]; do
> +	arg=3D"$1"; shift
> +	case "$arg" in
> +	-i)
> +		[ -z "$topic" ] || die "-i and -w are mutually exclusive"
> +		topic=3D-i;;
> +	-w)
> +		[ -z "$topic" ] || die "-i and -w are mutually exclusive"
> +		topic=3D-w;;
this can be compressed to:

	-i|-w)
		[ -z "$topic" ] || die "-i and -w are mutually exclusive"
		topic=3D$arg
		;;
=09
> +	-*)
> +		echo "Usage: tg [...] files [-i | -w] [NAME]" >&2
> +		exit 1;;
> +	*)
> +		[ -z "$name" ] || die "name already specified ($name)"
> +		name=3D"$arg";;
> +	esac
> +done
> +
> +
> +[ -n "$name" -a -n "$topic" ] &&
> +	die "-i/-w are mutually exclusive with NAME"
What about=20
	die "$topic is mutually exclusive with NAME"
?

> +
> +[ -n "$name" ] || name=3D"$(git symbolic-ref HEAD | sed 's#^refs/\(h=
eads\|top-bases\)/##')"
> +base_rev=3D"$(git rev-parse --short --verify "refs/top-bases/$name" =
2>/dev/null)" ||
> +	die "not a TopGit-controlled branch"
> +
> +b_tree=3D$(pretty_tree "$name" -b)
> +t_tree=3D$(pretty_tree "$name" $topic)
> +
> +git diff-tree --name-only -r $b_tree $t_tree
> +
> +# vim:noet
> diff --git a/tg.sh b/tg.sh
> index 9d08d63..2bc6bed 100644 tg.sh
> --- a/tg.sh
> +++ b/tg.sh
> @@ -39,6 +39,55 @@ cat_file()
>  	esac
>  }
> =20
> +# get tree for the committed topic
> +get_tree_()
> +{
> +	echo "$1"
> +}
> +
> +# get tree for the base
> +get_tree_b()
> +{
> +	echo "refs/top-bases/$1"
> +}
> +
> +# get tree for the index
> +get_tree_i()
> +{
> +	git write-tree
> +}
> +
> +# get tree for the worktree
> +get_tree_w()
> +{
> +	i_tree=3D$(git write-tree)
> +	(
> +		# the file for --index-output needs to sit next to the
> +		# current index file
> +		: ${GIT_INDEX_FILE:=3D"$git_dir/index"}
> +		TMP_INDEX=3D"$(mktemp "${GIT_INDEX_FILE}-tg.XXXXXX")"
> +		git read-tree -m $i_tree --index-output=3D"$TMP_INDEX" &&
> +		GIT_INDEX_FILE=3D"$TMP_INDEX" &&
> +		export GIT_INDEX_FILE &&
> +		git diff --name-only -z HEAD |
> +			git update-index -z --add --remove --stdin &&
> +		git write-tree &&
> +		rm -f "$TMP_INDEX"
> +	)
> +}
> +
> +# pretty_tree NAME [-b | -i | -w]
> +# Output tree ID of a cleaned-up tree without tg's artifacts.
> +# NAME will be ignored for -i and -w, but needs to be present
> +pretty_tree()
> +{
> +	name=3D$1
> +	source=3D${2#?}
> +	git ls-tree --full-tree "$(get_tree_$source "$name")" |
> +		awk -F '	' '$2 !~ /^.top/' |
> +		git mktree
> +}
> +
>  # setup_hook NAME
>  setup_hook()
>  {
> --=20
> tg: (9404aa1..) bw/files (depends on: master)
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
