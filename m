From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 8/8] Test git-patch-id
Date: Sun, 15 Feb 2009 23:25:45 +0100
Message-ID: <23dc30ed8d645391d6a1072f182a37d98bde460a.1234736374.git.trast@student.ethz.ch>
References: <cover.1234736374.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 23:28:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpSx-0004VH-Ob
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbZBOW0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbZBOW0P
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:26:15 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:11608 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456AbZBOW0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:26:11 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:56 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:55 +0100
X-Mailer: git-send-email 1.6.2.rc0.335.g1a2b
In-Reply-To: <cover.1234736374.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Feb 2009 22:25:55.0366 (UTC) FILETIME=[5E30F460:01C98FBC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110076>

So far, git-patch-id was untested.  Add some simple checks for output
format and patch (in)equality.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t4203-patch-id.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100755 t/t4203-patch-id.sh

diff --git a/t/t4203-patch-id.sh b/t/t4203-patch-id.sh
new file mode 100755
index 0000000..04f7bae
--- /dev/null
+++ b/t/t4203-patch-id.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='git patch-id'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial foo a &&
+	test_commit first foo b &&
+	git checkout -b same HEAD^ &&
+	test_commit same-msg foo b &&
+	git checkout -b notsame HEAD^ &&
+	test_commit notsame-msg foo c
+'
+
+test_expect_success 'patch-id output is well-formed' '
+	git log -p -1 | git patch-id > output &&
+	grep "^[a-f0-9]\{40\} $(git rev-parse HEAD)$" output
+'
+
+get_patch_id () {
+	git log -p -1 "$1" | git patch-id |
+		sed "s# .*##" > patch-id_"$1"
+}
+
+test_expect_success 'patch-id detects equality' '
+	get_patch_id master &&
+	get_patch_id same &&
+	test_cmp patch-id_master patch-id_same
+'
+
+test_expect_success 'patch-id detects inequality' '
+	get_patch_id master &&
+	get_patch_id notsame &&
+	! test_cmp patch-id_master patch-id_notsame
+'
+
+test_done
-- 
1.6.2.rc0.335.g1a2b
