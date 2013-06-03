From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v5 2/7] add tests for rebasing with patch-equivalence present
Date: Mon,  3 Jun 2013 13:42:10 -0700
Message-ID: <1370292135-1236-3-git-send-email-martinvonz@gmail.com>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
 <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 03 22:42:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbaL-0000d8-LK
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931Ab3FCUm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:42:29 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:65007 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917Ab3FCUm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:42:27 -0400
Received: by mail-qa0-f74.google.com with SMTP id bs12so362808qab.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=PGfLNShtynlJfNwgniaguoS9PDa0ywaVZFgXR4/cuUU=;
        b=WvAehfNDrvmrf0xRhFBacSITaVz3I00fWAX7JH8BRvaQlea9vHuvw0zbYfIFFasDuP
         IxeqIIzdgiyp8jM1l0GS+jMpWVNBtrf+KizLZmlTKyBjbuwBeYfezLOk8kPLOLbSYtxC
         7pycVk8BdiYwHPEG4ud6fCIh5dm77ldZA6WSmQDh03kfS7YDdNms5Trk7VBeR40Pq34J
         ljQboxPEQi2wcgoNYj9H8twZEMneyznphG96C65DkTxkR0TJYmu3chE7N/w6QrAfALiV
         Y2UwXbuNl0FqnbYQQ++PVcFjOmFMPgkhfUbgGKPDGCNImDoTkc7jWdb7nuG1DnOookQ4
         b4WA==
X-Received: by 10.236.21.198 with SMTP id r46mr12822095yhr.12.1370292146114;
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n78si5786765yhh.1.2013.06.03.13.42.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id EAE895A4217;
	Mon,  3 Jun 2013 13:42:25 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 6838E100A16; Mon,  3 Jun 2013 13:42:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmzay6KuPDptbUP0z93VYcmrPrhpe24M0/81iFzu0xZsAanqtprbpFE3zZXz2behBFk2aVT5CpG266Vx/gYMYljvMsLIySgUWKPgGtxYRjDkJRAiDyf8oECwrbxmejOMeptkk2eKfV7naLKIH9Su0blp5yLshlAi+p7JtO8HZamWMFPfPu8dUUAz5cE6igV6p+WRNGL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226279>

---
 t/lib-rebase.sh                   | 17 ++++++++
 t/t3421-rebase-topology-linear.sh | 85 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 62b3887..16eeb1c 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -80,3 +80,20 @@ reset_rebase () {
 	git reset --hard &&
 	git clean -f
 }
+
+cherry_pick () {
+	git cherry-pick -n "$2" &&
+	git commit -m "$1" &&
+	git tag "$1"
+}
+
+revert () {
+	git revert -n "$2" &&
+	git commit -m "$1" &&
+	git tag "$1"
+}
+
+make_empty () {
+	git commit --allow-empty -m "$1" &&
+	git tag "$1"
+}
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index c4b32db..75cc476 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -75,4 +75,89 @@ test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase success -p
 
+#       f
+#      /
+# a---b---c---g---h
+#      \
+#       d---G---i
+#
+# uppercase = cherry-picked
+# h = reverted g
+#
+# Reverted patches are there for tests to be able to check if a commit
+# that introduced the same change as another commit is
+# dropped. Without reverted commits, we could get false positives
+# because applying the patch succeeds, but simply results in no
+# changes.
+test_expect_success 'setup of linear history for range selection tests' '
+	git checkout c &&
+	test_commit g &&
+	revert h g &&
+	git checkout d &&
+	cherry_pick G g &&
+	test_commit i &&
+	git checkout b &&
+	test_commit f
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* drops patches in upstream" "
+		reset_rebase &&
+		git rebase $* h i &&
+		test_cmp_rev h HEAD~2 &&
+		test_linear_range 'd i' h..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* can drop last patch if in upstream" "
+		reset_rebase &&
+		git rebase $* h G &&
+		test_cmp_rev h HEAD^ &&
+		test_linear_range 'd' h..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --onto drops patches in upstream" "
+		reset_rebase &&
+		git rebase $* --onto f h i &&
+		test_cmp_rev f HEAD~2 &&
+		test_linear_range 'd i' f..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --onto does not drop patches in onto" "
+		reset_rebase &&
+		git rebase $* --onto h f i &&
+		test_cmp_rev h HEAD~3 &&
+		test_linear_range 'd G i' h..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
 test_done
-- 
1.8.3.497.g83fddbe
