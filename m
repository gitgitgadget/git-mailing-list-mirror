From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 03/11] t/t3511: add some tests of 'cherry-pick -s' functionality
Date: Sun, 25 Nov 2012 17:45:51 -0800
Message-ID: <1353894359-6733-4-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:47:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcnmx-0007DU-5q
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab2KZBqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 20:46:54 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56814 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab2KZBqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:46:53 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4643368pad.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iXFVtWeaqeVfVJXrES35l+5ZzH1L7P1vhYCWWxIh5YY=;
        b=MufqXlsx/jeK/KQrLiUBmpEuXC2AS7Sgt8lvzkM4O2wi1ybLxhW5Bablv3+S1BnVin
         0aDxCkUnBIE9pEFTODCs49Y0VZTrLiqIijyaObuox1uc3TtSpMXyIOgcYmBNvIQPTd/K
         uYSzZzARdU8T+GD+PYQV1LWCcJdCacPYQQ8lpbPttjUW1k0ggmRfiGndXX7p9qGt6qdd
         xoA/oaGamACG2gUobSQSWSwvMaYv3yu0wrdo/vdtE2+IwLDBrpQwjI1NQQNnuQXArJi9
         OczOs5inWo5chZf6H5BZFB2ZY91jNF+isHk3+Pdj6noFQAZVXFqKIZvfxT1+FKTfptmr
         aTQw==
Received: by 10.69.0.40 with SMTP id av8mr33078254pbd.117.1353894413275;
        Sun, 25 Nov 2012 17:46:53 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.46.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:46:52 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210393>

Add some tests to ensure that 'cherry-pick -s' operates in the following
manner:

   * Inserts a blank line before appending a s-o-b to a commit message that
     does not contain a s-o-b footer

   * Does not mistake first line "subject: description" as a s-o-b footer

   * Does not mistake single word message body as conforming to rfc2822

   * Appends a s-o-b when last s-o-b in footer does not match committer
     s-o-b, even when committer's s-o-b exists elsewhere in footer.

   * Does not append a s-o-b when last s-o-b matches committer s-o-b

   * Correctly detects a non-conforming footer containing a mix of s-o-b
     like elements and s-o-b elements. (marked "expect failure")

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 t/t3511-cherry-pick-x.sh | 111 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100755 t/t3511-cherry-pick-x.sh

diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
new file mode 100755
index 0000000..a6c4168
--- /dev/null
+++ b/t/t3511-cherry-pick-x.sh
@@ -0,0 +1,111 @@
+#!/bin/sh
+
+test_description='Test cherry-pick -x and -s'
+
+. ./test-lib.sh
+
+pristine_detach () {
+	git cherry-pick --quit &&
+	git checkout -f "$1^0" &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x
+}
+
+mesg_one_line='base: commit message'
+
+mesg_no_footer="$mesg_one_line
+
+OneWordBodyThatsNotA-S-o-B"
+
+mesg_with_footer="$mesg_no_footer
+
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+Signed-off-by: A.U. Thor <author@example.com>
+Signed-off-by: B.U. Thor <buthor@example.com>"
+
+mesg_broken_footer="$mesg_no_footer
+
+Signed-off-by: B.U. Thor <buthor@example.com>
+Not a valid footer element
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+
+mesg_with_footer_sob="$mesg_with_footer
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+
+
+test_expect_success setup '
+	git config advice.detachedhead false &&
+	echo unrelated >unrelated &&
+	git add unrelated &&
+	test_commit initial foo a &&
+	test_commit "$mesg_one_line" foo b mesg-one-line &&
+	git reset --hard initial &&
+	test_commit "$mesg_no_footer" foo b mesg-no-footer &&
+	git reset --hard initial &&
+	test_commit "$mesg_broken_footer" foo b mesg-broken-footer &&
+	git reset --hard initial &&
+	test_commit "$mesg_with_footer" foo b mesg-with-footer &&
+	git reset --hard initial &&
+	test_commit "$mesg_with_footer_sob" foo b mesg-with-footer-sob &&
+	pristine_detach initial &&
+	test_commit conflicting unrelated
+'
+
+test_expect_success 'cherry-pick -s inserts blank line after one line subject' '
+	pristine_detach initial &&
+	git cherry-pick -s mesg-one-line &&
+	cat <<-EOF >expect &&
+		$mesg_one_line
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'cherry-pick -s inserts blank line after non-conforming footer' '
+	pristine_detach initial &&
+	git cherry-pick -s mesg-broken-footer &&
+	cat <<-EOF >expect &&
+		$mesg_broken_footer
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick -s inserts blank line when conforming footer not found' '
+	pristine_detach initial &&
+	git cherry-pick -s mesg-no-footer &&
+	cat <<-EOF >expect &&
+		$mesg_no_footer
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick -s adds sob when last sob doesnt match committer' '
+	pristine_detach initial &&
+	git cherry-pick -s mesg-with-footer &&
+	cat <<-EOF >expect &&
+		$mesg_with_footer
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick -s refrains from adding duplicate trailing sob' '
+	pristine_detach initial &&
+	git cherry-pick -s mesg-with-footer-sob &&
+	cat <<-EOF >expect &&
+		$mesg_with_footer_sob
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.0.284.g959048a
