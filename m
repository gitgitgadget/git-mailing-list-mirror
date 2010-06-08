From: Carl Worth <cworth@cworth.org>
Subject: [PATCH 2/2] Add test from From_-line escaping.
Date: Tue,  8 Jun 2010 13:02:29 -0700
Message-ID: <1276027349-4064-2-git-send-email-cworth@cworth.org>
References: <87hbldjo0s.fsf@yoom.home.cworth.org>
 <1276027349-4064-1-git-send-email-cworth@cworth.org>
Cc: Carl Worth <cworth@cworth.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 22:10:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM58L-0001Vj-NP
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452Ab0FHUKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 16:10:45 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:51075 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab0FHUKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 16:10:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 33B5B4196F4
	for <git@vger.kernel.org>; Tue,  8 Jun 2010 13:02:31 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mD+d8+A9qZI0; Tue,  8 Jun 2010 13:02:31 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id A8F864196F2;
	Tue,  8 Jun 2010 13:02:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1276027349-4064-1-git-send-email-cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148707>

As implemented in the previous commit. We test that when applying from an
mbox that all escaped From_ lines are properly unescaped. We also test that
when applying from an email message the unescaping does not occur.

Signed-off-by: Carl Worth <cworth@cworth.org>
---
 t/t4152-am-From_.sh |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100755 t/t4152-am-From_.sh

diff --git a/t/t4152-am-From_.sh b/t/t4152-am-From_.sh
new file mode 100755
index 0000000..02821ee
--- /dev/null
+++ b/t/t4152-am-From_.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='git am properly unescaping From_ lines'
+
+. ./test-lib.sh
+
+cat >msg <<EOF
+From_ lines
+
+This is a commit message that contains a From_ line, which is line
+that begins with the characters "From ". Get ready for it, now...
+From this time forward, we'll have no From_-line bugs.
+
+Additionally, we'll also test lines that are escaped versions of From_
+lines. These are lines that begin with one or more '>' characters that
+are then followed by the characters "From ". We want to ensure that
+none of these intentional '>' characters get swallowed. Let's try that
+with three variations, (with 1, 2, and 3 leading '>' characters):
+
+>From now on (with one leading '>')
+>>From there to here (with two leading '>' characters)
+>>>From Here to Eternity (with three leading '>' characters)
+
+EOF
+
+test_expect_success setup '
+	echo hello >file &&
+	git add file &&
+	test_tick &&
+	git commit -m first &&
+	git tag first &&
+	echo world >>file &&
+	git add file &&
+	test_tick &&
+	git commit -s -F msg &&
+	git tag second &&
+	git format-patch --stdout first | sed -e "1{p;d};s/^\(>*From \)/>\1/" > From_ &&
+	{
+		echo "X-Fake-Field: Line One" &&
+		echo "X-Fake-Field: Line Two" &&
+		echo "X-Fake-Field: Line Three" &&
+		git format-patch --stdout first | sed -e "1d"
+	} > From_.eml
+'
+
+test_expect_success 'am unescapes From_ lines from mbox' '
+	git checkout first &&
+	git am From_ &&
+	! test -d .git/rebase-apply &&
+	test -z "$(git diff second)" &&
+	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
+'
+
+test_expect_success 'am does not unescape From_ lines from email' '
+	git checkout first &&
+	git am From_.eml &&
+	! test -d .git/rebase-apply &&
+	test -z "$(git diff second)" &&
+	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
+'
+
+test_done
-- 
1.7.0.4
