From: Jeff King <peff@peff.net>
Subject: [PATCH 55/68] color: add overflow checks for parsing colors
Date: Thu, 24 Sep 2015 17:08:07 -0400
Message-ID: <20150924210807.GZ30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDki-00028o-3h
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbbIXVIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:08:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:36024 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754392AbbIXVIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:08:10 -0400
Received: (qmail 12128 invoked by uid 102); 24 Sep 2015 21:08:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:08:09 -0500
Received: (qmail 29494 invoked by uid 107); 24 Sep 2015 21:08:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:08:07 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278601>

Our color parsing is designed to never exceed COLOR_MAXLEN
bytes. But the relationship between that hand-computed
number and the parsing code is not at all obvious, and we
merely hope that it has been computed correctly for all
cases.

Let's mark the expected "end" pointer for the destination
buffer and make sure that we do not exceed it.

Signed-off-by: Jeff King <peff@peff.net>
---
 color.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/color.c b/color.c
index 9027352..22782f8 100644
--- a/color.c
+++ b/color.c
@@ -150,22 +150,24 @@ int color_parse(const char *value, char *dst)
  * already have the ANSI escape code in it. "out" should have enough
  * space in it to fit any color.
  */
-static char *color_output(char *out, const struct color *c, char type)
+static char *color_output(char *out, int len, const struct color *c, char type)
 {
 	switch (c->type) {
 	case COLOR_UNSPECIFIED:
 	case COLOR_NORMAL:
 		break;
 	case COLOR_ANSI:
+		if (len < 2)
+			die("BUG: color parsing ran out of space");
 		*out++ = type;
 		*out++ = '0' + c->value;
 		break;
 	case COLOR_256:
-		out += sprintf(out, "%c8;5;%d", type, c->value);
+		out += xsnprintf(out, len, "%c8;5;%d", type, c->value);
 		break;
 	case COLOR_RGB:
-		out += sprintf(out, "%c8;2;%d;%d;%d", type,
-			       c->red, c->green, c->blue);
+		out += xsnprintf(out, len, "%c8;2;%d;%d;%d", type,
+				 c->red, c->green, c->blue);
 		break;
 	}
 	return out;
@@ -180,12 +182,13 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 {
 	const char *ptr = value;
 	int len = value_len;
+	char *end = dst + COLOR_MAXLEN;
 	unsigned int attr = 0;
 	struct color fg = { COLOR_UNSPECIFIED };
 	struct color bg = { COLOR_UNSPECIFIED };
 
 	if (!strncasecmp(value, "reset", len)) {
-		strcpy(dst, GIT_COLOR_RESET);
+		xsnprintf(dst, end - dst, GIT_COLOR_RESET);
 		return 0;
 	}
 
@@ -224,12 +227,19 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			goto bad;
 	}
 
+#undef OUT
+#define OUT(x) do { \
+	if (dst == end) \
+		die("BUG: color parsing ran out of space"); \
+	*dst++ = (x); \
+} while(0)
+
 	if (attr || !color_empty(&fg) || !color_empty(&bg)) {
 		int sep = 0;
 		int i;
 
-		*dst++ = '\033';
-		*dst++ = '[';
+		OUT('\033');
+		OUT('[');
 
 		for (i = 0; attr; i++) {
 			unsigned bit = (1 << i);
@@ -237,27 +247,28 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 				continue;
 			attr &= ~bit;
 			if (sep++)
-				*dst++ = ';';
-			dst += sprintf(dst, "%d", i);
+				OUT(';');
+			dst += xsnprintf(dst, end - dst, "%d", i);
 		}
 		if (!color_empty(&fg)) {
 			if (sep++)
-				*dst++ = ';';
+				OUT(';');
 			/* foreground colors are all in the 3x range */
-			dst = color_output(dst, &fg, '3');
+			dst = color_output(dst, end - dst, &fg, '3');
 		}
 		if (!color_empty(&bg)) {
 			if (sep++)
-				*dst++ = ';';
+				OUT(';');
 			/* background colors are all in the 4x range */
-			dst = color_output(dst, &bg, '4');
+			dst = color_output(dst, end - dst, &bg, '4');
 		}
-		*dst++ = 'm';
+		OUT('m');
 	}
-	*dst = 0;
+	OUT(0);
 	return 0;
 bad:
 	return error(_("invalid color value: %.*s"), value_len, value);
+#undef OUT
 }
 
 int git_config_colorbool(const char *var, const char *value)
-- 
2.6.0.rc3.454.g204ad51
