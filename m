From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 1/3] grep: load funcname patterns for -W
Date: Mon, 12 Dec 2011 22:16:06 +0100
Message-ID: <5abfcd11512c0118465459dd8cf43980aec7ceee.1323723759.git.trast@student.ethz.ch>
References: <cover.1323723759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>, Eric Herman <eric@freesa.org>
To: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:16:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDER-0004dm-Q0
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042Ab1LLVQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:16:14 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:7152 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643Ab1LLVQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:16:13 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 22:16:08 +0100
Received: from thomas.inf.ethz.ch (129.132.208.62) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 22:16:10 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323723759.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.208.62]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186950>

git-grep avoids loading the funcname patterns unless they are needed.
ba8ea74 (grep: add option to show whole function as context,
2011-08-01) forgot to extend this test also to the new funcbody
feature.  Do so.

The catch is that we also have to disable threading when using
userdiff, as explained in grep_threads_ok().  So we must be careful to
introduce the same test there.
---
 grep.c          |    7 ++++---
 t/t7810-grep.sh |   14 ++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index b29d09c..7a070e9 100644
--- a/grep.c
+++ b/grep.c
@@ -948,8 +948,8 @@ int grep_threads_ok(const struct grep_opt *opt)
 	 * machinery in grep_buffer_1. The attribute code is not
 	 * thread safe, so we disable the use of threads.
 	 */
-	if (opt->funcname && !opt->unmatch_name_only && !opt->status_only &&
-	    !opt->name_only)
+	if ((opt->funcname || opt->funcbody)
+	    && !opt->unmatch_name_only && !opt->status_only && !opt->name_only)
 		return 0;
 
 	return 1;
@@ -1008,7 +1008,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	}
 
 	memset(&xecfg, 0, sizeof(xecfg));
-	if (opt->funcname && !opt->unmatch_name_only && !opt->status_only &&
+	if ((opt->funcname || opt->funcbody)
+	    && !opt->unmatch_name_only && !opt->status_only &&
 	    !opt->name_only && !binary_match_only && !collect_hits) {
 		struct userdiff_driver *drv = userdiff_find_by_path(name);
 		if (drv && drv->funcname.pattern) {
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 81263b7..7ba5b16 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -523,6 +523,20 @@ test_expect_success 'grep -W' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+hello.c=	printf("Hello world.\n");
+hello.c:	return 0;
+hello.c-	/* char ?? */
+EOF
+
+test_expect_success 'grep -W with userdiff' '
+	test_when_finished "rm -f .gitattributes" &&
+	git config diff.custom.xfuncname "(printf.*|})$" &&
+	echo "hello.c diff=custom" >.gitattributes &&
+	git grep -W return >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'grep from a subdirectory to search wider area (1)' '
 	mkdir -p s &&
 	(
-- 
1.7.8.431.g2abf2
