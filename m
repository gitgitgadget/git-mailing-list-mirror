From: Jeff King <peff@peff.net>
Subject: [RFC] Colorize 'commit' lines in log ui
Date: Sun, 23 Jul 2006 05:24:18 -0400
Message-ID: <20060723092417.GA7547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jul 23 11:24:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4aCU-0001Lt-5S
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 11:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWGWJYV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 05:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWGWJYV
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 05:24:21 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:8584 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751164AbWGWJYU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Jul 2006 05:24:20 -0400
Received: (qmail 25638 invoked from network); 23 Jul 2006 05:23:54 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Jul 2006 05:23:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Jul 2006 05:24:18 -0400
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24093>

When paging through the output of git-whatchanged, the color cues help to
visually navigate within a diff. However, it is difficult to notice when a
new commit starts, because the commit and log are shown in the "normal"
color. This patch colorizes the 'commit' line, customizable through
diff.colors.commit and defaulting to yellow.

As a side effect, some of the diff color engine (slot enum, get_color) has
become accessible outside of diff.c.

Signed-off-by: Jeff King <peff@peff.net>
---

I think the visual cue makes the git-whatchanged -p output much easier
to read.

I originally thought of making a "colorized commit" patch where you
could independently set commit.color and commit.color.*. However, it was
clearly much simpler to start by using the diff engine's code.
  1. Do people really want to colorize the commit outside of colorizing
     the diffs, anyway? It makes sense for the code to go together.
  2. Should we call it something other than diff_colors (since now it's
     handling the commit log, too)?

It currently just colorizes the 'commit' line. We could also do the
'Author' and 'Date' lines (either as the same color, or independently),
as well as the log text.

It colorizes all formats given to show_log() except CMIT_FMT_EMAIL (so,
e.g., the sha1's in CMIT_FMT_ONELINE will be yellow). Is that what we
want?

 diff.c     |   28 +++++++++++-----------------
 diff.h     |   11 +++++++++++
 log-tree.c |    5 ++++-
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/diff.c b/diff.c
index 8b44756..6a71376 100644
--- a/diff.c
+++ b/diff.c
@@ -17,15 +17,6 @@ static int diff_detect_rename_default = 
 static int diff_rename_limit_default = -1;
 static int diff_use_color_default = 0;
 
-enum color_diff {
-	DIFF_RESET = 0,
-	DIFF_PLAIN = 1,
-	DIFF_METAINFO = 2,
-	DIFF_FRAGINFO = 3,
-	DIFF_FILE_OLD = 4,
-	DIFF_FILE_NEW = 5,
-};
-
 /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
 static char diff_colors[][24] = {
 	"\033[m",	/* reset */
@@ -33,7 +24,8 @@ static char diff_colors[][24] = {
 	"\033[1m",	/* bold */
 	"\033[36m",	/* cyan */
 	"\033[31m",	/* red */
-	"\033[32m"	/* green */
+	"\033[32m",	/* green */
+	"\033[33m"	/* yellow */
 };
 
 static int parse_diff_color_slot(const char *var, int ofs)
@@ -48,6 +40,8 @@ static int parse_diff_color_slot(const c
 		return DIFF_FILE_OLD;
 	if (!strcasecmp(var+ofs, "new"))
 		return DIFF_FILE_NEW;
+	if (!strcasecmp(var+ofs, "commit"))
+		return DIFF_COMMIT;
 	die("bad config variable '%s'", var);
 }
 
@@ -370,7 +364,7 @@ struct emit_callback {
 	const char **label_path;
 };
 
-static inline const char *get_color(int diff_use_color, enum color_diff ix)
+const char *diff_get_color(int diff_use_color, enum color_diff ix)
 {
 	if (diff_use_color)
 		return diff_colors[ix];
@@ -381,8 +375,8 @@ static void fn_out_consume(void *priv, c
 {
 	int i;
 	struct emit_callback *ecbdata = priv;
-	const char *set = get_color(ecbdata->color_diff, DIFF_METAINFO);
-	const char *reset = get_color(ecbdata->color_diff, DIFF_RESET);
+	const char *set = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
+	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 
 	if (ecbdata->label_path[0]) {
 		printf("%s--- %s%s\n", set, ecbdata->label_path[0], reset);
@@ -397,7 +391,7 @@ static void fn_out_consume(void *priv, c
 		;
 	if (2 <= i && i < len && line[i] == ' ') {
 		ecbdata->nparents = i - 1;
-		set = get_color(ecbdata->color_diff, DIFF_FRAGINFO);
+		set = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
 	}
 	else if (len < ecbdata->nparents)
 		set = reset;
@@ -410,7 +404,7 @@ static void fn_out_consume(void *priv, c
 			else if (line[i] == '+')
 				color = DIFF_FILE_NEW;
 		}
-		set = get_color(ecbdata->color_diff, color);
+		set = diff_get_color(ecbdata->color_diff, color);
 	}
 	if (len > 0 && line[len-1] == '\n')
 		len--;
@@ -767,8 +761,8 @@ static void builtin_diff(const char *nam
 	mmfile_t mf1, mf2;
 	const char *lbl[2];
 	char *a_one, *b_two;
-	const char *set = get_color(o->color_diff, DIFF_METAINFO);
-	const char *reset = get_color(o->color_diff, DIFF_RESET);
+	const char *set = diff_get_color(o->color_diff, DIFF_METAINFO);
+	const char *reset = diff_get_color(o->color_diff, DIFF_RESET);
 
 	a_one = quote_two("a/", name_a);
 	b_two = quote_two("b/", name_b);
diff --git a/diff.h b/diff.h
index a06f959..2cced53 100644
--- a/diff.h
+++ b/diff.h
@@ -69,6 +69,17 @@ struct diff_options {
 	add_remove_fn_t add_remove;
 };
 
+enum color_diff {
+	DIFF_RESET = 0,
+	DIFF_PLAIN = 1,
+	DIFF_METAINFO = 2,
+	DIFF_FRAGINFO = 3,
+	DIFF_FILE_OLD = 4,
+	DIFF_FILE_NEW = 5,
+	DIFF_COMMIT = 6,
+};
+const char *diff_get_color(int diff_use_color, enum color_diff ix);
+
 extern const char mime_boundary_leader[];
 
 extern void diff_tree_setup_paths(const char **paths, struct diff_options *);
diff --git a/log-tree.c b/log-tree.c
index 9d8d46f..b71cf9b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -129,7 +129,8 @@ void show_log(struct rev_info *opt, cons
 			opt->diffopt.stat_sep = buffer;
 		}
 	} else {
-		printf("%s%s",
+		printf("%s%s%s",
+		       diff_get_color(opt->diffopt.color_diff, DIFF_COMMIT),
 		       opt->commit_format == CMIT_FMT_ONELINE ? "" : "commit ",
 		       diff_unique_abbrev(commit->object.sha1, abbrev_commit));
 		if (opt->parents)
@@ -139,6 +140,8 @@ void show_log(struct rev_info *opt, cons
 			       diff_unique_abbrev(parent->object.sha1,
 						  abbrev_commit));
 		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
+		printf("%s",
+		       diff_get_color(opt->diffopt.color_diff, DIFF_RESET));
 	}
 
 	/*
-- 
1.4.2.rc1.gc470-dirty
