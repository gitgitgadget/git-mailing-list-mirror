From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 13/15] Add new test case to ensure git-merge reduces octopus parents when possible
Date: Fri, 27 Jun 2008 18:22:06 +0200
Message-ID: <2f3a41b78511ab22c31c2c2827b9b8a456462c83.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
 <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
 <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
 <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
 <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
 <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org>
 <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org>
 <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org>
 <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org>
 <3a8521edeb769e0fb85bec434daf064ce29edaa5.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:27:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGnU-0005l2-T9
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761442AbYF0QXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761424AbYF0QXO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:23:14 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45348 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760863AbYF0QWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:14 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id 6363E1DDC68;
	Fri, 27 Jun 2008 18:22:07 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 655C518E831; Fri, 27 Jun 2008 18:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <3a8521edeb769e0fb85bec434daf064ce29edaa5.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86593>

The old shell version used show-branch --independent to filter for the
ones that cannot be reached from any other reference.

The new C version uses reduce_heads() from commit.c for this, so
add test to ensure it works as expected.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7603-merge-reduce-heads.sh |   63 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100755 t/t7603-merge-reduce-heads.sh

diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
new file mode 100755
index 0000000..17b19dc
--- /dev/null
+++ b/t/t7603-merge-reduce-heads.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing octopus merge when reducing parents to independent branches.'
+
+. ./test-lib.sh
+
+# 0 - 1
+#   \ 2
+#   \ 3
+#   \ 4 - 5
+#
+# So 1, 2, 3 and 5 should be kept, 4 should be avoided.
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
+	git tag c2 &&
+	git reset --hard c0 &&
+	echo c3 > c3.c &&
+	git add c3.c &&
+	git commit -m c3 &&
+	git tag c3 &&
+	git reset --hard c0 &&
+	echo c4 > c4.c &&
+	git add c4.c &&
+	git commit -m c4 &&
+	git tag c4 &&
+	echo c5 > c5.c &&
+	git add c5.c &&
+	git commit -m c5 &&
+	git tag c5
+'
+
+test_expect_success 'merge c1 with c2, c3, c4, c5' '
+	git reset --hard c1 &&
+	git merge c2 c3 c4 c5 &&
+	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
+	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
+	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
+	test "$(git rev-parse c5)" = "$(git rev-parse HEAD^4)" &&
+	git diff --exit-code &&
+	test -f c0.c &&
+	test -f c1.c &&
+	test -f c2.c &&
+	test -f c3.c &&
+	test -f c4.c &&
+	test -f c5.c
+'
+
+test_done
-- 
1.5.6
