From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 40/45] add tests for rebasing of empty commits
Date: Sun,  9 Jun 2013 11:40:52 -0500
Message-ID: <1370796057-25312-41-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulijd-0007a8-TB
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553Ab3FIQoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:46 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33484 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab3FIQoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:44 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8804229obc.6
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=R9ThLhlLbHbjb7Ys2nWPedpDBdrvSEJ6KRmDVJUkmcg=;
        b=0lSj5dwKEft/DMtxzk+lszCYw+06svwf6/erVOaCzOi5FjQcrgD8jYvkFdmzzvFKl+
         VHWlsPCiF3siTaxIEv5PUDI5OyB8z3yHPUbqLGthuFae/BWbuBpafWR8ZU1ZRDtTXD/7
         Bp7gSeg8KEGmldSu3Y9iJhBj5Dr2BQnPPygEUOMGTbXemtaAXd38xA1/kJsn8s7LlUzt
         eLVXAGdOrEjt3L0RXwzUvMpGMDKchfFZXAw5AfTJKWtrP/ZD9flSEe8SsMvCYGvDE3il
         GYjnSBYUsREjpFgB7qUmHU2rt4KgoRgL5gGWu+4Qr7CNpig07vpLyvfUc4Eiaj27z5gi
         KMaQ==
X-Received: by 10.182.40.202 with SMTP id z10mr5238409obk.74.1370796283790;
        Sun, 09 Jun 2013 09:44:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm14896857obx.9.2013.06.09.09.44.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227007>

From: Martin von Zweigbergk <martinvonz@gmail.com>

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index ddcbfc6..f19f0d0 100755
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
1.8.3.698.g079b096
