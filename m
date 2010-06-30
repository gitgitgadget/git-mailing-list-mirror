From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 04/13] refactor parse_loc
Date: Wed, 30 Jun 2010 23:25:17 +0800
Message-ID: <1277911526-12105-4-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:29:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzDk-0008N5-VT
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783Ab0F3P27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:28:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36057 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab0F3P26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:28:58 -0400
Received: by pwj8 with SMTP id 8so320007pwj.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mOQOCoyFNFZW18epND2HonMl4tu+jmRgxvf95bC3DR4=;
        b=dP6x6zM6KZbPtfV+HTbuI6qubtSLQLQaCwfxUJ/kp5ExJ5PqO6xgmsSkg3aRsIzWuP
         S3TG4cyZrwRCKUCrdtR75K4zax3czFRrJ7v5KJL333AnEwcwlg36FkWpjPC8RLqvHwjd
         bweaW4Vbdk3vn5gnOkgt0Aj56s9mauHtJGyHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p/L/BK3BL7YYZnKySkHiGOL+DmAdwrvtf73sA9tgjuKG1ekw4SGmdx2APeJBFLdEwo
         OWQcuNajZzYdGV0j9b2dI+i74pV8136ilriyFUWvtQ86pW41ahPyCqkzHq1bWv8euaBA
         cF0G76mo+u9+m/P45v+rBxThlDEHZ/H17ILSk=
Received: by 10.114.186.29 with SMTP id j29mr9974120waf.99.1277911737457;
        Wed, 30 Jun 2010 08:28:57 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.28.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:28:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149967>

Both 'git blame -L' and 'git log -L' parse the same style
of line number arguments, so put the 'parse_loc' function
to line.c and export it.
The caller of parse_loc should provide a callback function
which is used to calculate the nth line start position.
Other parts such as regexp search, line number parsing are
abstracted and re-used.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/blame.c |   89 +++++-------------------------------------------------
 line.c          |   35 ++++++++++++---------
 line.h          |    5 +++
 3 files changed, 34 insertions(+), 95 deletions(-)

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
index ffa97ea..0855d29 100644
--- a/line.c
+++ b/line.c
@@ -94,22 +94,26 @@ static void fill_line_ends(struct diff_filespec *spec, long *lines,
 	*line_ends = ends;
 }
 
-static const char *nth_line(struct diff_filespec *spec, int line,
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
 
-	return (char *)spec->data + line_ends[line] + 1;
+	return (char *)d->spec->data + d->line_ends[line] + 1;
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
@@ -156,7 +160,7 @@ static const char *parse_loc(const char *spec, struct diff_filespec *file,
 	/* try [spec+1 .. term-1] as regexp */
 	*term = 0;
 	begin--; /* input is in human terms */
-	line = nth_line(file, begin, lines, line_ends);
+	line = nth_line(data, begin);
 
 	if (!(reg_error = regcomp(&regexp, spec + 1, REG_NEWLINE)) &&
 	    !(reg_error = regexec(&regexp, line, 1, match, 0))) {
@@ -164,7 +168,7 @@ static const char *parse_loc(const char *spec, struct diff_filespec *file,
 		const char *nline;
 
 		while (begin++ < lines) {
-			nline = nth_line(file, begin, lines, line_ends);
+			nline = nth_line(data, begin);
 			if (line <= cp && cp < nline)
 				break;
 			line = nline;
@@ -185,11 +189,12 @@ static void parse_range(long lines, unsigned long *line_ends,
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
index a2f8545..0eb03bd 100644
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
@@ -119,4 +121,7 @@ extern void add_line_range(struct rev_info *revs, struct commit *commit, struct
 
 extern struct diff_line_range *lookup_line_range(struct rev_info *revs, struct commit *commit);
 
+const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
+		void *data, long lines, long begin, long *ret);
+
 #endif
-- 
1.7.0.2.273.gc2413.dirty
