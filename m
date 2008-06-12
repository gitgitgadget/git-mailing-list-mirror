From: Alex Riesen <raa.lkml@gmail.com>,
	Alex Riesen <raa@limbo.localdomain>
Subject: [PATCH] Add test-tr: poor-man tr
Date: Thu, 12 Jun 2008 22:20:07 +0200
Message-ID: <20080612202007.GA8057@steel.home>
References: <20080611182501.GA3344@steel.home> <556d90580806112332s25f76caajaaafa8e16e895922@mail.gmail.com> <alpine.DEB.1.00.0806120822140.1783@racer>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alf Clement <alf.clement@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 22:21:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tIB-0007TR-Fb
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbYFLUUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbYFLUUM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:20:12 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:35129 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbYFLUUK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:20:10 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20lf50S7
Received: from tigra.home (Fab42.f.strato-dslnet.de [195.4.171.66])
	by post.webmailer.de (klopstock mo32) (RZmta 16.42)
	with ESMTP id V07145k5CIEhIp ; Thu, 12 Jun 2008 22:20:07 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5D86D277BD;
	Thu, 12 Jun 2008 22:20:07 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A2CD856D28; Thu, 12 Jun 2008 22:20:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806120822140.1783@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84783>

It offers a limited set of POSIX tr, in particular: no character class
support and no [n*m] operators. Only 8bit. C-escapes supported, and
character ranges. Deletion and squeezing should work, but -s does not
match the GNU tr from coreutils (which, in turn, does not match POSIX).

Even if the program does not offers the full tr features, what's left
is guaranteed to work the same on every platform where you manage to
compile it (unless the platform does something really nasty at low
level). Originally written to overcome brokenness of ActiveState Perl
on Windows, it should also improve (assuming it will be used instead
of local "tr" and "perl -pe y///") portability of the test suite on
other platforms.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Johannes Schindelin, Thu, Jun 12, 2008 09:25:09 +0200:
> On Thu, 12 Jun 2008, Alf Clement wrote:
> 
> > > +static unsigned char *unquote(const char *s, unsigned *len) +{
> > > +       unsigned char *result = malloc(strlen(s)), *r = result;
> > 
> > are you sure that the buffer is big enough?? Nomally you do a
> > malloc(strlen(s)+1).
> 
> AFAIU a "tr" really only ever replaces single characters by single 
> characters.  So, not even looking at the code -- just like you -- I would 
> expect it to get the exact number of bytes read, and to write the same 
> number of bytes.
> 
> I certainly would not expect it to do something string based, introducing 
> a silly expectation of NUL-terminations (which tr(1) does not expect 
> either).

In any case, Alf is right. The unquote is called unconditionally with
its arguments, even if there is nothing to unquote. In which case the
size of result is off by one. Corrected test-tr.c (also with a
sensible header) below.

 Makefile  |    2 +-
 test-tr.c |  212 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+), 1 deletions(-)
 create mode 100644 test-tr.c

diff --git a/Makefile b/Makefile
index 1937507..5f208d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1229,7 +1229,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X test-tr$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/test-tr.c b/test-tr.c
new file mode 100644
index 0000000..2248535
--- /dev/null
+++ b/test-tr.c
@@ -0,0 +1,212 @@
+/*
+ * test-tr  A simplified tr(1) implementation for testing purposes
+ *
+ * It offers a limited set of POSIX tr, in particular: no character
+ * class support and no [n*m] operators. Only 8bit. C-escapes
+ * supported, and character ranges. Deletion and squeezing should
+ * work, but -s does not match the GNU tr from coreutils (which, in
+ * turn, does not match POSIX).
+ */
+#include "cache.h"
+
+static int squeeze, delete;
+
+static unsigned char *unquote(const char *s, unsigned *len)
+{
+	unsigned char *result = malloc(strlen(s) + 1), *r = result;
+
+	while (*s) {
+		switch (*s) {
+		case '\\':
+			++s;
+#define ISOCT(c) (((c) >= '0' && (c) <= '7'))
+			if (ISOCT(*s)) {
+				unsigned int c;
+				char oct[4] = {0,0,0,0};
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
+static void put_op(unsigned char *conv, unsigned char ch, unsigned *len)
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
+				put_op(set, c, set_len);
+			++p;
+			++p;
+			continue;
+		}
+		put_op(set, *p, set_len);
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
+			put_op(set2, i, &set2_len);
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
+				}
+				if (!(squeeze && have_last && ch == last))
+					buf[o++] = ch;
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
1.5.6.rc2.43.g77bfa
