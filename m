From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] parse_color: support 24-bit RGB values
Date: Thu, 20 Nov 2014 10:25:39 -0500
Message-ID: <20141120152539.GE23680@peff.net>
References: <20141120151418.GA23607@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Baker <bakers@canbytel.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:25:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrTcA-0000HC-IM
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664AbaKTPZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:25:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:42781 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752578AbaKTPZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 10:25:41 -0500
Received: (qmail 12124 invoked by uid 102); 20 Nov 2014 15:25:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 09:25:41 -0600
Received: (qmail 13097 invoked by uid 107); 20 Nov 2014 15:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 10:25:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 10:25:39 -0500
Content-Disposition: inline
In-Reply-To: <20141120151418.GA23607@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some terminals (like XTerm) allow full 24-bit RGB color
specifications using an extension to the regular ANSI color
scheme. Let's allow users to specify hex RGB colors,
enabling the all-important feature of hot pink ref
decorations:

  git log --format="%h%C(#ff69b4)%d%C(reset) %s"

Signed-off-by: Jeff King <peff@peff.net>
---
Also no clue on which terminals support it. I did all of my testing on
a recent version of XTerm. It looks like it doesn't provide true 24-bit
support, though. It is happy to accept the 24-bit colors, but if you do:

  for b in $(seq 255); do
    h=$(printf %02x $b)
    git --no-pager log -1 --format="%C(#0000$h)$b%C(reset)"
  done

the gradient seems to "jump" in discrete steps. That's fine, though.
It's a quality-of-implementation issue for the terminal, and I still
think that the RGB spec is way more readable than the 256-color mode
ones.

 Documentation/config.txt |  3 ++-
 color.c                  | 29 ++++++++++++++++++++++++++++-
 color.h                  |  6 +++---
 t/t4026-color.sh         |  4 ++++
 4 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f615a5c..a237b82 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -842,7 +842,8 @@ doesn't matter.
 +
 Colors (foreground and background) may also be given as numbers between
 0 and 255; these use ANSI 256-color mode (but note that not all
-terminals may support this).
+terminals may support this).  If your terminal supports it, you may also
+specify 24-bit RGB values as hex, like `#ff0ab3`.
 
 color.diff::
 	Whether to use ANSI escape sequences to add color to patches.
diff --git a/color.c b/color.c
index 6edbcae..78cdbed 100644
--- a/color.c
+++ b/color.c
@@ -32,10 +32,13 @@ struct color {
 		COLOR_UNSPECIFIED = 0,
 		COLOR_NORMAL,
 		COLOR_ANSI, /* basic 0-7 ANSI colors */
-		COLOR_256
+		COLOR_256,
+		COLOR_RGB
 	} state;
 	/* The numeric value for ANSI and 256-color modes */
 	unsigned char value;
+	/* 24-bit RGB color values */
+	unsigned char red, green, blue;
 };
 
 /*
@@ -47,6 +50,16 @@ static int match_word(const char *word, int len, const char *match)
 	return !strncasecmp(word, match, len) && !match[len];
 }
 
+static int get_hex_color(const char *in, unsigned char *out)
+{
+	unsigned int val;
+	val = (hexval(in[0]) << 4) | hexval(in[1]);
+	if (val & ~0xff)
+		return -1;
+	*out = val;
+	return 0;
+}
+
 static int parse_color(struct color *out, const char *name, int len)
 {
 	/* Positions in array must match ANSI color codes */
@@ -64,6 +77,16 @@ static int parse_color(struct color *out, const char *name, int len)
 		return 0;
 	}
 
+	/* Try a 24-bit RGB value */
+	if (len == 7 && name[0] == '#') {
+		if (!get_hex_color(name + 1, &out->red) &&
+		    !get_hex_color(name + 3, &out->green) &&
+		    !get_hex_color(name + 5, &out->blue)) {
+			out->state = COLOR_RGB;
+			return 0;
+		}
+	}
+
 	/* Then pick from our human-readable color names... */
 	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
 		if (match_word(name, len, color_names[i])) {
@@ -140,6 +163,10 @@ static char *color_output(char *out, const struct color *c, char type)
 	case COLOR_256:
 		out += sprintf(out, "%c8;5;%d", type, c->value);
 		break;
+	case COLOR_RGB:
+		out += sprintf(out, "%c8;2;%d;%d;%d", type,
+			       c->red, c->green, c->blue);
+		break;
 	}
 	return out;
 }
diff --git a/color.h b/color.h
index f5beab1..4ec34b4 100644
--- a/color.h
+++ b/color.h
@@ -9,14 +9,14 @@ struct strbuf;
  * The maximum length of ANSI color sequence we would generate:
  * - leading ESC '['            2
  * - attr + ';'                 2 * 8 (e.g. "1;")
- * - fg color + ';'             9 (e.g. "38;5;2xx;")
- * - fg color + ';'             9 (e.g. "48;5;2xx;")
+ * - fg color + ';'             17 (e.g. "38;2;255;255;255;")
+ * - bg color + ';'             17 (e.g. "48;2;255;255;255;")
  * - terminating 'm' NUL        2
  *
  * The above overcounts attr (we only use 5 not 8) and one semicolon
  * but it is close enough.
  */
-#define COLOR_MAXLEN 40
+#define COLOR_MAXLEN 56
 
 /*
  * IMPORTANT: Due to the way these color codes are emulated on Windows,
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 63e4238..65386db 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -53,6 +53,10 @@ test_expect_success '256 colors' '
 	color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
 
+test_expect_success '24-bit colors' '
+	color "#ff00ff black" "[38;2;255;0;255;40m"
+'
+
 test_expect_success '"normal" yields no color at all"' '
 	color "normal black" "[40m"
 '
-- 
2.2.0.rc2.402.g4519813
