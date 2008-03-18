From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add test-tr: poor-man tr for the test suite
Date: Tue, 18 Mar 2008 23:24:28 +0100
Message-ID: <20080318222428.GB3450@steel.home>
References: <cover.1205356737.git.peff@peff.net> <20080312213106.GD26286@coredump.intra.peff.net> <20080318222302.GA3450@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:42:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6zM-00028i-Dm
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161935AbYCSWlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S941612AbYCSWlo
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:41:44 -0400
Received: from mo-p07-fb.rzone.de ([81.169.146.191]:31112 "EHLO
	mo-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161924AbYCSWlm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:41:42 -0400
Received: from mo-p07-ob.rzone.de (mrclete-mo-p07-ob.mail [192.168.63.176])
	by gibbsson-fb-07.store (RZmta 16.11) with ESMTP id G00b0bk2IHRQhq
	for <git@vger.kernel.org>; Tue, 18 Mar 2008 23:40:52 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTG+sg==
Received: from tigra.home (Fa830.f.strato-dslnet.de [195.4.168.48])
	by post.webmailer.de (mrclete mo60) (RZmta 16.13)
	with ESMTP id x04998k2ILAUjW ; Tue, 18 Mar 2008 23:24:28 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 47429277BD;
	Tue, 18 Mar 2008 23:24:28 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 452DF56D28; Tue, 18 Mar 2008 23:24:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080318222302.GA3450@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77579>

It offers a limited set of POSIX tr, in particular: no character class
support and no [n*m] operators. Only 8bit. C-escapes supported, and
character ranges. Deletion and squeezing should work, but -s does not
match what the GNU tr from coreutils (which, in turn, does not match
SuSv2).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

 Makefile              |    2 +-
 t/t0000-test-progs.sh |   72 +++++++++++++++
 test-tr.c             |  236 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 309 insertions(+), 1 deletions(-)
 create mode 100755 t/t0000-test-progs.sh
 create mode 100644 test-tr.c

diff --git a/Makefile b/Makefile
index 7c70b00..a458c30 100644
--- a/Makefile
+++ b/Makefile
@@ -1177,7 +1177,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X test-tr$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/t/t0000-test-progs.sh b/t/t0000-test-progs.sh
new file mode 100755
index 0000000..d8d339a
--- /dev/null
+++ b/t/t0000-test-progs.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='Test the test support programs for sanity'
+
+. ./test-lib.sh
+
+test_expect_success 'test-tr character range' '
+
+	echo def >expected &&
+	echo abc | test-tr a-c d-f >result &&
+	cmp expected result &&
+
+	printf def >expected &&
+	printf def | test-tr a-c d-f >result &&
+	cmp expected result
+
+	printf def >expected &&
+	printf abc | test-tr \\141-\\143 \\144-\\146 >result &&
+	cmp expected result
+
+	printf \\r\\n >expected &&
+	printf \\r\\n | test-tr rn \\r\\n >result &&
+	cmp expected result
+
+	printf \\000\\n >expected &&
+	printf 0n | test-tr 0n \\000\\n >result &&
+	cmp expected result
+
+	printf 0n >expected &&
+	printf \\000\\n | test-tr \\000\\n 0n >result &&
+	cmp expected result &&
+
+	echo nopqrstuvwxyzbcdefghklm >expected &&
+	echo abcdefghijklmopqrstuxyz | test-tr A-Za-z N-ZA-Mn-za-m >result &&
+	cmp expected result
+'
+
+test_expect_success 'test-tr delete characters' '
+
+	echo ac >expected &&
+	echo abc | test-tr -d b >result &&
+	cmp expected result &&
+
+	echo abcghijk >expected &&
+	echo abcdefghijk | test-tr -d d-f >result &&
+	cmp expected result
+
+'
+
+test_expect_success 'test-tr squeeze repeating characters' '
+
+	echo abc >expected &&
+	echo abbbbc | test-tr -s b >result &&
+	cmp expected result &&
+
+	echo def >expected &&
+	echo abbbbc | test-tr -s a-c d-f >result &&
+	cmp expected result
+
+'
+
+test_expect_success 'test-tr sanity' '
+
+	test_must_fail test-tr -d a-z A-Z &&
+	test_must_fail test-tr \\477 a &&
+	test_must_fail test-tr z-a a &&
+	test_must_fail test-tr a-z "" &&
+	test_must_fail test-tr a-z
+
+'
+
+test_done
diff --git a/test-tr.c b/test-tr.c
new file mode 100644
index 0000000..477ae16
--- /dev/null
+++ b/test-tr.c
@@ -0,0 +1,236 @@
+/*
+ *  Simplified tr
+ *
+ *  Supports:
+ *
+ *  CHAR1-CHAR2
+ *  Escape sequences
+ *  -d (delete)
+ *  -s (squeeze)
+ *
+ *  No unicode
+ *  No characters classes
+ *  No -c (complement) support
+ *  Behavior of "-s -d" not tested (never used in tests)
+ *
+ *  Squeeze of of repeating characters follows the behavior
+ *  described in the Single Unix Specification (as good as I
+ *  understand it), not what tr does (it squeezes every character
+ *  found in set1 OR set2, whereas the SuS says:
+ *
+ *  "When the -s option is specified, after any deletions or
+ *  translations have taken place, repeated sequences of the same
+ *  character will be replaced by one occurrence of the same
+ *  character, if the character is found in the array specified by the
+ *  last operand."
+ *
+ *  So this tr squeezes only characters matched the set1.
+ *
+ */
+#include "cache.h"
+
+static int squeeze, delete;
+
+static unsigned char *unquote(const char *s, unsigned *len)
+{
+	unsigned char *result = malloc(strlen(s)), *r = result;
+
+	while (*s) {
+		switch (*s) {
+		case '\\':
+			++s;
+#define ISOCT(c) (((c) >= '0' && (c) <= '7'))
+			if (ISOCT(*s)) {
+				unsigned int c;
+				char oct[4] = {0, 0, 0, 0};
+				oct[0] = *s++;
+				c = (oct[0] - '0');
+				if (ISOCT(*s)) {
+					oct[1] = *s++;
+					c = (c << 3) |(oct[1] - '0');
+					if (ISOCT(*s)) {
+						oct[2] = *s++;
+						c = (c << 3) |(oct[2] - '0');
+					}
+				}
+				if (c > 255) {
+					fprintf(stderr, "invalid octal character specification: \\%s\n", oct);
+					exit(1);
+				}
+				*r++ = c & 0xff;
+			} else {
+				switch (*s) {
+				case '\0':
+					*r++ = '\\';
+					break;
+				case '\\':
+					*r++ = *s++;
+					break;
+				case 'a':
+					*r++ = '\a';
+					++s;
+					break;
+				case 'b':
+					*r++ = '\b';
+					++s;
+					break;
+				case 'f':
+					*r++ = '\f';
+					++s;
+					break;
+				case 'n':
+					*r++ = '\n';
+					++s;
+					break;
+				case 'r':
+					*r++ = '\r';
+					++s;
+					break;
+				case 't':
+					*r++ = '\t';
+					++s;
+					break;
+				case 'v':
+					*r++ = '\v';
+					++s;
+					break;
+				default:
+					*r++ = '\\';
+					*r++ = *s++;
+					break;
+				}
+			}
+			break;
+		default:
+			*r++ = *s++;
+		}
+	}
+
+	*len = r - result;
+	*r = '\0';
+	return result;
+}
+
+#define MAX_PATTERN 256
+static void put_ch(unsigned char *conv, unsigned char ch, unsigned *len)
+{
+	unsigned i = (*len)++;
+	if (*len > MAX_PATTERN) {
+		fprintf(stderr, "pattern too long\n");
+		exit(1);
+	}
+	conv[i] = ch;
+}
+
+static void parse(const unsigned char *rule, unsigned rule_len,
+		  unsigned char *set, unsigned *set_len)
+{
+	const unsigned char *p = rule;
+	while (p < rule + rule_len) {
+		if ('-' == *p && p > rule && p[1]) {
+			unsigned c;
+			if (p[-1] > p[1]) {
+				fprintf(stderr, "%c%c%c: range is reversed\n",
+					p[-1], *p, p[1]);
+				exit(1);
+			}
+			c = p[-1] + 1u;
+			for (; c <= p[1]; ++c)
+				put_ch(set, c, set_len);
+			++p;
+			++p;
+			continue;
+		}
+		put_ch(set, *p, set_len);
+		++p;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned set1_len = 0, set2_len = 0;
+	unsigned char set1[MAX_PATTERN];
+	unsigned char set2[MAX_PATTERN];
+
+	ssize_t n;
+	unsigned char last = 0, have_last = 0;
+	unsigned char buf[BUFSIZ];
+
+	char *rule1 = NULL, *rule2 = NULL;
+	unsigned char *urule1, *urule2;
+	unsigned urule1_len, urule2_len;
+	int opt;
+
+	for (opt = 1; opt < argc; ++opt) {
+		if (!strcmp("-s", argv[opt]))
+			squeeze = 1;
+		else if (!strcmp("-d", argv[opt]))
+			delete = 1;
+		else if (!rule1) {
+			rule1 = argv[opt];
+		} else if (!rule2)
+			rule2 = argv[opt];
+	}
+	if (!rule1) {
+	    fprintf(stderr, "no source set given\n"
+		    "test-tr [-s] [-d] set1 [set2]\n"
+		    "\"set\" supports only \\NNN, \\a-\\v and CHAR1-CHAR2 rules\n");
+	    exit(1);
+	}
+	if (delete && rule2) {
+		fprintf(stderr, "extra operand %s when deleting\n", rule2);
+		exit(1);
+	}
+	urule1 = unquote(rule1, &urule1_len);
+	urule2 = NULL;
+	urule2_len = 0;
+	if ((!rule2 || !*rule2) && !delete && !squeeze) {
+		fprintf(stderr, "set2 must be non-empty\n");
+		exit(1);
+	}
+
+	parse(urule1, urule1_len, set1, &set1_len);
+
+	if (rule2) {
+		unsigned i;
+		urule2 = unquote(rule2, &urule2_len);
+		parse(urule2, urule2_len, set2, &set2_len);
+		i = set2[set2_len - 1];
+		while (set2_len < set1_len)
+			put_ch(set2, i, &set2_len);
+	}
+
+	while ((n = read(STDIN_FILENO, buf, sizeof(buf)))) {
+		if (n < 0) {
+			int err = errno;
+			if (EINTR == err || EAGAIN == err)
+				continue;
+			fprintf(stderr, "%s: %s\n", argv[0], strerror(err));
+			exit(1);
+		}
+		if (set1_len) {
+			unsigned i, o = 0;
+			for (i = 0; i < (unsigned)n; ++i) {
+				unsigned char *p, ch = buf[i];
+				p = memchr(set1, ch, set1_len);
+				if (p) {
+					if (delete)
+						continue;
+					if (set2_len)
+						ch = set2[p - set1];
+					if (!(squeeze &&
+					      have_last &&
+					      ch == last))
+						buf[o++] = ch;
+				} else
+					buf[o++] = ch;
+
+				have_last = 1;
+				last = ch;
+			}
+			n = o;
+		}
+		write(STDOUT_FILENO, buf, n);
+	}
+	return 0;
+}
-- 
1.5.5.rc0.53.g97734
