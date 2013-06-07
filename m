From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v6 2/7] add tests for rebasing with patch-equivalence present
Date: Thu,  6 Jun 2013 23:11:38 -0700
Message-ID: <1370585503-11374-3-git-send-email-martinvonz@gmail.com>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
 <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 08:12:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkpuN-0003G5-VR
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612Ab3FGGMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:12:15 -0400
Received: from mail-ye0-f201.google.com ([209.85.213.201]:50882 "EHLO
	mail-ye0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab3FGGMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:12:12 -0400
Received: by mail-ye0-f201.google.com with SMTP id q7so120907yen.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=taE0tpkPU2eF15swfBgs7Oyl7AgqVzSkQL696GcYsRw=;
        b=GZ4UraFel2RCEuLUsHcNdPpGYXZ8AXWsbXA4V+uJRkrQRHZFQ82GUk5M1vF3ECji5o
         otuAnDfneX9fN1A1apFmxaowRLjqE3Pd2nDC8PJkjJT4M+klraf67Q9NXhkROzloPHWO
         HeiXSeq067oWqm2AJBQq9HkQhVPUBYJnrgE1T9R/s0WJLxntR9Gq8mlY4CMKCcaSFmdy
         NP+qfXhVo93EP3Qikg9iIdEl0wWWa4bOn5dkWQD5V2FRBoExxJUEnbiFIh0tJTmIsgPP
         LMzM+aNGprd4TttlvDJfAtBzrhwbYTfR/4xr9B7P36ihTnhttfmNqfeZfA1OdQl8ZSs6
         REMg==
X-Received: by 10.236.200.229 with SMTP id z65mr22092690yhn.18.1370585510373;
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g80si522954yhj.7.2013.06.06.23.11.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 39C025A4208;
	Thu,  6 Jun 2013 23:11:50 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id D974210084A; Thu,  6 Jun 2013 23:11:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkZ0r4DSJNz8tvAoI3a5rW0LClJ2Dvn+Op82SAzuneZKHxBE8hFYZbVqYk02F3z5x9pvAOrf2/jL4EbEdpCZGbM6ylOarfHFFgDOVOaSTmjOKIDODv6HCXpjofwya/l1iDb1yUYoldlyI9PBnPbVcWoKkqngu204erqhMfqzsEpLXDdXV0Zlc3C0zHhHmOPv8dpVB53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226600>

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 t/lib-rebase.sh                   | 17 ++++++++
 t/t3421-rebase-topology-linear.sh | 85 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 1e0ff28..4b74ae4 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -81,3 +81,20 @@ reset_rebase () {
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
index 60365d1..ddcbfc6 100755
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
