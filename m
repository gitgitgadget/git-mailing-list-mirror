From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 1/4] git-submodule add: Add --local-branch option
Date: Mon, 26 Nov 2012 16:00:16 -0500
Message-ID: <15e0581e0cb0bb42bf84e8e195597e46d3457a93.1353962698.git.wking@tremily.us>
References: <20121123175402.GH2806@odin.tremily.us>
 <cover.1353962698.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:01:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5o2-0004rT-RJ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab2KZVBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2012 16:01:14 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:24487 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab2KZVBN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 16:01:13 -0500
Received: from odin.tremily.us ([unknown] [72.68.108.240])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME400ABG51QBXD0@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 26 Nov 2012 15:01:03 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id 076096DEFC8; Mon,
 26 Nov 2012 16:01:02 -0500 (EST)
X-Mailer: git-send-email 1.8.0.3.g95edff1.dirty
In-reply-to: <cover.1353962698.git.wking@tremily.us>
In-reply-to: <cover.1353962698.git.wking@tremily.us>
References: <cover.1353962698.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210490>

=46rom: "W. Trevor King" <wking@tremily.us>

This option allows you to record a submodule.<name>.branch option in
=2Egitmodules.  Git does not currently use this configuration option fo=
r
anything, but users have used it for several things, so it makes sense
to add some syntactic sugar for initializing the value.

Current consumers:

=C3=86var uses this setting to designate the local branch to checkout w=
hen
pulling submodule updates:

  $ git submodule foreach 'git checkout $(git config --file $toplevel/.=
gitmodules submodule.$name.branch) && git pull'

as he describes in

  commit f030c96d8643fa0a1a9b2bd9c2f36a77721fb61f
  Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
  Date:   Fri May 21 16:10:10 2010 +0000

    git-submodule foreach: Add $toplevel variable

Gerrit uses the same interpretation for the setting, but because
Gerrit has direct access to the subproject repositories, it updates
the superproject repositories automatically when a subproject changes.
Gerrit also accepts the special value '.', which it expands into the
superproject's branch name.

Earlier version of this patch remained agnostic on the variable usage,
but this was deemed potentially confusing.  Future patches in this
series will extend the submodule command to use the stored value
internally.

[1] https://gerrit.googlesource.com/gerrit/+/master/Documentation/user-=
submodules.txt

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 12 ++++++++++--
 Documentation/gitmodules.txt    |  5 +++++
 git-submodule.sh                | 19 ++++++++++++++++++-
 t/t7400-submodule-basic.sh      | 25 +++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index b4683bb..d0b4436 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,8 +9,8 @@ git-submodule - Initialize, update or inspect submodule=
s
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b branch] [-f|--force]
-	      [--reference <repository>] [--] <repository> [<path>]
+'git submodule' [--quiet] add [-b branch] [--local-branch[=3D<branch>]=
]
+	      [-f|--force] [--reference <repository>] [--] <repository> [<pat=
h>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>=
=2E..]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
@@ -209,6 +209,14 @@ OPTIONS
 --branch::
 	Branch of repository to add as submodule.
=20
+--local-branch::
+	Record a branch name used as `submodule.<path>.branch` in
+	`.gitmodules` for future reference.  If you do not list an explicit
+	name here, the name given with `--branch` will be recorded.  If that
+	is not set either, `HEAD` will be recorded.  Because the branch name
+	is optional, you must use the equal-sign form
+	(`--local-branch=3D<branch>`), not `--local-branch <branch>`.
+
 -f::
 --force::
 	This option is only valid for add and update commands.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.tx=
t
index 4effd78..840ccfe 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -47,6 +47,11 @@ submodule.<name>.update::
 	This config option is overridden if 'git submodule update' is given
 	the '--merge', '--rebase' or '--checkout' options.
=20
+submodule.<name>.branch::
+	A local branch name for the submodule (to avoid headless operation).
+	Set with the "--local-branch" option to "git submodule add", or
+	directly using "git config".
+
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
 	submodule. If this option is also present in the submodules entry in
diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..6eed008 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
=20
 dashless=3D$(basename "$0" | sed -e 's/-/ /')
-USAGE=3D"[--quiet] add [-b branch] [-f|--force] [--reference <reposito=
ry>] [--] <repository> [<path>]
+USAGE=3D"[--quiet] add [-b branch] [--local-branch[=3D<branch>]] [-f|-=
-force] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path=
>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force=
] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<=
path>...]
@@ -20,6 +20,8 @@ require_work_tree
=20
 command=3D
 branch=3D
+local_branch=3D
+local_branch_empty=3D
 force=3D
 reference=3D
 cached=3D
@@ -257,6 +259,12 @@ cmd_add()
 			branch=3D$2
 			shift
 			;;
+		--local-branch)
+			local_branch_empty=3Dtrue
+			;;
+		--local-branch=3D*)
+			local_branch=3D"${1#*=3D}"
+			;;
 		-f | --force)
 			force=3D$1
 			;;
@@ -328,6 +336,11 @@ cmd_add()
 	git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
 	die "$(eval_gettext "'\$sm_path' already exists in the index")"
=20
+	if test -z "$local_branch" && test "$local_branch_empty" =3D "true"
+	then
+		local_branch=3D"${branch:=3DHEAD}"
+	fi
+
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$sm_path=
" > /dev/null 2>&1
 	then
 		eval_gettextln "The following path is ignored by one of your .gitign=
ore files:
@@ -366,6 +379,10 @@ Use -f if you really want to add it." >&2
=20
 	git config -f .gitmodules submodule."$sm_path".path "$sm_path" &&
 	git config -f .gitmodules submodule."$sm_path".url "$repo" &&
+	if test -n "$local_branch"
+	then
+		git config -f .gitmodules submodule."$sm_path".branch "$local_branch=
"
+	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5397037..fc08647 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -133,6 +133,7 @@ test_expect_success 'submodule add --branch' '
 	(
 		cd addtest &&
 		git submodule add -b initial "$submodurl" submod-branch &&
+		test -z "$(git config -f .gitmodules submodule.submod-branch.branch)=
" &&
 		git submodule init
 	) &&
=20
@@ -211,6 +212,30 @@ test_expect_success 'submodule add with ./, /.. an=
d // in path' '
 	test_cmp empty untracked
 '
=20
+test_expect_success 'submodule add --local-branch' '
+	(
+		cd addtest &&
+		git submodule add --local-branch "$submodurl" submod-follow-head &&
+		test "$(git config -f .gitmodules submodule.submod-follow-head.branc=
h)" =3D "HEAD"
+	)
+'
+
+test_expect_success 'submodule add --local-branch --branch' '
+	(
+		cd addtest &&
+		git submodule add --local-branch -b initial "$submodurl" submod-auto=
-follow &&
+		test "$(git config -f .gitmodules submodule.submod-auto-follow.branc=
h)" =3D "initial"
+	)
+'
+
+test_expect_success 'submodule add --local-branch=3D<name> --branch' '
+	(
+		cd addtest &&
+		git submodule add --local-branch=3Dfinal -b initial "$submodurl" sub=
mod-follow &&
+		test "$(git config -f .gitmodules submodule.submod-follow.branch)" =3D=
 "final"
+	)
+'
+
 test_expect_success 'setup - add an example entry to .gitmodules' '
 	GIT_CONFIG=3D.gitmodules \
 	git config submodule.example.url git://example.com/init.git
--=20
1.8.0.3.g95edff1.dirty
