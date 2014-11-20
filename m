From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] parse_color: recognize "no$foo" to clear the $foo
 attribute
Date: Thu, 20 Nov 2014 10:25:52 -0500
Message-ID: <20141120152551.GF23680@peff.net>
References: <20141120151418.GA23607@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Baker <bakers@canbytel.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:26:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrTcS-0000PE-TF
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212AbaKTPZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:25:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:42785 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757084AbaKTPZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 10:25:55 -0500
Received: (qmail 12132 invoked by uid 102); 20 Nov 2014 15:25:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 09:25:53 -0600
Received: (qmail 13114 invoked by uid 107); 20 Nov 2014 15:26:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 10:26:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 10:25:52 -0500
Content-Disposition: inline
In-Reply-To: <20141120151418.GA23607@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can turn on ANSI text attributes like "reverse" by
putting "reverse" in your color spec. However, you cannot
ask to turn reverse off.

For common cases, this does not matter. You would turn on
"reverse" at the start of a colored section, and then clear
all attributes with a "reset". However, you may wish to turn
on some attributes, then selectively disable others. For
example:

  git log --format="%C(bold ul yellow)%h%C(noul) %s"

underlines just the hash, but without the need to re-specify
the rest of the attributes. This can also help third-party
programs, like contrib/diff-highlight, that want to turn
some attribute on/off without disrupting existing coloring.

Note that some attribute specifications are probably
nonsensical (e.g., "bold nobold"). We do not bother to flag
such constructs, and instead let the terminal sort it out.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |  3 ++-
 color.c                  |  8 +++++---
 color.h                  |  4 ++--
 t/t4026-color.sh         | 11 +++++++++++
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a237b82..7deae0b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -838,7 +838,8 @@ accepted are `normal`, `black`, `red`, `green`, `yellow`, `blue`,
 `magenta`, `cyan` and `white`; the attributes are `bold`, `dim`, `ul`,
 `blink` and `reverse`.  The first color given is the foreground; the
 second is the background.  The position of the attribute, if any,
-doesn't matter.
+doesn't matter. Attributes may be turned off specifically by prefixing
+them with `no` (e.g., `noreverse`, `noul`, etc).
 +
 Colors (foreground and background) may also be given as numbers between
 0 and 255; these use ANSI 256-color mode (but note that not all
diff --git a/color.c b/color.c
index 78cdbed..8dbd714 100644
--- a/color.c
+++ b/color.c
@@ -124,9 +124,11 @@ static int parse_color(struct color *out, const char *name, int len)
 
 static int parse_attr(const char *name, int len)
 {
-	static const int attr_values[] = { 1, 2, 4, 5, 7 };
+	static const int attr_values[] = { 1, 2, 4, 5, 7,
+					   22, 22, 24, 25, 27 };
 	static const char * const attr_names[] = {
-		"bold", "dim", "ul", "blink", "reverse"
+		"bold", "dim", "ul", "blink", "reverse",
+		"nobold", "nodim", "noul", "noblink", "noreverse"
 	};
 	int i;
 	for (i = 0; i < ARRAY_SIZE(attr_names); i++) {
@@ -238,7 +240,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			attr &= ~bit;
 			if (sep++)
 				*dst++ = ';';
-			*dst++ = '0' + i;
+			dst += sprintf(dst, "%d", i);
 		}
 		if (!color_empty(&fg)) {
 			if (sep++)
diff --git a/color.h b/color.h
index 4ec34b4..7fe77fb 100644
--- a/color.h
+++ b/color.h
@@ -8,7 +8,7 @@ struct strbuf;
 /*
  * The maximum length of ANSI color sequence we would generate:
  * - leading ESC '['            2
- * - attr + ';'                 2 * 8 (e.g. "1;")
+ * - attr + ';'                 3 * 10 (e.g. "1;")
  * - fg color + ';'             17 (e.g. "38;2;255;255;255;")
  * - bg color + ';'             17 (e.g. "48;2;255;255;255;")
  * - terminating 'm' NUL        2
@@ -16,7 +16,7 @@ struct strbuf;
  * The above overcounts attr (we only use 5 not 8) and one semicolon
  * but it is close enough.
  */
-#define COLOR_MAXLEN 56
+#define COLOR_MAXLEN 70
 
 /*
  * IMPORTANT: Due to the way these color codes are emulated on Windows,
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 65386db..267c43b 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -45,10 +45,21 @@ test_expect_success 'fg bg attr...' '
 	color "blue bold dim ul blink reverse" "[1;2;4;5;7;34m"
 '
 
+# note that nobold and nodim are the same code (22)
+test_expect_success 'attr negation' '
+	color "nobold nodim noul noblink noreverse" "[22;24;25;27m"
+'
+
 test_expect_success 'long color specification' '
 	color "254 255 bold dim ul blink reverse" "[1;2;4;5;7;38;5;254;48;5;255m"
 '
 
+test_expect_success 'absurdly long color specification' '
+	color \
+	  "#ffffff #ffffff bold nobold dim nodim ul noul blink noblink reverse noreverse" \
+	  "[1;2;4;5;7;22;24;25;27;38;2;255;255;255;48;2;255;255;255m"
+'
+
 test_expect_success '256 colors' '
 	color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
-- 
2.2.0.rc2.402.g4519813
