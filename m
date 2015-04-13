From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH v3 4/5] t4202-log: add tests for --merges=
Date: Mon, 13 Apr 2015 17:29:27 +0200
Message-ID: <1428938968-19013-4-git-send-email-koosha@posteo.de>
References: <1428938968-19013-1-git-send-email-koosha@posteo.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 17:30:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhgJp-0002Fc-Pa
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 17:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbbDMPac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 11:30:32 -0400
Received: from mx02.posteo.de ([89.146.194.165]:49918 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932399AbbDMPa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 11:30:29 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 910C025AF504
	for <git@vger.kernel.org>; Mon, 13 Apr 2015 17:30:28 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lQYmh2yLfz5vN2
	for <git@vger.kernel.org>; Mon, 13 Apr 2015 17:30:28 +0200 (CEST)
X-Mailer: git-send-email 2.3.3.263.g095251d.dirty
In-Reply-To: <1428938968-19013-1-git-send-email-koosha@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267087>

From: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 t/t4202-log.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..3edcd81 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -270,6 +270,35 @@ cat > expect <<\EOF
 * initial
 EOF
 
+test_expect_success 'setup merges=' '
+	git log --min-parents=2 --pretty=tformat:%s >expect_only &&
+	git log --max-parents=1 --pretty=tformat:%s >expect_hide &&
+	git log --min-parents=-1 --pretty=tformat:%s >expect_show
+'
+
+test_log_merges() {
+	expect=expect_$1
+	config=${2:+-c log.merges=$2}
+	option=${3:+--merges=$3}
+	option=${4:-$option}
+	test_expect_success "merges${config:+ $config}${option:+ $option}" "
+		git $config log $option --pretty=tformat:%s >actual &&
+		test_cmp $expect actual
+	"
+}
+
+states="show only hide"
+for c in '' $states
+do
+	for o in '' $states
+	do
+		test_log_merges ${o:-${c:-show}} "$c" "$o"
+	done
+done
+
+test_log_merges hide show '' --no-merges
+test_log_merges only hide '' '--merges --max-parents=2'
+
 test_expect_success 'log --graph with merge' '
 	git log --graph --date-order --pretty=tformat:%s |
 		sed "s/ *\$//" >actual &&
-- 
2.3.3.263.g095251d.dirty
