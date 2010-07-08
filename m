From: Pierre Habouzit <madcoder@madism.org>
Subject: fixing workdirs
Date: Thu, 8 Jul 2010 13:08:42 +0200
Message-ID: <20100708110842.GC12789@madism.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
Content-Transfer-Encoding: 8bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 13:08:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWoyM-0002yl-Bv
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 13:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab0GHLIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 07:08:45 -0400
Received: from pan.madism.org ([88.191.52.104]:44839 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754323Ab0GHLIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 07:08:44 -0400
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 0947F4EFF0
	for <git@vger.kernel.org>; Thu,  8 Jul 2010 13:08:44 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D03122B0B86; Thu,  8 Jul 2010 13:08:42 +0200 (CEST)
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150559>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

At work we (ab-)use workdirs a lot, though, workdirs aren't for
everybody, and as our company grows, not everybody uses them sanely.

The two problems (that are well known to this list, and is the reason
why git new-workdir is in contrib afaict) with workdirs are:

  - the HEAD reflogs aren't shared, which means that pruning a working
    directory may trash accessible stuff from the reflog of another one.

  - if two workdirs are on the same branch at the same time, really,
    really, *REALLY* bad things may happen if one isn't aware of that
    fact.

I'm intending to adress those issues, though I would like to know how it
would be received. My current plan is this one. Have a git workdir
command, with a few subcommands (create, move, rename, ...), that
addresses both of the previous issues.

for the first one, the fix is simple: workdirs have now a name, and
their HEAD reflog lives in the "master" git repository reflog namespace
under logs/workdir/$workdir_name/HEAD. The workdir HEAD reflog is then a
symlink to the masters.

In this way, all workdirs see all the reflogs of every single workdir,
and pruning is safe again.


For the second one, when a workdir is created, a [workdir "foo"] section
is added to the master directory, with a path configuration variable
pointing to the ... path of the working directory. My plan would be to
teach git checkout to lean about that, and when there are workdirs
set up, git checkout would check that no other workdir is currently "on
the same branch", and would refuse to checkout to a branch that is
already checkouted elsewhere.


The current state of my git-workdir.sh is attached, though before I
start diving into the checkout builtin, I wanted to be sure that's the
way to go, and if there isn't any other issue I could have missed, plus
if this work has any chance to enter git.git :)
-- 
·O·  Pierre Habouzit
··O                                                madcoder@debian.org
OOO                                                http://www.madism.org

--Yylu36WmvOXNoKYn
Content-Type: application/x-sh
Content-Disposition: inline; filename="git-workdir.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A#=0A# Copyright (c) 2010 Pierre Habouzit <madcoder@debian.org>=
=0A=0ANONGIT_OK=3DYes=0AOPTIONS_KEEPDASHDASH=3D=0AOPTIONS_SPEC=3D"\=0Agit w=
orkdir create <name> <repository> [-b] <branch> [<start-point>]=0Agit workd=
ir rename <name>=0A--=0A"=0A=0A. git-sh-setup=0A=0Aget_master_dir() {=0A	d=
=3D"$(readlink "$1"/logs/HEAD)"=0A	echo ${d%/logs/workdir/*/HEAD}=0A}=0A=0A=
get_wd_name() {=0A	d=3D"$(readlink "$1"/logs/HEAD)"=0A	d=3D"${d%/HEAD}"=0A	=
echo "${d#*/logs/workdir/}"=0A}=0A=0Aworkdir_create() {=0A	test $# -ge 3 ||=
 usage=0A=0A	name=3D"$1"; shift=0A	orig_git=3D"$1"; shift=0A	new_workdir=3D=
"$(pwd)"=0A=0A	# want to make sure that what is pointed to has a .git direc=
tory ...=0A	git_dir=3D$(cd "$orig_git" 2>/dev/null &&=0A	  git rev-parse --=
git-dir 2>/dev/null) ||=0A	  die "Not a git repository: \"$orig_git\""=0A=
=0A	if test -e "$git_dir/logs/workdir/$name/"; then=0A		die "workdir \"$nam=
e\" already exists"=0A	fi=0A=0A	# be sure '.' is empty=0A	if test "$(ls -1a=
 | wc -l)" !=3D 2; then=0A		die "\"$new_workdir\" isn't empty"=0A	fi=0A=0A	=
