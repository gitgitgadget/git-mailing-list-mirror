From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 04/10] Add new test to ensure git-merge handles pull.twohead and pull.octopus
Date: Thu,  5 Jun 2008 22:44:30 +0200
Message-ID: <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org>
 <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
 <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 22:45:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MKt-000606-Ue
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbYFEUoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbYFEUog
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:44:36 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:60243 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbYFEUoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:44:32 -0400
Received: from vmobile.example.net (dsl5401CC68.pool.t-online.hu [84.1.204.104])
	by yugo.frugalware.org (Postfix) with ESMTP id 5AD791DDC5E
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 22:44:29 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id BB15F18E2BB; Thu,  5 Jun 2008 22:44:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83969>

Test if the given strategies are used and test the case when multiple
strategies are configured using a space separated list.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t7601-merge-pull-config.sh |   57 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100755 t/t7601-merge-pull-config.sh

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
new file mode 100755
index 0000000..cc595ac
--- /dev/null
+++ b/t/t7601-merge-pull-config.sh
@@ -0,0 +1,57 @@
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
+	git merge c2 &&
+	test -e c1.c &&
+	test -e c2.c
+'
+
+test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
+	git reset --hard c1 &&
+	git config pull.twohead ours &&
+	git merge c2 &&
+	test -e c1.c &&
+	! test -e c2.c
+'
+
+test_expect_success 'merge c1 with c2 and c3 (recursive in pull.octopus)' '
+	git reset --hard c1 &&
+	git config pull.octopus "recursive" &&
+	! git merge c2 c3
+'
+
+test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octopus)' '
+	git reset --hard c1 &&
+	git config pull.octopus "recursive octopus" &&
+	git merge c2 c3
+'
+
+test_done
-- 
1.5.6.rc0.dirty
