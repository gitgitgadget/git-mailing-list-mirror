From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Convert 'git blame' to parse_options()
Date: Sun, 22 Jun 2008 22:15:41 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 07:17:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAeQu-0006Ix-5H
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 07:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbYFWFQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 01:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbYFWFQm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 01:16:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54888 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751649AbYFWFQl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 01:16:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5N5FfdF029967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jun 2008 22:15:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5N5FfiN012241;
	Sun, 22 Jun 2008 22:15:41 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-2.338 required=5 tests=AWL,BAYES_00,FB_MORE_SIZE
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85834>


Why? I did some more size statistics, and 'cmd_blame()' was the biggest 
function in all of git. Admittedly my script for finding sizes is probably 
broken, but it does look very messy.

Just cleaning up the option parsing actually cuts down the size a bit, and 
while parse_options() isn't really perfect for what cmd_blame() wants, 
it's manageable.

I think I'll want to add a PARSE_OPT_IGNORE_UNRECOGNIZED flag, and also 
make it not write the resulting array into argv[0..] but back into 
argv[1..] (so that you can use parse_options() as a _filter_ for options 
parsing and make it easier to do partial conversions), but in the meantime 
this mostly works.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

That builtin-blame option parsing is really ugly, trying to then move 
unrecognized options to be parsed by a secondary

	setup_revisions(unk, argv, &revs, NULL);

which parses the rest. This is _really_ not what parse_options() was 
written with in mind, and to give strictly the same behaviour as before 
you really do need some kind of PARSE_OPT_IGNORE_UNRECOGNIZED flag, but I 
think this is already a good enough halfway point.

Hmm?

Btw, making the "struct options" array be 'static' avoids having to build 
it up at run-time on the stack, which is why it's usually a good idea. Of 
course, it means that the option variables themselves have to be static, 
which has its own set of downsides, so it's a balancing act.

 builtin-blame.c |  177 +++++++++++++++++++++++++++----------------------------
 1 files changed, 86 insertions(+), 91 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index b451f6c..f04bd93 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -18,24 +18,11 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "mailmap.h"
+#include "parse-options.h"
 
-static char blame_usage[] =
-"git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
-"  -c                  Use the same output mode as git-annotate (Default: off)\n"
-"  -b                  Show blank SHA-1 for boundary commits (Default: off)\n"
-"  -l                  Show long commit SHA1 (Default: off)\n"
-"  --root              Do not treat root commits as boundaries (Default: off)\n"
-"  -t                  Show raw timestamp (Default: off)\n"
-"  -f, --show-name     Show original filename (Default: auto)\n"
-"  -n, --show-number   Show original linenumber (Default: off)\n"
-"  -s                  Suppress author name and timestamp (Default: off)\n"
-"  -p, --porcelain     Show in a format designed for machine consumption\n"
-"  -w                  Ignore whitespace differences\n"
-"  -L n,m              Process only line range n,m, counting from 1\n"
-"  -M, -C              Find line movements within and across files\n"
-"  --incremental       Show blame entries as we find them, incrementally\n"
-"  --contents file     Use <file>'s contents as the final image\n"
-"  -S revs-file        Use revisions from revs-file instead of calling git-rev-list\n";
+static char blame_usage[] = "git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file";
+
+static const char *blame_opt_usage[] = { blame_usage, NULL };
 
 static int longest_file;
 static int longest_author;
@@ -2122,6 +2109,50 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	return commit;
 }
 
