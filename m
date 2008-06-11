From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 04/10] Add new test to ensure git-merge handles pull.twohead and pull.octopus
Date: Wed, 11 Jun 2008 22:50:28 +0200
Message-ID: <c72207b02d37f3d8c064534264219f4dd38c7559.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
 <4818a0b71b7f6b44ef49621045a5871458ba5c38.1213217187.git.vmiklos@frugalware.org>
 <dedcc8309fed3282df455bec7fbc9d0f8275b74b.1213217187.git.vmiklos@frugalware.org>
 <9a5a141bd92756b529514579818a2c59a1a03899.1213217187.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 22:52:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XIq-0000Zk-3n
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 22:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbYFKUuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 16:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbYFKUum
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 16:50:42 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:32878 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbYFKUuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 16:50:35 -0400
Received: from vmobile.example.net (dsl5401C482.pool.t-online.hu [84.1.196.130])
	by yugo.frugalware.org (Postfix) with ESMTP id 6B68B1DDC5F
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 22:50:32 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id A335718DFE1; Wed, 11 Jun 2008 22:50:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <9a5a141bd92756b529514579818a2c59a1a03899.1213217187.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84655>

Test if the given strategies are used and test the case when multiple
strategies are configured using a space separated list.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t7601-merge-pull-config.sh |   72 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100755 t/t7601-merge-pull-config.sh

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
new file mode 100755
index 0000000..c0b550e
--- /dev/null
+++ b/t/t7601-merge-pull-config.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing pull.* configuration parsing.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo c0 >c0.c &&
+	git add c0.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	echo c1 >c1.c &&
+	git add c1.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	echo c2 >c2.c &&
+	git add c2.c &&
+	git commit -m c2 &&
+	git tag c2
+	git reset --hard c0 &&
+	echo c3 >c3.c &&
+	git add c3.c &&
+	git commit -m c3 &&
+	git tag c3
+'
+
+test_expect_success 'merge c1 with c2' '
+	git reset --hard c1 &&
+	test -f c0.c &&
+	test -f c1.c &&
+	test ! -f c2.c &&
+	test ! -f c3.c &&
+	git merge c2 &&
+	test -f c1.c &&
+	test -f c2.c
+'
+
+test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
+	git reset --hard c1 &&
+	git config pull.twohead ours &&
+	git merge c2 &&
+	test -f c1.c &&
+	! test -f c2.c
+'
+
+test_expect_success 'merge c1 with c2 and c3 (recursive in pull.octopus)' '
+	git reset --hard c1 &&
+	git config pull.octopus "recursive" &&
+	test_must_fail git merge c2 c3 &&
+	test "$(git rev-parse c1)" = "$(git rev-parse HEAD)"
+'
+
+test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octopus)' '
+	git reset --hard c1 &&
+	git config pull.octopus "recursive octopus" &&
+	git merge c2 c3 &&
+	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
+	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
+	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)"
+	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
+	git diff --exit-code &&
+	test -f c0.c &&
+	test -f c1.c &&
+	test -f c2.c &&
+	test -f c3.c
+'
+
+test_done
-- 
1.5.6.rc2.dirty
