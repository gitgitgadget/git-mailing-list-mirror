From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 41/45] add tests for rebasing root
Date: Sun,  9 Jun 2013 11:40:53 -0500
Message-ID: <1370796057-25312-42-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:45:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulije-0007a8-Ua
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab3FIQov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:51 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:59377 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab3FIQoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:46 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so9041771obb.29
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NoLOk0+Kfn+7H7JKbgNNXmxwxISCUkvIV1WW4XBVzek=;
        b=kvBObhKvZGpqivhdVPMtQwMgjCxnaKTjxGH02BORTn+IJ6xqsdhiWD52hZknxI8xVn
         aQl++M17O6vAstGrms9kCPsdh685J75v/hH2Te2JaxYbPw9Ow3a4qbs1KXrtAOf6THpm
         zLWOR5lmYnBk6TUSzwYXDQZJoe77gn2hViFaBosqnNvadq8+Z2iZX1cGt6IfhxbXRrzf
         FtjSgFEQ3gqmECwtI6JNStP1qWxGUrKs5zdy5IW5W2bH44VSW4bTSUlUiIJd6Eufy+8Z
         aryeFgzxvdYa8bC/SFTD5cuFBKJOo0cErXj20YhQMUqJvGQKVNO9xnZuF8CpIsY1TN1F
         TxIQ==
X-Received: by 10.60.80.103 with SMTP id q7mr5170499oex.135.1370796286460;
        Sun, 09 Jun 2013 09:44:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm15199818oel.2.2013.06.09.09.44.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227009>

From: Martin von Zweigbergk <martinvonz@gmail.com>

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3421-rebase-topology-linear.sh | 129 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index f19f0d0..e67add6 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -218,4 +218,133 @@ test_run_rebase failure -m
 test_run_rebase failure -i
 test_run_rebase failure -p
 
+#       m
+#      /
+# a---b---c---g
+#
+# x---y---B
+#
+# uppercase = cherry-picked
+# m = reverted b
+#
+# Reverted patches are there for tests to be able to check if a commit
+# that introduced the same change as another commit is
+# dropped. Without reverted commits, we could get false positives
+# because applying the patch succeeds, but simply results in no
+# changes.
+test_expect_success 'setup of linear history for test involving root' '
+	git checkout b &&
+	revert m b &&
+	git checkout --orphan disjoint &&
+	git rm -rf . &&
+	test_commit x &&
+	test_commit y &&
+	cherry_pick B b
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --onto --root" "
+		reset_rebase &&
+		git rebase $* --onto c --root y &&
+		test_cmp_rev c HEAD~2 &&
+		test_linear_range 'x y' c..
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
+	test_expect_$result "rebase $* without --onto --root with disjoint history" "
+		reset_rebase &&
+		git rebase $* c y &&
+		test_cmp_rev c HEAD~2 &&
+		test_linear_range 'x y' c..
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
+	test_expect_$result "rebase $* --onto --root drops patch in onto" "
+		reset_rebase &&
+		git rebase $* --onto m --root B &&
+		test_cmp_rev m HEAD~2 &&
+		test_linear_range 'x y' m..
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
+	test_expect_$result "rebase $* --onto --root with merge-base does not go to root" "
+		reset_rebase &&
+		git rebase $* --onto m --root g &&
+		test_cmp_rev m HEAD~2 &&
+		test_linear_range 'c g' m..
+	"
+}
+
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase failure -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* without --onto --root with disjoint history drops patch in onto" "
+		reset_rebase &&
+		git rebase $* m B &&
+		test_cmp_rev m HEAD~2 &&
+		test_linear_range 'x y' m..
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
+	test_expect_$result "rebase $* --root on linear history is a no-op" "
+		reset_rebase &&
+		git rebase $* --root c &&
+		test_cmp_rev c HEAD
+	"
+}
+test_run_rebase failure ''
+test_run_rebase failure -m
+test_run_rebase failure -i
+test_run_rebase failure -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* -f --root on linear history causes re-write" "
+		reset_rebase &&
+		git rebase $* -f --root c &&
+		! test_cmp_rev a HEAD~2 &&
+		test_linear_range 'a b c' HEAD
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
 test_done
-- 
1.8.3.698.g079b096
