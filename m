From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH v2 4/5] t4202-log: add tests for --merges=
Date: Sat,  4 Apr 2015 03:22:00 +0200
Message-ID: <1428110521-31028-4-git-send-email-koosha@posteo.de>
References: <266077>
 <1428110521-31028-1-git-send-email-koosha@posteo.de>
Cc: sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 03:23:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeCnv-0008AK-OF
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 03:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbbDDBXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 21:23:06 -0400
Received: from mx02.posteo.de ([89.146.194.165]:60066 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244AbbDDBXD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 21:23:03 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id CD4F325AF530;
	Sat,  4 Apr 2015 03:23:00 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lJgP04wzTz5vN9;
	Sat,  4 Apr 2015 03:23:00 +0200 (CEST)
X-Mailer: git-send-email 2.3.3.263.g095251d.dirty
In-Reply-To: <1428110521-31028-1-git-send-email-koosha@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266756>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 t/t4202-log.sh | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..ceaaf4e 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -270,6 +270,90 @@ cat > expect <<\EOF
 * initial
 EOF
 
+test_expect_success 'setup --merges=' '
+	git log --min-parents=2 --pretty=tformat:%s >expect_only &&
+	git log --max-parents=1 --pretty=tformat:%s >expect_hide &&
+	git log --min-parents=-1 --pretty=tformat:%s >expect_show
+'
+
+test_expect_success 'log with config log.merges=show' '
+	test_config log.merges show &&
+	git log --pretty=tformat:%s >actual &&
+	test_cmp expect_show actual
+'
+
+test_expect_success 'log with config log.merges=only' '
+	test_config log.merges only &&
+	git log --pretty=tformat:%s >actual &&
+	test_cmp expect_only actual
+'
+
+test_expect_success 'log with config log.merges=hide' '
+	test_config log.merges hide &&
+	git log --pretty=tformat:%s >actual &&
+	test_cmp expect_hide actual
+'
+
+test_expect_success 'log with config log.merges=show with git log --no-merges' '
+	test_config log.merges show &&
+	git log --no-merges --pretty=tformat:%s >actual &&
+	test_cmp expect_hide actual
+'
+
+test_expect_success 'log with config log.merges=hide with git log ---merges' '
+	test_config log.merges hide &&
+	git log --merges --pretty=tformat:%s >actual &&
+	test ! -s actual
+'
+
+test_expect_success 'log --merges=show' '
+	test_unconfig log.merges &&
+	git log --merges=show --pretty=tformat:%s >actual &&
+	test_cmp expect_show actual
+'
+
+test_expect_success 'log --merges=only' '
+	test_unconfig log.merges &&
+	git log --merges=only --pretty=tformat:%s >actual &&
+	test_cmp expect_only actual
+'
+
+test_expect_success 'log --merges=hide' '
+	test_unconfig log.merges &&
+	git log --merges=hide --pretty=tformat:%s >actual &&
+	test_cmp expect_hide actual
+'
+
+test_log_merges() {
+	test_config log.merges $2 &&
+	git log --merges=$1 --pretty=tformat:%s >actual &&
+	test_cmp $3 actual
+}
+
+test_expect_success 'log --merges=show with config log.merges=hide' '
+	test_log_merges show hide expect_show
+'
+
+test_expect_success 'log --merges=show with config log.merges=only' '
+	test_log_merges show only expect_show
+'
+
+test_expect_success 'log --merges=only with config log.merges=show' '
+	test_log_merges only show expect_only
+'
+
+test_expect_success 'log --merges=only with config log.merges=hide' '
+	test_log_merges only hide expect_only
+'
+
+test_expect_success 'log --merges=hide with config log.merges=show' '
+	test_log_merges hide show expect_hide
+'
+
+test_expect_success 'log --merges=hide with config log.merges=only' '
+	test_log_merges hide only expect_hide
+'
+
 test_expect_success 'log --graph with merge' '
 	git log --graph --date-order --pretty=tformat:%s |
 		sed "s/ *\$//" >actual &&
-- 
2.3.3.263.g095251d.dirty
