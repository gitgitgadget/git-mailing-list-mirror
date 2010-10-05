From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 1/4] provide fan-in and -out traversal interface
Date: Tue, 5 Oct 2010 09:13:34 +0200
Message-ID: <20101005071334.GF11737@pengutronix.de>
References: <1286231300-29268-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 09:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P31iZ-0000ub-T8
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 09:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757683Ab0JEHNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 03:13:36 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39177 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981Ab0JEHNg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 03:13:36 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P31iR-0005HE-8O; Tue, 05 Oct 2010 09:13:35 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P31iQ-0002dY-5c; Tue, 05 Oct 2010 09:13:34 +0200
Content-Disposition: inline
In-Reply-To: <1286231300-29268-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158167>

On Tue, Oct 05, 2010 at 12:28:17AM +0200, Bert Wesarg wrote:
> This adds general functions to get the list of all offending branches=
 for
Is offending the right word here?  I don't understand that.

> a given one. Either which depends on the given branch (fan-in) or all
> dependencies (fan-out).
>=20
> Two simple users are provided which just lists the names or generates=
 dot
> input.
This should then be used for tg summary --graphviz, too, doesn't it?

>=20
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>=20
> ---
>  tg.sh |  170 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 170 insertions(+), 0 deletions(-)
>=20
> diff --git a/tg.sh b/tg.sh
> index 3718702..926b31b 100644 tg.sh
> --- a/tg.sh
> +++ b/tg.sh
> @@ -351,6 +351,176 @@ setup_pager()
>  	trap "exec >&-; rm \"$_pager_fifo\"; rmdir \"$_pager_fifo_dir\"; wa=
it" EXIT
>  }
> =20
> +# traverse_fan_out(for_each_name, for_each_dep, name, head_deps)
This uses an unusual format.

please make it

# traverse_fan_out FOR_EACH_NAME FOR_EACH_DEP NAME HEAD_DEPS

> +#
> +# traverse the dependencies of @name in bfs order and call @for_each=
_name
> +# on each dep (i.e. node) and @for_each_dep on all dependencies (i.e=
=2E edge)
> +# with source and dest as arguments.
> +#
> +# @name' needs to be a TopGit controlled branch
> +#
> +# @head_deps specifies where to take the .topdeps from for the HEAD =
branch
> +# empty - from the committed tree
> +# '(i)' - from the index
> +# '(w)' - from the working dir
> +#
> +traverse_fan_out()
> +{
> +	local for_each_name=3D$1
> +	local for_each_dep=3D$2
> +	local name=3D$3
> +	local head_deps=3D$4 || :
> +	local deps_src
> +	local head=3D"$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-b=
ases\)/##')" || :
I don't remember the exact problems, but some shells get using local an=
d
assignment in a single command wrong.  Can you please fix that up?  (I
fixed that up for one of your commits.)

