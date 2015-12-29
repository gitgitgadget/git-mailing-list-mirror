From: Jeff King <peff@peff.net>
Subject: [PATCH 03/14] strutil: add skip_prefix_icase
Date: Tue, 29 Dec 2015 02:22:04 -0500
Message-ID: <20151229072204.GC8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:22:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDobk-0000AM-Nx
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbbL2HWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:22:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:46616 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753140AbbL2HWH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:22:07 -0500
Received: (qmail 17798 invoked by uid 102); 29 Dec 2015 07:22:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:22:07 -0600
Received: (qmail 19819 invoked by uid 107); 29 Dec 2015 07:22:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:22:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:22:04 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283094>

Some sites that otherwise would use skip_prefix cannot do
so, because it has no way to do case-insensitive
comparisons. Such sites usually get around this by using
strncasecmp, at the cost of having to use magic numbers.
We can help them by providing a case-insensitive version of
skip_prefix.

Unfortunately, we don't share any code with the original
skip_prefix. Since this is performance-sensitive code, we
would not want to introduce an extra "do we are about case?"
conditional into the middle of the loop. We could instead
use macros or another technique to generate the
almost-identical implementations, but the function simply
isn't long enough to merit that confusing boilerplate.

To show off the new function, we convert a simple case in
log's add_header function.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c |  8 ++++----
 strutil.h     | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 76823e6..44c6b26 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -677,10 +677,10 @@ static void add_header(const char *value)
 	struct string_list_item *item;
 	size_t len;
 
-	if (!strncasecmp(value, "to: ", 4))
-		item = string_list_append(&extra_to, value + 4);
-	else if (!strncasecmp(value, "cc: ", 4))
-		item = string_list_append(&extra_cc, value + 4);
+	if (skip_prefix_icase(value, "to: ", &value))
+		item = string_list_append(&extra_to, value);
+	else if (skip_prefix_icase(value, "cc: ", &value))
+		item = string_list_append(&extra_cc, value);
 	else
 		item = string_list_append(&extra_hdr, value);
 
diff --git a/strutil.h b/strutil.h
index 4fa2071..bb4c02d 100644
--- a/strutil.h
+++ b/strutil.h
@@ -32,6 +32,21 @@ static inline int skip_prefix(const char *str, const char *prefix,
 }
 
 /*
+ * Identical to skip_prefix, but compare characters case-insensitively.
+ */
+static inline int skip_prefix_icase(const char *str, const char *prefix,
+				    const char **out)
+{
+	do {
+		if (!*prefix) {
+			*out = str;
+			return 1;
+		}
+	} while (tolower(*str++) == tolower(*prefix++));
+	return 0;
+}
+
+/*
  * If buf ends with suffix, return 1 and subtract the length of the suffix
  * from *len. Otherwise, return 0 and leave *len untouched.
  */
-- 
2.7.0.rc3.367.g09631da
