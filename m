From: Junio C Hamano <junkio@cox.net>
Subject: Re: daemon.c broken on OpenBSD
Date: Sun, 23 Oct 2005 22:20:12 -0700
Message-ID: <7v64rnsd83.fsf@assigned-by-dhcp.cox.net>
References: <867jc336f4.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 07:20:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETukx-0007j7-8g
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 07:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVJXFUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 01:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVJXFUQ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 01:20:16 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62407 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750988AbVJXFUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 01:20:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024051956.PUHF9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Oct 2005 01:19:56 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <867jc336f4.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "23 Oct 2005 21:06:23 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10528>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Wow.
>...
> If that rings a bell, help me out here.  I'm guessing "isalnum" is getting
> defined (wrongly).  Yeah, looks like in cache.h.  Why is this getting
> defined?

Wow indeed.  It comes from this thread:

	http://marc.theaimsgroup.com/?l=git&m=112917422812418&w=2


Maybe something like this would help?

 ------------
[PATCH] do not override standard ctype macros, but use our own.

...since it can cause breakage in system supplied header files...

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

   It would be easier for *you* to grok if I say this patch is
   essentially this ;-):

	$ git-ls-files |
	xargs perl -i -p -e '
		s/\bis(space|digit|alpha|alnum)\b/is_$1/g;
		s/\bto(lower|upper)\b/to_$1/g;
	'

   except that I did not touch gitk.

