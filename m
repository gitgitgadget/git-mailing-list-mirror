From: Jeff King <peff@peff.net>
Subject: [PATCH 61/68] color: add color_set helper for copying raw colors
Date: Thu, 24 Sep 2015 17:08:21 -0400
Message-ID: <20150924210821.GF30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDkm-00028o-GP
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbbIXVI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:08:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:36037 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754400AbbIXVIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:08:24 -0400
Received: (qmail 12191 invoked by uid 102); 24 Sep 2015 21:08:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:08:24 -0500
Received: (qmail 29553 invoked by uid 107); 24 Sep 2015 21:08:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:08:21 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278604>

To set up default colors, we sometimes strcpy() from the
default string literals into our color buffers. This isn't a
bug (assuming the destination is COLOR_MAXLEN bytes), but
makes it harder to audit the code for problematic strcpy
calls.

Let's introduce a color_set which copies under the
assumption that there are COLOR_MAXLEN bytes in the
destination (of course you can call it on a smaller buffer,
so this isn't providing a huge amount of safety, but it's
more convenient than calling xsnprintf yourself).

Signed-off-by: Jeff King <peff@peff.net>
---
 color.c |  5 +++++
 color.h |  7 +++++++
 grep.c  | 32 ++++++++++++++++----------------
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/color.c b/color.c
index 22782f8..8f85153 100644
--- a/color.c
+++ b/color.c
@@ -145,6 +145,11 @@ int color_parse(const char *value, char *dst)
 	return color_parse_mem(value, strlen(value), dst);
 }
 
+void color_set(char *dst, const char *color_bytes)
+{
+	xsnprintf(dst, COLOR_MAXLEN, "%s", color_bytes);
+}
+
 /*
  * Write the ANSI color codes for "c" to "out"; the string should
  * already have the ANSI escape code in it. "out" should have enough
diff --git a/color.h b/color.h
index 7fe77fb..e155d13 100644
--- a/color.h
+++ b/color.h
@@ -75,6 +75,13 @@ extern int color_stdout_is_tty;
 int git_color_config(const char *var, const char *value, void *cb);
 int git_color_default_config(const char *var, const char *value, void *cb);
 
+/*
+ * Set the color buffer (which must be COLOR_MAXLEN bytes)
+ * to the raw color bytes; this is useful for initializing
+ * default color variables.
+ */
+void color_set(char *dst, const char *color_bytes);
+
 int git_config_colorbool(const char *var, const char *value);
 int want_color(int var);
 int color_parse(const char *value, char *dst);
diff --git a/grep.c b/grep.c
index 6c68d5b..7b2b96a 100644
--- a/grep.c
+++ b/grep.c
@@ -31,14 +31,14 @@ void init_grep_defaults(void)
 	opt->max_depth = -1;
 	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
 	opt->extended_regexp_option = 0;
-	strcpy(opt->color_context, "");
-	strcpy(opt->color_filename, "");
-	strcpy(opt->color_function, "");
-	strcpy(opt->color_lineno, "");
-	strcpy(opt->color_match_context, GIT_COLOR_BOLD_RED);
-	strcpy(opt->color_match_selected, GIT_COLOR_BOLD_RED);
-	strcpy(opt->color_selected, "");
-	strcpy(opt->color_sep, GIT_COLOR_CYAN);
+	color_set(opt->color_context, "");
+	color_set(opt->color_filename, "");
+	color_set(opt->color_function, "");
+	color_set(opt->color_lineno, "");
+	color_set(opt->color_match_context, GIT_COLOR_BOLD_RED);
+	color_set(opt->color_match_selected, GIT_COLOR_BOLD_RED);
+	color_set(opt->color_selected, "");
+	color_set(opt->color_sep, GIT_COLOR_CYAN);
 	opt->color = -1;
 }
 
@@ -151,14 +151,14 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->regflags = def->regflags;
 	opt->relative = def->relative;
 
-	strcpy(opt->color_context, def->color_context);
-	strcpy(opt->color_filename, def->color_filename);
-	strcpy(opt->color_function, def->color_function);
-	strcpy(opt->color_lineno, def->color_lineno);
-	strcpy(opt->color_match_context, def->color_match_context);
-	strcpy(opt->color_match_selected, def->color_match_selected);
-	strcpy(opt->color_selected, def->color_selected);
-	strcpy(opt->color_sep, def->color_sep);
+	color_set(opt->color_context, def->color_context);
+	color_set(opt->color_filename, def->color_filename);
+	color_set(opt->color_function, def->color_function);
+	color_set(opt->color_lineno, def->color_lineno);
+	color_set(opt->color_match_context, def->color_match_context);
+	color_set(opt->color_match_selected, def->color_match_selected);
+	color_set(opt->color_selected, def->color_selected);
+	color_set(opt->color_sep, def->color_sep);
 }
 
 void grep_commit_pattern_type(enum grep_pattern_type pattern_type, struct grep_opt *opt)
-- 
2.6.0.rc3.454.g204ad51
