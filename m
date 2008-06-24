From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 7/7] Migrate git-blame to parse-option partially.
Date: Tue, 24 Jun 2008 11:12:12 +0200
Message-ID: <1214298732-6247-8-git-send-email-madcoder@debian.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
 <1214298732-6247-1-git-send-email-madcoder@debian.org>
 <1214298732-6247-2-git-send-email-madcoder@debian.org>
 <1214298732-6247-3-git-send-email-madcoder@debian.org>
 <1214298732-6247-4-git-send-email-madcoder@debian.org>
 <1214298732-6247-5-git-send-email-madcoder@debian.org>
 <1214298732-6247-6-git-send-email-madcoder@debian.org>
 <1214298732-6247-7-git-send-email-madcoder@debian.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:14:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB4b6-0007pw-Pc
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 11:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbYFXJM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 05:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbYFXJM0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 05:12:26 -0400
Received: from pan.madism.org ([88.191.52.104]:48602 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867AbYFXJMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 05:12:17 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1BC3A380E8;
	Tue, 24 Jun 2008 11:12:16 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3B9733D6925; Tue, 24 Jun 2008 11:12:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.110.g736c7.dirty
In-Reply-To: <1214298732-6247-7-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86024>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  This patch is not really nice yet, but shows what we can do on top of the
  rest of the series. I shamelessly "stole" most of the code from Linus'
  patch.

  The nasty strdup can be removed safely using my setup_revisions split into
  setup_revisions and parse_revisions, by initializing revisions _before_
  actualy option parsing, making parse_revisions incremental (IOW eating
  options one at a time only) and do the whole thing in one single pass.

  IOW, one would see a inner loop like:

+   for (;;) {
+       int res;
+
+       switch (parse_options_step(&ctx, options, blame_opt_usage)) {
+       case PARSE_OPT_HELP:
+           exit(129);
+       case PARSE_OPT_DONE:
+           goto parse_done;
+       }
+
+       if (!strcmp(ctx.argv[0], "--reverse")) {
+           reverse = 1;
+           ctx.argv[0] = "--children";
+       }
+       res = parse_revisions(&revs, ctx.argc, ctx.argv);
+       if (res <= 0) {
+           if (res == 0)
+               error("unknown option %s", ctx.argv[0]);
+           usage_with_options(options, blame_opt_usage);
+       }
+       ctx.argv += j;
+       ctx.argc -= j;
+   }

  But despite being quite ugly (because of the cpidx fiddling and the strdup),
  this patch works as intended.

 builtin-blame.c |  195 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 100 insertions(+), 95 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index cf41511..632a28d 100644
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
+static char blame_usage[] = "git-blame [options] [--] file";
+
+static const char *blame_opt_usage[] = { blame_usage, NULL };
 
 static int longest_file;
 static int longest_author;
@@ -2219,6 +2206,50 @@ static const char *prepare_initial(struct scoreboard *sb)
    return final_commit_name;
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
@@ -2226,98 +2257,72 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
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
+
+	struct parse_opt_ctx_t ctx;
 
 	cmd_is_annotate = !strcmp(argv[0], "annotate");
 
 	git_config(git_blame_config, NULL);
 	save_commit_buffer = 0;
 
-	opt = 0;
+	parse_options_start(&ctx, argc, argv, PARSE_OPT_KEEP_DASHDASH |
+	                    PARSE_OPT_KEEP_ARGV0);
+	for (;;) {
+		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
+		case PARSE_OPT_HELP:
+			exit(129);
+		case PARSE_OPT_DONE:
+			goto parse_done;
+		}
+
+		if (!strcmp(ctx.argv[0], "--reverse")) {
+			ctx.out[ctx.cpidx++] = "--children";
+			reverse = 1;
+		} else {
+			ctx.out[ctx.cpidx++] = strdup(ctx.argv[0]);
+		}
+		ctx.argv++;
+		ctx.argc--;
+	}
+parse_done:
+	argc = parse_options_end(&ctx);
+
 	seen_dashdash = 0;
 	for (unk = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (*arg != '-')
 			break;
-		else if (!strcmp("-b", arg))
-			blank_boundary = 1;
-		else if (!strcmp("--root", arg))
-			show_root = 1;
-		else if (!strcmp("--reverse", arg)) {
-			argv[unk++] = "--children";
-			reverse = 1;
-		}
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
-- 
1.5.6.110.g736c7.dirty
