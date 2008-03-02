From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] diff: make sure work tree side is shown as 0{40} when
 different
Date: Sun,  2 Mar 2008 01:43:31 -0800
Message-ID: <1204451012-17487-3-git-send-email-gitster@pobox.com>
References: <1204451012-17487-1-git-send-email-gitster@pobox.com>
 <1204451012-17487-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 10:44:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVkkF-000078-L5
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 10:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbYCBJnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 04:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbYCBJnz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 04:43:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbYCBJny (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 04:43:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 83216224E
	for <git@vger.kernel.org>; Sun,  2 Mar 2008 04:43:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A7F4F224D for <git@vger.kernel.org>; Sun,  2 Mar 2008 04:43:51 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.468.g36990
In-Reply-To: <1204451012-17487-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75757>

Ping Yin noticed that "git diff-index --raw" shows 0{40} when work tree
has submodule difference, but "git diff --raw" didn't correctly do so.

There was a mistake in the diffcore_skip_stat_unmatch() that was meant to
clean up the stat-only difference for running diff between the index and
work tree and diff between the tree and the work tree, to cause it re-read
from the submodule repository HEAD.  When ce_stat_match() says work tree
is different, we should always say 0{40} on the work tree side.

This patch fixes the issue, and adds tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The real change is a net deletion of 3 lines.

 diff.c                    |    7 +----
 t/t4027-diff-submodule.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 5 deletions(-)
 create mode 100755 t/t4027-diff-submodule.sh

diff --git a/diff.c b/diff.c
index b80f656..00e1590 100644
--- a/diff.c
+++ b/diff.c
@@ -3187,11 +3187,8 @@ static void diffcore_apply_filter(const char *filter)
 static int diff_filespec_is_identical(struct diff_filespec *one,
 				      struct diff_filespec *two)
 {
-	if (S_ISGITLINK(one->mode)) {
-		diff_fill_sha1_info(one);
-		diff_fill_sha1_info(two);
-		return !hashcmp(one->sha1, two->sha1);
-	}
+	if (S_ISGITLINK(one->mode))
+		return 0;
 	if (diff_populate_filespec(one, 0))
 		return 0;
 	if (diff_populate_filespec(two, 0))
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
new file mode 100755
index 0000000..3d2d081
--- /dev/null
+++ b/t/t4027-diff-submodule.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description='difference in submodules'
+
+. ./test-lib.sh
+. ../diff-lib.sh
+
+_z40=0000000000000000000000000000000000000000
+test_expect_success setup '
+	test_tick &&
+	test_create_repo sub &&
+	(
+		cd sub &&
+		echo hello >world &&
+		git add world &&
+		git commit -m submodule
+	) &&
+
+	test_tick &&
+	echo frotz >nitfol &&
+	git add nitfol sub &&
+	git commit -m superproject &&
+
+	(
+		cd sub &&
+		echo goodbye >world &&
+		git add world &&
+		git commit -m "submodule #2"
+	) &&
+
+	set x $(
+		cd sub &&
+		git rev-list HEAD
+	) &&
+	echo ":160000 160000 $3 $_z40 M	sub" >expect
+'
+
+test_expect_success 'git diff --raw HEAD' '
+	git diff --raw --abbrev=40 HEAD >actual &&
+	diff -u expect actual
+'
+
+test_expect_success 'git diff-index --raw HEAD' '
+	git diff-index --raw HEAD >actual.index &&
+	diff -u expect actual.index
+'
+
+test_expect_success 'git diff-files --raw' '
+	git diff-files --raw >actual.files &&
+	diff -u expect actual.files
+'
+
+test_done
-- 
1.5.4.3.468.g36990

