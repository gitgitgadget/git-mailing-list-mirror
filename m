From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] grep: do not segfault when -f is used
Date: Fri, 16 Oct 2009 01:53:24 -0700
Message-ID: <1255683204-28988-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 16 11:09:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myioj-00053t-44
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 11:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427AbZJPJDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 05:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbZJPJC7
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 05:02:59 -0400
Received: from zoom.lafn.org ([206.117.18.8]:40737 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbZJPJC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 05:02:59 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Oct 2009 05:02:59 EDT
Received: from macbookpro (pool-173-51-225-123.lsanca.fios.verizon.net [173.51.225.123])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id n9G8u1Ux062960
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Oct 2009 01:56:01 -0700 (PDT)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by macbookpro with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1MyiYv-0000XQ-Kd; Fri, 16 Oct 2009 01:53:25 -0700
X-Mailer: git-send-email 1.6.5
X-Virus-Scanned: clamav-milter 0.95.1 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130470>

"git grep" would segfault if its -f option was used because it would
try to use an uninitialized strbuf, so initialize the strbuf.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 builtin-grep.c  |    2 +-
 t/t7002-grep.sh |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 761799d..1df25b0 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -631,7 +631,7 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 	struct grep_opt *grep_opt = opt->value;
 	FILE *patterns;
 	int lno = 0;
-	struct strbuf sb;
+	struct strbuf sb = STRBUF_INIT;
 
 	patterns = fopen(arg, "r");
 	if (!patterns)
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index ae56a36..762f815 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -44,6 +44,10 @@ test_expect_success 'grep should not segfault with a bad input' '
 	test_must_fail git grep "("
 '
 
+test_expect_success 'grep should not segfault with -f' '
+        test_must_fail git grep -f /dev/null
+'
+
 for H in HEAD ''
 do
 	case "$H" in
-- 
1.6.5
