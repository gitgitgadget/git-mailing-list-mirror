From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Teach "log -F --author=<match>" to behave better
Date: Thu, 04 Sep 2008 01:31:19 -0700
Message-ID: <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
References: <g9o0ac$qig$1@ger.gmane.org>
 <7v4p4w75b7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 10:32:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbAGZ-0007pB-D3
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 10:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbYIDIb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 04:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbYIDIb0
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 04:31:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbYIDIbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 04:31:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 69DBC5E3ED;
	Thu,  4 Sep 2008 04:31:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3D33F5E3E6; Thu,  4 Sep 2008 04:31:21 -0400 (EDT)
In-Reply-To: <7v4p4w75b7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Sep 2008 00:12:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC18E0AC-7A5B-11DD-BBBE-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94906>

To handle --author=<match> request, the code created a grep instruction
that tried to match a line that begins with 'author ' and <match>
somewhere on the same line.  "begins with 'author '" obviously needs to be
expressed with an regexp '^author '.

When the user specifies --fixed-string, this does not work at all.

This extends the grep machinery so that a match insn can ignore user
specified --fixed-string request, and uses the '( -e A --and -e B )'
construct from the grep machinery in order to express "has to begin with
'^author ', and also the same line must match the given pattern".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * A variant of this would be to make the --author match always ignore -F,
   which is now possible with the enhancement to the grep machinery.  But
   it is unlikely that you would have regexp metacharacters in author
   field, so it might not be necessary.

   "log -F --author=1220485514" would match the timestamp part of the
   author line.  This will not likely to change but it is not likely to
   cause issues in real world either, so I would not bother to address it
   myself.

 grep.c     |   16 ++++++++++++----
 grep.h     |    3 +++
 revision.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 revision.h |    7 +++++++
 4 files changed, 66 insertions(+), 4 deletions(-)

diff --git c/grep.c w/grep.c
index f67d671..dd71b78 100644
--- c/grep.c
+++ w/grep.c
@@ -2,19 +2,27 @@
 #include "grep.h"
 #include "xdiff-interface.h"
 
-void append_grep_pattern(struct grep_opt *opt, const char *pat,
-			 const char *origin, int no, enum grep_pat_token t)
+void append_grep_pattern_special(struct grep_opt *opt, const char *pat,
+				const char *origin, int no,
+				enum grep_pat_token t, unsigned flags)
 {
 	struct grep_pat *p = xcalloc(1, sizeof(*p));
 	p->pattern = pat;
 	p->origin = origin;
 	p->no = no;
 	p->token = t;
+	p->flags = flags;
 	*opt->pattern_tail = p;
 	opt->pattern_tail = &p->next;
 	p->next = NULL;
 }
 
+void append_grep_pattern(struct grep_opt *opt, const char *pat,
+			 const char *origin, int no, enum grep_pat_token t)
+{
+	append_grep_pattern_special(opt, pat, origin, no, t, 0);
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err = regcomp(&p->regexp, p->pattern, opt->regflags);
@@ -146,7 +154,7 @@ void compile_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN: /* atom */
 		case GREP_PATTERN_HEAD:
 		case GREP_PATTERN_BODY:
-			if (!opt->fixed)
+			if (!opt->fixed || (p->flags & GREP_ALWAYS_REGEXP))
 				compile_regexp(p, opt);
 			break;
 		default:
@@ -258,7 +266,7 @@ static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol
 		return 0;
 
  again:
-	if (!opt->fixed) {
+	if (!opt->fixed || (p->flags & GREP_ALWAYS_REGEXP)) {
 		regex_t *exp = &p->regexp;
 		hit = !regexec(exp, bol, ARRAY_SIZE(pmatch),
 			       pmatch, 0);
diff --git c/grep.h w/grep.h
index d252dd2..b03d89d 100644
--- c/grep.h
+++ w/grep.h
@@ -21,6 +21,8 @@ struct grep_pat {
 	struct grep_pat *next;
 	const char *origin;
 	int no;
+	unsigned flags;
+#define GREP_ALWAYS_REGEXP 01
 	enum grep_pat_token token;
 	const char *pattern;
 	regex_t regexp;
@@ -73,6 +75,7 @@ struct grep_opt {
 	unsigned post_context;
 };
 
+extern void append_grep_pattern_special(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t, unsigned);
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
 extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
diff --git c/revision.c w/revision.c
index 83478ef..65d22f5 100644
--- c/revision.c
+++ w/revision.c
@@ -955,6 +955,17 @@ static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token
 
 static void add_header_grep(struct rev_info *revs, const char *field, const char *pattern)
 {
+	struct pending_header_grep *p = xcalloc(1, sizeof(*p));
+	p->next = revs->pending_header_grep;
+	p->field = field;
+	p->pattern = pattern;
+	revs->pending_header_grep = p;;
+}
+
+static void add_header_grep_regexp(struct rev_info *revs, struct pending_header_grep *p)
+{
+	const char *field = p->field;
+	const char *pattern = p->pattern;
 	char *pat;
 	const char *prefix, *suffix;
 	int patlen, fldlen;
@@ -977,6 +988,38 @@ static void add_header_grep(struct rev_info *revs, const char *field, const char
 	add_grep(revs, pat, GREP_PATTERN_HEAD);
 }
 
+static void add_header_grep_fixed(struct rev_info *revs, struct pending_header_grep *p)
+{
+	char *field = xmalloc(strlen(p->field) + 2);
+	strcpy(field + 1, p->field);
+	field[0] = '^';
+	append_grep_pattern(&revs->grep_filter, "(",
+			    "header grep", 0, GREP_OPEN_PAREN);
+	append_grep_pattern_special(&revs->grep_filter, field,
+				    "header grep", 0, GREP_PATTERN_HEAD,
+				    GREP_ALWAYS_REGEXP);
+	append_grep_pattern(&revs->grep_filter, "--and",
+			    "header grep", 0, GREP_AND);
+	add_grep(revs, p->pattern, GREP_PATTERN_HEAD);
+	append_grep_pattern(&revs->grep_filter, ")",
+			    "header grep", 0, GREP_CLOSE_PAREN);
+}
+
+static void finish_header_grep(struct rev_info *revs)
+{
+	struct pending_header_grep *q, *p = revs->pending_header_grep;
+
+	while (p) {
+		if (revs->grep_filter.fixed)
+			add_header_grep_fixed(revs, p);
+		else
+			add_header_grep_regexp(revs, p);
+		q = p->next;
+		free(p);
+		p = q;
+	}
+}
+
 static void add_message_grep(struct rev_info *revs, const char *pattern)
 {
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
@@ -1347,6 +1390,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
 
+	finish_header_grep(revs);
 	compile_grep_patterns(&revs->grep_filter);
 
 	if (revs->reverse && revs->reflog_info)
diff --git c/revision.h w/revision.h
index 91f1944..f9cfa26 100644
--- c/revision.h
+++ w/revision.h
@@ -18,6 +18,12 @@
 struct rev_info;
 struct log_info;
 
+struct pending_header_grep {
+	struct pending_header_grep *next;
+	const char *field;
+	const char *pattern;
+};
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -94,6 +100,7 @@ struct rev_info {
 
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
+	struct pending_header_grep *pending_header_grep;
 
 	/* Display history graph */
 	struct git_graph *graph;
