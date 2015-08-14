From: Max Kirillov <max@max630.net>
Subject: [PATCH v2] utf8.c: print warning about iconv errors
Date: Sat, 15 Aug 2015 00:55:34 +0300
Message-ID: <1439589334-32318-1-git-send-email-max@max630.net>
References: <1433624551-20730-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:02:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQN3v-000260-Af
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 00:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbbHNWCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 18:02:51 -0400
Received: from p3plsmtpa09-01.prod.phx3.secureserver.net ([173.201.193.230]:47877
	"EHLO p3plsmtpa09-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751550AbbHNWCu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2015 18:02:50 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Aug 2015 18:02:50 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-01.prod.phx3.secureserver.net with 
	id 4lvb1r0025B68XE01lvfF8; Fri, 14 Aug 2015 14:55:41 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-reply-to: <1433624551-20730-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275965>

If reencoding a text data from one encoding to another fails, the original
version is used insted. Currently there is no warning about failed reencoding,
which can have an undesired outcome that returned data is incorrect but user
is not aware about it.

Add printing warning when conversion fails.

Also add test script to assert that warning is actually printed and output is
not changed, as expected.

Signed-off-by: Max Kirillov <max@max630.net>
---
Changes since v1:
* rebase to recent changes
* add handling runtime errors
* add test
* do not limit number of warnings - does not worth complicating the code
* noticed that incomplete utf8 sequence in input silently treated as latin1.
  so mark the testcase as expect_failure. Actually, it's quite surprising,
  would be nice if somebody tries it in various environments
Actually, as far as I could grep, all uses of the resoding happen
only for printing, so probably it is not that important.
 t/t3911-show-reencode.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 utf8.c                   | 24 +++++++++++++++++++++++-
 utf8.h                   |  7 ++-----
 3 files changed, 71 insertions(+), 6 deletions(-)
 create mode 100755 t/t3911-show-reencode.sh

diff --git a/t/t3911-show-reencode.sh b/t/t3911-show-reencode.sh
new file mode 100755
index 0000000..061d820
--- /dev/null
+++ b/t/t3911-show-reencode.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='reencoding'
+
+. ./test-lib.sh
+
+printf '\304\201\n' >a_macron_utf8
+printf '\303\244\n' >a_diaeresis_utf8
+printf '\303\244\304\n' >incomplete_utf8
+printf '\344\n' >a_diaeresis_latin1
+
+test_expect_success 'setup' '
+	git commit --allow-empty -F a_diaeresis_utf8 &&
+	git tag latin1_utf8 &&
+	git commit --allow-empty -F a_macron_utf8 &&
+	git tag extended_utf8 &&
+	git commit --allow-empty -F incomplete_utf8 &&
+	git tag invalid_utf8
+'
+
+test_expect_success 'encoding to latin1' '
+	git log --encoding=latin1 --pretty=format:%B -1 latin1_utf8 >out 2>err &&
+	test_must_be_empty err &&
+	test_cmp out a_diaeresis_latin1
+'
+
+test_expect_success 'unknown encoding' '
+	git log --encoding=no-encoding --pretty=format:%B -1 latin1_utf8 >out 2>err &&
+	grep -q "not supported" err &&
+	test_cmp out a_diaeresis_utf8
+'
+
+# apparently incomplete UTF8 byte sequences silently treated as latin1
+test_expect_failure 'incomplete utf8' '
+	git log --encoding=latin1 --pretty=format:%B -1 invalid_utf8 >out 2>err &&
+	grep -q "Invalid input" err &&
+	test_cmp out incomplete_utf8
+'
+
+test_expect_success 'does not fit into latin1' '
+	git log --encoding=latin1 --pretty=format:%B -1 extended_utf8 >out 2>err &&
+	grep -q "Invalid input" err &&
+	test_cmp out a_macron_utf8
+'
+
+test_done
diff --git a/utf8.c b/utf8.c
index 28e6d76..d284bb0 100644
--- a/utf8.c
+++ b/utf8.c
@@ -465,7 +465,9 @@ char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv, int *outs
 		if (cnt == (size_t) -1) {
 			size_t sofar;
 			if (errno != E2BIG) {
+				int failure_errno = errno;
 				free(out);
+				errno = failure_errno;
 				return NULL;
 			}
 			/* insz has remaining number of bytes.
@@ -513,14 +515,34 @@ char *reencode_string_len(const char *in, int insz,
 		if (is_encoding_utf8(out_encoding))
 			out_encoding = "UTF-8";
 		conv = iconv_open(out_encoding, in_encoding);
-		if (conv == (iconv_t) -1)
+		if (conv == (iconv_t) -1) {
+			if (errno == EINVAL)
+				warning("Conversion from %s to %s not supported, falling back to verbatim copy", in_encoding, out_encoding);
+			else
+				warning("Conversion from %s to %s failed: %s, falling back to verbatim copy", in_encoding, out_encoding, strerror(errno));
 			return NULL;
+		}
 	}
 
 	out = reencode_string_iconv(in, insz, conv, outsz);
+	if (out == NULL) {
+		if (errno == EILSEQ || errno == EINVAL)
+			warning("Invalid input for conversion from %s to %s, falling back to verbatim copy", in_encoding, out_encoding);
+		else
+			warning("Conversion from %s to %s failed: %s, falling back to verbatim copy", in_encoding, out_encoding, strerror(errno));
+	}
 	iconv_close(conv);
 	return out;
 }
+#else
+char *reencode_string_len(const char *in, int insz,
+			  const char *out_encoding, const char *in_encoding,
+			  int *outsz)
+{
+	if (!same_encoding(in_encoding, out_encoding))
+		warning("Iconv support is disabled at compile time. It is likely that\nincorrect data will be printed or stored in repository.\nConsider using other build for this task.");
+	return NULL;
+}
 #endif
 
 /*
diff --git a/utf8.h b/utf8.h
index 5a9e94b..c72998b 100644
--- a/utf8.h
+++ b/utf8.h
@@ -26,15 +26,12 @@ void strbuf_utf8_replace(struct strbuf *sb, int pos, int width,
 #ifndef NO_ICONV
 char *reencode_string_iconv(const char *in, size_t insz,
 			    iconv_t conv, int *outsz);
+#endif
+
 char *reencode_string_len(const char *in, int insz,
 			  const char *out_encoding,
 			  const char *in_encoding,
 			  int *outsz);
-#else
-static inline char *reencode_string_len(const char *a, int b,
-					const char *c, const char *d, int *e)
-{ if (e) *e = 0; return NULL; }
-#endif
 
 static inline char *reencode_string(const char *in,
 				    const char *out_encoding,
-- 
2.3.4.2801.g3d0809b