+static int blame_copy_callback(const struct option *option, const char *arg, int unset)
+{
+	int *opt = option->value;
+
+	/*
+	 * -C enables copy from removed files;
+	 * -C -C enables copy from existing files, but only
+	 *       when blaming a new file;
+	 * -C -C -C enables copy from existing files for
+	 *          everybody
+	 */
+	if (*opt & PICKAXE_BLAME_COPY_HARDER)
+		*opt |= PICKAXE_BLAME_COPY_HARDEST;
+	if (*opt & PICKAXE_BLAME_COPY)
+		*opt |= PICKAXE_BLAME_COPY_HARDER;
+	*opt |= PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE;
+
+	if (arg)
+		blame_copy_score = parse_score(arg);
+	return 0;
+}
+
+static int blame_move_callback(const struct option *option, const char *arg, int unset)
+{
+	int *opt = option->value;
+
+	*opt |= PICKAXE_BLAME_MOVE;
+
+	if (arg)
+		blame_move_score = parse_score(arg);
+	return 0;
+}
+
+static int blame_bottomtop_callback(const struct option *option, const char *arg, int unset)
+{
+	const char **bottomtop = option->value;
+	if (!arg)
+		return -1;
+	if (*bottomtop)
+		die("More than one '-L n,m' option given");
+	*bottomtop = arg;
+	return 0;
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -2129,94 +2160,58 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct scoreboard sb;
 	struct origin *o;
 	struct blame_entry *ent;
-	int i, seen_dashdash, unk, opt;
+	int i, seen_dashdash, unk;
 	long bottom, top, lno;
-	int output_option = 0;
-	int show_stats = 0;
-	const char *revs_file = NULL;
 	const char *final_commit_name = NULL;
 	enum object_type type;
-	const char *bottomtop = NULL;
-	const char *contents_from = NULL;
+
+	static const char *bottomtop = NULL;
+	static int output_option = 0, opt = 0;
+	static int show_stats = 0;
+	static const char *revs_file = NULL;
+	static const char *contents_from = NULL;
+	static const struct option options[] = {
+		OPT_BOOLEAN(0, "incremental", &incremental, "Show blame entries as we find them, incrementally"),
+		OPT_BOOLEAN('b', NULL, &blank_boundary, "Show blank SHA-1 for boundary commits (Default: off)"),
+		OPT_BOOLEAN(0, "root", &show_root, "Do not treat root commits as boundaries (Default: off)"),
+		OPT_BOOLEAN(0, "show-stats", &show_stats, "Show work cost statistics"),
+		OPT_BIT(0, "score-debug", &output_option, "Show output score for blame entries", OUTPUT_SHOW_SCORE),
+		OPT_BIT('f', "show-name", &output_option, "Show original filename (Default: auto)", OUTPUT_SHOW_NAME),
+		OPT_BIT('n', "show-number", &output_option, "Show original linenumber (Default: off)", OUTPUT_SHOW_NUMBER),
+		OPT_BIT('p', "porcelain", &output_option, "Show in a format designed for machine consumption", OUTPUT_PORCELAIN),
+		OPT_BIT('c', NULL, &output_option, "Use the same output mode as git-annotate (Default: off)", OUTPUT_ANNOTATE_COMPAT),
+		OPT_BIT('t', NULL, &output_option, "Show raw timestamp (Default: off)", OUTPUT_RAW_TIMESTAMP),
+		OPT_BIT('l', NULL, &output_option, "Show long commit SHA1 (Default: off)", OUTPUT_LONG_OBJECT_NAME),
+		OPT_BIT('s', NULL, &output_option, "Suppress author name and timestamp (Default: off)", OUTPUT_NO_AUTHOR),
+		OPT_BIT('w', NULL, &xdl_opts, "Ignore whitespace differences", XDF_IGNORE_WHITESPACE),
+		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file> instead of calling git-rev-list"),
+		OPT_STRING(0, "contents", &contents_from, "file", "Use <file>'s contents as the final image"),
+		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
+		{ OPTION_CALLBACK, 'M', NULL, &opt, "score", "Find line movements within and across files", PARSE_OPT_OPTARG, blame_move_callback },
+		OPT_CALLBACK('L', NULL, &bottomtop, "n,m", "Process only line range n,m, counting from 1", blame_bottomtop_callback),
+		OPT_END()
+	};
 
 	cmd_is_annotate = !strcmp(argv[0], "annotate");
 
+	argc = parse_options(argc, argv, options, blame_opt_usage,
+		PARSE_OPT_STOP_AT_NON_OPTION | PARSE_OPT_KEEP_DASHDASH);
+
+	/*
+	 * parse_options() offsets things by one - undo for now to make
+	 * old code happy.
+	 */
+	argc++;
+	argv--;
+
 	git_config(git_blame_config, NULL);
 	save_commit_buffer = 0;
 
-	opt = 0;
 	seen_dashdash = 0;
 	for (unk = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (*arg != '-')
 			break;
-		else if (!strcmp("-b", arg))
-			blank_boundary = 1;
-		else if (!strcmp("--root", arg))
-			show_root = 1;
-		else if (!strcmp(arg, "--show-stats"))
-			show_stats = 1;
-		else if (!strcmp("-c", arg))
-			output_option |= OUTPUT_ANNOTATE_COMPAT;
-		else if (!strcmp("-t", arg))
-			output_option |= OUTPUT_RAW_TIMESTAMP;
-		else if (!strcmp("-l", arg))
-			output_option |= OUTPUT_LONG_OBJECT_NAME;
-		else if (!strcmp("-s", arg))
-			output_option |= OUTPUT_NO_AUTHOR;
-		else if (!strcmp("-w", arg))
-			xdl_opts |= XDF_IGNORE_WHITESPACE;
-		else if (!strcmp("-S", arg) && ++i < argc)
-			revs_file = argv[i];
-		else if (!prefixcmp(arg, "-M")) {
-			opt |= PICKAXE_BLAME_MOVE;
-			blame_move_score = parse_score(arg+2);
-		}
-		else if (!prefixcmp(arg, "-C")) {
-			/*
-			 * -C enables copy from removed files;
-			 * -C -C enables copy from existing files, but only
-			 *       when blaming a new file;
-			 * -C -C -C enables copy from existing files for
-			 *          everybody
-			 */
-			if (opt & PICKAXE_BLAME_COPY_HARDER)
-				opt |= PICKAXE_BLAME_COPY_HARDEST;
-			if (opt & PICKAXE_BLAME_COPY)
-				opt |= PICKAXE_BLAME_COPY_HARDER;
-			opt |= PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE;
-			blame_copy_score = parse_score(arg+2);
-		}
-		else if (!prefixcmp(arg, "-L")) {
-			if (!arg[2]) {
-				if (++i >= argc)
-					usage(blame_usage);
-				arg = argv[i];
-			}
-			else
-				arg += 2;
-			if (bottomtop)
-				die("More than one '-L n,m' option given");
-			bottomtop = arg;
-		}
-		else if (!strcmp("--contents", arg)) {
-			if (++i >= argc)
-				usage(blame_usage);
-			contents_from = argv[i];
-		}
-		else if (!strcmp("--incremental", arg))
-			incremental = 1;
-		else if (!strcmp("--score-debug", arg))
-			output_option |= OUTPUT_SHOW_SCORE;
-		else if (!strcmp("-f", arg) ||
-			 !strcmp("--show-name", arg))
-			output_option |= OUTPUT_SHOW_NAME;
-		else if (!strcmp("-n", arg) ||
-			 !strcmp("--show-number", arg))
-			output_option |= OUTPUT_SHOW_NUMBER;
-		else if (!strcmp("-p", arg) ||
-			 !strcmp("--porcelain", arg))
-			output_option |= OUTPUT_PORCELAIN;
 		else if (!strcmp("--", arg)) {
 			seen_dashdash = 1;
 			i++;
