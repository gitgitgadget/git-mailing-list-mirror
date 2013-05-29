From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 2/7] add tests for rebasing with patch-equivalence present
Date: Tue, 28 May 2013 23:39:27 -0700
Message-ID: <1369809572-24431-3-git-send-email-martinvonz@gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
 <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 08:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uha8f-0006m7-5v
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759494Ab3E2Gpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:45:32 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:54791 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab3E2Gpb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:45:31 -0400
Received: by mail-vc0-f202.google.com with SMTP id m17so907895vca.1
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=Kp3SCgheKkrro2bTS8htOHNsSLNlNh5msR7Fiearcyw=;
        b=ArIrBtvI6atxRe4o9qMFkDcEvDn5FFLcHifN2tdUV3/R2bx/NULpu9nSjmP9/vr0Zp
         lwKamh/O6OeWZis6KghoqQ5g4+dbfjpmQNJSB3qsu0xPXzfB/pOHFiDHvkERTQiGhhZN
         X4ug6Xgnv1bF0YIfZYCOPb6+2fVE9m4IYm9QzZxahx7ago0ZHWmRB8MJSkNeLe/gADnr
         tg7xKYjObw9Sh+20nvlRRBmgyomVild/zH+knxTNPML69b+CrgrqNo0xA4ZEOAyP+IzS
         nyl7dJWJ6m2O/nAVucJt0ZN/eK/UBBNwBtYulPzHSdCp5wdz7oC9X1FsgKY7RwFIqgss
         TDYA==
X-Received: by 10.236.151.133 with SMTP id b5mr674223yhk.49.1369809608620;
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id b23si2629977yhj.4.2013.05.28.23.40.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6D4D231C121;
	Tue, 28 May 2013 23:40:08 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 2165B100371; Tue, 28 May 2013 23:40:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlkLyFKwNnWQOrUsR1KA61OMOB+uYQ2Ab3O73rFYYE1UonCk6A40E9TBeSkLEAD1UKkXQbhPbKvqfZRCi8B9pswStlmyAKJ68yp0EvSmYfabDk48HI4uiL3/zKvjYniSS02i7hzojMnanS9Xl9nJrgLqbWQ46pR9PTFjRwrOydie5foRuqyP5cwRJ/rC0RIZ7hgQsXr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225761>

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
index c4b32db..1152491 100755
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
+	test_expect_$result "rebase $* --onto does not lose patches in upstream" "
+		reset_rebase &&
+		git rebase $* --onto f h i &&
+		test_cmp_rev f HEAD~3 &&
+		test_linear_range 'd G i' f..
+	"
+}
+test_run_rebase failure ''
+test_run_rebase success -m
+test_run_rebase failure -i
+test_run_rebase failure -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --onto drops patches in onto" "
+		reset_rebase &&
+		git rebase $* --onto h f i &&
+		test_cmp_rev h HEAD~2 &&
+		test_linear_range 'd i' h..
+	"
+}
+test_run_rebase failure ''
+test_run_rebase failure -m
+test_run_rebase failure -i
+test_run_rebase failure -p
+
 test_done
-- 
1.8.2.674.gd17d3d2
