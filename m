From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v5 3/7] add tests for rebasing of empty commits
Date: Mon,  3 Jun 2013 13:42:11 -0700
Message-ID: <1370292135-1236-4-git-send-email-martinvonz@gmail.com>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
 <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 03 22:42:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbaW-0000k0-TR
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289Ab3FCUmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:42:38 -0400
Received: from mail-ye0-f202.google.com ([209.85.213.202]:36669 "EHLO
	mail-ye0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757699Ab3FCUm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:42:27 -0400
Received: by mail-ye0-f202.google.com with SMTP id r11so295150yen.3
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=ILFe3/Jt5PSy7xV0AQMJNX+PQrbLCJcZzHhqstHhJTQ=;
        b=f8jktUodPxNKu4DS4nu8J8lCkL68v4avJEdhXz5z8VY+Xs+XcI/Bp6VbO0GobhTaLe
         r9Ao6Puk8UT86Htgg3Gb5LgYCyN8U0y0RKgDV7AQRsd+QYFau6P5HnxwlqvrT/CbEY2u
         EAogvXHLchmPiB0bZxjU1eAT6JfTAOQhmhUhdwwulMnJ7KcL+mAvIfLJE86yR2PEkIwh
         HK2XewBYPBNhsdR5r7DEOgXNS3vnaSQ+uGBxah91UJNFR4rPWFqItm2oIlZZ2FdTpuZE
         J0iWb6Y4MOw5llIP7pRtOXgxkD27riZPNpPzX4hGXrl/tioDyrr3cEdUdlG6Ntm4hUZ3
         zaqw==
X-Received: by 10.236.80.106 with SMTP id j70mr13800612yhe.11.1370292146591;
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r76si4037533yhe.2.2013.06.03.13.42.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6A5A55A429D;
	Mon,  3 Jun 2013 13:42:26 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 97690101AB5; Mon,  3 Jun 2013 13:42:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQn0gRBsBAPhPALbPCOeoZ3V8lLxWV1Bi8tBGp9SBxrXj3u6OkxYKAkquUZG7ufpIfQ9QczwFHScyhUfjTSzy2oj+cY+cstGj1ziUrQlC4XobZyUmdt3etDqReT6/O8Ige4wp3ZLxFfkogZFU0C259bu9yiU/5mhwnvHiAhy5tdyiX9gWdn+h/3ywRQ8OaK+oxDXMJJR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226285>

---
 t/t3401-rebase-partial.sh         | 24 ----------------
 t/t3421-rebase-topology-linear.sh | 58 +++++++++++++++++++++++++++++++++++++++
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
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 75cc476..81e3d59 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
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
1.8.3.497.g83fddbe
