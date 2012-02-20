From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] xdiff: introduce XDF_IGNORE_CASE
Date: Sun, 19 Feb 2012 18:16:27 -0800
Message-ID: <1329704188-9955-5-git-send-email-gitster@pobox.com>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 03:16:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzIoA-0007vG-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 03:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab2BTCQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 21:16:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261Ab2BTCQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 21:16:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE82077E2
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Bmoo
	7A0Pzmoyk2xhhmp2RTEDaYI=; b=Hocnx8OE7noHTaKoQlD3pD8YCvxt3olDV1l9
	rAncpe73E1Aw1pXv5e/JdOnTz+UqcRawi2Blg+T88ZGMwqAWx54rP+9181z7ubIy
	zl9WPtXbBfhHu6LUvCESthRC0CHlRR4I7a/vxpzY+WzGcYuz681pl9b9AXhFCFf/
	f+VcW7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=AanBoY
	GO+7A75kgZA7such6YbZDZYXSltWlN0avgNbE8EUVs7QYcb/eP/UkgakHEJjNdgV
	qI0HwtuN03LhmTswYV1f8sDR2WnGUVvOrYc8NiWH8oJVqx0usjkziQTD2pC8utba
	vKq1nJXKWSNcn3EYcKiinkyrTqCzm3ERgLPk4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E616B77E1
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EF5277E0 for
 <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:37 -0500 (EST)
X-Mailer: git-send-email 1.7.9.1.265.g25f75
In-Reply-To: <1329704188-9955-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EAD97CA4-5B68-11E1-B9C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191040>

Teach the hash function and per-line comparison logic to compare lines
while ignoring the differences in case.  It is not an ignore-whitespace
option but still needs to trigger the inexact match logic, and that is
why the previous step introduced XDF_INEXACT_MATCH mask.

Assign the 7th bit for this option, and move the bits to select diff
algorithms out of the way in order to leave room for a few bits to add
more variants of ignore-whitespace, such as --ignore-tab-expansion, if
somebody else is inclined to do so later.

We would still need to teach the front-end to flip this bit, for this
change to be any useful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xdiff.h  |    7 ++++---
 xdiff/xutils.c |   50 ++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 48793f9..5a01a0e 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -36,10 +36,11 @@ extern "C" {
 	(XDF_IGNORE_WHITESPACE | \
 	 XDF_IGNORE_WHITESPACE_CHANGE | \
 	 XDF_IGNORE_WHITESPACE_AT_EOL)
-#define XDF_INEXACT_MATCH XDF_WHITESPACE_FLAGS
+#define XDF_IGNORE_CASE (1 << 7)
+#define XDF_INEXACT_MATCH (XDF_WHITESPACE_FLAGS | XDF_IGNORE_CASE)
 
-#define XDF_PATIENCE_DIFF (1 << 5)
-#define XDF_HISTOGRAM_DIFF (1 << 6)
+#define XDF_PATIENCE_DIFF (1 << 8)
+#define XDF_HISTOGRAM_DIFF (1 << 9)
 #define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
 #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)
 
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index aa6de74..925f1d0 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -170,6 +170,19 @@ long xdl_guess_lines(mmfile_t *mf, long sample) {
 	return nl + 1;
 }
 
+static inline int match_a_byte(char ch1, char ch2, long flags)
+{
+	if (ch1 == ch2)
+		return 1;
+	if (!(flags & XDF_IGNORE_CASE) || ((ch1 | ch2) & 0x80))
+		return 0;
+	if (isupper(ch1))
+		ch1 = tolower(ch1);
+	if (isupper(ch2))
+		ch2 = tolower(ch2);
+	return (ch1 == ch2);
+}
+
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 {
 	int i1, i2;
@@ -192,7 +205,7 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 	if (flags & XDF_IGNORE_WHITESPACE) {
 		goto skip_ws;
 		while (i1 < s1 && i2 < s2) {
-			if (l1[i1++] != l2[i2++])
+			if (!match_a_byte(l1[i1++], l2[i2++], flags))
 				return 0;
 		skip_ws:
 			while (i1 < s1 && XDL_ISSPACE(l1[i1]))
@@ -210,15 +223,28 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 					i2++;
 				continue;
 			}
-			if (l1[i1++] != l2[i2++])
+			if (!match_a_byte(l1[i1++], l2[i2++], flags))
 				return 0;
 		}
-	} else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL) {
-		while (i1 < s1 && i2 < s2 && l1[i1++] == l2[i2++])
+	} else {
+		/*
+		 * Either XDF_IGNORE_WHITESPACE_AT_EOL is set, or
+		 * no whitespace is ignored, but INEXACT_MATCH is
+		 * in effect for other reasons.
+		 */
+		while (i1 < s1 && i2 < s2 &&
+		       match_a_byte(l1[i1++], l2[i2++], flags))
 			; /* keep going */
 	}
 
 	/*
+	 * If we are not ignoring any whitespace, we must have consumed
+	 * everything for the lines to match.
+	 */
+	if (!(flags & XDF_WHITESPACE_FLAGS))
+		return i1 == s1 && i2 == s2;
+
+	/*
 	 * After running out of one side, the remaining side must have
 	 * nothing but whitespace for the lines to match.  Note that
 	 * ignore-whitespace-at-eol case may break out of the loop
@@ -238,6 +264,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 	return 1;
 }
 
+static inline unsigned long hash_a_byte(const char ch_, long flags)
+{
+	unsigned long ch = ch_ & 0xFF;
+	if ((flags & XDF_IGNORE_CASE) && !(ch & 0x80) && isupper(ch))
+		ch = tolower(ch);
+	return ch;
+}
+
 static unsigned long xdl_hash_record_with_whitespace(char const **data,
 		char const *top, long flags) {
 	unsigned long ha = 5381;
@@ -256,20 +290,20 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
 				 && !at_eol) {
 				ha += (ha << 5);
-				ha ^= (unsigned long) ' ';
+				ha ^= hash_a_byte(' ', flags);
 			}
 			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
 				 && !at_eol) {
 				while (ptr2 != ptr + 1) {
 					ha += (ha << 5);
-					ha ^= (unsigned long) *ptr2;
+					ha ^= hash_a_byte(*ptr2, flags);
 					ptr2++;
 				}
 			}
 			continue;
 		}
 		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
+		ha ^= hash_a_byte(*ptr, flags);
 	}
 	*data = ptr < top ? ptr + 1: ptr;
 
@@ -286,7 +320,7 @@ unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
 		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
+		ha ^= hash_a_byte(*ptr, flags);
 	}
 	*data = ptr < top ? ptr + 1: ptr;
 
-- 
1.7.9.1.265.g25f75
