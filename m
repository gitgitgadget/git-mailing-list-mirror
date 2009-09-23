From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] Add strbuf_add_wrapped_text() to utf8.[ch]
Date: Wed, 23 Sep 2009 22:34:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909232233330.4985@pacific.mpi-cbg.de>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org> <1253655038-20335-1-git-send-email-heipei@hackvalue.de> <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Gilger <heipei@hackvalue.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:32:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqYWG-0007JZ-Lf
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 22:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbZIWUct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 16:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbZIWUct
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 16:32:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:36908 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751767AbZIWUcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 16:32:48 -0400
Received: (qmail invoked by alias); 23 Sep 2009 20:32:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 23 Sep 2009 22:32:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/q3tIyrlDqXgLOLTpZcfkGkmO2gICs4KeCn3Cy18
	bap5N1s1J9z1Uk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128996>


The newly added function can rewrap text according to a given first-line
indent, other-indent and text width.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 utf8.c |   33 ++++++++++++++++++++++++---------
 utf8.h |    2 ++
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/utf8.c b/utf8.c
index 589876b..7383a70 100644
--- a/utf8.c
+++ b/utf8.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "strbuf.h"
 #include "utf8.h"
 
 /* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
@@ -279,14 +280,22 @@ int is_utf8(const char *text)
 	return 1;
 }
 
-static void print_spaces(int count)
+static inline void strbuf_write(struct strbuf *sb, const char *buf, int len)
+{
+	if (sb)
+		strbuf_insert(sb, sb->len, buf, len);
+	else
+		fwrite(buf, len, 1, stdout);
+}
+
+static void print_spaces(struct strbuf *buf, int count)
 {
 	static const char s[] = "                    ";
 	while (count >= sizeof(s)) {
-		fwrite(s, sizeof(s) - 1, 1, stdout);
+		strbuf_write(buf, s, sizeof(s) - 1);
 		count -= sizeof(s) - 1;
 	}
-	fwrite(s, count, 1, stdout);
+	strbuf_write(buf, s, count);
 }
 
 /*
@@ -295,7 +304,8 @@ static void print_spaces(int count)
  * If indent is negative, assume that already -indent columns have been
  * consumed (and no extra indent is necessary for the first line).
  */
-int print_wrapped_text(const char *text, int indent, int indent2, int width)
+int strbuf_add_wrapped_text(struct strbuf *buf,
+		const char *text, int indent, int indent2, int width)
 {
 	int w = indent, assume_utf8 = is_utf8(text);
 	const char *bol = text, *space = NULL;
@@ -315,8 +325,8 @@ int print_wrapped_text(const char *text, int indent, int indent2, int width)
 				if (space)
 					start = space;
 				else
-					print_spaces(indent);
-				fwrite(start, text - start, 1, stdout);
+					print_spaces(buf, indent);
+				strbuf_write(buf, start, text - start);
 				if (!c)
 					return w;
 				space = text;
@@ -325,18 +335,18 @@ int print_wrapped_text(const char *text, int indent, int indent2, int width)
 				else if (c == '\n') {
 					space++;
 					if (*space == '\n') {
-						putchar('\n');
+						strbuf_write(buf, "\n", 1);
 						goto new_line;
 					}
 					else
-						putchar(' ');
+						strbuf_write(buf, " ", 1);
 				}
 				w++;
 				text++;
 			}
 			else {
 new_line:
-				putchar('\n');
+				strbuf_write(buf, "\n", 1);
 				text = bol = space + isspace(*space);
 				space = NULL;
 				w = indent = indent2;
@@ -352,6 +362,11 @@ new_line:
 	}
 }
 
+int print_wrapped_text(const char *text, int indent, int indent2, int width)
+{
+	return strbuf_add_wrapped_text(NULL, text, indent, indent2, width);
+}
+
 int is_encoding_utf8(const char *name)
 {
 	if (!name)
diff --git a/utf8.h b/utf8.h
index 2f1b14f..ae30ae4 100644
--- a/utf8.h
+++ b/utf8.h
@@ -10,6 +10,8 @@ int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 
 int print_wrapped_text(const char *text, int indent, int indent2, int len);
+int strbuf_add_wrapped_text(struct strbuf *buf,
+		const char *text, int indent, int indent2, int width);
 
 #ifndef NO_ICONV
 char *reencode_string(const char *in, const char *out_encoding, const char *in_encoding);
-- 
1.6.4.297.gcb4cc
