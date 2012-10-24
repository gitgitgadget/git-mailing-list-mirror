From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Wed, 24 Oct 2012 21:15:32 +0200
Message-ID: <50883E54.4080507@web.de>
References: <20121023204437.GE28592@odin.tremily.us> <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Nahor <nahor.j+gmane@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Oct 24 21:15:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR6Qd-0006xw-LS
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 21:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302Ab2JXTPf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Oct 2012 15:15:35 -0400
Received: from mout.web.de ([212.227.17.11]:57770 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965086Ab2JXTPe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 15:15:34 -0400
Received: from [192.168.178.41] ([91.3.185.6]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LqDD6-1SwQR30CMC-00dbTu; Wed, 24 Oct 2012 21:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
X-Provags-ID: V02:K0:V98NxFQlM6IBgqiee1hd1dQR6ef4G3XGl4llWaKPDqj
 VVSMu34zLdHlkFuG5zfmy2L1Nn4amOdA/mXTNLFhgT/qMZEu/7
 ConG7tqxmcle6YOeCSpGAxOMzVA6k0HavhXSfAkZDCOXRI3f0M
 VCjduvcdhEwVy2WQuSnjeRxz5soHA5FESH+6fkOzszcz/+/m0J
 2VQY0wUGrYEaMa1nDi5dA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208321>

I still fail to see what adding that functionality to the submodule
command buys us (unless we also add code which really uses the branch
setting). What's wrong with doing a simple:

   git config -f .gitmodules submodule.<path>.branch <record_branch>

on the command line when you want to use the branch setting for your
own purposes? You could easily wrap that into a helper script, no?

Am 23.10.2012 23:57, schrieb W. Trevor King:
> From: "W. Trevor King" <wking@tremily.us>
>=20
> This option allows you to record a submodule.<name>.branch option in
> .gitmodules.  Git does not currently use this configuration option fo=
r
> anything, but users have used it for several things, so it makes sens=
e
> to add some syntactic sugar for initializing the value.
>=20
> Current consumers:
>=20
> =C3=86var uses this setting to designate the upstream branch for pull=
ing
> submodule updates:
>=20
>   $ git submodule foreach 'git checkout $(git config --file $toplevel=
/.gitmodules submodule.$name.branch) && git pull'
>=20
> as he describes in
>=20
>   commit f030c96d8643fa0a1a9b2bd9c2f36a77721fb61f
>   Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>   Date:   Fri May 21 16:10:10 2010 +0000
>=20
>     git-submodule foreach: Add $toplevel variable
>=20
> Gerrit uses this setting to
>=20
>   =E2=80=9Cindicate the branch of a submodule project that when updat=
ed will
>   trigger automatic update of its registered gitlink.=E2=80=9D [1]
>=20
> I'm not clear on what that means, but they accept special values like
> '.', so their usage is not compatible with =C3=86var's proposal.
>=20
> By remaining agnostic on the variable usage, this patch makes
> submodule setup more convenient for all parties.
>=20
> [1] https://gerrit.googlesource.com/gerrit/+/master/Documentation/use=
r-submodules.txt
>=20
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/git-submodule.txt | 11 ++++++++++-
>  git-submodule.sh                | 19 ++++++++++++++++++-
>  t/t7400-submodule-basic.sh      | 25 +++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-subm=
odule.txt
> index b4683bb..f9c74d6 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodu=
les
>  SYNOPSIS
>  --------
>  [verse]
> -'git submodule' [--quiet] add [-b branch] [-f|--force]
> +'git submodule' [--quiet] add [-b branch] [--record[=3D<branch>]] [-=
f|--force]
>  	      [--reference <repository>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<pat=
h>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> @@ -209,6 +209,15 @@ OPTIONS
>  --branch::
>  	Branch of repository to add as submodule.
> =20
> +-r::
> +--record::
> +  Record a branch name used as `submodule.<path>.branch` in
> +  `.gitmodules` for future reference.  If you do not list an explici=
t
> +  name here, the name given with `--branch` will be recorded.  If th=
at
> +  is not set either, `HEAD` will be recorded.  Because the branch na=
me
> +  is optional, you must use the equal-sign form (`-r=3D<branch>`), n=
ot
> +  `-r <branch>`.
> +
>  -f::
>  --force::
>  	This option is only valid for add and update commands.
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ab6b110..bc33112 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -5,7 +5,7 @@
>  # Copyright (c) 2007 Lars Hjemli
> =20
>  dashless=3D$(basename "$0" | sed -e 's/-/ /')
> -USAGE=3D"[--quiet] add [-b branch] [-f|--force] [--reference <reposi=
tory>] [--] <repository> [<path>]
> +USAGE=3D"[--quiet] add [-b branch] [--record[=3D<branch>]] [-f|--for=
ce] [--reference <repository>] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<pa=
th>...]
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--for=
ce] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] =
[<path>...]
> @@ -20,6 +20,8 @@ require_work_tree
> =20
>  command=3D
>  branch=3D
> +record_branch=3D
> +record_branch_empty=3D
>  force=3D
>  reference=3D
>  cached=3D
> @@ -257,6 +259,12 @@ cmd_add()
>  			branch=3D$2
>  			shift
>  			;;
> +		-r | --record)
> +			record_branch_empty=3Dtrue
> +			;;
> +		-r=3D* | --record=3D*)
> +			record_branch=3D"${1#*=3D}"
> +			;;
>  		-f | --force)
>  			force=3D$1
>  			;;
> @@ -328,6 +336,11 @@ cmd_add()
>  	git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
>  	die "$(eval_gettext "'\$sm_path' already exists in the index")"
> =20
> +	if test -z "$record_branch" && test "$record_branch_empty" =3D "tru=
e"
> +	then
> +		record_branch=3D"${branch:=3DHEAD}"
> +	fi
> +
>  	if test -z "$force" && ! git add --dry-run --ignore-missing "$sm_pa=
th" > /dev/null 2>&1
>  	then
>  		eval_gettextln "The following path is ignored by one of your .giti=
gnore files:
> @@ -366,6 +379,10 @@ Use -f if you really want to add it." >&2
> =20
>  	git config -f .gitmodules submodule."$sm_path".path "$sm_path" &&
>  	git config -f .gitmodules submodule."$sm_path".url "$repo" &&
> +	if test -n "$branch"
> +	then
> +		git config -f .gitmodules submodule."$sm_path".branch "$record_bra=
nch"
> +	fi &&
>  	git add --force .gitmodules ||
>  	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
>  }
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 5397037..88ae74c 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -133,6 +133,7 @@ test_expect_success 'submodule add --branch' '
>  	(
>  		cd addtest &&
>  		git submodule add -b initial "$submodurl" submod-branch &&
> +		test -z "$(git config -f .gitmodules submodule.submod-branch.branc=
h)" &&
>  		git submodule init
>  	) &&
> =20
> @@ -211,6 +212,30 @@ test_expect_success 'submodule add with ./, /.. =
and // in path' '
>  	test_cmp empty untracked
>  '
> =20
> +test_expect_success 'submodule add --record' '
> +	(
> +		cd addtest &&
> +		git submodule add -r "$submodurl" submod-record-head &&
> +		test "$(git config -f .gitmodules submodule.submod-record-head.bra=
nch)" =3D "HEAD"
> +	)
> +'
> +
> +test_expect_success 'submodule add --record --branch' '
> +	(
> +		cd addtest &&
> +		git submodule add -r -b initial "$submodurl" submod-auto-record &&
> +		test "$(git config -f .gitmodules submodule.submod-auto-record.bra=
nch)" =3D "initial"
> +	)
> +'
> +
> +test_expect_success 'submodule add --record=3D<name> --branch' '
> +	(
> +		cd addtest &&
> +		git submodule add -r=3Dfinal -b initial "$submodurl" submod-record=
 &&
> +		test "$(git config -f .gitmodules submodule.submod-record.branch)"=
 =3D "final"
> +	)
> +'
> +
>  test_expect_success 'setup - add an example entry to .gitmodules' '
>  	GIT_CONFIG=3D.gitmodules \
>  	git config submodule.example.url git://example.com/init.git
>=20
