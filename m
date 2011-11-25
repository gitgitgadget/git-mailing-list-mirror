From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] grep: load funcname patterns for -W
Date: Fri, 25 Nov 2011 15:46:18 +0100
Message-ID: <5e3bcf651b31b299ca411296e6e7c4d11f6ae617.1322232319.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 15:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTx2o-0005l1-Vs
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 15:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891Ab1KYOqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 09:46:22 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:23372 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755468Ab1KYOqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 09:46:21 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 25 Nov
 2011 15:46:15 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 25 Nov
 2011 15:46:18 +0100
X-Mailer: git-send-email 1.7.8.rc3.415.gbcbb2
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185932>

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
1.7.8.rc3.415.gbcbb2
