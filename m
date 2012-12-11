From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/2] shortlog: Fix wrapping lines of wraplen (was broken since recent off-by-one fix)
Date: Tue, 11 Dec 2012 06:59:21 +0100
Message-ID: <1355205562-23459-2-git-send-email-prohaska@zib.de>
References: <7v8v97efdv.fsf@alter.siamese.dyndns.org>
 <1355205562-23459-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, "Jan H. Schoenherr" <schnhrr@cs.tu-berlin.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:00:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiItd-0000vB-Te
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 07:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab2LKGAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 01:00:24 -0500
Received: from mailer.zib.de ([130.73.108.11]:61158 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab2LKGAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 01:00:21 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id qBB5xt6i024500;
	Tue, 11 Dec 2012 07:00:00 +0100 (CET)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id qBB5xabO025369;
	Tue, 11 Dec 2012 06:59:55 +0100 (MET)
X-Mailer: git-send-email 1.7.12.1.429.gf87fa45
In-Reply-To: <1355205562-23459-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211282>

A recent commit [1] fixed a off-by-one wrapping error.  As
a side-effect, the conditional in add_wrapped_shortlog_msg() whether to
append a newline needs to be removed.  add_wrapped_shortlog_msg() should
always append a newline, which was the case before the off-by-one fix,
because strbuf_add_wrapped_text() never returned a value of wraplen.

[1] 14e1a4e1ff70aff36db3f5d2a8b806efd0134d50 utf8: fix off-by-one
    wrapping of text

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin/shortlog.c  |  5 ++---
 t/t4201-shortlog.sh | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index b316cf3..8360514 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -306,9 +306,8 @@ parse_done:
 static void add_wrapped_shortlog_msg(struct strbuf *sb, const char *s,
 				     const struct shortlog *log)
 {
-	int col = strbuf_add_wrapped_text(sb, s, log->in1, log->in2, log->wrap);
-	if (col != log->wrap)
-		strbuf_addch(sb, '\n');
+	strbuf_add_wrapped_text(sb, s, log->in1, log->in2, log->wrap);
+	strbuf_addch(sb, '\n');
 }
 
 void shortlog_output(struct shortlog *log)
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 6872ba1..02ac978 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -120,6 +120,30 @@ test_expect_success 'shortlog from non-git directory' '
 	test_cmp expect out
 '
 
+test_expect_success 'shortlog should add newline when input line matches wraplen' '
+	cat >expect <<\EOF &&
+A U Thor (2):
+      bbbbbbbbbbbbbbbbbb: bbbbbbbb bbb bbbb bbbbbbb bb bbbb bbb bbbbb bbbbbb
+      aaaaaaaaaaaaaaaaaaaaaa: aaaaaa aaaaaaaaaa aaaa aaaaaaaa aa aaaa aa aaa
+
+EOF
+	git shortlog -w >out <<\EOF &&
+commit 0000000000000000000000000000000000000001
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    aaaaaaaaaaaaaaaaaaaaaa: aaaaaa aaaaaaaaaa aaaa aaaaaaaa aa aaaa aa aaa
+    
+commit 0000000000000000000000000000000000000002
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    bbbbbbbbbbbbbbbbbb: bbbbbbbb bbb bbbb bbbbbbb bb bbbb bbb bbbbb bbbbbb
+    
+EOF
+	test_cmp expect out
+'
+
 iconvfromutf8toiso88591() {
 	printf "%s" "$*" | iconv -f UTF-8 -t ISO8859-1
 }
-- 
1.8.1.rc1.2.gfb98a3a
