From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] strbuf_add_wrapped_text(): factor out strbuf_add_indented_text()
Date: Sun, 22 Nov 2009 17:15:29 +0100
Message-ID: <4B0963A1.1010900@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 22 17:15:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCF6C-0000Ak-78
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 17:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283AbZKVQP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 11:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbZKVQPZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 11:15:25 -0500
Received: from india601.server4you.de ([85.25.151.105]:45886 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbZKVQPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 11:15:25 -0500
Received: from [10.0.1.101] (p57B7F129.dip.t-dialin.net [87.183.241.41])
	by india601.server4you.de (Postfix) with ESMTPSA id 8C0B82F8051;
	Sun, 22 Nov 2009 17:15:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133437>

Add a new helper function, strbuf_add_indented_text(), to indent text
without a width limit, and call it from strbuf_add_wrapped_text().  It
respects both indent (applied to the first line) and indent2 (applied to
the rest of the lines); indent2 was ignored by the indent-only path of
strbuf_add_wrapped_text() before the patch.

Two simple test cases are added, one exercising strbuf_add_wrapped_text()
and the other strbuf_add_indented_text().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t4202-log.sh |   21 +++++++++++++++++++++
 utf8.c         |   26 +++++++++++++++++---------
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1e952ca..779a5ad 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -64,6 +64,27 @@ test_expect_success 'format' '
 '
 
 cat > expect << EOF
+ This is
+  the sixth
+  commit.
+ This is
+  the fifth
+  commit.
+EOF
+
+test_expect_success 'format %w(12,1,2)' '
+
+	git log -2 --format="%w(12,1,2)This is the %s commit." > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format %w(,1,2)' '
+
+	git log -2 --format="%w(,1,2)This is%nthe %s%ncommit." > actual &&
+	test_cmp expect actual
+'
+
+cat > expect << EOF
 804a787 sixth
 394ef78 fifth
 5d31159 fourth
diff --git a/utf8.c b/utf8.c
index 5c18f0c..01d1869 100644
--- a/utf8.c
+++ b/utf8.c
@@ -298,6 +298,22 @@ static void print_spaces(struct strbuf *buf, int count)
 	strbuf_write(buf, s, count);
 }
 
+static void strbuf_add_indented_text(struct strbuf *buf, const char *text,
+				     int indent, int indent2)
+{
+	if (indent < 0)
+		indent = 0;
+	while (*text) {
+		const char *eol = strchrnul(text, '\n');
+		if (*eol == '\n')
+			eol++;
+		print_spaces(buf, indent);
+		strbuf_write(buf, text, eol - text);
+		text = eol;
+		indent = indent2;
+	}
+}
+
 /*
  * Wrap the text, if necessary. The variable indent is the indent for the
  * first line, indent2 is the indent for all other lines.
@@ -311,15 +327,7 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
 	const char *bol = text, *space = NULL;
 
 	if (width <= 0) {
-		/* just indent */
-		while (*text) {
-			const char *eol = strchrnul(text, '\n');
-			if (*eol == '\n')
-				eol++;
-			print_spaces(buf, indent);
-			strbuf_write(buf, text, eol-text);
-			text = eol;
-		}
+		strbuf_add_indented_text(buf, text, indent, indent2);
 		return 1;
 	}
 
-- 
1.6.5.3
