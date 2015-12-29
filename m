From: Jeff King <peff@peff.net>
Subject: [PATCH 01/14] move string functions out of git-compat-util
Date: Tue, 29 Dec 2015 02:19:37 -0500
Message-ID: <20151229071936.GA8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:19:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoZL-0006JQ-DS
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbbL2HTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:19:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:46610 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752706AbbL2HTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:19:39 -0500
Received: (qmail 17668 invoked by uid 102); 29 Dec 2015 07:19:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:19:39 -0600
Received: (qmail 19777 invoked by uid 107); 29 Dec 2015 07:19:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:19:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:19:37 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283092>

We have several inline string helpers (skip_prefix, etc)
defined in git-compat-util.h. This is convenient, as it
makes them available everywhere, but this is probably not
the best place for them. Besides cluttering a file which is
otherwise mostly about compatibility issues, defining inline
functions in git-compat-util.h restricts what they can do.

For instance, if we wanted to use tolower() in one of the
functions, we run into an ordering problem with our
redefinitions of tolower(), which are done later in
git-compat-util.h.

This patch moves them to their own header file, strutil.h.
However, it also includes them in strbuf.h (which needs them
for its inline strbuf_strip_suffix). This also puts them
indirectly into cache.h, which means they are effectively
available everywhere (just as they were before).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 63 ---------------------------------------------------
 strbuf.h          |  2 ++
 strutil.h         | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 63 deletions(-)
 create mode 100644 strutil.h

diff --git a/git-compat-util.h b/git-compat-util.h
index 2da0a75..da67dc6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -430,69 +430,6 @@ extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
-extern int starts_with(const char *str, const char *prefix);
-
-/*
- * If the string "str" begins with the string found in "prefix", return 1.
- * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
- * the string right after the prefix).
- *
- * Otherwise, return 0 and leave "out" untouched.
- *
- * Examples:
- *
- *   [extract branch name, fail if not a branch]
- *   if (!skip_prefix(ref, "refs/heads/", &branch)
- *	return -1;
- *
- *   [skip prefix if present, otherwise use whole string]
- *   skip_prefix(name, "refs/heads/", &name);
- */
-static inline int skip_prefix(const char *str, const char *prefix,
-			      const char **out)
-{
-	do {
-		if (!*prefix) {
-			*out = str;
-			return 1;
-		}
-	} while (*str++ == *prefix++);
-	return 0;
-}
-
-/*
- * If buf ends with suffix, return 1 and subtract the length of the suffix
- * from *len. Otherwise, return 0 and leave *len untouched.
- */
-static inline int strip_suffix_mem(const char *buf, size_t *len,
-				   const char *suffix)
-{
-	size_t suflen = strlen(suffix);
-	if (*len < suflen || memcmp(buf + (*len - suflen), suffix, suflen))
-		return 0;
-	*len -= suflen;
-	return 1;
-}
-
-/*
- * If str ends with suffix, return 1 and set *len to the size of the string
- * without the suffix. Otherwise, return 0 and set *len to the size of the
- * string.
- *
- * Note that we do _not_ NUL-terminate str to the new length.
- */
-static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
-{
-	*len = strlen(str);
-	return strip_suffix_mem(str, len, suffix);
-}
-
-static inline int ends_with(const char *str, const char *suffix)
-{
-	size_t len;
-	return strip_suffix(str, suffix, &len);
-}
-
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
 
 #ifndef PROT_READ
diff --git a/strbuf.h b/strbuf.h
index 7123fca..a1a2df9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,8 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+#include "strutil.h"
+
 /**
  * strbuf's are meant to be used with all the usual C string and memory
  * APIs. Given that the length of the buffer is known, it's often better to
diff --git a/strutil.h b/strutil.h
new file mode 100644
index 0000000..4fa2071
--- /dev/null
+++ b/strutil.h
@@ -0,0 +1,67 @@
+#ifndef STRUTIL_H
+#define STRUTIL_H
+
+extern int starts_with(const char *str, const char *prefix);
+
+/*
+ * If the string "str" begins with the string found in "prefix", return 1.
+ * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
+ * the string right after the prefix).
+ *
+ * Otherwise, return 0 and leave "out" untouched.
+ *
+ * Examples:
+ *
+ *   [extract branch name, fail if not a branch]
+ *   if (!skip_prefix(ref, "refs/heads/", &branch)
+ *	return -1;
+ *
+ *   [skip prefix if present, otherwise use whole string]
+ *   skip_prefix(name, "refs/heads/", &name);
+ */
+static inline int skip_prefix(const char *str, const char *prefix,
+			      const char **out)
+{
+	do {
+		if (!*prefix) {
+			*out = str;
+			return 1;
+		}
+	} while (*str++ == *prefix++);
+	return 0;
+}
+
+/*
+ * If buf ends with suffix, return 1 and subtract the length of the suffix
+ * from *len. Otherwise, return 0 and leave *len untouched.
+ */
+static inline int strip_suffix_mem(const char *buf, size_t *len,
+				   const char *suffix)
+{
+	size_t suflen = strlen(suffix);
+	if (*len < suflen || memcmp(buf + (*len - suflen), suffix, suflen))
+		return 0;
+	*len -= suflen;
+	return 1;
+}
+
+/*
+ * If str ends with suffix, return 1 and set *len to the size of the string
+ * without the suffix. Otherwise, return 0 and set *len to the size of the
+ * string.
+ *
+ * Note that we do _not_ NUL-terminate str to the new length.
+ */
+static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
+{
+	*len = strlen(str);
+	return strip_suffix_mem(str, len, suffix);
+}
+
+static inline int ends_with(const char *str, const char *suffix)
+{
+	size_t len;
+	return strip_suffix(str, suffix, &len);
+}
+
+#endif /* STRUTIL_H */
-- 
2.7.0.rc3.367.g09631da