> +
> +	branchq=3D"$(mktemp -t tg-fan-out.XXXXXX)"
> +	allbranches=3D"$(mktemp -t -d tg-fan-out-all.XXXXXX)"
> +	trap "rm -rf \"$branchq\" \"$allbranches\"" 0
> +
> +	# fill queue with root name
> +	echo "$name" > "$branchq"
> +
> +	while [ -s "$branchq" ]; do
> +		# dequeue
> +		{
> +			read name
> +			cat > "$branchq.headless"
> +		} < "$branchq"
> +		mv -f "$branchq.headless" "$branchq"
> +
> +		# eval name
> +		eval "$for_each_name \"$name\""
> +
> +		# don't travers non-tgish branches
> +		ref_exists "refs/top-bases/$name" ||
> +			continue
> +
> +		deps_src=3D$name
> +		# select .topdeps source for HEAD branch
> +		[ "x$name" =3D "x$head" -a -n "$head_deps" ] &&
> +			deps_src=3D$head_deps
> +
> +		old_IFS=3D"$IFS"
> +		IFS=3D""
> +		cat_file "$deps_src:.topdeps" |
> +		while read dep; do
> +
> +			# eval dep
> +			eval "$for_each_dep \"$name\" \"$dep\""
> +
> +			[ -d "$allbranches/$dep" ] || {
> +				mkdir -p "$allbranches/$dep"
> +				echo "$dep" >> "$branchq"
> +			}
> +		done
> +		IFS=3D"$old_IFS"
> +
> +	done
> +}
> +
> +_graph_dep_edge()
> +{
> +	printf "\t\"%s\" -> \"%s\";\n" "$1" "$2"
> +}
> +
> +# prints the fan-out as a dot graph with edges
> +graph_fan_out()
> +{
> +	printf "digraph G {\n"
> +
> +	traverse_fan_out : _graph_dep_edge "$1" $2
> +
> +	printf "}\n"
> +}
> +
> +# prints the fan-out as name per line
> +list_fan_out()
> +{
> +	traverse_fan_out echo : "$1" $2
> +}
> +
> +# traverse_fan_in(for_each_name, for_each_dep, name, head_deps)
> +#
> +# traverse all branches which depends on @name in bfs order and call
> +# @for_each_name on each (i.e. node) and @for_each_dep on all depend=
encies
> +# (i.e. edge) with source and dest as arguments.
> +#
> +# @name' needs not to be a TopGit controlled branch
> +#
> +# @head_deps specifies where to take the .topdeps from for the HEAD =
branch
> +# empty - from the committed tree
> +# '(i)' - from the index
> +# '(w)' - from the working dir
> +#
> +traverse_fan_in()
> +{
> +	local for_each_name=3D$1
> +	local for_each_dep=3D$2
> +	local name=3D$3
> +	local head_deps=3D$4 || :
> +	local deps_src
> +	local head=3D"$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-b=
ases\)/##')" || :
> +
> +	branchq=3D"$(mktemp -t tg-fan-in.XXXXXX)"
> +	allbranches=3D"$(mktemp -t -d tg-fan-in-all.XXXXXX)"
> +	trap "rm -rf \"$branchq\" \"$allbranches\"" 0
> +
> +	echo "$name" > "$branchq"
> +
> +	while [ -s "$branchq" ]; do
> +		# dequeue
> +		{
> +			read name
> +			cat > "$branchq.headless"
> +		} < "$branchq"
> +		mv -f "$branchq.headless" "$branchq"
> +
> +		[ ! -d "$allbranches/$name" ] ||
> +			continue;
> +		mkdir -p "$allbranches/$name"
> +
> +		# eval branch
> +		eval "$for_each_name \"$name\""
> +
> +		old_IFS=3D"$IFS"
> +		IFS=3D""
> +		git for-each-ref --format=3D'%(refname)' refs/top-bases |
> +			while read ref; do
> +				parent=3D"${ref#refs/top-bases/}"
> +
> +				deps_src=3D$parent
> +				# select branch/index/worktree for HEAD branch
> +				[ "x$parent" =3D "x$head" -a -n "$head_deps" ] &&
> +					deps_src=3D$head_deps
> +				cat_file "$deps_src:.topdeps" | fgrep -qx "$name" ||
> +					continue
> +
> +				# eval dep
> +				eval "$for_each_dep \"$parent\" \"$name\""
> +
> +				echo "$parent" >> "$branchq"
> +			done
> +		IFS=3D"$old_IFS"
> +
> +	done
> +}
> +
> +# prints the fan-in as a dot graph with edges
> +graph_fan_in()
> +{
> +	printf "digraph G {\n"
> +
> +	traverse_fan_in : _graph_dep_edge "$1" $2
> +
> +	printf "}\n"
> +}
> +
> +# prints the fan-in as name per line
> +list_fan_in()
> +{
> +	traverse_fan_in echo : "$1" $2
> +}
> +
>  ## Startup
> =20
>  [ -d "@cmddir@" ] ||
> --=20
> tg: (ff59ac7..) bw/fan-in-out (depends on: master)
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
