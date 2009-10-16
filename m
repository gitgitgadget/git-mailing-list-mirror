From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] grep: do not segfault when -f is used
Date: Fri, 16 Oct 2009 07:13:25 -0700
Message-ID: <1255702405-7050-1-git-send-email-kraai@ftbfs.org>
References: <4AD8791A.8060500@viscovery.net>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org, gitster@pobox.com,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 16 16:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyncG-00041E-97
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760076AbZJPOQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 10:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760069AbZJPOQz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:16:55 -0400
Received: from zoom.lafn.org ([206.117.18.8]:35287 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760067AbZJPOQy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:16:54 -0400
Received: from macbookpro (pool-173-51-225-123.lsanca.fios.verizon.net [173.51.225.123])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id n9GEG65T070203
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Oct 2009 07:16:09 -0700 (PDT)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by macbookpro with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1MynYh-0001qM-0H; Fri, 16 Oct 2009 07:13:31 -0700
X-Mailer: git-send-email 1.6.5
In-Reply-To: <4AD8791A.8060500@viscovery.net>
X-Virus-Scanned: clamav-milter 0.95.1 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130488>

"git grep" would segfault if its -f option was used because it would
try to use an uninitialized strbuf, so initialize the strbuf.

Thanks to Johannes Sixt <j.sixt@viscovery.net> for the help with the
test cases.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 builtin-grep.c  |    2 +-
 t/t7002-grep.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletions(-)

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
index ae56a36..ae5290a 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -213,6 +213,72 @@ test_expect_success 'grep -e A --and --not -e B' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep -f, non-existent file' '
+	test_must_fail git grep -f patterns
+'
+
+cat >expected <<EOF
+file:foo mmap bar
+file:foo_mmap bar
+file:foo_mmap bar mmap
+file:foo mmap bar_mmap
+file:foo_mmap bar mmap baz
+EOF
+
+cat >pattern <<EOF
+mmap
+EOF
+
+test_expect_success 'grep -f, one pattern' '
+	git grep -f pattern >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+file:foo mmap bar
+file:foo_mmap bar
+file:foo_mmap bar mmap
+file:foo mmap bar_mmap
+file:foo_mmap bar mmap baz
+t/a/v:vvv
+t/v:vvv
+v:vvv
+EOF
+
+cat >patterns <<EOF
+mmap
+vvv
+EOF
+
+test_expect_success 'grep -f, multiple patterns' '
+	git grep -f patterns >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+file:foo mmap bar
+file:foo_mmap bar
+file:foo_mmap bar mmap
+file:foo mmap bar_mmap
+file:foo_mmap bar mmap baz
+t/a/v:vvv
+t/v:vvv
+v:vvv
+EOF
+
+cat >patterns <<EOF
+
+mmap
+
+vvv
+
+EOF
+
+test_expect_success 'grep -f, ignore empty lines' '
+	git grep -f patterns >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 y:y yy
 --
-- 
1.6.5
