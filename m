From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v3 1/7] add simple tests of consistency across rebase types
Date: Thu, 30 May 2013 23:49:41 -0700
Message-ID: <1369982987-18954-2-git-send-email-martinvonz@gmail.com>
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
	id 1UiJAH-0000co-14
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 08:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab3EaGuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 02:50:12 -0400
Received: from mail-gg0-f202.google.com ([209.85.161.202]:41371 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab3EaGuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 02:50:04 -0400
Received: by mail-gg0-f202.google.com with SMTP id o1so112834ggn.3
        for <git@vger.kernel.org>; Thu, 30 May 2013 23:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=bKNN+QHV3zJpwue1lQgFL44Un1BX05o0Z6aDJKXwNQY=;
        b=nGcs68dniFKDjmPKYMjzIZCg4J1qvjfXpoLlTkWqudVybHp+T4L3NK5ZNaY8YkP/yT
         AS7w1ZqNmz3//Qu/vFkwCJkZqIOGIDG1Z4FKDYQP/7/pLQlEatFdSBgLdhaySYfqlqe+
         aZP41aTrYUjMN9f+1gzdhZ+xIip8kXm5aO30Q3vWoYzGz0UHqwhfHGqYUJgUOq1wvQfl
         YWt8CLNY/deLUergguGXnPG4nfwYBs37blm3cax7vJ1W64UQcsBM3LcgbXvhNOeX+rBw
         E5yreW/BwSmCGFLwILuJhGcw38b3Tg0JbXCc/MqhKxuRLdDKhkquN0hsuvwy2LYiIf0b
         27Og==
X-Received: by 10.236.231.10 with SMTP id k10mr5717131yhq.30.1369983003443;
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y4si2042755yhi.3.2013.05.30.23.50.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 38F8331C1B9;
	Thu, 30 May 2013 23:50:03 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id DA3B8100D20; Thu, 30 May 2013 23:50:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlflmFuZ1AW8i4sBS8sC2fKSJx6xYqlUjxaYznLGXUGMvs9Jo48gTQl2yyT53FBZDTyOOn2t/VazOY0QzE/LW8vhBcY0V1A4yAcou+cFXjGP5znvTUJPsndDksuma/zppMDZ+m0hh3iMnyXUnxzpMPYGzs9TfCvNNtNJd+tf/mDbTIcfKEfJDZd2QzWg/IWCTNJ91aS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226051>

Helped-by: Johannes Sixt <j6t@kdbg.org>
---
 t/lib-rebase.sh                   | 15 ++++++++
 t/t3420-rebase-topology-linear.sh | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100755 t/t3420-rebase-topology-linear.sh

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
diff --git a/t/t3420-rebase-topology-linear.sh b/t/t3420-rebase-topology-linear.sh
new file mode 100755
index 0000000..c4b32db
--- /dev/null
+++ b/t/t3420-rebase-topology-linear.sh
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
1.8.2.674.gd17d3d2
