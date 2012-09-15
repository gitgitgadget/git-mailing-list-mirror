From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] graph.c: mark private file-scope symbols as static
Date: Sat, 15 Sep 2012 14:10:49 -0700
Message-ID: <1347743452-2487-4-git-send-email-gitster@pobox.com>
References: <5054AA62.2040603@ramsay1.demon.co.uk>
 <1347743452-2487-1-git-send-email-gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:11:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCze2-0004wn-K9
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab2IOVLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:11:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631Ab2IOVLB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:11:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 931518563;
	Sat, 15 Sep 2012 17:11:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DsUI
	mYDzTD5LR12wCDzM7TcUbz8=; b=EJqACig8g+YBfudDknED9nFIqrVI0Jj8a5jB
	bg+oMUs8+g1iV7uSIG5TXjS6CwxbeaKwgbEG6rlrdAfifnl4kYenP7VM0+d6frXN
	10X00CtecE5kHcr86Bj1dEmNIwqnrsKaySuxtoe8INCX69x1g2tUSrzDEqbKRGe2
	QqN3ns8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	OTFoU51lTnmAmhE55Fl5dc1mznPyGvjKppSNt+acmXNqWsF0GRXimsK2fy5iITmT
	7ND87HVIqDp2YmhT+07nvx/uiZcYBeYk0gwBvNXedmUnMRT4LQHh+AsJyeV8Nr9Q
	mT8bNVoB9aN7yA0WATbOUtGSErSkZ5OsgbnDnGBewmw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 815E78562;
	Sat, 15 Sep 2012 17:11:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B02418561; Sat, 15 Sep 2012
 17:10:59 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.508.g4d78187
In-Reply-To: <1347743452-2487-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D92A892A-FF79-11E1-AFC1-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205577>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 graph.c | 32 ++++++++++++++++++++++++++++++--
 graph.h | 27 ---------------------------
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/graph.c b/graph.c
index 7e0a099..e864fe2 100644
--- a/graph.c
+++ b/graph.c
@@ -8,6 +8,34 @@
 /* Internal API */
 
 /*
+ * Output the next line for a graph.
+ * This formats the next graph line into the specified strbuf.  It is not
+ * terminated with a newline.
+ *
+ * Returns 1 if the line includes the current commit, and 0 otherwise.
+ * graph_next_line() will return 1 exactly once for each time
+ * graph_update() is called.
+ */
+static int graph_next_line(struct git_graph *graph, struct strbuf *sb);
+
+/*
+ * Set up a custom scheme for column colors.
+ *
+ * The default column color scheme inserts ANSI color escapes to colorize
+ * the graph. The various color escapes are stored in an array of strings
+ * where each entry corresponds to a color, except for the last entry,
+ * which denotes the escape for resetting the color back to the default.
+ * When generating the graph, strings from this array are inserted before
+ * and after the various column characters.
+ *
+ * This function allows you to enable a custom array of color escapes.
+ * The 'colors_max' argument is the index of the last "reset" entry.
+ *
+ * This functions must be called BEFORE graph_init() is called.
+ */
+static void graph_set_column_colors(const char **colors, unsigned short colors_max);
+
+/*
  * Output a padding line in the graph.
  * This is similar to graph_next_line().  However, it is guaranteed to
  * never print the current commit line.  Instead, if the commit line is
@@ -62,7 +90,7 @@ enum graph_state {
 static const char **column_colors;
 static unsigned short column_colors_max;
 
-void graph_set_column_colors(const char **colors, unsigned short colors_max)
+static void graph_set_column_colors(const char **colors, unsigned short colors_max)
 {
 	column_colors = colors;
 	column_colors_max = colors_max;
@@ -1116,7 +1144,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 		graph_update_state(graph, GRAPH_PADDING);
 }
 
-int graph_next_line(struct git_graph *graph, struct strbuf *sb)
+static int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
 	switch (graph->state) {
 	case GRAPH_PADDING:
diff --git a/graph.h b/graph.h
index aff960c..19b0f66 100644
--- a/graph.h
+++ b/graph.h
@@ -4,22 +4,6 @@
 /* A graph is a pointer to this opaque structure */
 struct git_graph;
 
-/*
- * Set up a custom scheme for column colors.
- *
- * The default column color scheme inserts ANSI color escapes to colorize
- * the graph. The various color escapes are stored in an array of strings
- * where each entry corresponds to a color, except for the last entry,
- * which denotes the escape for resetting the color back to the default.
- * When generating the graph, strings from this array are inserted before
- * and after the various column characters.
- *
- * This function allows you to enable a custom array of color escapes.
- * The 'colors_max' argument is the index of the last "reset" entry.
- *
- * This functions must be called BEFORE graph_init() is called.
- */
-void graph_set_column_colors(const char **colors, unsigned short colors_max);
 
 /*
  * Create a new struct git_graph.
@@ -49,17 +33,6 @@ void graph_update(struct git_graph *graph, struct commit *commit);
  */
 int graph_is_commit_finished(struct git_graph const *graph);
 
-/*
- * Output the next line for a graph.
- * This formats the next graph line into the specified strbuf.  It is not
- * terminated with a newline.
- *
- * Returns 1 if the line includes the current commit, and 0 otherwise.
- * graph_next_line() will return 1 exactly once for each time
- * graph_update() is called.
- */
-int graph_next_line(struct git_graph *graph, struct strbuf *sb);
-
 
 /*
  * graph_show_*: helper functions for printing to stdout
-- 
1.7.12.508.g4d78187
