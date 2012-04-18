From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v4 4/4] Prevent graph_width of stat width from falling below min
Date: Wed, 18 Apr 2012 14:12:18 -0700
Message-ID: <1334783544-31311-1-git-send-email-lucian.poston@gmail.com>
References: <1334716196-9870-4-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 23:12:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKcBF-000752-H4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 23:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab2DRVMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 17:12:45 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:53641 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab2DRVMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 17:12:44 -0400
Received: by dake40 with SMTP id e40so10396735dak.11
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8kHz5Jt5qbvkflxKsqqjr+OsOE9QTuSpkkZtJGtqHK8=;
        b=EEfBCVNJvrizJLdkLYiEnUEMnsc13ud5EAl5Z+bRyo99YRfCj0r7BgTGVmRd8FYvcR
         0iwTjvbSLjpTOtGJ05PUaakJOZRzvgd47QEhr9WWv2I/TdMJHuQTy3hvkLrEWhYrbGZt
         ojMX0Ik7LDxW/A+LGjbILl2v+60kjp37zuI+mzj9Q49Mv6Cw7BenDuI++5GP0diOxi3G
         SydEfuO53oyVNffLvby0bIJK5m1q8HR4zvGEdYaQr8mR3OX92Yr3e7llHyp3Ackvo0ho
         mcF80+OGhL4zVpV6rGKDJzDWg05w5p07EnkR9r9CXwsxxa8Ddb1/i2ZC/IN63MZwPBfA
         7ozg==
Received: by 10.68.203.9 with SMTP id km9mr9306865pbc.94.1334783564042;
        Wed, 18 Apr 2012 14:12:44 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id d4sm181351pbr.32.2012.04.18.14.12.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 14:12:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334716196-9870-4-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195908>

Update tests in t4052 fixed by this change.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 diff.c                 |    6 +++++-
 t/t4052-stat-output.sh |   14 +++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 0b61cf7..f08b41a 100644
--- a/diff.c
+++ b/diff.c
@@ -1473,8 +1473,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * Adjust adjustable widths not to exceed maximum width
 	 */
 	if (name_width + number_width + 6 + graph_width > width) {
-		if (graph_width > width * 3/8 - number_width - 6)
+		if (graph_width > width * 3/8 - number_width - 6) {
 			graph_width = width * 3/8 - number_width - 6;
+			if (graph_width < 6)
+				graph_width = 6;
+		}
+
 		if (options->stat_graph_width &&
 		    graph_width > options->stat_graph_width)
 			graph_width = options->stat_graph_width;
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index b8eec8f..ced32db 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -290,9 +290,9 @@ EOF
 cat >expect1-graph <<'EOF'
 |  ...aaaaaaa | 1000 ++++++
 EOF
-while read teststate verb expect cmd args
+while read verb expect cmd args
 do
-	test_expect_$teststate "$cmd $verb prefix greater than COLUMNS (big change)" '
+	test_expect_success "$cmd $verb prefix greater than COLUMNS (big change)" '
 		COLUMNS=1 git $cmd $args >output
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
@@ -300,16 +300,16 @@ do
 
 	test "$cmd" != diff || continue
 
-	test_expect_$teststate "$cmd --graph $verb prefix greater than COLUMNS (big change)" '
+	test_expect_success "$cmd --graph $verb prefix greater than COLUMNS (big change)" '
 		COLUMNS=1 git $cmd $args --graph >output
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
 done <<\EOF
-success ignores expect80 format-patch -1 --stdout
-failure respects expect1 diff HEAD^ HEAD --stat
-failure respects expect1 show --stat
-failure respects expect1 log -1 --stat
+ignores expect80 format-patch -1 --stdout
+respects expect1 diff HEAD^ HEAD --stat
+respects expect1 show --stat
+respects expect1 log -1 --stat
 EOF
 
 cat >expect <<'EOF'
-- 
1.7.3.4
