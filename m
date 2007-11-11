From: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
Subject: [PATCH v3] Make GIT_INDEX_FILE apply to git-commit
Date: Sun, 11 Nov 2007 13:28:08 +0100
Message-ID: <87r6ixj7af.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:28:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrBvV-00050W-G2
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 13:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbXKKM2P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 07:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbXKKM2P
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 07:28:15 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:47872 "EHLO smtp.Neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751891AbXKKM2O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 07:28:14 -0500
Received: from vanicat.homelinux.org ([77.193.67.174])
 by sp604005mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-5.05 (built Feb 16 2006))
 with ESMTP id <0JRC00G3QDAXBC55@sp604005mt.gpm.neuf.ld> for
 git@vger.kernel.org; Sun, 11 Nov 2007 13:28:09 +0100 (CET)
Received: from moi by vanicat.homelinux.org with local (Exim 4.68)
	(envelope-from <remi.vanicat@laposte.net>)	id 1IrBv6-0007BH-Fg; Sun,
 11 Nov 2007 13:28:08 +0100
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: remi.vanicat@laposte.net
X-SA-Exim-Scanned: No (on vanicat.homelinux.org); SAEximRunCond expanded to
 false
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64449>

Currently, when committing, git-commit ignore the value of
GIT_INDEX_FILE, and always use $GIT_DIR/index. This patch
fix it.

Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
---
 git-commit.sh     |    2 +-
 t/t7500-commit.sh |   13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index fcb8443..6490045 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -26,7 +26,7 @@ refuse_partial () {
 }
=20
 TMP_INDEX=3D
-THIS_INDEX=3D"$GIT_DIR/index"
+THIS_INDEX=3D"${GIT_INDEX_FILE:-$GIT_DIR/index}"
 NEXT_INDEX=3D"$GIT_DIR/next-index$$"
 rm -f "$NEXT_INDEX"
 save_index () {
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index abbf54b..3e5abef 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -93,4 +93,17 @@ test_expect_success 'commit message from file should=
 override template' '
        commit_msg_is "standard input msg"
 '
=20
+test_expect_success 'using GIT_INDEX_FILE' '
+
+       echo "some new content" >file &&
+       GIT_INDEX_FILE=3D.git/another_index git add file &&
+       GIT_INDEX_FILE=3D.git/another_index \
+               git commit -m "commit using another index" &&
+       git reset HEAD &&
+       git diff HEAD -- file >current &&
+       touch empty-file &&
+       diff empty-file current
+
+'
+
 test_done
--=20
1.5.3.5
