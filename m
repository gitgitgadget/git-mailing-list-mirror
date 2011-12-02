From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/3] grep: load funcname patterns for -W
Date: Fri, 2 Dec 2011 14:07:46 +0100
Message-ID: <5e3bcf651b31b299ca411296e6e7c4d11f6ae617.1322830368.git.trast@student.ethz.ch>
References: <cover.1322830368.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Herman <eric@freesa.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Dec 02 14:08:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWSqX-000567-9M
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 14:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab1LBNIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 08:08:00 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:3814 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409Ab1LBNHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 08:07:51 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Dec
 2011 14:07:47 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Dec
 2011 14:07:48 +0100
X-Mailer: git-send-email 1.7.8.rc4.388.ge53ab
In-Reply-To: <cover.1322830368.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186216>

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
1.7.8.rc4.388.ge53ab
