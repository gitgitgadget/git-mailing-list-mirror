From: Remi Vanicat <vanicat@debian.org>
Subject: [PATCH] Make GIT_INDEX_FILE apply to git-commit
Date: Mon, 12 Nov 2007 19:45:12 +0100
Message-ID: <878x53i9qf.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 20:55:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrfNv-0003I0-EY
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 20:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbXKLTzf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 14:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbXKLTzf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 14:55:35 -0500
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:32833 "EHLO smTp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751029AbXKLTze convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 14:55:34 -0500
X-Greylist: delayed 3796 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2007 14:55:34 EST
Received: from vanicat.homelinux.org ([77.193.67.174])
 by sp604003mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-5.05 (built Feb 16 2006))
 with ESMTP id <0JRE006QJPFD8410@sp604003mt.gpm.neuf.ld> for
 git@vger.kernel.org; Mon, 12 Nov 2007 19:45:14 +0100 (CET)
Received: from moi by vanicat.homelinux.org with local (Exim 4.68)
	(envelope-from <remi.vanicat@laposte.net>)
	id 1IreHY-0005Dn-Gz	for git@vger.kernel.org; Mon, 12 Nov 2007 19:45:12 +0100
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: remi.vanicat@laposte.net
X-SA-Exim-Scanned: No (on vanicat.homelinux.org); SAEximRunCond expanded to
 false
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64696>


Currently, when committing, git-commit ignore the value of
GIT_INDEX_FILE, and always use $GIT_DIR/index. This patch
fix it.

Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
---
 git-commit.sh     |    2 +-
 t/t7500-commit.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index fcb8443..7022e6c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -26,7 +26,7 @@ refuse_partial () {
 }
=20
 TMP_INDEX=3D
-THIS_INDEX=3D"$GIT_DIR/index"
+THIS_INDEX=3D"${GIT_INDEX_FILE-$GIT_DIR/index}"
 NEXT_INDEX=3D"$GIT_DIR/next-index$$"
 rm -f "$NEXT_INDEX"
 save_index () {
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index abbf54b..2aa6faf 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -93,4 +93,36 @@ test_expect_success 'commit message from file should=
 override template' '
        commit_msg_is "standard input msg"
 '
=20
+test_expect_success 'using alternate GIT_INDEX_FILE (1)' '
+
+       cp .git/index saved-index &&
+       (
+               echo some new content >file &&
+               GIT_INDEX_FILE=3D.git/another_index &&
+               export GIT_INDEX_FILE &&
+               git add file &&
+               git commit -m "commit using another index" &&
+               git diff-index --exit-code HEAD &&
+               git diff-files --exit-code
+       ) &&
+       cmp .git/index saved-index >/dev/null
+
+'
+
+test_expect_success 'using alternate GIT_INDEX_FILE (2)' '
+
+       cp .git/index saved-index &&
+       (
+               rm -f .git/no-such-index &&
+               GIT_INDEX_FILE=3D.git/no-such-index &&
+               export GIT_INDEX_FILE &&
+               git commit -m "commit using nonexistent index" &&
+               test -z "$(git ls-files)" &&
+               test -z "$(git ls-tree HEAD)"
+
+       ) &&
+       cmp .git/index saved-index >/dev/null
+
+'
+
 test_done
--=20
1.5.3.5
