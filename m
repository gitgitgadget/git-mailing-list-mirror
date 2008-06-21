From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 13/13] Add new test case to ensure git-merge reduces octopus parents when possible
Date: Sat, 21 Jun 2008 19:15:35 +0200
Message-ID: <1214068535-18418-1-git-send-email-vmiklos@frugalware.org>
References: <67668993d3fc7ea52c9c191178f3e1dea7bb4282.1214066799.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 19:17:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA6hz-0004NO-1c
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 19:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbYFURPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 13:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbYFURPg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 13:15:36 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:59231 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbYFURPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 13:15:35 -0400
Received: from vmobile.example.net (dsl5402CEE1.pool.t-online.hu [84.2.206.225])
	by yugo.frugalware.org (Postfix) with ESMTP id 9DE9A1DDC5B;
	Sat, 21 Jun 2008 19:15:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7340A18E0E5; Sat, 21 Jun 2008 19:15:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <67668993d3fc7ea52c9c191178f3e1dea7bb4282.1214066799.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85721>

The old shell version used show-branch --independent to filter for the
ones that cannot be reached from any other reference.

The new C version uses reduce_heads() from commit.c for this, so
add test to ensure it works as expected.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Jun 21, 2008 at 07:00:50PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> The new C version uses filter_independent() from commit.c for this, so
> add test to ensure it works as expected.

Ouch, this info is now outdated. I updated the commit message and
renamed the test, no functional changes.

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