case "$git_dir" in=0A		.git) git_dir=3D"$orig_git/.git";;=0A		.)    git_dir=
=3D"$orig_git";;=0A	esac=0A=0A	# don't link to a configured bare repository=
=0A	if test "$(git --git-dir=3D"$git_dir" config --bool --get core.bare)" =
=3D "true"=0A	then=0A		die "\"$git_dir\" has core.bare set to true," \=0A		=
	" remove from \"$git_dir/config\" to use $0"=0A	fi=0A=0A	# don't link to a=
 workdir=0A	if test -L "$git_dir/config"; then=0A		die "\"$orig_git\" is a =
working directory only, please specify" \=0A			"a complete repository."=0A	=
fi=0A=0A	# make sure the the links use full paths=0A	git_dir=3D$(cd "$git_d=
ir"; pwd)=0A	cd "$new_workdir"=0A=0A	trap 'rm -rf *; rm -rf .* 2>/dev/null'=
 0 1 2 3 15=0A=0A	# create the workdir=0A	mkdir -p "$git_dir/logs/workdir/$=
name/"=0A	touch "$git_dir/logs/workdir/$name/HEAD"=0A	mkdir -p "$new_workdi=
r/.git" || die "unable to create \"$new_workdir\"!"=0A=0A	# create the link=
s to the original repo.  explictly exclude index, HEAD and=0A	# logs/HEAD f=
rom the list since they are purely related to the current working=0A	# dire=
ctory, and should not be shared.=0A	for x in config refs logs/refs objects =
info hooks packed-refs rr-cache svn=0A	do=0A		case $x in=0A		*/*)=0A			mkdi=
r -p "$(dirname "$new_workdir/.git/$x")"=0A			;;=0A		esac=0A		ln -s "$git_d=
ir/$x" "$new_workdir/.git/$x"=0A	done=0A	ln -s "$git_dir/logs/workdir/$name=
/HEAD" "$new_workdir/.git/logs/HEAD"=0A=0A	# now checkout what the user ask=
ed for=0A	cp "$git_dir/HEAD" .git/HEAD=0A	git checkout -f "$@"=0A	git --git=
-dir=3D"$git_dir" config "workdir.$name.path" "$new_workdir"=0A	trap - 0=0A=
}=0A=0Aworkdir_rename() {=0A	test $# =3D 1 || usage=0A=0A	git_dir=3D"$(git =
rev-parse --git-dir)" || exit=0A	test -L "$git_dir/config" || die "the repo=
sitory isn't a working directory"=0A	cd "$git_dir"=0A=0A	master_dir=3D"$(ge=
t_master_dir .)"=0A	oldname=3D"$(get_wd_name .)"=0A	name=3D"$1"=0A=0A	if te=
st -e "$master_dir/logs/workdir/$name/HEAD"; then=0A		die "\"$name\" workdi=
r already exists"=0A	fi=0A	mv "$master_dir/logs/workdir/$oldname" "$master_=
dir/logs/workdir/$name" || \=0A		die "unable to rename workdir from $oldnam=
e to $name"=0A	ln -sf "$master_dir/logs/workdir/$name/HEAD" logs/HEAD=0A	gi=
t --git-dir=3D"$master_dir" config --rename-section "workdir.$oldname" "wor=
kdir.$name"=0A}=0A=0Aworkdir_info() {=0A	git_dir=3D"$(git rev-parse --git-d=
ir)" || exit=0A	test -L "$git_dir/config" || die "the repository isn't a wo=
rking directory"=0A=0A	cd "$git_dir"=0A	echo "workdir \"$(get_wd_name .)\" =
-> \"$(get_master_dir .)\""=0A}=0A=0Awhile test $# !=3D 0=0Ado=0A	case "$1"=
 in=0A		--) shift; break;;=0A		*)  usage;;=0A	esac=0Adone=0A=0Acase "$1" in=
=0A	create)=0A		shift=0A		workdir_create "$@"=0A		;;=0A	rename)=0A		shift=
=0A		workdir_rename "$@"=0A		;;=0A	"")=0A		workdir_info=0A		;;=0A	*)=0A		us=
age=0A		;;=0Aesac=0A
--Yylu36WmvOXNoKYn--
