From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 2/3] diff: introduce --stat-lines to limit the stat lines
Date: Fri, 27 May 2011 14:36:41 +0200
Message-ID: <5da631c64438ec3f669f0c2b7456bcfbc371e2f5.1306499600.git.git@drmicha.warpmail.net>
References: <4DC0FD3D.9010004@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 14:36:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPwHd-0005GB-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 14:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab1E0Mgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 08:36:51 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36052 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753688Ab1E0Mgt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 08:36:49 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 792DE209C5;
	Fri, 27 May 2011 08:36:48 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 27 May 2011 08:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=60V1BN4UsnHrBIlhpZgJqy43BUs=; b=iqdRR41+wUruOQuufL3w+E9GrWtg+dMg7QBOyos96mTrVNoq9oygmq8JZjNocuKX5ecGyEtE4Ax+AY2J5/Z9Lz+wEcXivqKHt0DG71VLY54qvV/c6wTQaLIQuU6+Xgwze0O4Fn1ppcAmjTJiU4EY0/8kVBZRG/pcBECdUp8zYUw=
X-Sasl-enc: COxRkKs0MkdkrhpMD7ac41p4XgFqfpXY1QO8+PiMsF2t 1306499807
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D0A5E449467;
	Fri, 27 May 2011 08:36:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.657.g62c2
In-Reply-To: <4DC0FD3D.9010004@drmicha.warpmail.net>
In-Reply-To: <cover.1306499600.git.git@drmicha.warpmail.net>
References: <cover.1306499600.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174612>

Often one is interested in the full --stat output only for commits which
change a few files, but not others, because larger restructuring gives a
--stat which fills a few screens.

Introduce a new option --stat-count=<count> which limits the --stat output
to the first <count> lines, followed by a "..." line. It can
also be given as the third parameter in
--stat=<width>,<name-width>,<count>.

Also, the unstuck form is supported analogous to the other two stat
parameters.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/diff-options.txt |    5 ++++-
 diff.c                         |   38 ++++++++++++++++++++++++++++++++++----
 diff.h                         |    1 +
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 34f0145..000eae0 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -48,11 +48,14 @@ endif::git-format-patch[]
 --patience::
 	Generate a diff using the "patience diff" algorithm.
 
---stat[=<width>[,<name-width>]]::
+--stat[=<width>[,<name-width>[,<count>]]]::
 	Generate a diffstat.  You can override the default
 	output width for 80-column terminal by `--stat=<width>`.
 	The width of the filename part can be controlled by
 	giving another width to it separated by a comma.
+	By giving a third parameter `<count>`, you can limit the
+	output to the first `<count>` lines, followed by
+	`...` if there are more.
 
 --numstat::
 	Similar to `\--stat`, but shows number of added and
diff --git a/diff.c b/diff.c
index 4541939..6a6cbca 100644
--- a/diff.c
+++ b/diff.c
@@ -1244,7 +1244,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	int i, len, add, del, adds = 0, dels = 0;
 	uintmax_t max_change = 0, max_len = 0;
 	int total_files = data->nr;
-	int width, name_width;
+	int width, name_width, count;
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix = "";
 	struct strbuf *msg = NULL;
@@ -1259,6 +1259,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 
 	width = options->stat_width ? options->stat_width : 80;
 	name_width = options->stat_name_width ? options->stat_name_width : 50;
+	count = options->stat_count ? options->stat_count : data->nr;
 
 	/* Sanity: give at least 5 columns to the graph,
 	 * but leave at least 10 columns for the name.
@@ -1275,11 +1276,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	add_c = diff_get_color_opt(options, DIFF_FILE_NEW);
 	del_c = diff_get_color_opt(options, DIFF_FILE_OLD);
 
-	for (i = 0; i < data->nr; i++) {
+	for (i = 0; (i < count) && (i < data->nr); i++) {
 		struct diffstat_file *file = data->files[i];
 		uintmax_t change = file->added + file->deleted;
 		if (!data->files[i]->is_renamed &&
 			 (change == 0)) {
+			count++; /* not shown == room for one more */
 			continue;
 		}
 		fill_print_name(file);
@@ -1292,6 +1294,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (max_change < change)
 			max_change = change;
 	}
+	count = i; /* min(count, data->nr) */
 
 	/* Compute the width of the graph part;
 	 * 10 is for one blank at the beginning of the line plus
@@ -1306,7 +1309,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	else
 		width = max_change;
 
-	for (i = 0; i < data->nr; i++) {
+	for (i = 0; i < count; i++) {
 		const char *prefix = "";
 		char *name = data->files[i]->print_name;
 		uintmax_t added = data->files[i]->added;
@@ -1373,6 +1376,19 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		show_graph(options->file, '-', del, del_c, reset);
 		fprintf(options->file, "\n");
 	}
+	if (count < data->nr)
+		fprintf(options->file, "%s ...\n", line_prefix);
+	for (i = count; i < data->nr; i++) {
+		uintmax_t added = data->files[i]->added;
+		uintmax_t deleted = data->files[i]->deleted;
+		if (!data->files[i]->is_renamed &&
+			 (added + deleted == 0)) {
+			total_files--;
+			continue;
+		}
+		adds += added;
+		dels += deleted;
+	}
 	fprintf(options->file, "%s", line_prefix);
 	fprintf(options->file,
 	       " %d files changed, %d insertions(+), %d deletions(-)\n",
@@ -3109,6 +3125,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 	char *end;
 	int width = options->stat_width;
 	int name_width = options->stat_name_width;
+	int count = options->stat_count;
 	int argcount = 1;
 
 	arg += strlen("--stat");
@@ -3136,12 +3153,24 @@ static int stat_opt(struct diff_options *options, const char **av)
 				name_width = strtoul(av[1], &end, 10);
 				argcount = 2;
 			}
+		} else if (!prefixcmp(arg, "-count")) {
+			arg += strlen("-count");
+			if (*arg == '=')
+				count = strtoul(arg + 1, &end, 10);
+			else if (!*arg && !av[1])
+				die("Option '--stat-count' requires a value");
+			else if (!*arg) {
+				count = strtoul(av[1], &end, 10);
+				argcount = 2;
+			}
 		}
 		break;
 	case '=':
 		width = strtoul(arg+1, &end, 10);
 		if (*end == ',')
 			name_width = strtoul(end+1, &end, 10);
+		if (*end == ',')
+			count = strtoul(end+1, &end, 10);
 	}
 
 	/* Important! This checks all the error cases! */
@@ -3150,6 +3179,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 	options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	options->stat_name_width = name_width;
 	options->stat_width = width;
+	options->stat_count = count;
 	return argcount;
 }
 
@@ -3195,7 +3225,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "-s"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (!prefixcmp(arg, "--stat"))
-		/* --stat, --stat-width, or --stat-name-width */
+		/* --stat, --stat-width, --stat-name-width, or --stat-count */
 		return stat_opt(options, av);
 
 	/* renames options */
diff --git a/diff.h b/diff.h
index d83e53e..30ce9d8 100644
--- a/diff.h
+++ b/diff.h
@@ -124,6 +124,7 @@ struct diff_options {
 
 	int stat_width;
 	int stat_name_width;
+	int stat_count;
 	const char *word_regex;
 	enum diff_words_type word_diff;
 
-- 
1.7.5.2.657.g62c2
