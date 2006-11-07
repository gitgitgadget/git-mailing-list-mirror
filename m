X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-pickaxe: -L /regexp/,/regexp/
Date: Mon, 06 Nov 2006 17:57:33 -0800
Message-ID: <7vmz749fxu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 01:57:48 +0000 (UTC)
Cc: pasky@suse.cz
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31037>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhGDh-0007fp-7H for gcvg-git@gmane.org; Tue, 07 Nov
 2006 02:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753944AbWKGB5f (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 20:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbWKGB5f
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 20:57:35 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4252 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1753944AbWKGB5e
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 20:57:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107015734.ZMGR22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Mon, 6
 Nov 2006 20:57:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id jdxf1V0021kojtg0000000; Mon, 06 Nov 2006
 20:57:39 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

With this change, you can specify the beginning and the ending
line of the range you wish to inspect with pattern matching.

For example, these are equivalent with the git.git sources:

    git pickaxe -L 7,21                       v1.4.0 -- commit.c
    git pickaxe -L '/^struct sort_node/,/^}/' v1.4.0 -- commit.c
    git pickaxe -L '7,/^}/'                   v1.4.0 -- commit.c
    git pickaxe -L '/^struct sort_node/,21'   v1.4.0 -- commit.c

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Pasky, the other day I overheard that you were moaning about
   git-annotate using -S to mean something other than pickaxe,
   and git-pickaxe needed to stay compatible with it.  I think
   this is a better way to do what you wanted.

 builtin-pickaxe.c |  103 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/builtin-pickaxe.c b/builtin-pickaxe.c
index f45edbd..007b1b8 100644
--- a/builtin-pickaxe.c
+++ b/builtin-pickaxe.c
@@ -17,6 +17,7 @@
 
 #include <time.h>
 #include <sys/time.h>
+#include <regex.h>
 
 static char pickaxe_usage[] =
 "git-pickaxe [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [commit] [--] file\n"
@@ -1533,6 +1534,85 @@ static const char *add_prefix(const char
 	return prefix_path(prefix, strlen(prefix), path);
 }
 
+static const char *parse_loc(const char *spec,
+			     struct scoreboard *sb, long lno,
+			     long begin, long *ret)
+{
+	char *term;
+	const char *line;
+	long num;
+	regex_t regexp;
+
+	num = strtol(spec, &term, 10);
+	if (term != spec) {
+		*ret = num;
+		return term;
+	}
+
+	if (spec[0] != '/')
+		return spec;
+
+	/* it could be a regexp of form /.../ */
+	for (term = (char*) spec + 1; *term && *term != '/'; term++) {
+		if (*term == '\\')
+			term++;
+	}
+	if (*term != '/')
+		return spec;
+	/* try [spec+1 .. term-1] as regexp */
+	*term = 0;
+	if (regcomp(&regexp, spec + 1, REG_NEWLINE)) {
+		/* not a regexp */
+	error_return:
+		regfree(&regexp);
+		*term = '/';
+		return spec;
+	}
+
+	/* Now find the first line that matches the regexp, after
+	 * line "begin" in sb->final_buf.
+	 */
+	while (begin < lno) {
+		char *nline;
+		int hit;
+
+		begin++;
+		line = nth_line(sb, begin);
+		if (begin < lno) {
+			nline = (char*) nth_line(sb, begin+1);
+			nline[-1] = 0;
+		}
+		hit = regexec(&regexp, line, 0, NULL, 0);
+		if (begin < lno)
+			nline[-1] = '\n';
+		if (!hit) {
+			/* lines count from 1 in UI terms */
+			*ret = begin + 1;
+			regfree(&regexp);
+			*term++ = '/';
+			return term;
+		}
+	}
+	goto error_return;
+}
+
+static void prepare_blame_range(struct scoreboard *sb,
+				const char *bottomtop,
+				long lno,
+				long *bottom, long *top)
+{
+	const char *term;
+
+	term = parse_loc(bottomtop, sb, lno, 0, bottom);
+	if (*term == ',') {
+		term = parse_loc(term + 1, sb, lno, *bottom + 1, top);
+		if (*term)
+			usage(pickaxe_usage);
+	}
+	if (*term)
+		usage(pickaxe_usage);
+}
+
 int cmd_pickaxe(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -1547,11 +1627,11 @@ int cmd_pickaxe(int argc, const char **a
 	const char *revs_file = NULL;
 	const char *final_commit_name = NULL;
 	char type[10];
+	const char *bottomtop = NULL;
 
 	save_commit_buffer = 0;
 
 	opt = 0;
-	bottom = top = 0;
 	seen_dashdash = 0;
 	for (unk = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -1578,7 +1658,6 @@ int cmd_pickaxe(int argc, const char **a
 			blame_copy_score = parse_score(arg+2);
 		}
 		else if (!strncmp("-L", arg, 2)) {
-			char *term;
 			if (!arg[2]) {
 				if (++i >= argc)
 					usage(pickaxe_usage);
@@ -1586,18 +1665,9 @@ int cmd_pickaxe(int argc, const char **a
 			}
 			else
 				arg += 2;
-			if (bottom || top)
+			if (bottomtop)
 				die("More than one '-L n,m' option given");
-			bottom = strtol(arg, &term, 10);
-			if (*term == ',') {
-				top = strtol(term + 1, &term, 10);
-				if (*term)
-					usage(pickaxe_usage);
-			}
-			if (bottom && top && top < bottom) {
-				unsigned long tmp;
-				tmp = top; top = bottom; bottom = tmp;
-			}
+			bottomtop = arg;
 		}
 		else if (!strcmp("--score-debug", arg))
 			output_option |= OUTPUT_SHOW_SCORE;
@@ -1758,6 +1828,13 @@ int cmd_pickaxe(int argc, const char **a
 	num_read_blob++;
 	lno = prepare_lines(&sb);
 
+	bottom = top = 0;
+	if (bottomtop)
+		prepare_blame_range(&sb, bottomtop, lno, &bottom, &top);
+	if (bottom && top && top < bottom) {
+		long tmp;
+		tmp = top; top = bottom; bottom = tmp;
+	}
 	if (bottom < 1)
 		bottom = 1;
 	if (top < 1)
-- 
1.4.3.4.g9f05

