From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 5/7] Add a new test for using a custom merge strategy
Date: Sat, 26 Jul 2008 13:54:49 +0200
Message-ID: <13f39dd6752a34beeb6ecccb51dbc7546ef87182.1217037178.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
 <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org>
 <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
 <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
 <68749731fe8de8b2a9ffc53963291aeab9256b82.1217037178.git.vmiklos@frugalware.org>
 <99c90877657be0ed439a9918f500d6ad132550a2.1217037178.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMiNE-0002Vg-0l
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbYGZLyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbYGZLyh
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:54:37 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:54451 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbYGZLy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:54:27 -0400
Received: from vmobile.example.net (dsl5401C493.pool.t-online.hu [84.1.196.147])
	by yugo.frugalware.org (Postfix) with ESMTP id D56CE1DDC63
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 13:54:23 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id BBB641AB594; Sat, 26 Jul 2008 13:54:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <99c90877657be0ed439a9918f500d6ad132550a2.1217037178.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217037178.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90216>

Testing is done by creating a simple git-merge-theirs strategy which is
the opposite of ours. Using this in real merges is not recommended but
it's perfect for our testing needs.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t7606-merge-custom.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100755 t/t7606-merge-custom.sh

diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
new file mode 100755
index 0000000..f295e56
--- /dev/null
+++ b/t/t7606-merge-custom.sh
@@ -0,0 +1,45 @@
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
+	git diff --exit-code &&
+	test -f c0.c &&
+	test ! -f c1.c &&
+	test -f c2.c
+'
+
+test_done
-- 
1.6.0.rc0.14.g95f8.dirty
