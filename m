From: Jeff King <peff@peff.net>
Subject: [PATCH 27/68] config: use xstrfmt in normalize_value
Date: Thu, 24 Sep 2015 17:07:05 -0400
Message-ID: <20150924210705.GX30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDjf-0001wh-AE
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbbIXVHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:35965 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753076AbbIXVHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:07 -0400
Received: (qmail 11955 invoked by uid 102); 24 Sep 2015 21:07:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:07 -0500
Received: (qmail 29215 invoked by uid 107); 24 Sep 2015 21:07:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:05 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278585>

We xmalloc a fixed-size buffer and sprintf into it; this is
OK because the size of our formatting types is finite, but
that's not immediately clear to a reader auditing sprintf
calls. Let's switch to xstrfmt, which is shorter and
obviously correct.

Note that just dropping the common xmalloc here causes gcc
to complain with -Wmaybe-uninitialized. That's because if
"types" does not match any of our known types, we never
write anything into the "normalized" pointer. With the
current code, gcc doesn't notice because we always return a
valid pointer (just one which might point to uninitialized
data, but the compiler doesn't know that). In other words,
the current code is potentially buggy if new types are added
without updating this spot.

So let's take this opportunity to clean up the function a
bit more. We can drop the "normalized" pointer entirely, and
just return directly from each code path. And then add an
assertion at the end in case we haven't covered any cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 71acc44..adc7727 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -246,8 +246,6 @@ free_strings:
 
 static char *normalize_value(const char *key, const char *value)
 {
-	char *normalized;
-
 	if (!value)
 		return NULL;
 
@@ -258,27 +256,21 @@ static char *normalize_value(const char *key, const char *value)
 		 * "~/foobar/" in the config file, and to expand the ~
 		 * when retrieving the value.
 		 */
-		normalized = xstrdup(value);
-	else {
-		normalized = xmalloc(64);
-		if (types == TYPE_INT) {
-			int64_t v = git_config_int64(key, value);
-			sprintf(normalized, "%"PRId64, v);
-		}
-		else if (types == TYPE_BOOL)
-			sprintf(normalized, "%s",
-				git_config_bool(key, value) ? "true" : "false");
-		else if (types == TYPE_BOOL_OR_INT) {
-			int is_bool, v;
-			v = git_config_bool_or_int(key, value, &is_bool);
-			if (!is_bool)
-				sprintf(normalized, "%d", v);
-			else
-				sprintf(normalized, "%s", v ? "true" : "false");
-		}
+		return xstrdup(value);
+	if (types == TYPE_INT)
+		return xstrfmt("%"PRId64, git_config_int64(key, value));
+	if (types == TYPE_BOOL)
+		return xstrdup(git_config_bool(key, value) ?  "true" : "false");
+	if (types == TYPE_BOOL_OR_INT) {
+		int is_bool, v;
+		v = git_config_bool_or_int(key, value, &is_bool);
+		if (!is_bool)
+			return xstrfmt("%d", v);
+		else
+			return xstrdup(v ? "true" : "false");
 	}
 
-	return normalized;
+	die("BUG: cannot normalize type %d", types);
 }
 
 static int get_color_found;
-- 
2.6.0.rc3.454.g204ad51
