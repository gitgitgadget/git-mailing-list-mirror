From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 11/15] Add strbuf_vaddf(), use it in strbuf_addf(), and add strbuf_initf()
Date: Fri, 27 Jun 2008 18:22:04 +0200
Message-ID: <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
 <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
 <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
 <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
 <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
 <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org>
 <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org>
 <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGnU-0005l2-22
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761416AbYF0QXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758908AbYF0QXM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:23:12 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45349 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760913AbYF0QWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:14 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id 618C51DDC67;
	Fri, 27 Jun 2008 18:22:07 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 5EC5418E82E; Fri, 27 Jun 2008 18:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86594>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

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
 .gitignore       |    1 +
 Makefile         |    4 +-
 strbuf.c         |  134 +++++++++++++++++++++++++++++++++++++++++++++++------
 strbuf.h         |    3 +
 t/t0000-basic.sh |    8 +++
 test-strbuf.c    |   17 +++++++
 6 files changed, 150 insertions(+), 17 deletions(-)
 create mode 100644 test-strbuf.c

diff --git a/.gitignore b/.gitignore
index 4ff2fec..9281395 100644
--- a/.gitignore
+++ b/.gitignore
@@ -151,6 +151,7 @@ test-genrandom
 test-match-trees
 test-parse-options
 test-sha1
+test-strbuf
 common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 314339d..1b43171 100644
--- a/Makefile
+++ b/Makefile
@@ -1230,7 +1230,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X test-strbuf$X
 
 all:: $(TEST_PROGRAMS)
 
@@ -1249,6 +1249,8 @@ test-delta$X: diff-delta.o patch-delta.o
 
 test-parse-options$X: parse-options.o
 
+test-strbuf$X: strbuf.o
+
 .PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 
 test-%$X: test-%.o $(GITLIBS)
diff --git a/strbuf.c b/strbuf.c
index 4aed752..72b3585 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -122,28 +122,130 @@ void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
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
index 690f80a..7c7ca4c 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -311,6 +311,14 @@ test_expect_success 'absolute path works as expected' '
 	test "$sym" = "$(test-absolute-path "$dir2/syml")"
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
1.5.6
