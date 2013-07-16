From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] t3032 - make compatible with systems using \r\n as a line ending
Date: Tue, 16 Jul 2013 16:26:30 -0400
Message-ID: <1374006390-1666-1-git-send-email-mlevedahl@gmail.com>
References: <20130716185933.GO14690@google.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 16 22:56:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzCIN-0007uJ-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 22:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934026Ab3GPU4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 16:56:23 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:39959 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933718Ab3GPU4W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 16:56:22 -0400
Received: by mail-gg0-f174.google.com with SMTP id y3so308486ggc.5
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r+KFQgUD77IegSbzTO1y17ZqrJdvk6z46TOj1u/zq9o=;
        b=Am35PriUopNNQUsZD80JH3+6BajDTJRUSd6FyQuP/x3JcmoF/uY8acXy4+DIc03PTP
         UZIBXfkYnVeaq//DpRflhK0ecDV0kvcIPZU1FFGLYFsRLVHUrF7/cHDqPj+MuV0gOwlB
         rvqjo03bnaBrESSEa+30oaMOxjTeE/2YV1cRx70mnYqecOcX/M4HadHfmrCmolWNLt0V
         1vF+t13ElnUlbhFHspYfF2nUEX5fIDkNoGXmee8NSQ30IxqlVhFwKm0sTw5Z6oXY0o17
         cHsktv+fDaE+YQEa3FMZTyZ7p2GMlydHxEjvkvwAKVojys+tqyM7MYCEUvFz9K/v0FW4
         YCCA==
X-Received: by 10.236.123.210 with SMTP id v58mr996915yhh.64.1374006394953;
        Tue, 16 Jul 2013 13:26:34 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id e69sm3485436yhl.3.2013.07.16.13.26.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 13:26:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
In-Reply-To: <20130716185933.GO14690@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230584>

Subtests 6, 7, and 9 rely test that merge-recursive correctly
ignores whitespace when so directed. These tests create and test for
lines ending in \r\n, but as this is a valid line separator on Windows,
convert such lines in the output to avoid confusion by line-oriented
grep.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 t/t3032-merge-recursive-options.sh | 22 +++++++++++++---------
 t/test-lib-functions.sh            |  4 ++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 2b17311..41ba184 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -125,13 +125,14 @@ test_expect_success '-Xignore-space-change makes cherry-pick succeed' '
 '
 
 test_expect_success '--ignore-space-change: our w/s-only change wins' '
-	q_to_cr <<-\EOF >expected &&
+	cat <<-\EOF >expected &&
 	    justice and holiness and is the nurse of his age and theQ
 	EOF
 
 	git read-tree --reset -u HEAD &&
 	git merge-recursive --ignore-space-change HEAD^ -- HEAD remote &&
-	grep "justice and holiness" text.txt >actual &&
+	cr_to_q <text.txt > text.txt+ &&
+	grep "justice and holiness" text.txt+ >actual &&
 	test_cmp expected actual
 '
 
@@ -150,14 +151,15 @@ test_expect_success '--ignore-space-change: does not ignore new spaces' '
 	cat <<-\EOF >expected1 &&
 	Well said, Cephalus, I replied; but as con cerning justice, what is
 	EOF
-	q_to_cr <<-\EOF >expected2 &&
+	cat <<-\EOF >expected2 &&
 	un intentionally; and when he departs to the world below he is not inQ
 	EOF
 
 	git read-tree --reset -u HEAD &&
 	git merge-recursive --ignore-space-change HEAD^ -- HEAD remote &&
-	grep "Well said" text.txt >actual1 &&
-	grep "when he departs" text.txt >actual2 &&
+	cr_to_q <text.txt >text.txt+
+	grep "Well said" text.txt+ >actual1 &&
+	grep "when he departs" text.txt+ >actual2 &&
 	test_cmp expected1 actual1 &&
 	test_cmp expected2 actual2
 '
@@ -174,18 +176,19 @@ test_expect_success '--ignore-all-space drops their new spaces' '
 '
 
 test_expect_success '--ignore-all-space keeps our new spaces' '
-	q_to_cr <<-\EOF >expected &&
+	cat <<-\EOF >expected &&
 	un intentionally; and when he departs to the world below he is not inQ
 	EOF
 
 	git read-tree --reset -u HEAD &&
 	git merge-recursive --ignore-all-space HEAD^ -- HEAD remote &&
-	grep "when he departs" text.txt >actual &&
+	cr_to_q <text.txt >text.txt+ &&
+	grep "when he departs" text.txt+ >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success '--ignore-space-at-eol' '
-	q_to_cr <<-\EOF >expected &&
+	cat <<-\EOF >expected &&
 	<<<<<<< HEAD
 	is not in his right mind; ought I to give them back to him?  No oneQ
 	=======
@@ -196,7 +199,8 @@ test_expect_success '--ignore-space-at-eol' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git merge-recursive --ignore-space-at-eol \
 						 HEAD^ -- HEAD remote &&
-	conflict_hunks text.txt >actual &&
+	cr_to_q <text.txt >text.txt+ &&
+	conflict_hunks text.txt+ >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a7e9aac..aa8e38f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -87,6 +87,10 @@ q_to_cr () {
 	tr Q '\015'
 }
 
+cr_to_q () {
+	tr '\015' Q
+}
+
 q_to_tab () {
 	tr Q '\011'
 }
-- 
1.8.3.2.0.13
