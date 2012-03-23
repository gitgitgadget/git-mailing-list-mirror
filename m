From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph output into account
Date: Thu, 22 Mar 2012 22:54:55 -0700
Message-ID: <1332482108-2659-1-git-send-email-lucian.poston@gmail.com>
References: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 06:55:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAxTc-0004ps-NY
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 06:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941Ab2CWFzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 01:55:47 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61894 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab2CWFzr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 01:55:47 -0400
Received: by pbcun15 with SMTP id un15so2243763pbc.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 22:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ST6RFjSVAt6d1lMBF+u+zMhmgeDj1ujhnc9SHr4RHbg=;
        b=coqvYO0hELH+Q8ydfLhCDw8FXSJmvUTjcgBOErTJyO9BRCmSoC6t9bPDsxYKlL4uz1
         N2mMFJc4To/P8Gd0u4ogknU8160C3XWdxtqxkrJKmHLjwZGQP73vDroF0Lc22oISlD63
         tS6mseJEzWOlrH2k+o4s2o+QaMur8vg+X264ueY1Jm/oHMvJQOFZKnH4Z6XFE8LJwE0K
         BEWmxH6WtEFUFL+VbmuQTuqJxVkYaqnzJGFF/pGxFLj4P52EX2vqBQ+kPOpJpau+XVTU
         xXTJVEKEFUi9sEx3JgL6G9xVAyQYaM6VaO4e9zh01ORryv3yW5RPTxYtt8nMYrhcWxVD
         V9UQ==
Received: by 10.68.223.67 with SMTP id qs3mr26434477pbc.142.1332482146528;
        Thu, 22 Mar 2012 22:55:46 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id z7sm2116068pbk.63.2012.03.22.22.55.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 22:55:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193746>

The recent change to compute the width of diff --stat did not take into
consideration the output from --graph. The consequence is that when both
options are used, e.g. in 'log --stat --graph', the lines are too long.

Adjust stat width calculations to take --graph output into account.

Prevent graph width of diff-stat from falling below minimum.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 diff.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 377ec1e..31ba10c 100644
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
@@ -1427,37 +1430,46 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * We have width = stat_width or term_columns() columns total.
 	 * We want a maximum of min(max_len, stat_name_width) for the name part.
 	 * We want a maximum of min(max_change, stat_graph_width) for the +- part.
-	 * We also need 1 for " " and 4 + decimal_width(max_change)
-	 * for " | NNNN " and one the empty column at the end, altogether
+	 * Each line needs space for the following characters:
+	 *   - 1 for the initial " "
+	 *   - 4 + decimal_width(max_change) for " | NNNN "
+	 *   - 1 for the empty column at the end,
+	 * Altogether, the reserved_character_count totals
 	 * 6 + decimal_width(max_change).
 	 *
-	 * If there's not enough space, we will use the smaller of
-	 * stat_name_width (if set) and 5/8*width for the filename,
-	 * and the rest for constant elements + graph part, but no more
-	 * than stat_graph_width for the graph part.
-	 * (5/8 gives 50 for filename and 30 for the constant parts + graph
-	 * for the standard terminal size).
+	 * Additionally, there may be a line_prefix, which reduces the available
+	 * width by line_prefix_length.
+	 *
+	 * If there's not enough space, we will use the smaller of stat_name_width
+	 * (if set) and 5/8*width for the filename, and the rest for the graph
+	 * part, but no more than stat_graph_width for the graph part.
+	 * Assuming the line prefix is empty, on a standard 80 column terminal
+	 * this ratio results in 50 characters for the filename and 20 characters
+	 * for the graph (plus the 10 reserved characters).
 	 *
 	 * In other words: stat_width limits the maximum width, and
 	 * stat_name_width fixes the maximum width of the filename,
 	 * and is also used to divide available columns if there
 	 * aren't enough.
 	 */
+	reserved_character_count = 6 + number_width;
 
 	if (options->stat_width == -1)
 		width = term_columns();
 	else
 		width = options->stat_width ? options->stat_width : 80;
 
+	width -= line_prefix_length;
+
 	if (options->stat_graph_width == -1)
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
@@ -1472,16 +1484,36 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	/*
 	 * Adjust adjustable widths not to exceed maximum width
 	 */
-	if (name_width + number_width + 6 + graph_width > width) {
-		if (graph_width > width * 3/8 - number_width - 6)
-			graph_width = width * 3/8 - number_width - 6;
+	if (reserved_character_count + name_width + graph_width > width) {
+		/*
+		 * Reduce graph_width to be at most 3/8 of the unreserved space and no
+		 * less than 6, which leaves at least 5/8 for the filename.
+		 */
+		if (graph_width > width * 3/8 - reserved_character_count) {
+			graph_width = width * 3/8 - reserved_character_count;
+			if (graph_width < 6) {
+				graph_width = 6;
+			}
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
-- 
1.7.3.4
