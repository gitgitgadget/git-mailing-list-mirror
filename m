From: Max Kirillov <max@max630.net>
Subject: [PATCH] utf8.c: print warning about disabled iconv
Date: Sun,  7 Jun 2015 00:02:31 +0300
Message-ID: <1433624551-20730-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 23:09:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1LLg-0007Jh-Rc
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 23:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbbFFVJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 17:09:36 -0400
Received: from p3plsmtpa09-05.prod.phx3.secureserver.net ([173.201.193.234]:53423
	"EHLO p3plsmtpa09-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752875AbbFFVJe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2015 17:09:34 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jun 2015 17:09:34 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-05.prod.phx3.secureserver.net with 
	id d92K1q0025B68XE0192PWR; Sat, 06 Jun 2015 14:02:25 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270952>

It is an allowed compile-time option to build git without iconv
support. Resulting build almost always functions correctly, and
never displays that it is missing anything, but reencode_string_len()
just never modifies its input. This gives undesirable result that
returned data or even data written into repository is incorrect
and user is not aware about it.

Show warning there is non-trivial reencoding requested. Show it only once
during program run.

Signed-off-by: Max Kirillov <max@max630.net>
---
Hi.

I have noticed there is some activity around the option, so it's not completely
abandoned. Maybe then this patch could be useful?
 utf8.c | 13 +++++++++++++
 utf8.h |  5 ++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/utf8.c b/utf8.c
index 520fbb4..b1b836e 100644
--- a/utf8.c
+++ b/utf8.c
@@ -521,6 +521,19 @@ char *reencode_string_len(const char *in, int insz,
 	iconv_close(conv);
 	return out;
 }
+#else
+static int noiconv_warning_shown = 0;
+
+char *reencode_string_len(const char *in, int insz,
+			  const char *out_encoding, const char *in_encoding,
+			  int *outsz)
+{
+	if (!same_encoding(in_encoding, out_encoding) && !noiconv_warning_shown) {
+		warning("Iconv support is disabled at compile time. It is likely that\nincorrect data will be printed or stored in repository.\nConsider using other build for this task.");
+		noiconv_warning_shown = 1;
+	}
+	return NULL;
+}
 #endif
 
 /*
diff --git a/utf8.h b/utf8.h
index e4d9183..3d900f1 100644
--- a/utf8.h
+++ b/utf8.h
@@ -23,13 +23,12 @@ void strbuf_utf8_replace(struct strbuf *sb, int pos, int width,
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
-#define reencode_string_len(a,b,c,d,e) NULL
-#endif
 
 static inline char *reencode_string(const char *in,
 				    const char *out_encoding,
-- 
2.3.4.2801.g3d0809b
