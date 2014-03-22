From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 06/10] pickaxe: honor -i when used with -S and --pickaxe-regex
Date: Sat, 22 Mar 2014 18:15:56 +0100
Message-ID: <1395508560-19893-7-git-send-email-l.s.r@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPXN-00025U-9R
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbaCVRQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:42 -0400
Received: from mout.web.de ([212.227.15.4]:59225 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbaCVRQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:35 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MN4K8-1WTdWf1zbs-006dmf; Sat, 22 Mar 2014 18:16:21
 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
X-Provags-ID: V03:K0:06ymekJ9uue8104R1cCexSMylVG5RQfkuaCY4ZLfyAy/w1SgtVP
 xGW3NbWmaXyaPQqFoEuSSr0iVgwAmzQZicGvboO6kUylypPKI9gsvFIDa4MM2BPh1pTgtws
 VkWYw3PgAg91klJBO5Xo7Wku7+mpJ8C/ersClBsCnTBWCAjYgQ1LB0irDU+zseyPiW7uHtY
 z2DgIGj41h6keDYGjOdow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244774>

accccde4 (pickaxe: allow -i to search in patch case-insensitively)
allowed case-insenitive matching for -G and -S, but for the latter
only if fixed string matching is used.  Allow it for -S and regular
expression matching as well to make the support complete.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diffcore-pickaxe.c     | 5 ++++-
 t/t4209-log-pickaxe.sh | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 401eb72..cb75851 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -237,7 +237,10 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 
 	if (opts & DIFF_PICKAXE_REGEX) {
 		int err;
-		err = regcomp(&regex, needle, REG_EXTENDED | REG_NEWLINE);
+		int cflags = REG_EXTENDED | REG_NEWLINE;
+		if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
+			cflags |= REG_ICASE;
+		err = regcomp(&regex, needle, cflags);
 		if (err) {
 			/* The POSIX.2 people are surely sick */
 			char errbuf[1024];
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 80aabe2..a31388f 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -79,6 +79,11 @@ test_log	expect_second	-S Picked
 test_log_icase	expect_second	-S picked
 test_log_icase	expect_nomatch	-S pickle
 
+test_log	expect_nomatch	-S p.cked --pickaxe-regex
+test_log	expect_second	-S P.cked --pickaxe-regex
+test_log_icase	expect_second	-S p.cked --pickaxe-regex
+test_log_icase	expect_nomatch	-S p.ckle --pickaxe-regex
+
 test_expect_success 'log -S --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
 	test_must_fail git -c diff.test.textconv=missing log -Sfoo &&
-- 
1.9.1