diff --git a/apply.c b/apply.c
index e5c0b7d..9608f92 100644
--- a/apply.c
+++ b/apply.c
@@ -113,7 +113,7 @@ static unsigned long linelen(const char 
 
 static int is_dev_null(const char *str)
 {
-	return !memcmp("/dev/null", str, 9) && isspace(str[9]);
+	return !memcmp("/dev/null", str, 9) && is_space(str[9]);
 }
 
 #define TERM_SPACE	1
@@ -167,7 +167,7 @@ static char * find_name(const char *line
 	for (;;) {
 		char c = *line;
 
-		if (isspace(c)) {
+		if (is_space(c)) {
 			if (c == '\n')
 				break;
 			if (name_terminate(start, line-start, c, terminate))
@@ -447,7 +447,7 @@ static char *git_header_name(char *line,
 		/* second points at one past closing dq of name.
 		 * find the second name.
 		 */
-		while ((second < line + llen) && isspace(*second))
+		while ((second < line + llen) && is_space(*second))
 			second++;
 
 		if (line + llen <= second)
@@ -508,7 +508,7 @@ static char *git_header_name(char *line,
 			len = strlen(np);
 			if (len < cp - name &&
 			    !strncmp(np, name, len) &&
-			    isspace(name[len])) {
+			    is_space(name[len])) {
 				/* Good */
 				memmove(sp, np, len + 1);
 				return sp;
@@ -615,7 +615,7 @@ static int parse_num(const char *line, u
 {
 	char *ptr;
 
-	if (!isdigit(*line))
+	if (!is_digit(*line))
 		return 0;
 	*p = strtoul(line, &ptr, 10);
 	return ptr - line;
diff --git a/cache.h b/cache.h
index d776016..3f6ff0d 100644
--- a/cache.h
+++ b/cache.h
@@ -388,23 +388,17 @@ extern char git_default_email[MAX_GITNAM
 extern char git_default_name[MAX_GITNAME];
 
 /* Sane ctype - no locale, and works with signed chars */
-#undef isspace
-#undef isdigit
-#undef isalpha
-#undef isalnum
-#undef tolower
-#undef toupper
 extern unsigned char sane_ctype[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
-#define isspace(x) sane_istest(x,GIT_SPACE)
-#define isdigit(x) sane_istest(x,GIT_DIGIT)
-#define isalpha(x) sane_istest(x,GIT_ALPHA)
-#define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
-#define tolower(x) sane_case((unsigned char)(x), 0x20)
-#define toupper(x) sane_case((unsigned char)(x), 0)
+#define is_space(x) sane_istest(x,GIT_SPACE)
+#define is_digit(x) sane_istest(x,GIT_DIGIT)
+#define is_alpha(x) sane_istest(x,GIT_ALPHA)
+#define is_alnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
+#define to_lower(x) sane_case((unsigned char)(x), 0x20)
+#define to_upper(x) sane_case((unsigned char)(x), 0)
 
 static inline int sane_case(int x, int high)
 {
diff --git a/commit.c b/commit.c
index 8f40318..4d094b5 100644
--- a/commit.c
+++ b/commit.c
@@ -379,7 +379,7 @@ static int add_user_info(const char *wha
 
 static int is_empty_line(const char *line, int len)
 {
-	while (len && isspace(line[len-1]))
+	while (len && is_space(line[len-1]))
 		len--;
 	return !len;
 }
diff --git a/compat/strcasestr.c b/compat/strcasestr.c
index b96414d..d1a4253 100644
--- a/compat/strcasestr.c
+++ b/compat/strcasestr.c
@@ -12,7 +12,7 @@ char *gitstrcasestr(const char *haystack
 		for (j = 0; j < nlen; j++) {
 			unsigned char c1 = haystack[i+j];
 			unsigned char c2 = needle[j];
-			if (toupper(c1) != toupper(c2))
+			if (to_upper(c1) != to_upper(c2))
 				goto next;
 		}
 		return (char *) haystack + i;
diff --git a/config.c b/config.c
index 519fecf..24b017f 100644
--- a/config.c
+++ b/config.c
@@ -40,7 +40,7 @@ static char *parse_value(void)
 		}
 		if (comment)
 			continue;
-		if (isspace(c) && !quote) {
+		if (is_space(c) && !quote) {
 			space = 1;
 			continue;
 		}
@@ -97,9 +97,9 @@ static int get_value(config_fn_t fn, cha
 		c = get_next_char();
 		if (c == EOF)
 			break;
-		if (!isalnum(c))
+		if (!is_alnum(c))
 			break;
-		name[len++] = tolower(c);
+		name[len++] = to_lower(c);
 		if (len >= MAXNAME)
 			return -1;
 	}
@@ -128,11 +128,11 @@ static int get_base_var(char *name)
 			return -1;
 		if (c == ']')
 			return baselen;
-		if (!isalnum(c))
+		if (!is_alnum(c))
 			return -1;
 		if (baselen > MAXNAME / 2)
 			return -1;
-		name[baselen++] = tolower(c);
+		name[baselen++] = to_lower(c);
 	}
 }
 
@@ -151,7 +151,7 @@ static int git_parse_file(config_fn_t fn
 			comment = 0;
 			continue;
 		}
-		if (comment || isspace(c))
+		if (comment || is_space(c))
 			continue;
 		if (c == '#' || c == ';') {
 			comment = 1;
@@ -165,9 +165,9 @@ static int git_parse_file(config_fn_t fn
 			var[baselen] = 0;
 			continue;
 		}
-		if (!isalpha(c))
+		if (!is_alpha(c))
 			break;
-		var[baselen] = tolower(c);
+		var[baselen] = to_lower(c);
 		if (get_value(fn, var, baselen+1) < 0)
 			break;
 	}
diff --git a/convert-objects.c b/convert-objects.c
index a892013..621c1bb 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -166,7 +166,7 @@ static unsigned long parse_oldstyle_date
 	const char **fmt = formats;
 
 	p = buffer;
-	while (isspace(c = *buf))
+	while (is_space(c = *buf))
 		buf++;
 	while ((c = *buf++) != '\n')
 		*p++ = c;
@@ -181,7 +181,7 @@ static unsigned long parse_oldstyle_date
 			buf = next;
 		} else {
 			const char **p = timezones;
-			while (isspace(*buf))
+			while (is_space(*buf))
 				buf++;
 			while (*p) {
 				if (!memcmp(buf, *p, strlen(*p))) {
@@ -217,7 +217,7 @@ static int convert_date_line(char *dst, 
 	dst += len;
 
 	/* Is it already in new format? */
-	if (isdigit(*date)) {
+	if (is_digit(*date)) {
 		int datelen = next - date;
 		memcpy(dst, date, datelen);
 		return len + datelen;
diff --git a/date.c b/date.c
index 63f5a09..340052d 100644
--- a/date.c
+++ b/date.c
@@ -131,9 +131,9 @@ static int match_string(const char *date
 	for (i = 0; *date; date++, str++, i++) {
 		if (*date == *str)
 			continue;
-		if (toupper(*date) == toupper(*str))
+		if (to_upper(*date) == to_upper(*str))
 			continue;
-		if (!isalnum(*date))
+		if (!is_alnum(*date))
 			break;
 		return 0;
 	}
@@ -145,7 +145,7 @@ static int skip_alpha(const char *date)
 	int i = 0;
 	do {
 		i++;
-	} while (isalpha(date[i]));
+	} while (is_alpha(date[i]));
 	return i;
 }
 
@@ -229,7 +229,7 @@ static int match_multi_number(unsigned l
 
 	num2 = strtol(end+1, &end, 10);
 	num3 = -1;
-	if (*end == c && isdigit(end[1]))
+	if (*end == c && is_digit(end[1]))
 		num3 = strtol(end+1, &end, 10);
 
 	/* Time? Date? */
@@ -295,7 +295,7 @@ static int match_digit(const char *date,
 	case ':':
 	case '/':
 	case '-':
-		if (isdigit(end[1])) {
+		if (is_digit(end[1])) {
 			int match = match_multi_number(num, *end, date, end, tm);
 			if (match)
 				return match;
@@ -310,7 +310,7 @@ static int match_digit(const char *date,
 	n = 0;
 	do {
 		n++;
-	} while (isdigit(date[n]));
+	} while (is_digit(date[n]));
 
 	/* Four-digit year or a timezone? */
 	if (n == 4) {
@@ -420,11 +420,11 @@ int parse_date(const char *date, char *r
 		if (!c || c == '\n')
 			break;
 
-		if (isalpha(c))
+		if (is_alpha(c))
 			match = match_alpha(date, &tm, &offset);
-		else if (isdigit(c))
+		else if (is_digit(c))
 			match = match_digit(date, &tm, &offset, &tm_gmt);
-		else if ((c == '-' || c == '+') && isdigit(date[1]))
+		else if ((c == '-' || c == '+') && is_digit(date[1]))
 			match = match_tz(date, &offset);
 
 		if (!match) {
diff --git a/diff-tree.c b/diff-tree.c
index 382011a..f7b16eb 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -137,7 +137,7 @@ static int diff_tree_stdin(char *line)
 	line[len-1] = 0;
 	if (get_sha1_hex(line, commit))
 		return -1;
-	if (isspace(line[40]) && !get_sha1_hex(line+41, parent)) {
+	if (is_space(line[40]) && !get_sha1_hex(line+41, parent)) {
 		line[40] = 0;
 		line[81] = 0;
 		sprintf(this_header, "%s (from %s)\n", line, line+41);
diff --git a/ident.c b/ident.c
index bc89e1d..0a3d735 100644
--- a/ident.c
+++ b/ident.c
@@ -34,7 +34,7 @@ static void copy_gecos(struct passwd *w,
 		}
 		if (len + nlen < sz) {
 			/* Sorry, Mr. McDonald... */
-			*dst++ = toupper(*w->pw_name);
+			*dst++ = to_upper(*w->pw_name);
 			memcpy(dst, w->pw_name + 1, nlen - 1);
 			dst += nlen - 1;
 		}
diff --git a/mailinfo.c b/mailinfo.c
index cb853df..3a06240 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -6,9 +6,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <ctype.h>
 #include <iconv.h>
 
+#include "cache.h"
+
 #ifdef NO_STRCASESTR
 extern char *gitstrcasestr(const char *haystack, const char *needle);
 #endif
@@ -61,7 +62,7 @@ static int handle_from(char *line)
 	 */
 	while (at > line) {
 		char c = at[-1];
-		if (isspace(c))
+		if (is_space(c))
 			break;
 		if (c == '<') {
 			at[-1] = ' ';
@@ -72,7 +73,7 @@ static int handle_from(char *line)
 	dst = email;
 	for (;;) {
 		unsigned char c = *at;
-		if (!c || c == '>' || isspace(c)) {
+		if (!c || c == '>' || is_space(c)) {
 			if (c == '>')
 				*at = ' ';
 			break;
@@ -90,7 +91,7 @@ static int handle_from(char *line)
 	at = line + strlen(line);
 	while (at > line) {
 		unsigned char c = *--at;
-		if (!isspace(c)) {
+		if (!is_space(c)) {
 			at[(c == ')') ? 0 : 1] = 0;
 			break;
 		}
@@ -99,7 +100,7 @@ static int handle_from(char *line)
 	at = line;
 	for (;;) {
 		unsigned char c = *at;
-		if (!c || !isspace(c)) {
+		if (!c || !is_space(c)) {
 			if (c == '(')
 				at++;
 			break;
@@ -164,7 +165,7 @@ static int handle_subcontent_type(char *
 	if (*charset) {
 		int i, c;
 		for (i = 0; (c = charset[i]) != 0; i++)
-			charset[i] = tolower(c);
+			charset[i] = to_lower(c);
 	}
 	return 0;
 }
@@ -199,7 +200,7 @@ static int is_multipart_boundary(const c
 static int eatspace(char *line)
 {
 	int len = strlen(line);
-	while (len > 0 && isspace(line[len-1]))
+	while (len > 0 && is_space(line[len-1]))
 		line[--len] = 0;
 	return len;
 }
@@ -211,27 +212,27 @@ static int eatspace(char *line)
 /* First lines of body can have From:, Date:, and Subject: */
 static int handle_inbody_header(int *seen, char *line)
 {
-	if (!memcmp("From:", line, 5) && isspace(line[5])) {
+	if (!memcmp("From:", line, 5) && is_space(line[5])) {
 		if (!(*seen & SEEN_FROM) && handle_from(line+6)) {
 			*seen |= SEEN_FROM;
 			return 1;
 		}
 	}
-	if (!memcmp("Date:", line, 5) && isspace(line[5])) {
+	if (!memcmp("Date:", line, 5) && is_space(line[5])) {
 		if (!(*seen & SEEN_DATE)) {
 			handle_date(line+6);
 			*seen |= SEEN_DATE;
 			return 1;
 		}
 	}
-	if (!memcmp("Subject:", line, 8) && isspace(line[8])) {
+	if (!memcmp("Subject:", line, 8) && is_space(line[8])) {
 		if (!(*seen & SEEN_SUBJECT)) {
 			handle_subject(line+9);
 			*seen |= SEEN_SUBJECT;
 			return 1;
 		}
 	}
-	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
+	if (!memcmp("[PATCH]", line, 7) && is_space(line[7])) {
 		if (!(*seen & SEEN_SUBJECT)) {
 			handle_subject(line);
 			*seen |= SEEN_SUBJECT;
@@ -282,10 +283,10 @@ static void cleanup_space(char *buf)
 	unsigned char c;
 	while ((c = *buf) != 0) {
 		buf++;
-		if (isspace(c)) {
+		if (is_space(c)) {
 			buf[-1] = ' ';
 			c = *buf;
-			while (isspace(c)) {
+			while (is_space(c)) {
 				int len = strlen(buf);
 				memmove(buf, buf+1, len);
 				c = *buf;
@@ -312,7 +313,7 @@ static void check_header(char *line, int
 	for (i = 0; header[i].name; i++) {
 		int len = header[i].namelen;
 		if (!strncasecmp(line, header[i].name, len) &&
-		    line[len] == ':' && isspace(line[len + 1])) {
+		    line[len] == ':' && is_space(line[len + 1])) {
 			header[i].func(line + len + 2);
 			break;
 		}
@@ -491,7 +492,7 @@ static void decode_header_bq(char *it)
 		if (!cp)
 			return; /* no munging */
 		for (sp = ep; sp < cp; sp++)
-			charset_q[sp - ep] = tolower(*sp);
+			charset_q[sp - ep] = to_lower(*sp);
 		charset_q[cp - ep] = 0;
 		encoding = cp[1];
 		if (!encoding || cp[2] != '?')
@@ -499,7 +500,7 @@ static void decode_header_bq(char *it)
 		ep = strstr(cp + 3, "?=");
 		if (!ep)
 			return; /* no munging */
-		switch (tolower(encoding)) {
+		switch (to_lower(encoding)) {
 		default:
 			return; /* no munging */
 		case 'b':
@@ -709,11 +710,6 @@ static void handle_body(void)
 static const char mailinfo_usage[] =
 	"git-mailinfo [-k] [-u] msg patch <mail >info";
 
-static void usage(void) {
-	fprintf(stderr, "%s\n", mailinfo_usage);
-	exit(1);
-}
-
 int main(int argc, char **argv)
 {
 	while (1 < argc && argv[1][0] == '-') {
@@ -722,12 +718,12 @@ int main(int argc, char **argv)
 		else if (!strcmp(argv[1], "-u"))
 			metainfo_utf8 = 1;
 		else
-			usage();
+			usage(mailinfo_usage);
 		argc--; argv++;
 	}
 
 	if (argc != 3)
-		usage();
+		usage(mailinfo_usage);
 	cmitmsg = fopen(argv[1], "w");
 	if (!cmitmsg) {
 		perror(argv[1]);
diff --git a/mailsplit.c b/mailsplit.c
index 189f4ed..de9fb2b 100644
--- a/mailsplit.c
+++ b/mailsplit.c
@@ -33,11 +33,11 @@ static int is_from_line(const char *line
 			break;
 	}
 
-	if (!isdigit(colon[-4]) ||
-	    !isdigit(colon[-2]) ||
-	    !isdigit(colon[-1]) ||
-	    !isdigit(colon[ 1]) ||
-	    !isdigit(colon[ 2]))
+	if (!is_digit(colon[-4]) ||
+	    !is_digit(colon[-2]) ||
+	    !is_digit(colon[-1]) ||
+	    !is_digit(colon[ 1]) ||
+	    !is_digit(colon[ 2]))
 		return 0;
 
 	/* year */
diff --git a/pack-objects.c b/pack-objects.c
index b3e6152..314616d 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -464,7 +464,7 @@ int main(int argc, char **argv)
 		p = line+40;
 		while (*p) {
 			unsigned char c = *p++;
-			if (isspace(c))
+			if (is_space(c))
 				continue;
 			hash = hash * 11 + c;
 		}
diff --git a/patch-id.c b/patch-id.c
index edbc4aa..ba09d2a 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -21,7 +21,7 @@ static int remove_space(char *line)
 	unsigned char c;
 
 	while ((c = *src++) != '\0') {
-		if (!isspace(c))
+		if (!is_space(c))
 			*dst++ = c;
 	}
 	return dst - line;
diff --git a/refs.c b/refs.c
index 97506a4..4d202ee 100644
--- a/refs.c
+++ b/refs.c
@@ -43,7 +43,7 @@ int validate_symref(const char *path)
 		return -1;
 	buf = buffer + 4;
 	len -= 4;
-	while (len && isspace(*buf))
+	while (len && is_space(*buf))
 		buf++, len--;
 	if (len >= 5 && !memcmp("refs/", buf, 5))
 		return 0;
@@ -103,9 +103,9 @@ const char *resolve_ref(const char *path
 			break;
 		buf = buffer + 4;
 		len -= 4;
-		while (len && isspace(*buf))
+		while (len && is_space(*buf))
 			buf++, len--;
-		while (len && isspace(buf[len-1]))
+		while (len && is_space(buf[len-1]))
 			buf[--len] = 0;
 		path = git_path("%.*s", len, buf);
 	}
diff --git a/stripspace.c b/stripspace.c
index 96cd0a8..a6204b6 100644
--- a/stripspace.c
+++ b/stripspace.c
@@ -1,6 +1,6 @@
 #include <stdio.h>
 #include <string.h>
-#include <ctype.h>
+#include "cache.h"
 
 /*
  * Remove empty lines from the beginning and end.
@@ -15,7 +15,7 @@ static void cleanup(char *line)
 	if (len > 1 && line[len-1] == '\n') {
 		do {
 			unsigned char c = line[len-2];
-			if (!isspace(c))
+			if (!is_space(c))
 				break;
 			line[len-2] = '\n';
 			len--;
