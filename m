From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Tue, 29 Jul 2008 01:39:24 +0200
Message-ID: <f3af7df2dda2dcb7801314cc993470264259f970.1217288180.git.vmiklos@frugalware.org>
References: <cover.1217288180.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:39:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNcJq-0004Om-2c
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 01:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbYG1Xi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 19:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbYG1Xi6
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 19:38:58 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:41855 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbYG1Xi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 19:38:57 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 77CBC1DDC5B;
	Tue, 29 Jul 2008 01:38:55 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7B7461AA738; Tue, 29 Jul 2008 01:39:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <alpine.DEB.1.00.0807281506510.2725@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90523>

Testing is done by creating a simple git-merge-theirs strategy which
just picks the upstream tree. (In other words, this is not the opposite
of -s ours.)

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Mon, Jul 28, 2008 at 03:12:59PM +0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Note that what was asked for, and what Junio implemented before
> deciding
> that it would do more harm than good in git.git, is not the same as
> what
> you provide.

Thanks, now I see the difference. The updated commit message is
hopefully better.

Also I added a check to make sure the upstream and the result tree is
the same as well.

 t/t7606-merge-custom.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100755 t/t7606-merge-custom.sh

diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
new file mode 100755
index 0000000..13e8ff5
--- /dev/null
+++ b/t/t7606-merge-custom.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing a custom strategy.'
+
+. ./test-lib.sh
+
+cat > git-merge-theirs << EOF
+#!/bin/sh
+eval git read-tree --reset -u \\\$\$#
+EOF
+chmod +x git-merge-theirs
+PATH=.:$PATH
+export PATH
+
+test_expect_success 'setup' '
+	echo c0 > c0.c &&
+	git add c0.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	echo c1 > c1.c &&
+	git add c1.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	echo c2 > c2.c &&
+	git add c2.c &&
+	git commit -m c2 &&
+	git tag c2
+'
+
+test_expect_success 'merge c2 with a custom strategy' '
+	git reset --hard c1 &&
+	git merge -s theirs c2 &&
+	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
+	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
+	test "$(git rev-parse c2^{tree})" = "$(git rev-parse HEAD^{tree})" &&
+	git diff --exit-code &&
+	test -f c0.c &&
+	test ! -f c1.c &&
+	test -f c2.c
+'
+
+test_done
-- 
1.6.0.rc0.14.g95f8.dirty
