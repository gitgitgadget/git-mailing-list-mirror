From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Tue, 26 Sep 2006 19:40:43 -0700
Message-ID: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Sep 27 04:41:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPLv-0002X1-EB
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 04:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWI0Ckr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 22:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWI0Ckq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 22:40:46 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:13773 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932262AbWI0Ckp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 22:40:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927024045.JVDT6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 22:40:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TEgi1V00G1kojtg0000000
	Tue, 26 Sep 2006 22:40:42 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27855>

This adds two parameters to "diff --stat".

 . --stat-width=72 tells that the page should fit on 72-column output.

 . --stat-name-width=30 tells that the filename part is limited
   to 30 columns.

Without these flags, they default to 80 and 50 as before.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Adrian Bunk on the kernel list wanted ot have "diffstat
   -w72", so here it is.

 diff.c |  132 ++++++++++++++++++++++++++++++++++++++++++++++------------------
 diff.h |    3 +
 2 files changed, 97 insertions(+), 38 deletions(-)

diff --git a/diff.c b/diff.c
index 443e248..6101365 100644
--- a/diff.c
+++ b/diff.c
@@ -545,21 +545,63 @@ static void diffstat_consume(void *priv,
 		x->deleted++;
 }
 
-static const char pluses[] = "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
-static const char minuses[]= "----------------------------------------------------------------------";
 const char mime_boundary_leader[] = "------------";
 
