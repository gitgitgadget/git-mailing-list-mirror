From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] parse_color: refactor color storage
Date: Thu, 20 Nov 2014 10:17:05 -0500
Message-ID: <20141120151704.GD23680@peff.net>
References: <20141120151418.GA23607@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Baker <bakers@canbytel.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:17:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrTTw-0004ha-CP
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757686AbaKTPRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:17:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:42776 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756195AbaKTPRH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 10:17:07 -0500
Received: (qmail 11737 invoked by uid 102); 20 Nov 2014 15:17:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 09:17:06 -0600
Received: (qmail 13065 invoked by uid 107); 20 Nov 2014 15:17:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 10:17:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 10:17:05 -0500
Content-Disposition: inline
In-Reply-To: <20141120151418.GA23607@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we parse a color name like "red" into its ANSI color
value, we pack the storage into a single int that may take
on many values:

  1. If it's "-2", no value has been specified.

  2. If it's "-1", the value is "normal" (i.e., no color).

  3. If it's 0 through 7, the value is a standard ANSI
     color.

  4. If it's larger (up to 255), it is a 256-color extended
     value.

Given these magic numbers, it is often hard to see what is
going on in the code. Let's refactor this into a struct with
a flag that tells which scheme we are using, along with a
numeric value. This is more verbose, but should hopefully be
simpler to follow. It will also allow us to easily add
support for more schemes, like 24-bit RGB values.

The result is also slightly less efficient to store, but
that's OK; we only store this intermediate state during the
parse, after which we write out the actual ANSI bytes.

Signed-off-by: Jeff King <peff@peff.net>
---
 color.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 106 insertions(+), 32 deletions(-)

diff --git a/color.c b/color.c
index 7941e93..6edbcae 100644
--- a/color.c
+++ b/color.c
@@ -26,23 +26,77 @@ const char *column_colors_ansi[] = {
 /* Ignore the RESET at the end when giving the size */
 const int column_colors_ansi_max = ARRAY_SIZE(column_colors_ansi) - 1;
 
-static int parse_color(const char *name, int len)
+/* An individual foreground or background color. */
+struct color {
+	enum {
+		COLOR_UNSPECIFIED = 0,
+		COLOR_NORMAL,
+		COLOR_ANSI, /* basic 0-7 ANSI colors */
+		COLOR_256
+	} state;
+	/* The numeric value for ANSI and 256-color modes */
+	unsigned char value;
+};
+
+/*
+ * "word" is a buffer of length "len"; does it match the NUL-terminated
+ * "match" exactly?
+ */
+static int match_word(const char *word, int len, const char *match)
 {
+	return !strncasecmp(word, match, len) && !match[len];
+}
+
+static int parse_color(struct color *out, const char *name, int len)
+{
+	/* Positions in array must match ANSI color codes */
 	static const char * const color_names[] = {
-		"normal", "black", "red", "green", "yellow",
+		"black", "red", "green", "yellow",
 		"blue", "magenta", "cyan", "white"
 	};
 	char *end;
 	int i;
+	long val;
+
+	/* First try the special word "normal"... */
+	if (match_word(name, len, "normal")) {
+		out->state = COLOR_NORMAL;
+		return 0;
+	}
+
+	/* Then pick from our human-readable color names... */
 	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
-		const char *str = color_names[i];
-		if (!strncasecmp(name, str, len) && !str[len])
-			return i - 1;
+		if (match_word(name, len, color_names[i])) {
+			out->state = COLOR_ANSI;
+			out->value = i;
+			return 0;
+		}
 	}
-	i = strtol(name, &end, 10);
-	if (end - name == len && i >= -1 && i <= 255)
-		return i;
-	return -2;
+
+	/* And finally try a literal 256-color-mode number */
+	val = strtol(name, &end, 10);
+	if (end - name == len) {
+		/*
+		 * Allow "-1" as an alias for "normal", but other negative
+		 * numbers are bogus.
+		 */
+		if (val < -1)
+			; /* fall through to error */
+		else if (val < 0) {
+			out->state = COLOR_NORMAL;
+			return 0;
+		/* Rewrite low numbers as more-portable standard colors. */
+		} else if (val < 8) {
+			out->state = COLOR_ANSI;
+			out->value = val;
+		} else if (val < 256) {
+			out->state = COLOR_256;
+			out->value = val;
+			return 0;
+		}
+	}
+
+	return -1;
 }
 
 static int parse_attr(const char *name, int len)
