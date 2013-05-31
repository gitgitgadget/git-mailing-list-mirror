From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v3 3/7] add tests for rebasing of empty commits
Date: Thu, 30 May 2013 23:49:43 -0700
Message-ID: <1369982987-18954-4-git-send-email-martinvonz@gmail.com>
References: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
 <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 08:50:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJAO-0000gk-Qv
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 08:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab3EaGuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 02:50:15 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:50749 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab3EaGuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 02:50:04 -0400
Received: by mail-qc0-f202.google.com with SMTP id d1so113187qcz.3
        for <git@vger.kernel.org>; Thu, 30 May 2013 23:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=Kp/g8jC2icUZ5SvriB6LqLxmGvqsnOiGrjNgQJ6Acxc=;
        b=Ak43Y3t0heLmxY9BjBSQ6g8zf2yj5+jpogn+m0GdWuaH+PSs9yrQFlXk0/Vk7sSeof
         ywcH5d/INkUAPu7x1H2NRr3YOAHridWhfcKrjQKkOmy+kVlHCS2TuimX/N4qH3/fS473
         Vmz0Zc9E79frYvap2pK0FMojiplNiHfUtMDO2KkwrSWVBfNapOPOXFowqAQA8G71zbT/
         LEboAPiQwFE8G35bYZ67/QpVNN2lqsjj3zYtpiAq14kglgeYgImVvR5wKvJFTVsODLmn
         S5Ciiv3SD2MyGnf8VuJNppapDsR7nvXd+OXqQga8a4xrFUnPOBrBc2b2xoJo7dP7dzmZ
         q4zg==
X-Received: by 10.236.43.72 with SMTP id k48mr5917263yhb.35.1369983003481;
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o42si3620395yhe.5.2013.05.30.23.50.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 52C955A405D;
	Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 08ED9100D56; Thu, 30 May 2013 23:50:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQnqg/JNuFruu0XLqI0242V9nD+tAcPRs60RRrBzchkNSzpThW8T8Pfk5+pcPi5C0jXSfxC3Vw6KUVKCV7bR2wxsRSlYaWOHSU9nHQ1q8PCCAFaRmhrSUb4M7ALm+lKbE58Nxx+/hBllTJW6vO1qG7leFJx1RJnmCpt6SsWN9aMJTJ07v97eel207qzpYTDMmPb6xl2p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226053>

---
 t/t3401-rebase-partial.sh         | 24 ----------------
 t/t3420-rebase-topology-linear.sh | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 58f4823..7ba1797 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -42,28 +42,4 @@ test_expect_success 'rebase --merge topic branch that was partially merged upstr
 	test_path_is_missing .git/rebase-merge
 '
 
-test_expect_success 'rebase ignores empty commit' '
-	git reset --hard A &&
-	git commit --allow-empty -m empty &&
-	test_commit D &&
-	git rebase C &&
-	test "$(git log --format=%s C..)" = "D"
-'
-
-test_expect_success 'rebase --keep-empty' '
-	git reset --hard D &&
-	git rebase --keep-empty C &&
-	test "$(git log --format=%s C..)" = "D
-empty"
-'
-
-test_expect_success 'rebase --keep-empty keeps empty even if already in upstream' '
-	git reset --hard A &&
-	git commit --allow-empty -m also-empty &&
-	git rebase --keep-empty D &&
-	test "$(git log --format=%s A..)" = "also-empty
-D
-empty"
-'
-
 test_done
diff --git a/t/t3420-rebase-topology-linear.sh b/t/t3420-rebase-topology-linear.sh
index 75cc476..81e3d59 100755
--- a/t/t3420-rebase-topology-linear.sh
+++ b/t/t3420-rebase-topology-linear.sh
@@ -160,4 +160,62 @@ test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase success -p
 
+# a---b---c---j!
+#      \
+#       d---k!--l
+#
+# ! = empty
+test_expect_success 'setup of linear history for empty commit tests' '
+	git checkout c &&
+	make_empty j &&
+	git checkout d &&
+	make_empty k &&
+	test_commit l
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* drops empty commit" "
+		reset_rebase &&
+		git rebase $* c l &&
+		test_cmp_rev c HEAD~2 &&
+		test_linear_range 'd l' c..
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
+	test_expect_$result "rebase $* --keep-empty" "
+		reset_rebase &&
+		git rebase $* --keep-empty c l &&
+		test_cmp_rev c HEAD~3 &&
+		test_linear_range 'd k l' c..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase success -i
+test_run_rebase failure -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --keep-empty keeps empty even if already in upstream" "
+		reset_rebase &&
+		git rebase $* --keep-empty j l &&
+		test_cmp_rev j HEAD~3 &&
+		test_linear_range 'd k l' j..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase failure -i
+test_run_rebase failure -p
+
 test_done
-- 
1.8.2.674.gd17d3d2
