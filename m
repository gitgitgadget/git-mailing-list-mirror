From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] diff: Support both attributes and colors
Date: Thu, 13 Jul 2006 19:06:12 +0300
Message-ID: <20060713190612.ee66dfba.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 18:11:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G13mA-0005Ep-8J
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 18:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWGMQKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGMQKl
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 12:10:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:27170 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751427AbWGMQKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 12:10:40 -0400
Received: by nf-out-0910.google.com with SMTP id p48so210754nfa
        for <git@vger.kernel.org>; Thu, 13 Jul 2006 09:10:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=DeWAtr4VxrQOxOBCIVh45QPWZByYFgJw+ZRFx0Z5dvi5GFv7uUm9ToeUTLMgjNV/WfYTJWnW+KpnWVHz8A6JJvfGJ8jJ07xJ50EEqko1baTLDbAx8eyJzXS1Nz0NgSyCBlCJJhYpQ1P4QRIl6qrpL8wFE3UV1eVRoCukYLRM/r4=
Received: by 10.48.4.17 with SMTP id 17mr1070168nfd;
        Thu, 13 Jul 2006 09:10:38 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.107])
        by mx.gmail.com with ESMTP id n22sm2019910nfc.2006.07.13.09.10.37;
        Thu, 13 Jul 2006 09:10:38 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.0; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23841>

Make it possible to set both colors and a attribute for diff colors.
Background colors are supported too.

Syntax is now:

	[attr] [fg [bg]]
	[fg [bg]] [attr]

Empty value is same as "normal normal", ie use default colors.  The new
syntax is backwards compatible.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 diff.c |  164 ++++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 107 insertions(+), 57 deletions(-)

diff --git a/diff.c b/diff.c
index a007019..a9118a9 100644
--- a/diff.c
+++ b/diff.c
@@ -26,30 +26,14 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 };
 
