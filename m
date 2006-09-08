From: Jeff King <peff@peff.net>
Subject: [PATCH] Move color option parsing out of diff.c and into color.[ch]
Date: Fri, 8 Sep 2006 04:03:18 -0400
Message-ID: <20060908080318.GA3771@coredump.intra.peff.net>
References: <20060908073452.GA25343@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 10:03:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLbKk-000152-A9
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 10:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWIHIDX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 04:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWIHIDX
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 04:03:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:739 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750920AbWIHIDU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 04:03:20 -0400
Received: (qmail 3295 invoked from network); 8 Sep 2006 04:02:44 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Sep 2006 04:02:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  8 Sep 2006 04:03:18 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060908073452.GA25343@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26681>

The intent is to lib-ify colorizing code so it can be reused.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a resend with formatting cleanups and a new function,
color_printf_ln.

 Makefile |    3 +
 color.c  |  176 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 color.h  |   12 ++++
 diff.c   |  136 +-----------------------------------------------
 4 files changed, 194 insertions(+), 133 deletions(-)

diff --git a/Makefile b/Makefile
index 7b3114f..78748cb 100644
--- a/Makefile
+++ b/Makefile
@@ -251,7 +251,8 @@ LIB_OBJS = \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o \
-	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS)
+	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
+	color.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/color.c b/color.c
new file mode 100644
index 0000000..a949136
--- /dev/null
+++ b/color.c
@@ -0,0 +1,176 @@
+#include "color.h"
+#include "cache.h"
+#include "git-compat-util.h"
+
+#include <stdarg.h>
+
+#define COLOR_RESET "\033[m"
+
+static int parse_color(const char *name, int len)
+{
+	static const char * const color_names[] = {
+		"normal", "black", "red", "green", "yellow",
+		"blue", "magenta", "cyan", "white"
+	};
+	char *end;
+	int i;
+	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
+		const char *str = color_names[i];
+		if (!strncasecmp(name, str, len) && !str[len])
+			return i - 1;
+	}
+	i = strtol(name, &end, 10);
+	if (*name && !*end && i >= -1 && i <= 255)
+		return i;
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
+void color_parse(const char *value, const char *var, char *dst)
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
+			if (fg < 8) {
+				*dst++ = '3';
+				*dst++ = '0' + fg;
+			} else {
+				dst += sprintf(dst, "38;5;%d", fg);
+			}
+		}
+		if (bg >= 0) {
+			if (sep++)
+				*dst++ = ';';
+			if (bg < 8) {
+				*dst++ = '4';
+				*dst++ = '0' + bg;
+			} else {
+				dst += sprintf(dst, "48;5;%d", bg);
+			}
+		}
+		*dst++ = 'm';
+	}
+	*dst = 0;
+	return;
+bad:
+	die("bad config value '%s' for variable '%s'", value, var);
+}
+
+int git_config_colorbool(const char *var, const char *value)
+{
+	if (!value)
+		return 1;
+	if (!strcasecmp(value, "auto")) {
+		if (isatty(1) || (pager_in_use && pager_use_color)) {
+			char *term = getenv("TERM");
+			if (term && strcmp(term, "dumb"))
+				return 1;
+		}
+		return 0;
+	}
+	if (!strcasecmp(value, "never"))
+		return 0;
+	if (!strcasecmp(value, "always"))
+		return 1;
+	return git_config_bool(var, value);
+}
+
+static int color_vprintf(const char *color, const char *fmt,
+		va_list args, const char *trail)
+{
+	int r = 0;
+
+	if (*color)
+		r += printf("%s", color);
+	r += vprintf(fmt, args);
+	if (trail)
+		r += printf("%s", trail);
+	if (*color)
+		r += printf("%s", COLOR_RESET);
+	return r;
+}
+
+
+
+int color_printf(const char *color, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+	va_start(args, fmt);
+	r = color_vprintf(color, fmt, args, 0);
+	va_end(args);
+	return r;
+}
+
+int color_printf_ln(const char *color, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+	va_start(args, fmt);
+	r = color_vprintf(color, fmt, args, "\n");
+	va_end(args);
+	return r;
+}
diff --git a/color.h b/color.h
new file mode 100644
index 0000000..88bb8ff
--- /dev/null
+++ b/color.h
@@ -0,0 +1,12 @@
+#ifndef COLOR_H
+#define COLOR_H
+
+/* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
+#define COLOR_MAXLEN 24
+
+int git_config_colorbool(const char *var, const char *value);
+void color_parse(const char *var, const char *value, char *dst);
+int color_printf(const char *color, const char *fmt, ...);
+int color_printf_ln(const char *color, const char *fmt, ...);
+
+#endif /* COLOR_H */
diff --git a/diff.c b/diff.c
index a3ebc62..8178c11 100644
--- a/diff.c
+++ b/diff.c
@@ -10,6 +10,7 @@ #include "diff.h"
 #include "diffcore.h"
 #include "delta.h"
 #include "xdiff-interface.h"
