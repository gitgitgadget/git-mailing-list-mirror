From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 04/18] Refactor parse_loc
Date: Fri,  6 Aug 2010 00:11:43 +0800
Message-ID: <1281024717-7855-5-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh346-0000oB-Lc
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759190Ab0HEQMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:12:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57614 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759050Ab0HEQMr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:12:47 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so2533376pzk.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=v7/cPZoIkaYTvJ85jjmA3m8q6HAaJiVChLJZBNe8Aac=;
        b=iZjJRLNku78Z1lisEpVRDxHTJ29/NFwUozHkEyZ5J39sl3zXSaMcpZgV1i5956LyxE
         ZB3IORB5oLrzBMk+Lh1YXyzVXqhryNw0vt2IYHGRgO1odFRM2BZMxqfbkoEFAjrbRHiZ
         FORslD5jW3w9Wvz7hT1pCyQneA1DTVaZpJy9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L4DRrydW1dNZqQCHUTbiye9rYcta+QbZnFEGElYwYBgIl/zezqVeBk1wZAFlNDNA8M
         +TnQSuyF/Q0g2EUXbnCFqWEnVFOB77eplzEaNyKBBkbjKETmTpwgVVujxKVDoT/bSkbK
         DR6MBih+42ZeAR8h9YyI0TlwR4JMpQWbs0NWM=
Received: by 10.142.164.3 with SMTP id m3mr9440350wfe.6.1281024767342;
        Thu, 05 Aug 2010 09:12:47 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.12.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:12:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152665>

Both 'git blame -L' and 'git log -L' parse the same style
of line number arguments, so put the 'parse_loc' function
to line.c and export it.

The caller of parse_loc should provide a callback function
which is used to calculate the start position of the nth line.
Other parts such as regexp search, line number parsing are
abstracted and re-used.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/blame.c |   89 +++++-------------------------------------------------
 line.c          |   37 +++++++++++++----------
 line.h          |    5 +++
 3 files changed, 35 insertions(+), 96 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 01e62fd..17b71cd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -21,6 +21,7 @@
 #include "parse-options.h"
 #include "utf8.h"
 #include "userdiff.h"
+#include "line.h"
 
 static char blame_usage[] = "git blame [options] [rev-opts] [rev] [--] file";
 
@@ -541,11 +542,16 @@ static void dup_entry(struct blame_entry *dst, struct blame_entry *src)
 	dst->score = 0;
 }
 
-static const char *nth_line(struct scoreboard *sb, int lno)
+static const char *nth_line(struct scoreboard *sb, long lno)
 {
 	return sb->final_buf + sb->lineno[lno];
 }
 
