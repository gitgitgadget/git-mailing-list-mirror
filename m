From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] libgit.a: add some UTF-8 handling functions
Date: Fri, 22 Dec 2006 22:03:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 22:04:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxrYc-0004Gk-CH
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbWLVVDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 16:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbWLVVDz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:03:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:59588 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752703AbWLVVDz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 16:03:55 -0500
Received: (qmail invoked by alias); 22 Dec 2006 21:03:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 22 Dec 2006 22:03:53 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35218>


This adds utf8_byte_count(), utf8_strlen() and print_wrapped_text().

The most important is probably utf8_strlen(), which returns the length
of the text, if it is in UTF-8, otherwise -1.

Note that we do not go the full nine yards: we could also check that
the character is encoded with the minimum amount of bytes, as pointed
out by Uwe Kleine-Koenig.

The function print_wrapped_text() can be used to wrap text to a certain
line length.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Fri, 22 Dec 2006, Junio C Hamano wrote:

	> Nicolas Pitre <nico@cam.org> writes:
	> 
	> > On Fri, 22 Dec 2006, Johannes Schindelin wrote:
	> >> 
	> >> On Thu, 21 Dec 2006, Junio C Hamano wrote:
	> >> 
	> >> >  (2) update commit-tree to reject non utf-8 log messages and
	> >> >      author/committer names when i18n.commitEncoding is _NOT_
	> >> >      set, or set to utf-8.
	> >> 
	> >> The problem is: you cannot easily recognize if it is UTF8 or 
	> >> not, programatically. There is a good indicator _against_ 
	> >> UTF8, namely the first byte can _only_ be 0xxxxxxx, 110xxxxx, 
	> >> 1110xxxx, 11110xxx. But there is no _positive_ sign that it 
	> >> is UTF8. For example, many umlauts and other special 
	> >> modifications to letters, stay in the range 0x7f-0xff.
	> >
	> > Still... that would be a good enough thing to have in the 
	> > majority of cases, wouldn't it?
	> 
	> I think that would be very sane thing to do.

	Well, this patch together with the next one implements that.

 Makefile |    6 ++-
 utf8.c   |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 utf8.h   |    8 +++++
 3 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 29c4662..b4ca48b 100644
--- a/Makefile
+++ b/Makefile
@@ -237,7 +237,8 @@ LIB_H = \
 	archive.h blob.h cache.h commit.h csum-file.h delta.h grep.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
-	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h
+	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
+	utf8.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -256,7 +257,8 @@ LIB_OBJS = \
 	revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
-	color.o wt-status.o archive-zip.o archive-tar.o shallow.o
+	color.o wt-status.o archive-zip.o archive-tar.o shallow.o \
+	utf8.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/utf8.c b/utf8.c
new file mode 100644
index 0000000..06a66c7
--- /dev/null
+++ b/utf8.c
@@ -0,0 +1,93 @@
+#include "git-compat-util.h"
+#include "utf8.h"
+
+/*
+ * This function returns the number of bytes occupied by the character
+ * pointed to by the variable start. If it is not valid UTF-8, it
+ * returns -1.
+ */
+int utf8_byte_count(const char *start)
+{
+	unsigned char c = *(unsigned char *)start;
+	int i, count = 0;
+
+	if (!(c & 0x80))
+		count = 1;
+	else if ((c & 0xe0) == 0xc0)
+		count = 2;
+	else if ((c & 0xf0) == 0xe0)
+		count = 3;
+	else if ((c & 0xf8) == 0xf0)
+		count = 4;
+	else
+		return -1;
+
+	for (i = 1; i < count; i++)
+		if ((start[i] & 0xc0) != 0x80)
+			return -1;
+	return count;
+}
+
+int utf8_strlen(const char *text)
+{
+	int len = 0;
+	while (*text) {
+		int count = utf8_byte_count(text);
+		if (count < 0)
+			return -1;
+		len += count;
+		text += count;
+	}
+	return len;
+}
+
+static void print_spaces(int count)
+{
+	static const char s[] = "                    ";
+	while (count >= sizeof(s)) {
+		fwrite(s, sizeof(s) - 1, 1, stdout);
+		count -= sizeof(s) - 1;
+	}
+	fwrite(s, count, 1, stdout);
+}
+
+/*
+ * Wrap the text, if necessary. The variable indent is the indent for the
+ * first line, indent2 is the indent for all other lines.
+ */
+void print_wrapped_text(const char *text, int indent, int indent2, int len)
+{
+	int count = 0, space = -1;
+	int l = utf8_strlen(text), assume_utf8 = (l >= 0);
+
+	l = indent;
+
+	for (;;) {
+		char c = text[count];
+		if (!c || isspace(c)) {
+			if (l < len || space < 0) {
+				const char *start = text;
+				if (space >= 0)
+					start += space;
+				else
+					print_spaces(indent);
+				fwrite(start, text + count - start, 1, stdout);
+				if (!c) {
+					putchar('\n');
+					return;
+				} else if (c == '\t')
+					l |= 0x07;
+				space = count;
+			} else {
+				putchar('\n');
+				text += space + 1;
+				indent = indent2;
+				space = -1;
+				count = l = 0;
+				continue;
+			}
+		}
+		count += assume_utf8 ? utf8_byte_count(text + count) : 1;
+		l++;
+	}
+}
diff --git a/utf8.h b/utf8.h
new file mode 100644
index 0000000..96dded9
--- /dev/null
+++ b/utf8.h
@@ -0,0 +1,8 @@
+#ifndef GIT_UTF8_H
+#define GIT_UTF8_H
+
+int utf8_byte_count(const char *start);
+int utf8_strlen(const char *text);
+void print_wrapped_text(const char *text, int indent, int indent2, int len);
+
+#endif
-- 
1.4.4.3.ge5f98-dirty
