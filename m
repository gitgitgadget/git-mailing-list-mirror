From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] utf8_width(): allow non NUL-terminated input
Date: Wed, 02 Jan 2008 01:49:58 -0800
Message-ID: <7v4pdwzhdl.fsf@gitster.siamese.dyndns.org>
References: <20080102.082014.02281301.tshibata@ab.jp.nec.com>
	<7v1w904x29.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 10:50:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA0FJ-0004Nj-3w
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 10:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156AbYABJuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 04:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757193AbYABJuI
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 04:50:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756967AbYABJuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 04:50:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E262EB268;
	Wed,  2 Jan 2008 04:50:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 172FBB267;
	Wed,  2 Jan 2008 04:49:59 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69466>

The original interface assumed that the input string to be
always terminated with NUL, but that wasn't too useful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a preparatory step for the next one that follows what
   I outlined in my response.  As we are in pre-1.5.4 freeze, I
   won't be applying this to 'master' but this and the one that
   implements the sane truncation might be 'next' material.

 utf8.c |   68 ++++++++++++++++++++++++++++++++++++++-------------------------
 utf8.h |    2 +-
 2 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/utf8.c b/utf8.c
index 9efcdb9..5d641fa 100644
--- a/utf8.c
+++ b/utf8.c
@@ -157,57 +157,71 @@ static int git_wcwidth(ucs_char_t ch)
  * pointed to by the variable start. The pointer is updated to point at
  * the next character. If it was not valid UTF-8, the pointer is set to NULL.
  */
-int utf8_width(const char **start)
+int utf8_width(const char **start, size_t *remainder_p)
 {
 	unsigned char *s = (unsigned char *)*start;
 	ucs_char_t ch;
+	size_t remainder, incr;
 
-	if (*s < 0x80) {
+	/*
+	 * A caller that assumes NUL terminated text can choose
+	 * not to bother with the remainder length.
+	 */
+	remainder = (remainder_p ? *remainder_p : 999);
+
+	if (remainder < 1) {
+		goto invalid;
+	} else if (*s < 0x80) {
 		/* 0xxxxxxx */
 		ch = *s;
-		*start += 1;
+		incr = 1;
 	} else if ((s[0] & 0xe0) == 0xc0) {
 		/* 110XXXXx 10xxxxxx */
-		if ((s[1] & 0xc0) != 0x80 ||
-				/* overlong? */
-				(s[0] & 0xfe) == 0xc0)
+		if (remainder < 2 ||
+		    (s[1] & 0xc0) != 0x80 ||
+		    (s[0] & 0xfe) == 0xc0)
 			goto invalid;
 		ch = ((s[0] & 0x1f) << 6) | (s[1] & 0x3f);
-		*start += 2;
+		incr = 2;
 	} else if ((s[0] & 0xf0) == 0xe0) {
 		/* 1110XXXX 10Xxxxxx 10xxxxxx */
-		if ((s[1] & 0xc0) != 0x80 ||
-				(s[2] & 0xc0) != 0x80 ||
-				/* overlong? */
-				(s[0] == 0xe0 && (s[1] & 0xe0) == 0x80) ||
-				/* surrogate? */
-				(s[0] == 0xed && (s[1] & 0xe0) == 0xa0) ||
-				/* U+FFFE or U+FFFF? */
-				(s[0] == 0xef && s[1] == 0xbf &&
-				 (s[2] & 0xfe) == 0xbe))
+		if (remainder < 3 ||
+		    (s[1] & 0xc0) != 0x80 ||
+		    (s[2] & 0xc0) != 0x80 ||
+		    /* overlong? */
+		    (s[0] == 0xe0 && (s[1] & 0xe0) == 0x80) ||
+		    /* surrogate? */
+		    (s[0] == 0xed && (s[1] & 0xe0) == 0xa0) ||
+		    /* U+FFFE or U+FFFF? */
+		    (s[0] == 0xef && s[1] == 0xbf &&
+		     (s[2] & 0xfe) == 0xbe))
 			goto invalid;
 		ch = ((s[0] & 0x0f) << 12) |
 			((s[1] & 0x3f) << 6) | (s[2] & 0x3f);
-		*start += 3;
+		incr = 3;
 	} else if ((s[0] & 0xf8) == 0xf0) {
 		/* 11110XXX 10XXxxxx 10xxxxxx 10xxxxxx */
-		if ((s[1] & 0xc0) != 0x80 ||
-				(s[2] & 0xc0) != 0x80 ||
-				(s[3] & 0xc0) != 0x80 ||
-				/* overlong? */
-				(s[0] == 0xf0 && (s[1] & 0xf0) == 0x80) ||
-				/* > U+10FFFF? */
-				(s[0] == 0xf4 && s[1] > 0x8f) || s[0] > 0xf4)
+		if (remainder < 4 ||
+		    (s[1] & 0xc0) != 0x80 ||
+		    (s[2] & 0xc0) != 0x80 ||
+		    (s[3] & 0xc0) != 0x80 ||
+		    /* overlong? */
+		    (s[0] == 0xf0 && (s[1] & 0xf0) == 0x80) ||
+		    /* > U+10FFFF? */
+		    (s[0] == 0xf4 && s[1] > 0x8f) || s[0] > 0xf4)
 			goto invalid;
 		ch = ((s[0] & 0x07) << 18) | ((s[1] & 0x3f) << 12) |
 			((s[2] & 0x3f) << 6) | (s[3] & 0x3f);
-		*start += 4;
+		incr = 4;
 	} else {
 invalid:
 		*start = NULL;
 		return 0;
 	}
 
+	*start += incr;
+	if (remainder_p)
+		*remainder_p = remainder - incr;
 	return git_wcwidth(ch);
 }
 
@@ -218,7 +232,7 @@ int is_utf8(const char *text)
 			text++;
 			continue;
 		}
-		utf8_width(&text);
+		utf8_width(&text, NULL);
 		if (!text)
 			return 0;
 	}
@@ -278,7 +292,7 @@ int print_wrapped_text(const char *text, int indent, int indent2, int width)
 			continue;
 		}
 		if (assume_utf8)
-			w += utf8_width(&text);
+			w += utf8_width(&text, NULL);
 		else {
 			w++;
 			text++;
diff --git a/utf8.h b/utf8.h
index 15db6f1..4295a19 100644
--- a/utf8.h
+++ b/utf8.h
@@ -1,7 +1,7 @@
 #ifndef GIT_UTF8_H
 #define GIT_UTF8_H
 
-int utf8_width(const char **start);
+int utf8_width(const char **start, size_t *remain);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 
-- 
1.5.4.rc2.13.g690bd