+#include "color.h"
 
 static int use_size_cache;
 
@@ -17,8 +18,7 @@ static int diff_detect_rename_default;
 static int diff_rename_limit_default = -1;
 static int diff_use_color_default;
 
-/* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
-static char diff_colors[][24] = {
+static char diff_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
 	"",		/* normal */
 	"\033[1m",	/* bold */
@@ -45,119 +45,6 @@ static int parse_diff_color_slot(const c
 	die("bad config variable '%s'", var);
 }
 
-static int parse_color(const char *name, int len)
-{
-	static const char * const color_names[] = {
-		"normal", "black", "red", "green", "yellow",
-		"blue", "magenta", "cyan", "white"
-	};
-	char *end;
-	int i;
-	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
-		const char *str = color_names[i];
-		if (!strncasecmp(name, str, len) && !str[len])
-			return i - 1;
-	}
-	i = strtol(name, &end, 10);
-	if (*name && !*end && i >= -1 && i <= 255)
-		return i;
-	return -2;
-}
-
-static int parse_attr(const char *name, int len)
-{
-	static const int attr_values[] = { 1, 2, 4, 5, 7 };
-	static const char * const attr_names[] = {
-		"bold", "dim", "ul", "blink", "reverse"
-	};
-	int i;
-	for (i = 0; i < ARRAY_SIZE(attr_names); i++) {
-		const char *str = attr_names[i];
-		if (!strncasecmp(name, str, len) && !str[len])
-			return attr_values[i];
-	}
-	return -1;
-}
-
-static void parse_diff_color_value(const char *value, const char *var, char *dst)
-{
-	const char *ptr = value;
-	int attr = -1;
-	int fg = -2;
-	int bg = -2;
-
-	if (!strcasecmp(value, "reset")) {
-		strcpy(dst, "\033[m");
-		return;
-	}
-
-	/* [fg [bg]] [attr] */
-	while (*ptr) {
-		const char *word = ptr;
-		int val, len = 0;
-
-		while (word[len] && !isspace(word[len]))
-			len++;
-
-		ptr = word + len;
-		while (*ptr && isspace(*ptr))
-			ptr++;
-
-		val = parse_color(word, len);
-		if (val >= -1) {
-			if (fg == -2) {
-				fg = val;
-				continue;
-			}
-			if (bg == -2) {
-				bg = val;
-				continue;
-			}
-			goto bad;
-		}
-		val = parse_attr(word, len);
-		if (val < 0 || attr != -1)
-			goto bad;
-		attr = val;
-	}
-
-	if (attr >= 0 || fg >= 0 || bg >= 0) {
-		int sep = 0;
-
-		*dst++ = '\033';
-		*dst++ = '[';
-		if (attr >= 0) {
-			*dst++ = '0' + attr;
-			sep++;
-		}
-		if (fg >= 0) {
-			if (sep++)
-				*dst++ = ';';
-			if (fg < 8) {
-				*dst++ = '3';
-				*dst++ = '0' + fg;
-			} else {
-				dst += sprintf(dst, "38;5;%d", fg);
-			}
-		}
-		if (bg >= 0) {
-			if (sep++)
-				*dst++ = ';';
-			if (bg < 8) {
-				*dst++ = '4';
-				*dst++ = '0' + bg;
-			} else {
-				dst += sprintf(dst, "48;5;%d", bg);
-			}
-		}
-		*dst++ = 'm';
-	}
-	*dst = 0;
-	return;
-bad:
-	die("bad config value '%s' for variable '%s'", value, var);
-}
-
 /*
  * These are to give UI layer defaults.
  * The core-level commands such as git-diff-files should
@@ -171,22 +58,7 @@ int git_diff_ui_config(const char *var, 
 		return 0;
 	}
 	if (!strcmp(var, "diff.color")) {
-		if (!value)
-			diff_use_color_default = 1; /* bool */
-		else if (!strcasecmp(value, "auto")) {
-			diff_use_color_default = 0;
-			if (isatty(1) || (pager_in_use && pager_use_color)) {
-				char *term = getenv("TERM");
-				if (term && strcmp(term, "dumb"))
-					diff_use_color_default = 1;
-			}
-		}
-		else if (!strcasecmp(value, "never"))
-			diff_use_color_default = 0;
-		else if (!strcasecmp(value, "always"))
-			diff_use_color_default = 1;
-		else
-			diff_use_color_default = git_config_bool(var, value);
+		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "diff.renames")) {
@@ -201,7 +73,7 @@ int git_diff_ui_config(const char *var, 
 	}
 	if (!strncmp(var, "diff.color.", 11)) {
 		int slot = parse_diff_color_slot(var, 11);
-		parse_diff_color_value(value, var, diff_colors[slot]);
+		color_parse(value, var, diff_colors[slot]);
 		return 0;
 	}
 	return git_default_config(var, value);
-- 
1.4.2.g5290b
