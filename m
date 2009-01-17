From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] color: make it easier for non-config to parse color
	specs
Date: Sat, 17 Jan 2009 10:32:30 -0500
Message-ID: <20090117153229.GA27071@coredump.intra.peff.net>
References: <20090117152108.GA24899@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 16:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODCW-00066A-9g
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759264AbZAQPce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758992AbZAQPcd
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:32:33 -0500
Received: from peff.net ([208.65.91.99]:39322 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758922AbZAQPcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:32:32 -0500
Received: (qmail 31611 invoked by uid 107); 17 Jan 2009 15:32:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Jan 2009 10:32:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Jan 2009 10:32:30 -0500
Content-Disposition: inline
In-Reply-To: <20090117152108.GA24899@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106059>

We have very featureful color-parsing routines which are
used for color.diff.* and other options. Let's make it
easier to use those routines from other parts of the code.

This patch adds a color_parse_mem() helper function which
takes a length-bounded string instead of a NUL-terminated
one. While the helper is only a few lines long, it is nice
to abstract this out so that:

 - callers don't forget to free() the temporary buffer

 - right now, it is implemented in terms of color_parse().
   But it would be more efficient to reverse this and
   implement color_parse in terms of color_parse_mem.

This also changes the error string for an invalid color not
to mention the word "config", since it is not always
appropriate (and when it is, the context is obvious since
the offending config variable is given).

Finally, while we are in the area, we clean up the parameter
names in the declaration of color_parse; the var and value
parameters were reversed from the actual implementation.

Signed-off-by: Jeff King <peff@peff.net>
---
Just setup for the next patch.

 color.c |    9 ++++++++-
 color.h |    3 ++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/color.c b/color.c
index fc0b72a..54a3da1 100644
--- a/color.c
+++ b/color.c
@@ -115,7 +115,7 @@ void color_parse(const char *value, const char *var, char *dst)
 	*dst = 0;
 	return;
 bad:
-	die("bad config value '%s' for variable '%s'", value, var);
+	die("bad color value '%s' for variable '%s'", value, var);
 }
 
 int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
@@ -191,3 +191,10 @@ int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...)
 	va_end(args);
 	return r;
 }
+
+void color_parse_mem(const char *value, int len, const char *var, char *dst)
+{
+	char *tmp = xmemdupz(value, len);
+	color_parse(tmp, var, dst);
+	free(tmp);
+}
diff --git a/color.h b/color.h
index 6cf5c88..7066099 100644
--- a/color.h
+++ b/color.h
@@ -16,7 +16,8 @@ extern int git_use_color_default;
 int git_color_default_config(const char *var, const char *value, void *cb);
 
 int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
-void color_parse(const char *var, const char *value, char *dst);
+void color_parse(const char *value, const char *var, char *dst);
+void color_parse_mem(const char *value, int len, const char *var, char *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
 
-- 
1.6.1.238.g32268.dirty
