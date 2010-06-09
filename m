From: Carl Worth <cworth@cworth.org>
Subject: [PATCH] Add a test for "git rebase" with a From_ line in the commit message
Date: Wed,  9 Jun 2010 10:29:17 -0700
Message-ID: <1276104557-2025-1-git-send-email-cworth@cworth.org>
Cc: Carl Worth <cworth@cworth.org>
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 19:29:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMP5t-0000Y4-9r
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 19:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970Ab0FIR3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 13:29:31 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:34435 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757946Ab0FIR3a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 13:29:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 75C054196F2;
	Wed,  9 Jun 2010 10:29:30 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y2AJ4iwDU-+V; Wed,  9 Jun 2010 10:29:18 -0700 (PDT)
Received: from yoom.amr.corp.intel.com (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 36BFB431FC1;
	Wed,  9 Jun 2010 10:29:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.249.g74df7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148801>

This test ensures that all tools underlying "git rebase", (such as
"git format-patch" and "git am"), collectively agree on a robust
escaping mechanism for a line in the commit message that looks like
an mbox separator.

Specifically, the problematic line begins with "From " and ends with a
timestamp in the form returned by the asctime function.

Signed-off-by: Carl Worth <cworth@cworth.org>
---

This test fails with git from origin/master but passes with my current
series of patches to implement mboxrd format in both format-patch and
mailsplit. This would also be a useful test even if some other robust
format were chosen other than mboxrd.

 t/t3418-rebase-From_.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100755 t/t3418-rebase-From_.sh

diff --git a/t/t3418-rebase-From_.sh b/t/t3418-rebase-From_.sh
new file mode 100755
index 0000000..c809fda
--- /dev/null
+++ b/t/t3418-rebase-From_.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Carl Worth
+#
+
+test_description='git rebase with a commit with a From_ line in it
+
+This test ensures that git rebase will not get confused by a commit
+that contains a line in the commit message that looks like a mbox
+separator (begins with "From " and ends with an asctime-like timestamp)
+'
+. ./test-lib.sh
+
+cat >msg <<EOF
+From_-line commit
+
+This crafty commit message contains a line that looks an awful lot
+like an mbox separator. This kind of thing has been known to happen,
+(often accidentally), but git rebase should still support it.
+
+Here's the tricky line:
+
+From 74df72aec0b959c3015f4d7f213453217cb21aed Mon Sep 17 00:00:00 2001
+
+EOF
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+	echo "hello world" > file &&
+	git add file &&
+	git commit -F msg
+'
+
+test_expect_success 'git rebase replaying a commit with a From_ line' '
+	git rebase --onto A B
+'
+
+test_done
-- 
1.7.1.249.g74df7
