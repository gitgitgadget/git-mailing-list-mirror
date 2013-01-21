From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 03/10] t/t3511: add some tests of 'cherry-pick -s' functionality
Date: Mon, 21 Jan 2013 00:40:20 -0800
Message-ID: <1358757627-16682-4-git-send-email-drafnel@gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCwg-000346-P9
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab3AUIks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:40:48 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36251 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab3AUIkr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:40:47 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so3280798pad.36
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=yiKo6Q0PeeQSxh5AbScW5O2JTS3iFiGC1jRvr/+kSsM=;
        b=oCEkIFUus2MBZh6X9SODlQlyL6OvNvlekxIGEoBBO4YynK1tWrpez811d3i+ipdmZ2
         put1yV36UM56cCWOP2UEYm8QlbuQufWqGDHVbbpooQsEyBVYdtoEr5/PdskV32FxOVZ3
         4RdhtPbCVWJfyDoc2bm37ZYUS4VrEUwTm2WaQaV6EbJvCYorpYdOu1C+UCHWTRfkI1pc
         0CsopUnS3wjxDToXPx7HqCdg7pEE9/dO0ZOMaoUWXuF4vpMrc9DZPrwTjIjF7FlfIDu6
         B17TM+vT3HwUq0FmxNKmAMZ9b8+dKnlh+6I70KTcKbhlhwsK53441yIe7QiBNJudqxY9
         Po2g==
X-Received: by 10.68.217.4 with SMTP id ou4mr27486442pbc.88.1358757647085;
        Mon, 21 Jan 2013 00:40:47 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.40.45
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:40:46 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214105>

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
1.8.1.1.252.gdb33759
