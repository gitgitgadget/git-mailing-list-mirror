From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Thu, 08 Nov 2012 22:35:12 -0500
Message-ID: <fb2d915cf60160c200b84df88c6112c1c2d4eefd.1352431674.git.wking@tremily.us>
References: <cover.1352431674.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 04:42:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWfUI-0003WI-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 04:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492Ab2KIDmV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 22:42:21 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:56613 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757447Ab2KIDmU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 22:42:20 -0500
Received: from odin.tremily.us ([unknown] [72.68.90.158])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MD700GAFBMJDY20@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 08 Nov 2012 21:42:20 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id BBDEF68EDC4; Thu,
 08 Nov 2012 22:42:18 -0500 (EST)
X-Mailer: git-send-email 1.8.0.3.gc2eb43a
In-reply-to: <cover.1352431674.git.wking@tremily.us>
In-reply-to: <cover.1352431674.git.wking@tremily.us>
References: <20121029222759.GI20513@sigill.intra.peff.net>
 <cover.1352431674.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209200>

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

Gerrit uses the same interpretation for the setting, but because
Gerrit has direct access to the subproject repositories, it updates
the superproject repositories automatically when a subproject changes.
Gerrit also accepts the special value '.', which it expands into the
superproject's branch name.

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
index b4683bb..cbec363 100644
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
+	Record a branch name used as `submodule.<path>.branch` in
+	`.gitmodules` for future reference.  If you do not list an explicit
+	name here, the name given with `--branch` will be recorded.  If that
+	is not set either, `HEAD` will be recorded.  Because the branch name
+	is optional, you must use the equal-sign form (`-r=3D<branch>`), not
+	`-r <branch>`.
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
1.8.0.3.gc2eb43a
