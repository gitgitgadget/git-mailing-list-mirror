From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Tue, 23 Oct 2012 17:57:59 -0400
Message-ID: <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
References: <20121023204437.GE28592@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nahor <nahor.j+gmane@gmail.com>, Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 23:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQmVh-00014G-NR
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 23:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab2JWV73 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2012 17:59:29 -0400
Received: from vms173013pub.verizon.net ([206.46.173.13]:11249 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab2JWV72 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 17:59:28 -0400
Received: from odin.tremily.us ([unknown] [72.76.145.253])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCD00BBQ930B4A0@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 23 Oct 2012 16:59:26 -0500 (CDT)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id 97F3567EB8A; Tue,
 23 Oct 2012 17:59:24 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.1.g61a31f6.dirty
In-reply-to: <20121023204437.GE28592@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208258>

=46rom: "W. Trevor King" <wking@tremily.us>

This option allows you to record a submodule.<name>.branch option in
=2Egitmodules.  Git does not currently use this configuration option fo=
r
anything, but users have used it for several things, so it makes sense
to add some syntactic sugar for initializing the value.

Current consumers:

=C3=86var uses this setting to designate the upstream branch for pullin=
g
submodule updates:

  $ git submodule foreach 'git checkout $(git config --file $toplevel/.=
gitmodules submodule.$name.branch) && git pull'

as he describes in

  commit f030c96d8643fa0a1a9b2bd9c2f36a77721fb61f
  Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
  Date:   Fri May 21 16:10:10 2010 +0000

    git-submodule foreach: Add $toplevel variable

Gerrit uses this setting to

  =E2=80=9Cindicate the branch of a submodule project that when updated=
 will
  trigger automatic update of its registered gitlink.=E2=80=9D [1]

I'm not clear on what that means, but they accept special values like
'.', so their usage is not compatible with =C3=86var's proposal.

By remaining agnostic on the variable usage, this patch makes
submodule setup more convenient for all parties.

[1] https://gerrit.googlesource.com/gerrit/+/master/Documentation/user-=
submodules.txt

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 11 ++++++++++-
 git-submodule.sh                | 19 ++++++++++++++++++-
 t/t7400-submodule-basic.sh      | 25 +++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index b4683bb..f9c74d6 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodule=
s
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b branch] [-f|--force]
+'git submodule' [--quiet] add [-b branch] [--record[=3D<branch>]] [-f|=
--force]
 	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>=
=2E..]
 'git submodule' [--quiet] init [--] [<path>...]
@@ -209,6 +209,15 @@ OPTIONS
 --branch::
 	Branch of repository to add as submodule.
=20
+-r::
+--record::
+  Record a branch name used as `submodule.<path>.branch` in
+  `.gitmodules` for future reference.  If you do not list an explicit
+  name here, the name given with `--branch` will be recorded.  If that
+  is not set either, `HEAD` will be recorded.  Because the branch name
+  is optional, you must use the equal-sign form (`-r=3D<branch>`), not
+  `-r <branch>`.
+
 -f::
 --force::
 	This option is only valid for add and update commands.
diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..bc33112 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
=20
 dashless=3D$(basename "$0" | sed -e 's/-/ /')
-USAGE=3D"[--quiet] add [-b branch] [-f|--force] [--reference <reposito=
ry>] [--] <repository> [<path>]
+USAGE=3D"[--quiet] add [-b branch] [--record[=3D<branch>]] [-f|--force=
] [--reference <repository>] [--] <repository> [<path>]
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
+record_branch=3D
+record_branch_empty=3D
 force=3D
 reference=3D
 cached=3D
@@ -257,6 +259,12 @@ cmd_add()
 			branch=3D$2
 			shift
 			;;
+		-r | --record)
+			record_branch_empty=3Dtrue
+			;;
+		-r=3D* | --record=3D*)
+			record_branch=3D"${1#*=3D}"
+			;;
 		-f | --force)
 			force=3D$1
 			;;
@@ -328,6 +336,11 @@ cmd_add()
 	git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
 	die "$(eval_gettext "'\$sm_path' already exists in the index")"
=20
+	if test -z "$record_branch" && test "$record_branch_empty" =3D "true"
+	then
+		record_branch=3D"${branch:=3DHEAD}"
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
+	if test -n "$branch"
+	then
+		git config -f .gitmodules submodule."$sm_path".branch "$record_branc=
h"
+	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5397037..88ae74c 100755
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
+test_expect_success 'submodule add --record' '
+	(
+		cd addtest &&
+		git submodule add -r "$submodurl" submod-record-head &&
+		test "$(git config -f .gitmodules submodule.submod-record-head.branc=
h)" =3D "HEAD"
+	)
+'
+
+test_expect_success 'submodule add --record --branch' '
+	(
+		cd addtest &&
+		git submodule add -r -b initial "$submodurl" submod-auto-record &&
+		test "$(git config -f .gitmodules submodule.submod-auto-record.branc=
h)" =3D "initial"
+	)
+'
+
+test_expect_success 'submodule add --record=3D<name> --branch' '
+	(
+		cd addtest &&
+		git submodule add -r=3Dfinal -b initial "$submodurl" submod-record &=
&
+		test "$(git config -f .gitmodules submodule.submod-record.branch)" =3D=
 "final"
+	)
+'
+
 test_expect_success 'setup - add an example entry to .gitmodules' '
 	GIT_CONFIG=3D.gitmodules \
 	git config submodule.example.url git://example.com/init.git
--=20
1.8.0.1.g61a31f6.dirty