+static const char *nth_line_cb(void *data, long lno)
+{
+	return nth_line((struct scoreboard *)data, lno);
+}
+
 /*
  * It is known that lines between tlno to same came from parent, and e
  * has an overlap with that range.  it also is known that parent's
@@ -1907,83 +1913,6 @@ static const char *add_prefix(const char *prefix, const char *path)
 }
 
 /*
- * Parsing of (comma separated) one item in the -L option
- */
-static const char *parse_loc(const char *spec,
-			     struct scoreboard *sb, long lno,
-			     long begin, long *ret)
-{
-	char *term;
-	const char *line;
-	long num;
-	int reg_error;
-	regex_t regexp;
-	regmatch_t match[1];
-
-	/* Allow "-L <something>,+20" to mean starting at <something>
-	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
-	 * <something>.
-	 */
-	if (1 < begin && (spec[0] == '+' || spec[0] == '-')) {
-		num = strtol(spec + 1, &term, 10);
-		if (term != spec + 1) {
-			if (spec[0] == '-')
-				num = 0 - num;
-			if (0 < num)
-				*ret = begin + num - 2;
-			else if (!num)
-				*ret = begin;
-			else
-				*ret = begin + num;
-			return term;
-		}
-		return spec;
-	}
-	num = strtol(spec, &term, 10);
-	if (term != spec) {
-		*ret = num;
-		return term;
-	}
-	if (spec[0] != '/')
-		return spec;
-
-	/* it could be a regexp of form /.../ */
-	for (term = (char *) spec + 1; *term && *term != '/'; term++) {
-		if (*term == '\\')
-			term++;
-	}
-	if (*term != '/')
-		return spec;
-
-	/* try [spec+1 .. term-1] as regexp */
-	*term = 0;
-	begin--; /* input is in human terms */
-	line = nth_line(sb, begin);
-
-	if (!(reg_error = regcomp(&regexp, spec + 1, REG_NEWLINE)) &&
-	    !(reg_error = regexec(&regexp, line, 1, match, 0))) {
-		const char *cp = line + match[0].rm_so;
-		const char *nline;
-
-		while (begin++ < lno) {
-			nline = nth_line(sb, begin);
-			if (line <= cp && cp < nline)
-				break;
-			line = nline;
-		}
-		*ret = begin;
-		regfree(&regexp);
-		*term++ = '/';
-		return term;
-	}
-	else {
-		char errbuf[1024];
-		regerror(reg_error, &regexp, errbuf, 1024);
-		die("-L parameter '%s': %s", spec + 1, errbuf);
-	}
-}
-
-/*
  * Parsing of -L option
  */
 static void prepare_blame_range(struct scoreboard *sb,
@@ -1993,9 +1922,9 @@ static void prepare_blame_range(struct scoreboard *sb,
 {
 	const char *term;
 
-	term = parse_loc(bottomtop, sb, lno, 1, bottom);
+	term = parse_loc(bottomtop, nth_line_cb, sb, lno, 1, bottom);
 	if (*term == ',') {
-		term = parse_loc(term + 1, sb, lno, *bottom + 1, top);
+		term = parse_loc(term + 1, nth_line_cb, sb, lno, *bottom + 1, top);
 		if (*term)
 			usage(blame_usage);
 	}
diff --git a/line.c b/line.c
index fdec93a..4314cee 100644
--- a/line.c
+++ b/line.c
@@ -95,25 +95,29 @@ static void fill_line_ends(struct diff_filespec *spec, long *lines,
 	*line_ends = ends;
 }
 
-static const char *nth_line(struct diff_filespec *spec, long line,
-		long lines, unsigned long *line_ends)
+struct nth_line_cb {
+	struct diff_filespec *spec;
+	long lines;
+	unsigned long *line_ends;
+};
+
+static const char *nth_line(void *data, long line)
 {
-	assert(line < lines);
-	assert(spec && spec->data);
+	struct nth_line_cb *d = data;
+	assert(d && line < d->lines);
+	assert(d->spec && d->spec->data);
 
 	if (line == 0)
-		return (char *)spec->data;
+		return (char *)d->spec->data;
 	else
-		return (char *)spec->data + line_ends[line] + 1;
+		return (char *)d->spec->data + d->line_ends[line] + 1;
 }
 
 /*
- * copied from blame.c, indeed, we can even to use this to test
- * whether line log works. :)
+ * Parsing of (comma separated) one item in the -L option
  */
-static const char *parse_loc(const char *spec, struct diff_filespec *file,
-			     long lines, unsigned long *line_ends,
-			     long begin, long *ret)
+const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
+		void *data, long lines, long begin, long *ret)
 {
 	char *term;
 	const char *line;
@@ -160,7 +164,7 @@ static const char *parse_loc(const char *spec, struct diff_filespec *file,
 	/* try [spec+1 .. term-1] as regexp */
 	*term = 0;
 	begin--; /* input is in human terms */
-	line = nth_line(file, begin, lines, line_ends);
+	line = nth_line(data, begin);
 
 	if (!(reg_error = regcomp(&regexp, spec + 1, REG_NEWLINE)) &&
 	    !(reg_error = regexec(&regexp, line, 1, match, 0))) {
@@ -168,7 +172,7 @@ static const char *parse_loc(const char *spec, struct diff_filespec *file,
 		const char *nline;
 
 		while (begin++ < lines) {
-			nline = nth_line(file, begin, lines, line_ends);
+			nline = nth_line(data, begin);
 			if (line <= cp && cp < nline)
 				break;
 			line = nline;
@@ -189,11 +193,12 @@ static void parse_range(long lines, unsigned long *line_ends,
 		struct range *r, struct diff_filespec *spec)
 {
 	const char *term;
+	struct nth_line_cb data = {spec, lines, line_ends};
 
-	term = parse_loc(r->arg, spec, lines, line_ends, 1, &r->start);
+	term = parse_loc(r->arg, nth_line, &data, lines, 1, &r->start);
 	if (*term == ',') {
-		term = parse_loc(term + 1, spec, lines, line_ends,
-			r->start + 1, &r->end);
+		term = parse_loc(term + 1, nth_line, &data, lines,
+				r->start + 1, &r->end);
 		if (*term) {
 			die("-L parameter's argument should be <start>,<end>");
 		}
diff --git a/line.h b/line.h
index caf84c7..8b30ada 100644
--- a/line.h
+++ b/line.h
@@ -8,6 +8,8 @@ struct commit;
 struct diff_line_range;
 struct diff_options;
 
+typedef const char *(*nth_line_fn_t)(void *data, long lno);
+
 struct print_range {
 	int start, end;
 	int pstart, pend;
@@ -125,4 +127,7 @@ extern void add_line_range(struct rev_info *revs, struct commit *commit,
 extern struct diff_line_range *lookup_line_range(struct rev_info *revs,
 		struct commit *commit);
 
+const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
+		void *data, long lines, long begin, long *ret);
+
 #endif
-- 
1.7.2.20.g388bbb
