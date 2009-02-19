From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 8/8] Test git-patch-id
Date: Thu, 19 Feb 2009 12:13:42 +0100
Message-ID: <889fbb648233ddfd5eb03e231d4f5aa7be60e009.1235041345.git.trast@student.ethz.ch>
References: <cover.1235041345.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:16:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6sz-0000Pm-NF
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 12:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbZBSLOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 06:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbZBSLOS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 06:14:18 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16533 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbZBSLON (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 06:14:13 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:54 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
X-Mailer: git-send-email 1.6.2.rc1.266.gce6c4
In-Reply-To: <cover.1235041345.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 11:13:52.0977 (UTC) FILETIME=[25D3AC10:01C99283]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110680>

So far, git-patch-id was untested.  Add some simple checks for output
format and patch (in)equality.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Same as v1.

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
1.6.2.rc1.266.gce6c4
