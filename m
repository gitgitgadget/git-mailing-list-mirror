From: Christoph Junghans <ottxor@gentoo.org>
Subject: [PATCH v2] git-log: added --none-match option
Date: Sun, 11 Jan 2015 18:39:49 -0700
Message-ID: <1421026789-14932-1-git-send-email-ottxor@gentoo.org>
References: <xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Christoph Junghans <ottxor@gentoo.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 12 02:40:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YATzM-000211-9R
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 02:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbbALBj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2015 20:39:56 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:52066 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbbALBjz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2015 20:39:55 -0500
Received: from dev.gentoo.org:587 (unknown [50.130.223.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ottxor)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 904793406A1;
	Mon, 12 Jan 2015 01:39:53 +0000 (UTC)
Received: by dev.gentoo.org:587 (sSMTP sendmail emulation); Sun, 11 Jan 2015 18:39:50 -0700
X-Mailer: git-send-email 2.0.5
In-Reply-To: <xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262284>

Implements a none match for git log, which is useful from time to
time to e.g. filter FIXUP message out of git log.

Internally, the bol 'all_match' was changed to an int 'all_or_none'
taken the values 0, GREP_ALL_MATCH or GREP_NONE_MATCH.

For git grep a similar functionality can achieved by the existing
--files-without-match option.

Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
---
 Documentation/rev-list-options.txt     |  4 ++++
 builtin/grep.c                         |  5 +++--
 contrib/completion/git-completion.bash |  2 +-
 gitk-git/gitk                          |  1 +
 grep.c                                 | 24 ++++++++++++++++++------
 grep.h                                 |  4 +++-
 revision.c                             |  4 +++-
 7 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index afccfdc..08e4ed8 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -66,6 +66,10 @@ if it is part of the log message.
 	Limit the commits output to ones that match all given `--grep`,
 	instead of ones that match at least one.
 
+--none-match::
+	Limit the commits output to ones that do not match any of the 
+	given `--grep`, instead of ones that match at least one.
+
 -i::
 --regexp-ignore-case::
 	Match the regular expression limiting patterns without regard to letter
diff --git a/builtin/grep.c b/builtin/grep.c
index 4063882..1ec8ce1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -727,8 +727,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		  close_callback },
 		OPT__QUIET(&opt.status_only,
 			   N_("indicate hit with exit status without output")),
-		OPT_BOOL(0, "all-match", &opt.all_match,
-			N_("show only matches from files that match all patterns")),
+		OPT_SET_INT(0, "all-match", &opt.all_or_none,
+			    N_("show only matches from files that match all patterns"),
+			    GREP_ALL_MATCH),
 		{ OPTION_SET_INT, 0, "debug", &opt.debug, NULL,
 		  N_("show parse tree for grep expression"),
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1 },
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cd76579..47ed970 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1425,7 +1425,7 @@ __git_log_gitk_options="
 # Options that go well for log and shortlog (not gitk)
 __git_log_shortlog_options="
 	--author= --committer= --grep=
-	--all-match
+	--all-match --none-match
 "
 
 __git_log_pretty_formats="oneline short medium full fuller email raw format:"
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 78358a7..c67674f 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3977,6 +3977,7 @@ set known_view_options {
     {committer t15  .  "--committer=*"  {mc "Committer:"}}
     {loginfo   t15  .. "--grep=*"       {mc "Commit Message:"}}
     {allmatch  b    .. "--all-match"    {mc "Matches all Commit Info criteria"}}
+    {nonematch b    .. "--none-match"   {mc "Matches none Commit Info criteria"}}
     {changes_l l    +  {}               {mc "Changes to Files:"}}
     {pickaxe_s r0   .  {}               {mc "Fixed String"}}
     {pickaxe_t r1   .  "--pickaxe-regex"  {mc "Regular Expression"}}
diff --git a/grep.c b/grep.c
index 6e085f8..f6eb044 100644
--- a/grep.c
+++ b/grep.c
@@ -609,8 +609,14 @@ static void dump_grep_expression(struct grep_opt *opt)
 {
 	struct grep_expr *x = opt->pattern_expression;
 
-	if (opt->all_match)
+	switch (opt->all_or_none) {
+	case GREP_ALL_MATCH:
 		fprintf(stderr, "[all-match]\n");
+	case GREP_NONE_MATCH:
+		fprintf(stderr, "[none-match]\n");
+	default:
+		break;
+	}
 	dump_grep_expression_1(x, 0);
 	fflush(NULL);
 }
@@ -713,7 +719,7 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
 		}
 	}
 
-	if (opt->all_match || header_expr)
+	if ((opt->all_or_none == GREP_ALL_MATCH) || header_expr)
 		opt->extended = 1;
 	else if (!opt->extended && !opt->debug)
 		return;
@@ -729,13 +735,13 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
 
 	if (!opt->pattern_expression)
 		opt->pattern_expression = header_expr;
-	else if (opt->all_match)
+	else if (opt->all_or_none == GREP_ALL_MATCH)
 		opt->pattern_expression = grep_splice_or(header_expr,
 							 opt->pattern_expression);
 	else
 		opt->pattern_expression = grep_or_expr(opt->pattern_expression,
 						       header_expr);
-	opt->all_match = 1;
+	opt->all_or_none = GREP_ALL_MATCH;
 }
 
 void compile_grep_patterns(struct grep_opt *opt)
@@ -1624,10 +1630,16 @@ int grep_source(struct grep_opt *opt, struct grep_source *gs)
 {
 	/*
 	 * we do not have to do the two-pass grep when we do not check
-	 * buffer-wide "all-match".
+	 * buffer-wide "all-match" or check "none-match".
 	 */
-	if (!opt->all_match)
+	switch (opt->all_or_none) {
+	case GREP_NONE_MATCH:
+		return !grep_source_1(opt, gs, 0);
+	case GREP_ALL_MATCH:
+		break;
+	default:
 		return grep_source_1(opt, gs, 0);
+	}
 
 	/* Otherwise the toplevel "or" terms hit a bit differently.
 	 * We first clear hit markers from them.
diff --git a/grep.h b/grep.h
index 95f197a..2cdabf2 100644
--- a/grep.h
+++ b/grep.h
@@ -101,7 +101,9 @@ struct grep_opt {
 	int count;
 	int word_regexp;
 	int fixed;
-	int all_match;
+#define GREP_ALL_MATCH 1
+#define GREP_NONE_MATCH 2
+	int all_or_none;
 	int debug;
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
diff --git a/revision.c b/revision.c
index 14e0e03..723b495 100644
--- a/revision.c
+++ b/revision.c
@@ -2010,7 +2010,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--perl-regexp")) {
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--all-match")) {
-		revs->grep_filter.all_match = 1;
+		revs->grep_filter.all_or_none = GREP_ALL_MATCH;
+	} else if (!strcmp(arg, "--none-match")) {
+		revs->grep_filter.all_or_none = GREP_NONE_MATCH;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding = xstrdup(optarg);
-- 
2.0.5
