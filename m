From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 04/12] t/t3511: add some tests of 'cherry-pick -s' functionality
Date: Tue, 12 Feb 2013 02:17:31 -0800
Message-ID: <1360664260-11803-5-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:18:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Cwn-0002O8-Mz
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920Ab3BLKSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:18:16 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:39225 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab3BLKSO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:14 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so3201335dan.23
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=xyDHhkjE7JafIJY6BvyjOV4mAtujSfakoppL1PEB2OY=;
        b=v4XdPS4Es25JO5HVq8MGZb5c0SIo7nfL9RA5r21iWWMJEOvQ8XkmOUpoe0tbLVLck0
         2B0P3XdJx5PdkFKVp/HUdfglyf/iKhltRcDfQ2juUW0fyepQryvyka5MyJVnCUGdV7n/
         ZY+GGLFgoGga4Q1nup4cEkqVw7OJRx3h3OCUPLe6K2SYb9bs3rODtSMwYDxYEcCjGR7M
         RsLLUUTW24YzsbatrPLz2tsnOQ7X+YQ5R3nxGgPkCZriwiFLSTEUD6EHmQciSMyWAV6y
         QX+3SqhIfFtzt1bfHJID8tvb1HuolQePyIA9WDZEdT6r8eqMUL+duNj7WrHT7OiwFe5h
         jxQg==
X-Received: by 10.66.76.37 with SMTP id h5mr50585134paw.33.1360664294408;
        Tue, 12 Feb 2013 02:18:14 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.12
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:13 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216134>

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
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
1.8.1.3.579.gd9af3b6
