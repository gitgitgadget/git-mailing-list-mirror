From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/86] pretty: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:05:59 +0100
Message-ID: <20131109070720.18178.27578.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2ho-0005cp-8A
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933382Ab3KIHLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:36 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65344 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933223Ab3KIHIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:23 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id BFD5B81;
	Sat,  9 Nov 2013 08:08:21 +0100 (CET)
X-git-sha1: d2d95a681b9b3eacfccae3ac1098b3eaeaa5aae9 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237537>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pretty.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/pretty.c b/pretty.c
index b4e32b7..961241a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -40,7 +40,7 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
 	const char *fmt;
 	int i;
 
-	if (prefixcmp(var, "pretty."))
+	if (!has_prefix(var, "pretty."))
 		return 0;
 
 	name = var + strlen("pretty.");
@@ -67,7 +67,7 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
 	commit_format->name = xstrdup(name);
 	commit_format->format = CMIT_FMT_USERFORMAT;
 	git_config_string(&fmt, var, value);
-	if (!prefixcmp(fmt, "format:") || !prefixcmp(fmt, "tformat:")) {
+	if (has_prefix(fmt, "format:") || has_prefix(fmt, "tformat:")) {
 		commit_format->is_tformat = fmt[0] == 't';
 		fmt = strchr(fmt, ':') + 1;
 	} else if (strchr(fmt, '%'))
@@ -115,7 +115,7 @@ static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
 	for (i = 0; i < commit_formats_len; i++) {
 		size_t match_len;
 
-		if (prefixcmp(commit_formats[i].name, sought))
+		if (!has_prefix(commit_formats[i].name, sought))
 			continue;
 
 		match_len = strlen(commit_formats[i].name);
@@ -151,7 +151,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		rev->commit_format = CMIT_FMT_DEFAULT;
 		return;
 	}
-	if (!prefixcmp(arg, "format:") || !prefixcmp(arg, "tformat:")) {
+	if (has_prefix(arg, "format:") || has_prefix(arg, "tformat:")) {
 		save_user_format(rev, strchr(arg, ':') + 1, arg[0] == 't');
 		return;
 	}
@@ -840,10 +840,10 @@ static void parse_commit_header(struct format_commit_context *context)
 
 		if (i == eol) {
 			break;
-		} else if (!prefixcmp(msg + i, "author ")) {
+		} else if (has_prefix(msg + i, "author ")) {
 			context->author.off = i + 7;
 			context->author.len = eol - i - 7;
-		} else if (!prefixcmp(msg + i, "committer ")) {
+		} else if (has_prefix(msg + i, "committer ")) {
 			context->committer.off = i + 10;
 			context->committer.len = eol - i - 10;
 		}
@@ -983,7 +983,7 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 
 		if (!end)
 			return 0;
-		if (!prefixcmp(begin, "auto,")) {
+		if (has_prefix(begin, "auto,")) {
 			if (!want_color(c->pretty_ctx->color))
 				return end - placeholder + 1;
 			begin += 5;
@@ -994,16 +994,16 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, color);
 		return end - placeholder + 1;
 	}
-	if (!prefixcmp(placeholder + 1, "red")) {
+	if (has_prefix(placeholder + 1, "red")) {
 		strbuf_addstr(sb, GIT_COLOR_RED);
 		return 4;
-	} else if (!prefixcmp(placeholder + 1, "green")) {
+	} else if (has_prefix(placeholder + 1, "green")) {
 		strbuf_addstr(sb, GIT_COLOR_GREEN);
 		return 6;
-	} else if (!prefixcmp(placeholder + 1, "blue")) {
+	} else if (has_prefix(placeholder + 1, "blue")) {
 		strbuf_addstr(sb, GIT_COLOR_BLUE);
 		return 5;
-	} else if (!prefixcmp(placeholder + 1, "reset")) {
+	} else if (has_prefix(placeholder + 1, "reset")) {
 		strbuf_addstr(sb, GIT_COLOR_RESET);
 		return 6;
 	} else
@@ -1060,11 +1060,11 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 			end = strchr(start, ')');
 			if (!end || end == start)
 				return 0;
-			if (!prefixcmp(start, "trunc)"))
+			if (has_prefix(start, "trunc)"))
 				c->truncate = trunc_right;
-			else if (!prefixcmp(start, "ltrunc)"))
+			else if (has_prefix(start, "ltrunc)"))
 				c->truncate = trunc_left;
-			else if (!prefixcmp(start, "mtrunc)"))
+			else if (has_prefix(start, "mtrunc)"))
 				c->truncate = trunc_middle;
 			else
 				return 0;
@@ -1089,7 +1089,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
-		if (!prefixcmp(placeholder + 1, "(auto)")) {
+		if (has_prefix(placeholder + 1, "(auto)")) {
 			c->auto_color = 1;
 			return 7; /* consumed 7 bytes, "C(auto)" */
 		} else {
@@ -1556,7 +1556,7 @@ static void pp_header(struct pretty_print_context *pp,
 			continue;
 		}
 
-		if (!prefixcmp(line, "parent ")) {
+		if (has_prefix(line, "parent ")) {
 			if (linelen != 48)
 				die("bad parent line in commit");
 			continue;
@@ -1580,11 +1580,11 @@ static void pp_header(struct pretty_print_context *pp,
 		 * FULL shows both authors but not dates.
 		 * FULLER shows both authors and dates.
 		 */
-		if (!prefixcmp(line, "author ")) {
+		if (has_prefix(line, "author ")) {
 			strbuf_grow(sb, linelen + 80);
 			pp_user_info(pp, "Author", sb, line + 7, encoding);
 		}
-		if (!prefixcmp(line, "committer ") &&
+		if (has_prefix(line, "committer ") &&
 		    (pp->fmt == CMIT_FMT_FULL || pp->fmt == CMIT_FMT_FULLER)) {
 			strbuf_grow(sb, linelen + 80);
 			pp_user_info(pp, "Commit", sb, line + 10, encoding);
-- 
1.8.4.1.566.geca833c
