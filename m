From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2 v2] Add strbuf_vaddf(), use it in strbuf_addf(), and add
 strbuf_initf()
Date: Thu, 6 Mar 2008 17:29:50 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061727120.3941@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>  <alpine.LSU.1.00.0802281159550.22527@racer.site>  <200803052221.12495.johannes.sixt@telecom.at>  <alpine.LSU.1.00.0803052317350.15786@racer.site>  <7vir00lski.fsf@gitster.siamese.dyndns.org>
  <alpine.LSU.1.00.0803052327570.15786@racer.site>  <alpine.LSU.1.00.0803060212170.15786@racer.site>  <20080306063331.GA7325@glandium.org>  <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>  <alpine.LSU.1.00.0803061153400.15786@racer.site>
 <3f4fd2640803060353w70651522w4b3896b8106b01c0@mail.gmail.com> <alpine.LSU.1.00.0803061319590.15786@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 17:31:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXIzW-0002zL-37
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 17:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934932AbYCFQ3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 11:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933296AbYCFQ3x
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 11:29:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:59135 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763976AbYCFQ3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 11:29:51 -0500
Received: (qmail invoked by alias); 06 Mar 2008 16:29:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 06 Mar 2008 17:29:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BF6pQCwHB6+A3aEyaghsZCQfwq5HUITK3ERCh+f
	9W89JjXK0167St
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803061319590.15786@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76396>


The most common use of addf() was to init a strbuf and addf() right away.
Since it is so common, it makes sense to have a function strbuf_initf() to
wrap both calls into one.

To do that, we implement a (really minimal) vaddf() lookalike to
vsprintf().

At the moment, it only handles %u, %i, %d, %l, %o, %x and %X with size
indicators '<number>', ' <number>' and '0<number>', as well as %c and %s,
the latter with size indicators '.*' in addition to the same size
indicators as for numbers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 6 Mar 2008, Johannes Schindelin wrote:

	> Of course, having a simple implementation for addf() _not_ using 
	> vsnprintf() could help, too (and make the process more efficient, 
	> probably).

	Having thought about this a bit, I came up with this 
	implementation (replacing my earlier PATCH 1/2).  It is by far not 
	complete, but that is exactly the idea: we do not _need_ a fully-fledged 
	printf() implementation.

	Besides, it was fun.

 .gitignore       |    1 +
 Makefile         |    4 +-
 strbuf.c         |  134 +++++++++++++++++++++++++++++++++++++++++++++++------
 strbuf.h         |    3 +
 t/t0000-basic.sh |    8 +++
 test-strbuf.c    |   17 +++++++
 6 files changed, 150 insertions(+), 17 deletions(-)
 create mode 100644 test-strbuf.c

diff --git a/.gitignore b/.gitignore
index 219759f..c0ecd41 100644
--- a/.gitignore
+++ b/.gitignore
@@ -152,6 +152,7 @@ test-genrandom
 test-match-trees
 test-parse-options
 test-sha1
+test-strbuf
 common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index cd0b294..58f6238 100644
--- a/Makefile
+++ b/Makefile
@@ -1052,7 +1052,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X test-strbuf$X
 
 all:: $(TEST_PROGRAMS)
 
@@ -1071,6 +1071,8 @@ test-delta$X: diff-delta.o patch-delta.o
 
 test-parse-options$X: parse-options.o
 
+test-strbuf$X: strbuf.o
+
 .PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 
 test-%$X: test-%.o $(GITLIBS)
