From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/1] get_sha1_hex(): do not read past a NUL character
Date: Fri, 23 Sep 2011 15:38:36 +0200
Message-ID: <1316785116-21831-1-git-send-email-mhagger@alum.mit.edu>
References: <4E7C857D.8000304@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 15:38:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R75xv-000479-P5
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 15:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721Ab1IWNiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 09:38:51 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:52050 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab1IWNiu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 09:38:50 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R75t3-0001Be-Rh; Fri, 23 Sep 2011 15:33:53 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <4E7C857D.8000304@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181966>

Previously, get_sha1_hex() would read one character past the end of a
null-terminated string whose strlen was an even number less than 40.
Although the function correctly returned -1 in these cases, the extra
memory access might have been to uninitialized (or even, conceivably,
unallocated) memory.

Add a check to avoid reading past the end of a string.

This problem was discovered by Thomas Rast <trast@student.ethz.ch>
using valgrind.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
It is suggested to apply this bugfix before mh/check-ref-format-3;
otherwise the latter triggers the bug, leading to a valgrind error.

This patch could optionally be applied to maint (to which it can be
rebased cleanly), though the bug that it fixes is relatively benign.

 cache.h |    9 +++++++++
 hex.c   |   10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git cache.h cache.h
index 607c2ea..e7bbc0d 100644
--- cache.h
+++ cache.h
@@ -819,7 +819,16 @@ static inline int get_sha1_with_context(const char *str, unsigned char *sha1, st
 {
 	return get_sha1_with_context_1(str, sha1, orc, 0, NULL);
 }
+
+/*
+ * Try to read a SHA1 in hexadecimal format from the 40 characters
+ * starting at hex.  Write the 20-byte result to sha1 in binary form.
+ * Return 0 on success.  Reading stops if a NUL is encountered in the
+ * input, so it is safe to pass this function an arbitrary
+ * null-terminated string.
+ */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
+
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
diff --git hex.c hex.c
index bb402fb..9ebc050 100644
--- hex.c
+++ hex.c
@@ -39,7 +39,15 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 {
 	int i;
 	for (i = 0; i < 20; i++) {
-		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+		unsigned int val;
+		/*
+		 * hex[1]=='\0' is caught when val is checked below,
+		 * but if hex[0] is NUL we have to avoid reading
+		 * past the end of the string:
+		 */
+		if (!hex[0])
+			return -1;
+		val = (hexval(hex[0]) << 4) | hexval(hex[1]);
 		if (val & ~0xff)
 			return -1;
 		*sha1++ = val;
-- 
1.7.7.rc2
