From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/2] diff: introduce --stat-lines to limit the stat lines
Date: Tue,  3 May 2011 12:46:38 +0200
Message-ID: <102e117f7a9f7fd6e652f23d5630db973e8e52b8.1304419588.git.git@drmicha.warpmail.net>
References: <7vmxj6s22r.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 12:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHD7z-0006lp-Ho
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 12:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab1ECKqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 06:46:43 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46709 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752272Ab1ECKqm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 06:46:42 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 379B62080E;
	Tue,  3 May 2011 06:46:42 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 03 May 2011 06:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=BVBy6lwDmeLsBZyJTH9E4bXpSnk=; b=K1zcCsG/e8J/fY0wKc3ALgzv9ya1cV3IWmgtbh1eo6vgo9rzUNh5Xpu6Cmd+vfrcKC16k+ZZgU9toFHPPcMAy4uF8PU63OTa9G3R8bZoWHvtSFOvMmMKt60qvH3FceUJE0m08jfRmqhEAaenxp3x5czSw9Ov6IMa+AFXSB4r+Ug=
X-Sasl-enc: mafpHLetmPr5HWVacfw/t7GNzQkQteVVasrJUp8A3rB2 1304419601
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 751044425A2;
	Tue,  3 May 2011 06:46:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.250.g4493b
In-Reply-To: <7vmxj6s22r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172657>

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
I would even consider a default of 20 to be sensible but have refrained from
such a behaviour change.

We have hardcoded defaults for width (80) and name-width (50), but - as Junio
points out - typical terminals are horizontally limited, not vertically.

v2 uses the name "count" as suggested by Junio and limits to the first <count>
lines/items.

In the case with <count>+1 items one may argue whether it makes more sense to
ignore the user wish and output all <count>+1 lines, or <count> lines (as
requested) plus the "..." line.

(I saw the suggestion about N-2...2 just now. Would work also, but I guess
we would do this in more cases then, as Junio indicated.)
---
 Documentation/diff-options.txt |    5 ++++-
 diff.c                         |   37 +++++++++++++++++++++++++++++++++----
 diff.h                         |    1 +
 3 files changed, 38 insertions(+), 5 deletions(-)

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
index feced34..a6b0f0f 100644
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
@@ -1259,6 +1259,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 
 	width = options->stat_width ? options->stat_width : 80;
 	name_width = options->stat_name_width ? options->stat_name_width : 50;
+	count = (options->stat_count && options->stat_count < data->nr)
+					? options->stat_count : data->nr;
 
 	/* Sanity: give at least 5 columns to the graph,
 	 * but leave at least 10 columns for the name.
@@ -1275,7 +1277,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	add_c = diff_get_color_opt(options, DIFF_FILE_NEW);
 	del_c = diff_get_color_opt(options, DIFF_FILE_OLD);
 
-	for (i = 0; i < data->nr; i++) {
+	for (i = 0; i < count; i++) {
 		struct diffstat_file *file = data->files[i];
 		uintmax_t change = file->added + file->deleted;
 		fill_print_name(file);
@@ -1302,7 +1304,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	else
 		width = max_change;
 
-	for (i = 0; i < data->nr; i++) {
+	for (i = 0; i < count; i++) {
 		const char *prefix = "";
 		char *name = data->files[i]->print_name;
 		uintmax_t added = data->files[i]->added;
@@ -1369,6 +1371,19 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
@@ -3105,6 +3120,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 	char *end;
 	int width = options->stat_width;
 	int name_width = options->stat_name_width;
+	int count = options->stat_count;
 	int argcount = 1;
 
 	arg += strlen("--stat");
@@ -3132,12 +3148,24 @@ static int stat_opt(struct diff_options *options, const char **av)
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
@@ -3146,6 +3174,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 	options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	options->stat_name_width = name_width;
 	options->stat_width = width;
+	options->stat_count = count;
 	return argcount;
 }
 
@@ -3191,7 +3220,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
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
1.7.5.250.g4493b