diff --git a/strbuf.c b/strbuf.c
index 5afa8f3..5ad89a8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -123,28 +123,130 @@ void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+static int number_length(unsigned long number, long base)
+{
+	int length = 1;
+	while (number >= base) {
+		number /= base;
+		length++;
+	}
+	return length;
+}
+
+/*
+ * Only supports %u, %i, %d, %l, %o, %x and %X with size indicators
+ *   '<number>', '0<number>', and ' <number>',
+ * as well as %c,
+ * and %s with size indicators '<number>', ' <number>' and '.*'.
+ */
+void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
+{
+	while (*fmt) {
+		char fill = '\0';
+		int size = -1, max_size = -1;
+		char *p = (char *)fmt;
+
+		if (*p != '%' || *(++p) == '%') {
+			strbuf_addch(sb, *p++);
+			fmt = p;
+			continue;
+		}
+		if (*p == ' ' || *p == '0')
+			fill = *p++;
+		if (isdigit(*p))
+			size = (int)strtol(p, &p, 10);
+		else if (!prefixcmp(p, ".*")) {
+			max_size = va_arg(ap, int);
+			p += 2;
+		}
+		switch (*p) {
+		case 's': {
+			const char *s = va_arg(ap, const char *);
+			if (fill) {
+				int len = size - strlen(s);
+				while (len-- > 0)
+					strbuf_addch(sb, fill);
+			}
+			while (*s && max_size--)
+				strbuf_addch(sb, *s++);
+			break;
+		}
+		case 'c':
+			strbuf_addch(sb, va_arg(ap, int));
+			break;
+		case 'u':
+		case 'i':
+		case 'l':
+		case 'd':
+		case 'o':
+		case 'x':
+		case 'X': {
+			int base = *p == 'x' || *p == 'X' ? 16 :
+				*p == 'o' ? 8 : 10;
+			int negative = 0, len;
+			unsigned long number, power;
+
+			if (*p == 'u')
+				number = va_arg(ap, unsigned int);
+			else {
+				long signed_number;
+				if (*p == 'l')
+					signed_number = va_arg(ap, long);
+				else
+					signed_number = va_arg(ap, int);
+				if (signed_number < 0) {
+					negative = 1;
+					number = -signed_number;
+				} else
+					number = signed_number;
+			}
+
+			/* pad */
+			len = number_length(number, base);
+			while (size-- > len + negative)
+				strbuf_addch(sb, fill ? fill : ' ');
+			if (negative)
+				strbuf_addch(sb, '-');
+
+			/* output number */
+			power = 1;
+			while (len-- > 1)
+				power *= base;
+			while (power) {
+				int digit = number / power;
+				strbuf_addch(sb, digit < 10 ? '0' + digit
+					: *p + 'A' - 'X' + digit - 10);
+				number -= digit * power;
+				power /= base;
+			}
+
+			break;
+		}
+		default:
+			/* unknown / invalid format: copy verbatim */
+			strbuf_insert(sb, sb->len, fmt, p - fmt + 1);
+		}
+		fmt = p + (*p != '\0');
+	}
+}
+
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 {
-	int len;
 	va_list ap;
 
-	if (!strbuf_avail(sb))
-		strbuf_grow(sb, 64);
 	va_start(ap, fmt);
-	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
+	strbuf_vaddf(sb, fmt, ap);
+	va_end(ap);
+}
+
+void strbuf_initf(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list ap;
+
+	strbuf_init(sb, strlen(fmt) + 64);
+	va_start(ap, fmt);
+	strbuf_vaddf(sb, fmt, ap);
 	va_end(ap);
-	if (len < 0)
-		die("your vsnprintf is broken");
-	if (len > strbuf_avail(sb)) {
-		strbuf_grow(sb, len);
-		va_start(ap, fmt);
-		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
-		va_end(ap);
-		if (len > strbuf_avail(sb)) {
-			die("this should not happen, your snprintf is broken");
-		}
-	}
-	strbuf_setlen(sb, sb->len + len);
 }
 
 void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
diff --git a/strbuf.h b/strbuf.h
index faec229..d7c7aaf 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -106,8 +106,11 @@ extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
 typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
 extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
 
+extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list args);
 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+__attribute__((format(printf,2,3)))
+extern void strbuf_initf(struct strbuf *sb, const char *fmt, ...);
 
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 27b54cb..c1d4639 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -311,6 +311,14 @@ test_expect_success 'absolute path works as expected' '
 	test "$sym" = "$(test-absolute-path $dir2/syml)"
 '
 
+test_expect_success 'strbuf_initf() works as expected' '
+
+	eval $(test-strbuf) &&
+	test ! -z "$result" &&
+	test "$result" = "$expect"
+
+'
+
 test_expect_success 'very long name in the index handled sanely' '
 
 	a=a && # 1
diff --git a/test-strbuf.c b/test-strbuf.c
new file mode 100644
index 0000000..479fa08
--- /dev/null
+++ b/test-strbuf.c
@@ -0,0 +1,17 @@
+#include "cache.h"
+#include "strbuf.h"
+
+int main(int argc, char **argv)
+{
+	struct strbuf buf;
+#define TEST_FORMAT \
+	"'%%%.*s,%x,%05X,%u,%i,% 4d,%3d,%c,%3d'", \
+	5, "Hello, World!", 27, 27, -1, -1, 1, 5, ':', 1234
+
+	strbuf_initf(&buf, TEST_FORMAT);
+	printf("result=%s\n", buf.buf);
+	printf("expect=" TEST_FORMAT);
+	strbuf_release(&buf);
+
+	return 0;
+}
-- 
1.5.4.3.571.g9aec3.dirty