-static void show_stats(struct diffstat_t* data)
+static int scale_linear(int it, int width, int max_change)
+{
+	/*
+	 * round(width * it / max_change);
+	 */
+	return (it * width * 2 + max_change) / (max_change * 2);
+}
+
+static void show_name(const char *prefix, const char *name, int len)
+{
+	printf(" %s%-*s |", prefix, len, name);
+}
+
+static void show_graph(char ch, int cnt)
+{
+	if (!cnt)
+		return;
+	while (cnt--)
+		putchar(ch);
+}
+
+static void show_stats(struct diffstat_t* data, struct diff_options *options)
 {
 	int i, len, add, del, total, adds = 0, dels = 0;
-	int max, max_change = 0, max_len = 0;
+	int max_change = 0, max_len = 0;
 	int total_files = data->nr;
+	int width, name_width;
 
 	if (data->nr == 0)
 		return;
 
+	width = options->stat_width ? options->stat_width : 80;
+	name_width = options->stat_name_width ? options->stat_name_width : 50;
+
+	/* Sanity: give at least 5 columns to the graph,
+	 * but leave at least 10 columns for the name.
+	 */
+	if (width < name_width + 15) {
+		if (25 < name_width)
+			name_width = width - 15;
+		else
+			width = name_width + 15;
+	}
+
+	/* Find the longest filename and max number of changes */
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
+		int change = file->added + file->deleted;
+
+		if (0 < (len = quote_c_style(file->name, NULL, NULL, 0))) {
+			char *qname = xmalloc(len + 1);
+			quote_c_style(file->name, qname, NULL, 0);
+			free(file->name);
+			file->name = qname;
+		}
 
 		len = strlen(file->name);
 		if (max_len < len)
@@ -567,54 +609,53 @@ static void show_stats(struct diffstat_t
 
 		if (file->is_binary || file->is_unmerged)
 			continue;
-		if (max_change < file->added + file->deleted)
-			max_change = file->added + file->deleted;
+		if (max_change < change)
+			max_change = change;
 	}
 
+	/* Compute the width of the graph part;
+	 * 10 is for one blank at the beginning of the line plus
+	 * " | count " between the name and the graph.
+	 *
+	 * From here on, name_width is the width of the name area,
+	 * and width is the width of the graph area.
+	 */
+	name_width = (name_width < max_len) ? name_width : max_len;
+	if (width < (name_width + 10) + max_change)
+		width = width - (name_width + 10);
+	else
+		width = max_change;
+
 	for (i = 0; i < data->nr; i++) {
 		const char *prefix = "";
 		char *name = data->files[i]->name;
 		int added = data->files[i]->added;
 		int deleted = data->files[i]->deleted;
-
-		if (0 < (len = quote_c_style(name, NULL, NULL, 0))) {
-			char *qname = xmalloc(len + 1);
-			quote_c_style(name, qname, NULL, 0);
-			free(name);
-			data->files[i]->name = name = qname;
-		}
+		int name_len;
 
 		/*
 		 * "scale" the filename
 		 */
-		len = strlen(name);
-		max = max_len;
-		if (max > 50)
-			max = 50;
-		if (len > max) {
+		len = name_width;
+		name_len = strlen(name);
+		if (name_width < name_len) {
 			char *slash;
 			prefix = "...";
-			max -= 3;
-			name += len - max;
+			len -= 3;
+			name += name_len - len;
 			slash = strchr(name, '/');
 			if (slash)
 				name = slash;
 		}
-		len = max;
-
-		/*
-		 * scale the add/delete
-		 */
-		max = max_change;
-		if (max + len > 70)
-			max = 70 - len;
 
 		if (data->files[i]->is_binary) {
-			printf(" %s%-*s |  Bin\n", prefix, len, name);
+			show_name(prefix, name, len);
+			printf("  Bin\n");
 			goto free_diffstat_file;
 		}
 		else if (data->files[i]->is_unmerged) {
-			printf(" %s%-*s |  Unmerged\n", prefix, len, name);
+			show_name(prefix, name, len);
+			printf("  Unmerged\n");
 			goto free_diffstat_file;
 		}
 		else if (!data->files[i]->is_renamed &&
@@ -623,27 +664,34 @@ static void show_stats(struct diffstat_t
 			goto free_diffstat_file;
 		}
 
+		/*
+		 * scale the add/delete
+		 */
 		add = added;
 		del = deleted;
 		total = add + del;
 		adds += add;
 		dels += del;
 
-		if (max_change > 0) {
-			total = (total * max + max_change / 2) / max_change;
-			add = (add * max + max_change / 2) / max_change;
+		if (max_change < width)
+			;
+		else {
+			total = scale_linear(total, width, max_change);
+			add = scale_linear(add, width, max_change);
 			del = total - add;
 		}
-		printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
-				len, name, added + deleted,
-				add, pluses, del, minuses);
+		show_name(prefix, name, len);
+		printf("%5d ", added + deleted);
+		show_graph('+', add);
+		show_graph('-', del);
+		putchar('\n');
 	free_diffstat_file:
 		free(data->files[i]->name);
 		free(data->files[i]);
 	}
 	free(data->files);
 	printf(" %d files changed, %d insertions(+), %d deletions(-)\n",
-			total_files, adds, dels);
+	       total_files, adds, dels);
 }
 
 struct checkdiff_t {
@@ -1681,6 +1729,14 @@ int diff_opt_parse(struct diff_options *
 	}
 	else if (!strcmp(arg, "--stat"))
 		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	else if (!strncmp(arg, "--stat-width=", 13)) {
+		options->stat_width = strtoul(arg + 13, NULL, 10);
+		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	}
+	else if (!strncmp(arg, "--stat-name-width=", 18)) {
+		options->stat_name_width = strtoul(arg + 18, NULL, 10);
+		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	}
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
@@ -2438,7 +2494,7 @@ void diff_flush(struct diff_options *opt
 			if (check_pair_status(p))
 				diff_flush_stat(p, options, &diffstat);
 		}
-		show_stats(&diffstat);
+		show_stats(&diffstat, options);
 		separator++;
 	}
 
diff --git a/diff.h b/diff.h
index b60a02e..e06d0f4 100644
--- a/diff.h
+++ b/diff.h
@@ -69,6 +69,9 @@ struct diff_options {
 	const char *stat_sep;
 	long xdl_opts;
 
+	int stat_width;
+	int stat_name_width;
+
 	int nr_paths;
 	const char **paths;
 	int *pathlens;
-- 
1.4.2.1.gf80a
