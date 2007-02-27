From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Actually make print_wrapped_text() useful
Date: Tue, 27 Feb 2007 16:20:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271619350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net
To: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 16:20:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM484-0004CY-4Q
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbXB0PUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbXB0PUd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:20:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:34356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932081AbXB0PUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:20:32 -0500
Received: (qmail invoked by alias); 27 Feb 2007 15:20:31 -0000
X-Provags-ID: V01U2FsdGVkX18v7JgSalQvdL4qlZMbus7mfTnTNkaiP+RsCq2vwx
	752g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40743>


Now, it returns the current column, does not add a newline, and you can
pass a negative indent, to indicate that the indent was already printed.

With this, you can actually continue in the middle of a paragraph, not
having to print everything into a buffer first.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 utf8.c |   17 ++++++++++++-----
 utf8.h |    2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/utf8.c b/utf8.c
index 7c80eec..ea23a6e 100644
--- a/utf8.c
+++ b/utf8.c
@@ -235,12 +235,19 @@ static void print_spaces(int count)
 /*
  * Wrap the text, if necessary. The variable indent is the indent for the
  * first line, indent2 is the indent for all other lines.
+ * If indent is negative, assume that already -indent columns have been
+ * consumed (and no extra indent is necessary for the first line).
  */
-void print_wrapped_text(const char *text, int indent, int indent2, int width)
+int print_wrapped_text(const char *text, int indent, int indent2, int width)
 {
 	int w = indent, assume_utf8 = is_utf8(text);
 	const char *bol = text, *space = NULL;
 
+	if (indent < 0) {
+		w = -indent;
+		space = text;
+	}
+
 	for (;;) {
 		char c = *text;
 		if (!c || isspace(c)) {
@@ -251,10 +258,9 @@ void print_wrapped_text(const char *text, int indent, int indent2, int width)
 				else
 					print_spaces(indent);
 				fwrite(start, text - start, 1, stdout);
-				if (!c) {
-					putchar('\n');
-					return;
-				} else if (c == '\t')
+				if (!c)
+					return w;
+				else if (c == '\t')
 					w |= 0x07;
 				space = text;
 				w++;
@@ -275,6 +281,7 @@ void print_wrapped_text(const char *text, int indent, int indent2, int width)
 			text++;
 		}
 	}
+	return w;
 }
 
 int is_encoding_utf8(const char *name)
diff --git a/utf8.h b/utf8.h
index a07c5a8..15db6f1 100644
--- a/utf8.h
+++ b/utf8.h
@@ -5,7 +5,7 @@ int utf8_width(const char **start);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 
-void print_wrapped_text(const char *text, int indent, int indent2, int len);
+int print_wrapped_text(const char *text, int indent, int indent2, int len);
 
 #ifndef NO_ICONV
 char *reencode_string(const char *in, const char *out_encoding, const char *in_encoding);
-- 
1.5.0.2.2410.g737b
