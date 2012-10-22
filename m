From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Mon, 22 Oct 2012 12:34:43 -0400
Message-ID: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 19:36:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQLvP-0004Pa-Ki
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 19:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab2JVRgQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2012 13:36:16 -0400
Received: from vms173013pub.verizon.net ([206.46.173.13]:39150 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab2JVRgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 13:36:15 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2012 13:36:15 EDT
Received: from odin.tremily.us ([unknown] [72.68.93.242])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCA0072WZG50C80@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 22 Oct 2012 11:36:05 -0500 (CDT)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id DB8C867D7A6; Mon,
 22 Oct 2012 12:36:04 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.2.g09b91ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208199>

=46rom: "W. Trevor King" <wking@tremily.us>

This removes a configuration step if you're trying to setup =C3=86var's

  $ git submodule foreach 'git checkout $(git config --file $toplevel/.=
gitmodules submodule.$name.branch) && git pull'

workflow from

  commit f030c96d8643fa0a1a9b2bd9c2f36a77721fb61f
  Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
  Date:   Fri May 21 16:10:10 2010 +0000

    git-submodule foreach: Add $toplevel variable

If you're not using that workflow, I see no harm in recording the
branch used to determine the original submodule commit.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 3 ++-
 git-submodule.sh                | 4 ++++
 t/t7400-submodule-basic.sh      | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index b4683bb..b9f437f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -207,7 +207,8 @@ OPTIONS
=20
 -b::
 --branch::
-	Branch of repository to add as submodule.
+	Branch of repository to add as submodule.  The branch name is
+	recorded in .gitmodules for future reference.
=20
 -f::
 --force::
diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..fd15a54 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -366,6 +366,10 @@ Use -f if you really want to add it." >&2
=20
 	git config -f .gitmodules submodule."$sm_path".path "$sm_path" &&
 	git config -f .gitmodules submodule."$sm_path".url "$repo" &&
+	if test -n "$branch"
+	then
+		git config -f .gitmodules submodule."$sm_path".branch "$branch"
+	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5397037..5031e2a 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -133,6 +133,7 @@ test_expect_success 'submodule add --branch' '
 	(
 		cd addtest &&
 		git submodule add -b initial "$submodurl" submod-branch &&
+		test "$(git config -f .gitmodules submodule.submod-branch.branch)" =3D=
 initial &&
 		git submodule init
 	) &&
=20
--=20
1.8.0.2.g09b91ca
