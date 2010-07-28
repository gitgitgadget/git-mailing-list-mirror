From: =?UTF-8?q?Tor=20Arne=20Vestb=C3=B8?= <tor.arne.vestbo@nokia.com>
Subject: [PATCH] require_work_tree: Look for top-level instead of is-inside-work-tree
Date: Wed, 28 Jul 2010 18:47:04 +0200
Message-ID: <1280335624-90132-1-git-send-email-tor.arne.vestbo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch,
	=?UTF-8?q?Tor=20Arne=20Vestb=C3=B8?= <tor.arne.vestbo@nokia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 18:47:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe9nL-00038o-4o
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 18:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608Ab0G1Qrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 12:47:46 -0400
Received: from smtp.nokia.com ([192.100.122.233]:32813 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab0G1Qrp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 12:47:45 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o6SGlGao008783;
	Wed, 28 Jul 2010 19:47:39 +0300
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by vaebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 28 Jul 2010 19:47:34 +0300
Received: from mgw-da02.ext.nokia.com ([147.243.128.26]) by esebh102.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 28 Jul 2010 19:47:33 +0300
Received: from whopper.europe.nokia.com (olwst90128.europe.nokia.com [172.24.90.128])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o6SGlS7B020871;
	Wed, 28 Jul 2010 19:47:29 +0300
X-Mailer: git-send-email 1.7.2.19.g48995
X-OriginalArrivalTime: 28 Jul 2010 16:47:33.0684 (UTC) FILETIME=[938E1F40:01CB2E74]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152101>

The documentation describes require_work_tree as guarding against
bare repositories, and that's also the way it's used from porcelain
such as git-rebase. When implemented using --is-inside-work-tree
the samantics change, causing git-rebase to fail if run from outside
GIT_WORK_TREE, even if GIT_WORK_TREE is valid.

Signed-off-by: Tor Arne Vestb=C3=B8 <tor.arne.vestbo@nokia.com>
---
 git-sh-setup.sh     |    2 +-
 t/t1501-worktree.sh |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6131670..f8e4428 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -141,7 +141,7 @@ cd_to_toplevel () {
 }
=20
 require_work_tree () {
-	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" =3D true ||
+	test -n "$(git rev-parse --show-toplevel 2>/dev/null)" ||
 	die "fatal: $0 cannot be used without a working tree."
 }
=20
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index bd8b607..45b09e7 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -114,6 +114,15 @@ test_expect_success 'repo finds its work tree from=
 work tree, too' '
 	 test sub/dir/tracked =3D "$(git ls-files)")
 '
=20
+test_expect_success 'require_work_tree finds work tree' '
+	(cd repo.git/work &&
+	. "$(git --exec-path)"/git-sh-setup &&
+	cd .. &&
+	require_work_tree &&
+	cd .. &&
+	require_work_tree)
+'
+
 test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE'=
 '
 	(cd repo.git/work/sub/dir &&
 	GIT_DIR=3D../../.. GIT_WORK_TREE=3D../.. GIT_PAGER=3D \
--=20
1.7.2.19.g48995