-#define COLOR_NORMAL  ""
-#define COLOR_BOLD    "\033[1m"
-#define COLOR_DIM     "\033[2m"
-#define COLOR_UL      "\033[4m"
-#define COLOR_BLINK   "\033[5m"
-#define COLOR_REVERSE "\033[7m"
-#define COLOR_RESET   "\033[m"
-
-#define COLOR_BLACK   "\033[30m"
-#define COLOR_RED     "\033[31m"
-#define COLOR_GREEN   "\033[32m"
-#define COLOR_YELLOW  "\033[33m"
-#define COLOR_BLUE    "\033[34m"
-#define COLOR_MAGENTA "\033[35m"
-#define COLOR_CYAN    "\033[36m"
-#define COLOR_WHITE   "\033[37m"
-
-static const char *diff_colors[] = {
-	COLOR_RESET,
-	COLOR_NORMAL,
-	COLOR_BOLD,
-	COLOR_CYAN,
-	COLOR_RED,
-	COLOR_GREEN
+/* "\033[1;30;47m\0" is 11 bytes */
+static char diff_colors[][16] = {
+	"\033[m",	/* reset */
+	"",		/* normal */
+	"\033[1m",	/* bold */
+	"\033[36m",	/* cyan */
+	"\033[31m",	/* red */
+	"\033[32m"	/* green */
 };
 
 static int parse_diff_color_slot(const char *var, int ofs)
@@ -67,38 +51,104 @@ static int parse_diff_color_slot(const c
 	die("bad config variable '%s'", var);
 }
 
-static const char *parse_diff_color_value(const char *value, const char *var)
-{
-	if (!strcasecmp(value, "normal"))
-		return COLOR_NORMAL;
-	if (!strcasecmp(value, "bold"))
-		return COLOR_BOLD;
-	if (!strcasecmp(value, "dim"))
-		return COLOR_DIM;
-	if (!strcasecmp(value, "ul"))
-		return COLOR_UL;
-	if (!strcasecmp(value, "blink"))
-		return COLOR_BLINK;
-	if (!strcasecmp(value, "reverse"))
-		return COLOR_REVERSE;
-	if (!strcasecmp(value, "reset"))
-		return COLOR_RESET;
-	if (!strcasecmp(value, "black"))
-		return COLOR_BLACK;
-	if (!strcasecmp(value, "red"))
-		return COLOR_RED;
-	if (!strcasecmp(value, "green"))
-		return COLOR_GREEN;
-	if (!strcasecmp(value, "yellow"))
-		return COLOR_YELLOW;
-	if (!strcasecmp(value, "blue"))
-		return COLOR_BLUE;
-	if (!strcasecmp(value, "magenta"))
-		return COLOR_MAGENTA;
-	if (!strcasecmp(value, "cyan"))
-		return COLOR_CYAN;
-	if (!strcasecmp(value, "white"))
-		return COLOR_WHITE;
+static int parse_color(const char *name, int len)
+{
+	static const char * const color_names[] = {
+		"normal", "black", "red", "green", "yellow",
+		"blue", "magenta", "cyan", "white"
+	};
+	int i;
+	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
+		const char *str = color_names[i];
+		if (!strncasecmp(name, str, len) && !str[len])
+			return i - 1;
+	}
+	return -2;
+}
+
+static int parse_attr(const char *name, int len)
+{
+	static const int attr_values[] = { 1, 2, 4, 5, 7 };
+	static const char * const attr_names[] = {
+		"bold", "dim", "ul", "blink", "reverse"
+	};
+	int i;
+	for (i = 0; i < ARRAY_SIZE(attr_names); i++) {
+		const char *str = attr_names[i];
+		if (!strncasecmp(name, str, len) && !str[len])
+			return attr_values[i];
+	}
+	return -1;
+}
+
+static void parse_diff_color_value(const char *value, const char *var, char *dst)
+{
+	const char *ptr = value;
+	int attr = -1;
+	int fg = -2;
+	int bg = -2;
+
+	if (!strcasecmp(value, "reset")) {
+		strcpy(dst, "\033[m");
+		return;
+	}
+
+	/* [fg [bg]] [attr] */
+	while (*ptr) {
+		const char *word = ptr;
+		int val, len = 0;
+
+		while (word[len] && !isspace(word[len]))
+			len++;
+
+		ptr = word + len;
+		while (*ptr && isspace(*ptr))
+			ptr++;
+
+		val = parse_color(word, len);
+		if (val >= -1) {
+			if (fg == -2) {
+				fg = val;
+				continue;
+			}
+			if (bg == -2) {
+				bg = val;
+				continue;
+			}
+			goto bad;
+		}
+		val = parse_attr(word, len);
+		if (val < 0 || attr != -1)
+			goto bad;
+		attr = val;
+	}
+
+	if (attr >= 0 || fg >= 0 || bg >= 0) {
+		int sep = 0;
+
+		*dst++ = '\033';
+		*dst++ = '[';
+		if (attr >= 0) {
+			*dst++ = '0' + attr;
+			sep++;
+		}
+		if (fg >= 0) {
+			if (sep++)
+				*dst++ = ';';
+			*dst++ = '3';
+			*dst++ = '0' + fg;
+		}
+		if (bg >= 0) {
+			if (sep++)
+				*dst++ = ';';
+			*dst++ = '4';
+			*dst++ = '0' + bg;
+		}
+		*dst++ = 'm';
+	}
+	*dst = 0;
+	return;
+bad:
 	die("bad config value '%s' for variable '%s'", value, var);
 }
 
@@ -145,7 +195,7 @@ int git_diff_ui_config(const char *var, 
 	}
 	if (!strncmp(var, "diff.color.", 11)) {
 		int slot = parse_diff_color_slot(var, 11);
-		diff_colors[slot] = parse_diff_color_value(value, var);
+		parse_diff_color_value(value, var, diff_colors[slot]);
 		return 0;
 	}
 	return git_default_config(var, value);
-- 
1.4.1.gd0c9d-dirty
