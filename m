From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v3 04/11] t/t3511: add some tests of 'cherry-pick -s' functionality
Date: Sun, 27 Jan 2013 17:11:48 -0800
Message-ID: <1359335515-13818-5-git-send-email-drafnel@gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Cc: jrnieder@gmail.com, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdHC-0006Q3-39
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092Ab3A1BMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:12:24 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38489 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998Ab3A1BMW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:12:22 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so1197498pad.9
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WEv5gxg2CpXK3g5X0aLbqY4zQhOl7/Rm4qaYbD+EkTw=;
        b=bY02/3ntP1RcDX7FyMql6OgOiXkcZniG2bmyfoPMitOS4ZkOnjOa3aTAB8wc3viRJi
         W8sJya8qyD3Qgi+tfyPMEdSC9LTiLxu8dZEPJZZUeYALG/IUHx70vWt2ghRD9SL12lvp
         JYLS+RAUBewmiji5pOkivfwOgOMbsk4JQJrr9DI4bL/7bYWKcRfsX2GtpEnm+OOA9iKk
         FAAoKmekk4XklthuzcOp+GfmXkieElAs8L9ZfAsQ4pVSfxJ1PJTVIKSvOukEz9Lsct3a
         FRs8S3kOlEpB1eu19la1OpT2+7frn5gJnbTGAbIUlq7e1Ys7LxkgEQYoLRdSvg8b90bv
         RJ0w==
X-Received: by 10.66.78.100 with SMTP id a4mr32247682pax.4.1359335541713;
        Sun, 27 Jan 2013 17:12:21 -0800 (PST)
Received: from charliebrown.sbx10663.mountca.wayport.net (ip-64-134-226-147.public.wayport.net. [64.134.226.147])
        by mx.google.com with ESMTPS id x2sm5619521paw.8.2013.01.27.17.12.19
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:12:20 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214767>

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
index 0000000..2a040b7
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
+The signed-off-by string should begin with the words Signed-off-by followed
+by a colon and space, and then the signers name and email address. e.g.
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
1.8.1.1.450.g0327af3
