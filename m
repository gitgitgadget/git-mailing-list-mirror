From: Jeff King <peff@peff.net>
Subject: [PATCH 54/67] color: add overflow checks for parsing colors
Date: Tue, 15 Sep 2015 12:07:03 -0400
Message-ID: <20150915160703.GB29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:07:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbslX-000052-GP
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbbIOQHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:07:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:59446 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753481AbbIOQHG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:07:06 -0400
Received: (qmail 14183 invoked by uid 102); 15 Sep 2015 16:07:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:07:05 -0500
Received: (qmail 7853 invoked by uid 107); 15 Sep 2015 16:07:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:07:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:07:03 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277959>

Our color parsing is designed to never exceed COLOR_MAXLEN
bytes. But the relationship between that hand-computed
number and the parsing code is not at all obvious, and we
merely hope that it has been computed correctly for all
cases.

Let's mark the expected "end" pointer for the destination
buffer and make sure that we do not exceed it.

Signed-off-by: Jeff King <peff@peff.net>
---
 color.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/color.c b/color.c
index 9027352..3a3fa33 100644
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
 
@@ -224,12 +227,18 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			goto bad;
 	}
 
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
@@ -237,24 +246,24 @@ int color_parse_mem(const char *value, int value_len, char *dst)
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
-- 
2.6.0.rc2.408.ga2926b9
