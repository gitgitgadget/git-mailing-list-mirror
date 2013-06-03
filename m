From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v5 1/7] add simple tests of consistency across rebase types
Date: Mon,  3 Jun 2013 13:42:09 -0700
Message-ID: <1370292135-1236-2-git-send-email-martinvonz@gmail.com>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
 <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 03 22:42:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbaX-0000k0-Dw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758312Ab3FCUmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:42:40 -0400
Received: from mail-gg0-f201.google.com ([209.85.161.201]:64127 "EHLO
	mail-gg0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757674Ab3FCUm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:42:27 -0400
Received: by mail-gg0-f201.google.com with SMTP id f4so420968ggn.4
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=NX92VqxjMlSD3sGMnvsam3+2aceXPwkl6helm/pEtiI=;
        b=bFTC9SAvoaRUMPYkypuvABCfLcMX2uBvwgTLCvgUXaKD8jcpOVW8obVgFKph5WciwS
         f/MJ3Juv4DDHJm7y/21QVJsW6D8t70z0J/gUTRTVStObklC+PaHpZLNgoaE5rF5Jfe+K
         7tStCJJc3nzflQ9JoOsaqQ7fYQRDpEF5A8J0MJg2mci4gxCBaSuAmMQQtWN6V4+i6SqU
         M5LDRVb8nF1uGWbDmjI6YYUl3OZQ6uGo5Q3uJuS8Me5U/e3o6NjPhWmmaCFaFCVAGB47
         9HR21S78PnTLUy6ROYqadto2GcHYFKzzApWYS6EI1DwBnT0uENTUaHoIdwb8QNNeZSQs
         qTdA==
X-Received: by 10.236.209.196 with SMTP id s44mr9162756yho.25.1370292146579;
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o42si5782802yhe.5.2013.06.03.13.42.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6879231C1ED;
	Mon,  3 Jun 2013 13:42:26 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id A1B35100F96; Mon,  3 Jun 2013 13:42:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkL9V6wzXBingZuArrg06wgnxqA0gkJZcZ7rhDgcAFmeOb6blqkrppXjTyUnI192lDPmJT3TjFKfKCteP9QLap3rJbBc4yuvcV44cmm/326GKQ/XVcMDwQSMvRmlwGJlCRI1Ciw5xA4KDYbkRimXs7OR2nRkqBeWSk7ju1JU2PKxIXLS4/tSZynsw6zA3yE26406x4C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226282>

Helped-by: Johannes Sixt <j6t@kdbg.org>
---
 t/lib-rebase.sh                   | 15 ++++++++
 t/t3421-rebase-topology-linear.sh | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100755 t/t3421-rebase-topology-linear.sh

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6ccf797..62b3887 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -65,3 +65,18 @@ EOF
 	test_set_editor "$(pwd)/fake-editor.sh"
 	chmod a+x fake-editor.sh
 }
+
+# checks that the revisions in "$2" represent a linear range with the
+# subjects in "$1"
+test_linear_range () {
+	! { git log --format=%p "$2" | sane_grep " " ;} &&
+	expected=$1
+	set -- $(git log --reverse --format=%s "$2")
+	test "$expected" = "$*"
+}
+
+reset_rebase () {
+	git rebase --abort # may fail; ignore exit code
+	git reset --hard &&
+	git clean -f
+}
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
new file mode 100755
index 0000000..c4b32db
--- /dev/null
+++ b/t/t3421-rebase-topology-linear.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='basic rebase topology tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+# a---b---c
+#      \
+#       d---e
+test_expect_success 'setup' '
+	test_commit a &&
+	test_commit b &&
+	test_commit c &&
+	git checkout b &&
+	test_commit d &&
+	test_commit e
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "simple rebase $*" "
+		reset_rebase &&
+		git rebase $* c e &&
+		test_cmp_rev c HEAD~2 &&
+		test_linear_range 'd e' c..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* is no-op if upstream is an ancestor" "
+		reset_rebase &&
+		git rebase $* b e &&
+		test_cmp_rev e HEAD
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* -f rewrites even if upstream is an ancestor" "
+		reset_rebase &&
+		git rebase $* -f b e &&
+		! test_cmp_rev e HEAD &&
+		test_cmp_rev b HEAD~2 &&
+		test_linear_range 'd e' b..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase failure -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* fast-forwards if an ancestor of upstream" "
+		reset_rebase &&
+		git rebase $* e b &&
+		test_cmp_rev e HEAD
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_done
-- 
1.8.3.497.g83fddbe
