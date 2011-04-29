From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] diff: introduce --stat-lines to limit the stat lines
Date: Fri, 29 Apr 2011 16:57:45 +0200
Message-ID: <5f16db0f3730be70ff522e63fbd491dc910c34d0.1304089050.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 16:58:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFp8o-0003yU-7X
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 16:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab1D2O5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 10:57:51 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51719 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751697Ab1D2O5u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 10:57:50 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 761BA207A5
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 10:57:49 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 29 Apr 2011 10:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=n+XUr8UIn816eYlGMoNeXcpc5vw=; b=Ucn5hpgmgag1wwvFEP8Z0mw80f2Mri4bG0kzSHy4Fjod1DfzM4M5lUvxfnBoy3HBedhULJTR1fvqeq8uQd/6lvOgVEAnR6RgaaUSYkmzqIuQ1rwBYPKlSZhDDSxf+KskffYxxNHH9UGQ8UBDNAaLRkv3nFh4zRALgXWewi+tKWQ=
X-Sasl-enc: 9mZGHo6OmW8GE8Qv0P/+sgoXlyaXltRW6wYiXmpBF2Jt 1304089068
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C56BB40362A;
	Fri, 29 Apr 2011 10:57:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.250.g4493b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172455>

Often one is interested in the full --stat output only for commits which
change a few files, but not others, because larger restructuring gives a
--stat which fills a few screens.

Introduce a new option --stat-lines=<lines> which limits the --stat output
to the first and last <lines> lines, separated by a "..." line. It can
also be given as the third parameter in
--stat=<width>,<name-width>,<lines>.

Also, the unstuck form is supported analogous to the other two stat
parameters.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I would even consider a default of 10 (i.e. show a 20 line stat in full,
abbreviate larger ones) to be sensible but have refrained from such a
behaviour change.

We have hardcoded defaults for width (80) and name-width (50), so having
one for lines should be okay also. Can I has tis wiz default? ;)
---
 Documentation/diff-options.txt |    5 ++++-
 diff.c                         |   25 +++++++++++++++++++++++--
 diff.h                         |    1 +
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 34f0145..e0429b3 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -48,11 +48,14 @@ endif::git-format-patch[]
 --patience::
 	Generate a diff using the "patience diff" algorithm.
 
---stat[=<width>[,<name-width>]]::
+--stat[=<width>[,<name-width>[,<lines>]]]::
 	Generate a diffstat.  You can override the default
 	output width for 80-column terminal by `--stat=<width>`.
 	The width of the filename part can be controlled by
 	giving another width to it separated by a comma.
+	By giving a third parameter `<lines>`, you can limit the
+	output to the first and last `<lines>` lines, separated by
+	`...`.
 
 --numstat::
 	Similar to `\--stat`, but shows number of added and
diff --git a/diff.c b/diff.c
index feced34..9ccba1e 100644
--- a/diff.c
+++ b/diff.c
@@ -1244,7 +1244,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	int i, len, add, del, adds = 0, dels = 0;
 	uintmax_t max_change = 0, max_len = 0;
 	int total_files = data->nr;
-	int width, name_width;
+	int width, name_width, lines;
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix = "";
 	struct strbuf *msg = NULL;
@@ -1259,6 +1259,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 
 	width = options->stat_width ? options->stat_width : 80;
 	name_width = options->stat_name_width ? options->stat_name_width : 50;
+	lines = options->stat_lines;
 
 	/* Sanity: give at least 5 columns to the graph,
 	 * but leave at least 10 columns for the name.
@@ -1303,6 +1304,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		width = max_change;
 
 	for (i = 0; i < data->nr; i++) {
+		if (lines && i >= lines && i < data->nr-lines) {
+			fprintf(options->file, "%s ...\n", line_prefix);
+			i = data->nr-lines-1;
+			lines = 0; /* no need to recheck */
+			continue;
+		}
 		const char *prefix = "";
 		char *name = data->files[i]->print_name;
 		uintmax_t added = data->files[i]->added;
@@ -3105,6 +3112,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 	char *end;
 	int width = options->stat_width;
 	int name_width = options->stat_name_width;
+	int lines = options->stat_lines;
 	int argcount = 1;
 
 	arg += strlen("--stat");
@@ -3132,12 +3140,24 @@ static int stat_opt(struct diff_options *options, const char **av)
 				name_width = strtoul(av[1], &end, 10);
 				argcount = 2;
 			}
+		} else if (!prefixcmp(arg, "-lines")) {
+			arg += strlen("-lines");
+			if (*arg == '=')
+				lines = strtoul(arg + 1, &end, 10);
+			else if (!*arg && !av[1])
+				die("Option '--stat-lines' requires a value");
+			else if (!*arg) {
+				lines = strtoul(av[1], &end, 10);
+				argcount = 2;
+			}
 		}
 		break;
 	case '=':
 		width = strtoul(arg+1, &end, 10);
 		if (*end == ',')
 			name_width = strtoul(end+1, &end, 10);
+		if (*end == ',')
+			lines = strtoul(end+1, &end, 10);
 	}
 
 	/* Important! This checks all the error cases! */
@@ -3146,6 +3166,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 	options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	options->stat_name_width = name_width;
 	options->stat_width = width;
+	options->stat_lines = lines;
 	return argcount;
 }
 
@@ -3191,7 +3212,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "-s"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (!prefixcmp(arg, "--stat"))
-		/* --stat, --stat-width, or --stat-name-width */
+		/* --stat, --stat-width, --stat-name-width, or --stat-lines */
 		return stat_opt(options, av);
 
 	/* renames options */
diff --git a/diff.h b/diff.h
index d83e53e..98e9aed 100644
--- a/diff.h
+++ b/diff.h
@@ -124,6 +124,7 @@ struct diff_options {
 
 	int stat_width;
 	int stat_name_width;
+	int stat_lines;
 	const char *word_regex;
 	enum diff_words_type word_diff;
 
-- 
1.7.5.250.g4493b
