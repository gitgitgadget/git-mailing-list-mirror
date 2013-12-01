From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/5] strbuf: introduce starts_with() and ends_with()
Date: Sun, 01 Dec 2013 08:49:16 +0100
Message-ID: <20131201074919.3042.28757.chriscool@tuxfamily.org>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 01 08:50:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn1nq-0004Pp-HE
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 08:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899Ab3LAHuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 02:50:51 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:55884 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750848Ab3LAHu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 02:50:28 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 165AE9A;
	Sun,  1 Dec 2013 08:50:07 +0100 (CET)
X-git-sha1: 96ea20fafb5b933e5d5881cff38733e03b7cde36 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238583>

prefixcmp() and suffixcmp() cannot be really used as comparison
functions as they are not antisymmetric:

        prefixcmp("foo", "foobar") < 0
        prefixcmp("foobar", "foo") == 0

So they are not suitable as functions for passing to qsort.
And in fact they are used nowhere as comparison functions.

Therefore we should replace them with functions that just check
for equality.

As a first step toward this goal, this patch introduces
starts_with() and end_with() that will be used to replace
respectively prefixcmp() and suffixcmp().

Some popular programming languages, like Java, Python and Ruby
have functions or methods called like starts_with() and
ends_with() that are doing what we want. Therefore it makes sense
to use such names.

In vcs-svn/fast_export.c, there was already an ends_with()
function that did the same thing. Let's use the new one instead
while at it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h     |  2 ++
 strbuf.c              | 18 ++++++++++++++++++
 vcs-svn/fast_export.c | 11 +----------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7776f12..b73916b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -350,7 +350,9 @@ extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_lis
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
+extern int starts_with(const char *str, const char *prefix);
 extern int prefixcmp(const char *str, const char *prefix);
+extern int ends_with(const char *str, const char *suffix);
 extern int suffixcmp(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
diff --git a/strbuf.c b/strbuf.c
index 1170d01..83caf4a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,6 +1,15 @@
 #include "cache.h"
 #include "refs.h"
 
+int starts_with(const char *str, const char *prefix)
+{
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return 1;
+		else if (*str != *prefix)
+			return 0;
+}
+
 int prefixcmp(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
@@ -10,6 +19,15 @@ int prefixcmp(const char *str, const char *prefix)
 			return (unsigned char)*prefix - (unsigned char)*str;
 }
 
+int ends_with(const char *str, const char *suffix)
+{
+	int len = strlen(str), suflen = strlen(suffix);
+	if (len < suflen)
+		return 0;
+	else
+		return !strcmp(str + len - suflen, suffix);
+}
+
 int suffixcmp(const char *str, const char *suffix)
 {
 	int len = strlen(str), suflen = strlen(suffix);
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index f2b23c8..bd0f2c2 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -162,22 +162,13 @@ static void die_short_read(struct line_buffer *input)
 	die("invalid dump: unexpected end of file");
 }
 
-static int ends_with(const char *s, size_t len, const char *suffix)
-{
-	const size_t suffixlen = strlen(suffix);
-	if (len < suffixlen)
-		return 0;
-	return !memcmp(s + len - suffixlen, suffix, suffixlen);
-}
-
 static int parse_cat_response_line(const char *header, off_t *len)
 {
-	size_t headerlen = strlen(header);
 	uintmax_t n;
 	const char *type;
 	const char *end;
 
-	if (ends_with(header, headerlen, " missing"))
+	if (ends_with(header, " missing"))
 		return error("cat-blob reports missing blob: %s", header);
 	type = strstr(header, " blob ");
 	if (!type)
-- 
1.8.4.1.561.g12affca
