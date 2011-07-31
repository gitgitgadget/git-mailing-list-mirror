From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] grep: add option to show whole function as context
Date: Sun, 31 Jul 2011 17:59:30 +0200
Message-ID: <4E357BE2.8030409@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 17:59:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnYQo-0003Eq-Jl
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 17:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094Ab1GaP7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 11:59:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:60512 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab1GaP7v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 11:59:51 -0400
Received: from [192.168.2.104] (p579BEE49.dip.t-dialin.net [87.155.238.73])
	by india601.server4you.de (Postfix) with ESMTPSA id 3DD7B2F8050;
	Sun, 31 Jul 2011 17:59:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178262>

Add a new option, -S, to show the whole surrounding function of a match.

It uses the same regular expressions as -p and diff to find the beginning
of sections.

Currently it will not display comments in front of a function, but those
that are following one.  Despite this shortcoming it is already useful,
e.g. to simply see a more complete applicable context or to extract whole
functions.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Extending userdiff to allow comments to be recognized would be a bit more
involved, especially since we'd need to able to handle nested multi-line
comment blocks.

 Documentation/git-grep.txt |    6 ++++++
 builtin/grep.c             |    5 ++++-
 grep.c                     |   32 ++++++++++++++++++++++----------
 grep.h                     |    1 +
 t/t7810-grep.sh            |   14 ++++++++++++++
 5 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 07b3c6a..78e6fc4 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -172,6 +172,12 @@ OPTIONS
 	patch hunk headers (see 'Defining a custom hunk-header' in
 	linkgit:gitattributes[5]).
 
+-S::
+	Show the surrounding text from the previous line containing a
+	function name up to the one before the next function name,
+	effectively showing the whole function in which the match was
+	found.
+
 -f <file>::
 	Read patterns from <file>, one per line.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index cccf8da..fc50859 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -838,6 +838,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			context_callback),
 		OPT_BOOLEAN('p', "show-function", &opt.funcname,
 			"show a line with the function name before matches"),
+		OPT_BOOLEAN('S', NULL, &opt.funcbody,
+			"show the surrounding function"),
 		OPT_GROUP(""),
 		OPT_CALLBACK('f', NULL, &opt, "file",
 			"read patterns from file", file_callback),
@@ -980,7 +982,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		use_threads = 0;
 
 	if (use_threads) {
-		if (opt.pre_context || opt.post_context || opt.file_break)
+		if (opt.pre_context || opt.post_context || opt.file_break ||
+		    opt.funcbody)
 			skip_first_line = 1;
 		start_threads(&opt);
 	}
diff --git a/grep.c b/grep.c
index 04e9ba4..26e8d8e 100644
--- a/grep.c
+++ b/grep.c
@@ -724,7 +724,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	if (opt->file_break && opt->last_shown == 0) {
 		if (opt->show_hunk_mark)
 			opt->output(opt, "\n", 1);
-	} else if (opt->pre_context || opt->post_context) {
+	} else if (opt->pre_context || opt->post_context || opt->funcbody) {
 		if (opt->last_shown == 0) {
 			if (opt->show_hunk_mark) {
 				output_color(opt, "--", 2, opt->color_sep);
@@ -819,10 +819,13 @@ static void show_funcname_line(struct grep_opt *opt, const char *name,
 }
 
 static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
-			     char *bol, unsigned lno)
+			     char *bol, char *end, unsigned lno)
 {
 	unsigned cur = lno, from = 1, funcname_lno = 0;
-	int funcname_needed = opt->funcname;
+	int funcname_needed = !!opt->funcname;
+
+	if (opt->funcbody && !match_funcname(opt, bol, end))
+		funcname_needed = 2;
 
 	if (opt->pre_context < lno)
 		from = lno - opt->pre_context;
@@ -830,7 +833,8 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 		from = opt->last_shown + 1;
 
 	/* Rewind. */
-	while (bol > buf && cur > from) {
+	while (bol > buf &&
+	       cur > (funcname_needed == 2 ? opt->last_shown + 1 : from)) {
 		char *eol = --bol;
 
 		while (bol > buf && bol[-1] != '\n')
@@ -942,13 +946,15 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	int binary_match_only = 0;
 	unsigned count = 0;
 	int try_lookahead = 0;
+	int show_function = 0;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 	xdemitconf_t xecfg;
 
 	if (!opt->output)
 		opt->output = std_output;
 
-	if (opt->pre_context || opt->post_context || opt->file_break) {
+	if (opt->pre_context || opt->post_context || opt->file_break ||
+	    opt->funcbody) {
 		/* Show hunk marks, except for the first file. */
 		if (opt->last_shown)
 			opt->show_hunk_mark = 1;
@@ -1004,7 +1010,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		 */
 		if (try_lookahead
 		    && !(last_hit
-			 && lno <= last_hit + opt->post_context)
+			 && (show_function ||
+			     lno <= last_hit + opt->post_context))
 		    && look_ahead(opt, &left, &lno, &bol))
 			break;
 		eol = end_of_line(bol, &left);
@@ -1051,15 +1058,20 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			/* Hit at this line.  If we haven't shown the
 			 * pre-context lines, we would need to show them.
 			 */
-			if (opt->pre_context)
-				show_pre_context(opt, name, buf, bol, lno);
+			if (opt->pre_context || opt->funcbody)
+				show_pre_context(opt, name, buf, bol, eol, lno);
 			else if (opt->funcname)
 				show_funcname_line(opt, name, buf, bol, lno);
 			show_line(opt, bol, eol, name, lno, ':');
 			last_hit = lno;
+			if (opt->funcbody)
+				show_function = 1;
+			goto next_line;
 		}
-		else if (last_hit &&
-			 lno <= last_hit + opt->post_context) {
+		if (show_function && match_funcname(opt, bol, eol))
+			show_function = 0;
+		if (show_function ||
+		    (last_hit && lno <= last_hit + opt->post_context)) {
 			/* If the last hit is within the post context,
 			 * we need to show this line.
 			 */
diff --git a/grep.h b/grep.h
index c568297..ae50c45 100644
--- a/grep.h
+++ b/grep.h
@@ -98,6 +98,7 @@ struct grep_opt {
 	int color;
 	int max_depth;
 	int funcname;
+	int funcbody;
 	char color_context[COLOR_MAXLEN];
 	char color_filename[COLOR_MAXLEN];
 	char color_function[COLOR_MAXLEN];
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index a29ae45..3f127ac 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -509,6 +509,20 @@ test_expect_success 'grep -p -B5' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+hello.c=int main(int argc, const char **argv)
+hello.c-{
+hello.c-	printf("Hello world.\n");
+hello.c:	return 0;
+hello.c-	/* char ?? */
+hello.c-}
+EOF
+
+test_expect_success 'grep -S' '
+	git grep -S return >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'grep from a subdirectory to search wider area (1)' '
 	mkdir -p s &&
 	(
-- 
1.7.6
