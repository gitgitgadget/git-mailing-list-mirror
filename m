From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Add a test for git-commit being confused by relative GIT_DIR
Date: Sun, 12 Aug 2007 00:02:28 +0200
Organization: Organization?!?
Message-ID: <85tzr5spaj.fsf@lola.goethe.zz>
References: <7vbqddn8zj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 00:02:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJz2Y-0004Ez-Gk
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 00:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760587AbXHKWCb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 18:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757948AbXHKWCb
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 18:02:31 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:51978 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756661AbXHKWCa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 18:02:30 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 492FA17FB25
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 00:02:29 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 3AC555BD6A
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 00:02:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-066.pools.arcor-ip.net [84.61.49.66])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 03352292B62
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 00:02:28 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 705831C3C79D; Sun, 12 Aug 2007 00:02:28 +0200 (CEST)
In-Reply-To: <7vbqddn8zj.fsf@assigned-by-dhcp.cox.net>
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3927/Sat Aug 11 22:11:25 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55638>


Signed-off-by: David Kastrup <dak@gnu.org>
---
It takes an inordinarily large amount of time to create these tests, I
am afraid.  There is little sense in making a more extensive audit,
cranking out more cases which fail with relative paths, when the fix,
namely making GIT_DIR absolute, is so simple.

 t/t2050-git-dir-relative.sh |   54 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100755 t/t2050-git-dir-relative.sh

diff --git a/t/t2050-git-dir-relative.sh b/t/t2050-git-dir-relative.sh
new file mode 100755
index 0000000..54a3512
--- /dev/null
+++ b/t/t2050-git-dir-relative.sh
@@ -0,0 +1,54 @@
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
+test_expect_success 'Setting up post-commit hook' '
+mkdir -p .git/hooks &&
+cat <<EOF >.git/hooks/post-commit &&
+#!/bin/sh
+touch $(pwd)/output
+echo "Post commit hook was called."
+EOF
+chmod +x .git/hooks/post-commit'
+
+test_expect_success 'post-commit hook used ordinarily' '
+echo initial >top &&
+git-add top
+git-commit -m initial &&
+test -r output
+'
+
+rm -rf output
+mkdir subdir
+mv .git subdir
+
+test_expect_success 'post-commit-hook created and used from top dir' '
+echo changed >top &&
+git --git-dir subdir/.git add top &&
+git --git-dir subdir/.git commit -m topcommit &&
+test -r output
+'
+
+rm -rf output
+
+test_expect_success 'post-commit-hook from sub dir' '
+echo changed again >top
+cd subdir &&
+git --git-dir .git --work-tree .. add ../top &&
+git --git-dir .git --work-tree .. commit -m subcommit &&
+test -r ../output
+'
+
+test_done
-- 
1.5.3.rc2.187.g9a1d2-dirty
