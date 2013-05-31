From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v3 2/7] add tests for rebasing with patch-equivalence present
Date: Thu, 30 May 2013 23:49:42 -0700
Message-ID: <1369982987-18954-3-git-send-email-martinvonz@gmail.com>
References: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
 <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 08:50:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJAG-0000co-GY
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 08:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab3EaGuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 02:50:09 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:57668 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab3EaGuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 02:50:04 -0400
Received: by mail-yh0-f73.google.com with SMTP id a41so113525yho.2
        for <git@vger.kernel.org>; Thu, 30 May 2013 23:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=zajv2FHfVkRJOIk5rLwk84+x1Z8qSJPwsBDJZBHH0kQ=;
        b=dMuwl95+hxk5GipqkqI9i9OZuFxCM/FsLwTll1cTzZYmDdOBD3ZSxptQe8BwFvpFEz
         dCn+WvvurgXfXyIN81RErQ/+lVVx19kwhl8za9kEmpCGgSbePYrKO/cg0GMasUXZu1s6
         iqTPj11qFJMHWYUFY/IuwhaevzddehPI1v6R/wEtkpcIhuP2BUzpsi9ZBAk0N4tVlyTB
         RzdwNGwVjx8Yz0QXi2Muool5i0vFBQbd7r9o+7PXzSUQsuc1Ovv80JR/uku8o6VVh3cW
         eO86a1VYLSCxz1yAcCG9H//PGSFzLku7nDK4qVzBCXZk21VEKjxPI6sOsi4iBhEJrNfL
         m3Kw==
X-Received: by 10.236.61.42 with SMTP id v30mr5806025yhc.15.1369983003450;
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id b23si3620873yhj.4.2013.05.30.23.50.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 49E9D31C2DF;
	Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id E8906100576; Thu, 30 May 2013 23:50:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQm33Al3wAqMNHc51YLCfJBJLlbyZ3Pc+Xgyv+jJUIP2fNXanIgzB3Sn/wwVckfVoKfk+RU+KMQKI3UaUchfUPniKQGEz1oMSIyIjnXpTWXhmM1L0iafP8fjfueokwKUFI+3YF7oSdCQV4TyeOLtiBaDmD4HW1/93ZWni82YLf6fhT/JQcaezJkqmjQYf7QmdVp2RkKG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226052>

---
 t/lib-rebase.sh                   | 17 ++++++++
 t/t3420-rebase-topology-linear.sh | 85 +++++++++++++++++++++++++++++++++++++++
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
diff --git a/t/t3420-rebase-topology-linear.sh b/t/t3420-rebase-topology-linear.sh
index c4b32db..75cc476 100755
--- a/t/t3420-rebase-topology-linear.sh
+++ b/t/t3420-rebase-topology-linear.sh
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
1.8.2.674.gd17d3d2
