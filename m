From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Add a test for git-commit being confused by relative GIT_DIR
Date: Mon, 13 Aug 2007 07:38:11 +0200
Organization: Organization?!?
Message-ID: <853ayo570c.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 13 07:38:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKSdA-000878-Or
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 07:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbXHMFiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 01:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbXHMFiQ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 01:38:16 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:42361 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752874AbXHMFiP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Aug 2007 01:38:15 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id AA0C44CCFE
	for <git@vger.kernel.org>; Mon, 13 Aug 2007 07:38:13 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 9C53D2DABC0
	for <git@vger.kernel.org>; Mon, 13 Aug 2007 07:38:13 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-003.pools.arcor-ip.net [84.61.55.3])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 7233E8C470
	for <git@vger.kernel.org>; Mon, 13 Aug 2007 07:38:13 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 54E281C3C79D; Mon, 13 Aug 2007 07:38:12 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3942/Mon Aug 13 06:21:54 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55743>


Signed-off-by: David Kastrup <dak@gnu.org>
---
 t/t2050-git-dir-relative.sh |   55 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100755 t/t2050-git-dir-relative.sh

diff --git a/t/t2050-git-dir-relative.sh b/t/t2050-git-dir-relative.sh
new file mode 100755
index 0000000..8b8e233
--- /dev/null
+++ b/t/t2050-git-dir-relative.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='check problems with relative GIT_DIR
+
+This test creates a working tree state with a file and subdir:
+
+  top (committed several times)
+  subdir (a subdirectory)
+
+It creates a commit-hook and tests it, then moves .git
+into the subdir while keeping the worktree location, 
+and tries commits from the top and the subdir, checking
+that the commit-hook still gets called.'
+
+. ./test-lib.sh
+
+COMMIT_FILE="$(pwd)/output"
+export COMMIT_FILE
+
+test_expect_success 'Setting up post-commit hook' '
+mkdir -p .git/hooks &&
+echo >.git/hooks/post-commit "#!/bin/sh
+touch \"\${COMMIT_FILE}\"
+echo Post commit hook was called." &&
+chmod +x .git/hooks/post-commit'
+
+test_expect_success 'post-commit hook used ordinarily' '
+echo initial >top &&
+git-add top
+git-commit -m initial &&
+test -r "${COMMIT_FILE}"
+'
+
+rm -rf "${COMMIT_FILE}"
+mkdir subdir
+mv .git subdir
+
+test_expect_success 'post-commit-hook created and used from top dir' '
+echo changed >top &&
+git --git-dir subdir/.git add top &&
+git --git-dir subdir/.git commit -m topcommit &&
+test -r "${COMMIT_FILE}"
+'
+
+rm -rf "${COMMIT_FILE}"
+
+test_expect_success 'post-commit-hook from sub dir' '
+echo changed again >top
+cd subdir &&
+git --git-dir .git --work-tree .. add ../top &&
+git --git-dir .git --work-tree .. commit -m subcommit &&
+test -r "${COMMIT_FILE}"
+'
+
+test_done
-- 
1.5.3.rc2.257.gd8a21
