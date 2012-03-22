From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v2 2/3] Adjust stat width calculations to take --graph output into account
Date: Thu, 22 Mar 2012 12:27:40 -0700
Message-ID: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
References: <1332444461-11957-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Bo Yang" <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 20:28:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAngc-0001vC-UH
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759383Ab2CVT2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:28:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53670 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab2CVT2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:28:24 -0400
Received: by gghe5 with SMTP id e5so2111617ggh.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=q8+Ceuv57XHDSYJXcson+CY4BKiQrA49pzNt6dWU3/s=;
        b=RY//X2e09lFsPCstREZ8sGyGNus1lsBxrZSjIYYJLMlclLTphy46eR4WFL+rKRGMG0
         et97YlCg78sM/pQwqVy+rRPuSVNl7zuXtBl1lOGBs7JRMgkGlouhH2ejRJq9rD4cjzRs
         Ie48bg4zaZ7AwH85p8pxQWu8XqZSEL/PkePcaAFFbxEC7/K5UzOmtg91OfpsJtZdj7Ms
         4o3JtXGZRfeCC98W2oJiglgZFBt2pjmP4wKvFZW4LVYqpol/nNlnI5FdF1kYG6jZtPdg
         FCAZaupyGAhgJvTwnF2uRyS4UliYxrpUidtKn5Rl46+yJ2b/AfwDWi9miPv3smyhR/0k
         xd8w==
Received: by 10.68.125.134 with SMTP id mq6mr23166384pbb.74.1332444502967;
        Thu, 22 Mar 2012 12:28:22 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id m5sm4281227pbo.69.2012.03.22.12.28.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:28:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1332444461-11957-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193696>

The recent change to compute the width of diff --stat did not take into
consideration the output from --graph. The consequence is that when both
options are used, e.g. in 'log --stat --graph', the lines are too long.

Adjust stat width calculations to take --graph output into account.

Adjust stat width calculations to reserve space for required characters before
scaling the widths for the filename and graph portions of the diff-stat. For
example, consider:

" diff.c |   66 ++-"

Before calculating the widths allocated to the filename, "diff.c", and the
graph, "++-", reserve space for the initial " " and the part between the
filename and graph portions " |   66 ". Then, divide the remaining space so
that 5/8ths is given to the filename and 3/8ths for the graph.

Update the affected test, t4502.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 diff.c                 |   66 ++++++++++++++++++++++++++++++++---------------
 t/t4052-stat-output.sh |    4 +-
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index 377ec1e..ed48480 100644
--- a/diff.c
+++ b/diff.c
@@ -1383,6 +1383,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	int width, name_width, graph_width, number_width = 4, count;
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix = "";
+	int line_prefix_length = 0;
+	int reserved_character_count;
 	int extra_shown = 0;
 	struct strbuf *msg = NULL;
 
@@ -1392,6 +1394,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	if (options->output_prefix) {
 		msg = options->output_prefix(options, options->output_prefix_data);
 		line_prefix = msg->buf;
+		line_prefix_length = options->output_prefix_length;
 	}
 
 	count = options->stat_count ? options->stat_count : data->nr;
@@ -1427,22 +1430,27 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * We have width = stat_width or term_columns() columns total.
 	 * We want a maximum of min(max_len, stat_name_width) for the name part.
 	 * We want a maximum of min(max_change, stat_graph_width) for the +- part.
-	 * We also need 1 for " " and 4 + decimal_width(max_change)
-	 * for " | NNNN " and one the empty column at the end, altogether
-	 * 6 + decimal_width(max_change).
+	 * Each line needs space for the following characters:
+	 *   - line_prefix_length for the line_prefix
+	 *   - 1 for the initial " "
+	 *   - 4 + decimal_width(max_change) for " | NNNN "
+	 *   - 1 for the empty column at the end,
+	 * Altogether, the reserved_character_count totals
+	 * 6 + line_prefix_length + decimal_width(max_change).
 	 *
-	 * If there's not enough space, we will use the smaller of
-	 * stat_name_width (if set) and 5/8*width for the filename,
-	 * and the rest for constant elements + graph part, but no more
-	 * than stat_graph_width for the graph part.
-	 * (5/8 gives 50 for filename and 30 for the constant parts + graph
-	 * for the standard terminal size).
+	 * If there's not enough space, we will use the smaller of stat_name_width
+	 * (if set) and 5/8*(width - reserved) for the filename, and the rest for
+	 * the graph part, but no more than stat_graph_width for the graph part.
+	 * Assuming the line prefix is empty, on a standard 80 column terminal
+	 * this ratio results in 44 characters for the filename and 26 characters
+	 * for the graph (plus the 10 reserved characters).
 	 *
 	 * In other words: stat_width limits the maximum width, and
 	 * stat_name_width fixes the maximum width of the filename,
 	 * and is also used to divide available columns if there
 	 * aren't enough.
 	 */
+	reserved_character_count = 6 + number_width + line_prefix_length;
 
 	if (options->stat_width == -1)
 		width = term_columns();
@@ -1453,11 +1461,11 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		options->stat_graph_width = diff_stat_graph_width;
 
 	/*
-	 * Guarantee 3/8*16==6 for the graph part
-	 * and 5/8*16==10 for the filename part
+	 * Guarantees at least 6 characters for the graph part [16 * 3/8]
+	 * and at least 10 for the filename part [16 * 5/8]
 	 */
-	if (width < 16 + 6 + number_width)
-		width = 16 + 6 + number_width;
+	if (width < 16 + reserved_character_count)
+		width = 16 + reserved_character_count;
 
 	/*
 	 * First assign sizes that are wanted, ignoring available width.
@@ -1472,16 +1480,32 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	/*
 	 * Adjust adjustable widths not to exceed maximum width
 	 */
-	if (name_width + number_width + 6 + graph_width > width) {
-		if (graph_width > width * 3/8 - number_width - 6)
-			graph_width = width * 3/8 - number_width - 6;
+	if (reserved_character_count + name_width + graph_width > width) {
+		/*
+		 * Reduce graph_width to be at most 3/8 of the unreserved space.
+		 */
+		if (graph_width > (width - reserved_character_count) * 3/8) {
+			graph_width = (width - reserved_character_count) * 3/8;
+		}
+
+		/*
+		 * If the remaining unreserved space will not accomodate the
+		 * filenames, adjust name_width to use all available remaining space.
+		 * Otherwise, assign any extra space to graph_width.
+		 */
+		if (name_width > width - reserved_character_count - graph_width) {
+			name_width = width - reserved_character_count - graph_width;
+		} else {
+			graph_width = width - reserved_character_count - name_width;
+		}
+
+		/*
+		 * If stat-graph-width was specified, limit graph_width to its value.
+		 */
 		if (options->stat_graph_width &&
-		    graph_width > options->stat_graph_width)
+				graph_width > options->stat_graph_width) {
 			graph_width = options->stat_graph_width;
-		if (name_width > width - number_width - 6 - graph_width)
-			name_width = width - number_width - 6 - graph_width;
-		else
-			graph_width = width - number_width - 6 - name_width;
+		}
 	}
 
 	/*
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 328aa8f..c95f120 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -162,7 +162,7 @@ test_expect_success 'preparation for long filename tests' '
 '
 
 cat >expect <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++++++++
 EOF
 while read cmd args
 do
@@ -179,7 +179,7 @@ log -1 --stat
 EOF
 
 cat >expect80 <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++++++++++
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++++++++++++++++
 EOF
 cat >expect200 <<'EOF'
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 
1.7.3.4