@@ -65,13 +119,43 @@ int color_parse(const char *value, char *dst)
 	return color_parse_mem(value, strlen(value), dst);
 }
 
+#define COLOR_FOREGROUND '3'
+#define COLOR_BACKGROUND '4'
+
+/*
+ * Write the ANSI color codes for "c" to "out"; the string should
+ * already have the ANSI escape code in it. "out" should have enough
+ * space in it to fit any color.
+ */
+static char *color_output(char *out, const struct color *c, char type)
+{
+	switch (c->state) {
+	case COLOR_UNSPECIFIED:
+	case COLOR_NORMAL:
+		break;
+	case COLOR_ANSI:
+		*out++ = type;
+		*out++ = '0' + c->value;
+		break;
+	case COLOR_256:
+		out += sprintf(out, "%c8;5;%d", type, c->value);
+		break;
+	}
+	return out;
+}
+
+static int color_empty(const struct color *c)
+{
+	return c->state <= COLOR_NORMAL;
+}
+
 int color_parse_mem(const char *value, int value_len, char *dst)
 {
 	const char *ptr = value;
 	int len = value_len;
 	unsigned int attr = 0;
-	int fg = -2;
-	int bg = -2;
+	struct color fg = { COLOR_UNSPECIFIED };
+	struct color bg = { COLOR_UNSPECIFIED };
 
 	if (!strncasecmp(value, "reset", len)) {
 		strcpy(dst, GIT_COLOR_RESET);
@@ -81,6 +165,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	/* [fg [bg]] [attr]... */
 	while (len > 0) {
 		const char *word = ptr;
+		struct color c;
 		int val, wordlen = 0;
 
 		while (len > 0 && !isspace(word[wordlen])) {
@@ -94,14 +179,13 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			len--;
 		}
 
-		val = parse_color(word, wordlen);
-		if (val >= -1) {
-			if (fg == -2) {
-				fg = val;
+		if (!parse_color(&c, word, wordlen)) {
+			if (fg.state == COLOR_UNSPECIFIED) {
+				fg = c;
 				continue;
 			}
-			if (bg == -2) {
-				bg = val;
+			if (bg.state == COLOR_UNSPECIFIED) {
+				bg = c;
 				continue;
 			}
 			goto bad;
@@ -113,7 +197,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			goto bad;
 	}
 
-	if (attr || fg >= 0 || bg >= 0) {
+	if (attr || !color_empty(&fg) || !color_empty(&bg)) {
 		int sep = 0;
 		int i;
 
@@ -129,25 +213,15 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 				*dst++ = ';';
 			*dst++ = '0' + i;
 		}
-		if (fg >= 0) {
+		if (!color_empty(&fg)) {
 			if (sep++)
 				*dst++ = ';';
-			if (fg < 8) {
-				*dst++ = '3';
-				*dst++ = '0' + fg;
-			} else {
-				dst += sprintf(dst, "38;5;%d", fg);
-			}
+			dst = color_output(dst, &fg, COLOR_FOREGROUND);
 		}
-		if (bg >= 0) {
+		if (!color_empty(&bg)) {
 			if (sep++)
 				*dst++ = ';';
-			if (bg < 8) {
-				*dst++ = '4';
-				*dst++ = '0' + bg;
-			} else {
-				dst += sprintf(dst, "48;5;%d", bg);
-			}
+			dst = color_output(dst, &bg, COLOR_BACKGROUND);
 		}
 		*dst++ = 'm';
 	}
-- 
2.2.0.rc2.402.g4519813
