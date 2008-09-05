From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "log -F --author=<match>" to behave better
Date: Thu, 04 Sep 2008 21:47:59 -0700
Message-ID: <7vabenyz9c.fsf@gitster.siamese.dyndns.org>
References: <g9o0ac$qig$1@ger.gmane.org>
 <7v4p4w75b7.fsf@gitster.siamese.dyndns.org>
 <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
 <20080904140902.GY10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 05 06:49:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbTG2-0005C5-1r
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 06:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbYIEEsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 00:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbYIEEsK
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 00:48:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYIEEsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 00:48:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B291073D7E;
	Fri,  5 Sep 2008 00:48:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9A8C673D7A; Fri,  5 Sep 2008 00:48:01 -0400 (EDT)
In-Reply-To: <20080904140902.GY10544@machine.or.cz> (Petr Baudis's message of
 "Thu, 4 Sep 2008 16:09:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4D9A3E4-7B05-11DD-8AF1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94988>

Actually, I changed my mind.  If we were to polish the grep machinery to
suit the log matching usage, I think doing it the way this patch does is
much better.

-- >8 --
log --author/--committer: really match only with name part

When we tried to find commits done by AUTHOR, the first implementation
tried to pattern match a line with "^author .*AUTHOR", which later was
enhanced to strip leading caret and look for "^author AUTHOR" when the
search pattern was anchored at the left end (i.e. --author="^AUTHOR").

This had a few problems:

 * When looking for fixed strings (e.g. "git log -F --author=x --grep=y"),
   the regexp internally used "^author .*x" would never match anything;

 * To match at the end (e.g. "git log --author='google.com>$'"), the
   generated regexp has to also match the trailing timestamp part the
   commit header lines have.  Also, in order to determine if the '$' at
   the end means "match at the end of the line" or just a literal dollar
   sign (probably backslash-quoted), we would need to parse the regexp
   ourselves.

An earlier alternative tried to make sure that a line matches "^author "
(to limit by field name) and the user supplied pattern at the same time.
While it solved the -F problem by introducing a special override for
matching the "^author ", it did not solve the trailing timestamp nor tail
match problem.  It also would have matched every commit if --author=author
was asked for, not because the author's email part had this string, but
because every commit header line that talks about the author begins with
that field name, regardleses of who wrote it.  

Instead of piling more hacks on top of hacks, this rethinks the grep
machinery that is used to look for strings in the commit header, and makes
sure that (1) field name matches literally at the beginning of the line,
followed by a SP, and (2) the user supplied pattern is matched against the
remainder of the line, excluding the trailing timestamp data.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c     |   41 +++++++++++++++++++++++++++++++++++++++++
 grep.h     |    3 +++
 revision.c |   15 +--------------
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git c/grep.c w/grep.c
index f67d671..44a7dc6 100644
--- c/grep.c
+++ w/grep.c
@@ -2,6 +2,20 @@
 #include "grep.h"
 #include "xdiff-interface.h"
 
+void append_header_grep_pattern(struct grep_opt *opt, const char *field, const char *pat)
+{
+	struct grep_pat *p = xcalloc(1, sizeof(*p));
+	p->pattern = pat;
+	p->origin = "header";
+	p->no = 0;
+	p->token = GREP_PATTERN_HEAD;
+	p->field = field;
+	p->field_len = strlen(field);
+	*opt->pattern_tail = p;
+	opt->pattern_tail = &p->next;
+	p->next = NULL;
+}
+
 void append_grep_pattern(struct grep_opt *opt, const char *pat,
 			 const char *origin, int no, enum grep_pat_token t)
 {
@@ -247,16 +261,41 @@ static int fixmatch(const char *pattern, char *line, regmatch_t *match)
 	}
 }
 
+static int strip_timestamp(char *bol, char **eol_p)
+{
+	char *eol = *eol_p;
+	int ch;
+
+	while (bol < --eol) {
+		if (*eol != '>')
+			continue;
+		*eol_p = ++eol;
+		ch = *eol;
+		*eol = '\0';
+		return ch;
+	}
+	return 0;
+}
+
 static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol, char *eol, enum grep_context ctx)
 {
 	int hit = 0;
 	int at_true_bol = 1;
+	int saved_ch = 0;
 	regmatch_t pmatch[10];
 
 	if ((p->token != GREP_PATTERN) &&
 	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)))
 		return 0;
 
+	if (p->token == GREP_PATTERN_HEAD) {
+		/* author/committer fields in a commit object */
+		if (strncmp(bol, p->field, p->field_len) || bol[p->field_len] != ' ')
+			return 0;
+		bol += p->field_len + 1;
+		saved_ch = strip_timestamp(bol, &eol);
+	}
+
  again:
 	if (!opt->fixed) {
 		regex_t *exp = &p->regexp;
@@ -298,6 +337,8 @@ static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol
 			goto again;
 		}
 	}
+	if (p->token == GREP_PATTERN_HEAD && saved_ch)
+		*eol = saved_ch;
 	return hit;
 }
 
diff --git c/grep.h w/grep.h
index d252dd2..0454e50 100644
--- c/grep.h
+++ w/grep.h
@@ -23,6 +23,8 @@ struct grep_pat {
 	int no;
 	enum grep_pat_token token;
 	const char *pattern;
+	const char *field;
+	int field_len;
 	regex_t regexp;
 };
 
@@ -74,6 +76,7 @@ struct grep_opt {
 };
 
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
+extern void append_header_grep_pattern(struct grep_opt *opt, const char *field, const char *pat);
 extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
 extern int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size);
diff --git c/revision.c w/revision.c
index 36291b6..4092a11 100644
--- c/revision.c
+++ w/revision.c
@@ -955,20 +955,7 @@ static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token
 
 static void add_header_grep(struct rev_info *revs, const char *field, const char *pattern)
 {
-	char *pat;
-	const char *prefix;
-	int patlen, fldlen;
-
-	fldlen = strlen(field);
-	patlen = strlen(pattern);
-	pat = xmalloc(patlen + fldlen + 10);
-	prefix = ".*";
-	if (*pattern == '^') {
-		prefix = "";
-		pattern++;
-	}
-	sprintf(pat, "^%s %s%s", field, prefix, pattern);
-	add_grep(revs, pat, GREP_PATTERN_HEAD);
+	append_header_grep_pattern(&revs->grep_filter, field, pattern);
 }
 
 static void add_message_grep(struct rev_info *revs, const char *pattern)
