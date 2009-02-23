From: tilo@tilo-schwarz.de
Subject: [PATCH 1/1] Make height of split view configurable
Date: Mon, 23 Feb 2009 23:24:03 +0100
Message-ID: <25c05f03ae71d23eb40e60f49037590939eb352d.1235338009.git.tilo@tilo-schwarz.de>
References: <cover.1235338009.git.tilo@tilo-schwarz.de>
Cc: git@vger.kernel.org, Tilo Schwarz <tilo@tilo-schwarz.de>
To: jonas.fonseca@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 23 23:26:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbjFW-0002n8-Sb
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 23:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757445AbZBWWYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 17:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757385AbZBWWYU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 17:24:20 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:11832 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175AbZBWWYT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 17:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1235427854; l=3943;
	s=domk; d=tilo-schwarz.de;
	h=References:In-Reply-To:References:In-Reply-To:Date:Subject:Cc:To:
	From:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=ShBnfh/QhKp+BUDUubCPP7hFBmIVq3K2zbeQ1PLHfIY=;
	b=DYvb7y5sHHsKoNZu7cHqF2yRj/fn/2tRpdN+TH+xqYb+Elk/wxVyFzJ58oLd3UT2Mhn
	T91kdl1vK7dktGlDtvIDbxsBnKkSFbijtSrmKA6rN+PEhjIiBsRoy+4rWYKRecbBytSmw
	3NZljGbbxAKLX+OgGPBn+MJ/RCNhqXMWY0g=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlsJ41cQl
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CF809.dip.t-dialin.net [84.156.248.9])
	by post.strato.de (klopstock mo11) (RZmta 18.21)
	with ESMTP id 006128l1NL9q0D ; Mon, 23 Feb 2009 23:24:10 +0100 (MET)
Received: by dellschleppa (sSMTP sendmail emulation); Mon, 23 Feb 2009 23:24:08 +0100
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <cover.1235338009.git.tilo@tilo-schwarz.de>
In-Reply-To: <cover.1235338009.git.tilo@tilo-schwarz.de>
References: <cover.1235338009.git.tilo@tilo-schwarz.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111175>


Signed-off-by: Tilo Schwarz <tilo@tilo-schwarz.de>
---
 NEWS        |    3 +++
 tig.c       |   30 +++++++++++++++++++-----------
 tigrc.5.txt |    8 ++++++++
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/NEWS b/NEWS
index 15d898b..a48ed16 100644
--- a/NEWS
+++ b/NEWS
@@ -11,6 +11,9 @@ Improvements:
  - Tree view: sort entries by name, date or author. Toggling is bound to
    'i' by default, with 'I' controlling whether or not to sort in
    ascending order.
+ - Make height of the lower view in a split view configurable by setting the
+   'split-view-height' variable to a number or a percentage. Defaults to 66% of
+   the total view height.
 
 Bug fixes:
 
diff --git a/tig.c b/tig.c
index 58d7bd0..ad77c95 100644
--- a/tig.c
+++ b/tig.c
@@ -72,6 +72,7 @@ static size_t utf8_length(const char **string, size_t col, int *width, size_t ma
 
 #define ABS(x)		((x) >= 0  ? (x) : -(x))
 #define MIN(x, y)	((x) < (y) ? (x) :  (y))
+#define MAX(x, y)	((x) > (y) ? (x) :  (y))
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof(x[0]))
 #define STRING_SIZE(x)	(sizeof(x) - 1)
@@ -111,7 +112,8 @@ static size_t utf8_length(const char **string, size_t col, int *width, size_t ma
 
 #define TAB_SIZE	8
 
-#define	SCALE_SPLIT_VIEW(height)	((height) * 2 / 3)
+#define	SCALE_SPLIT_VIEW (2.0 / 3.0)
+#define MIN_VIEW_HEIGHT 4
 
 #define NULL_ID		"0000000000000000000000000000000000000000"
 
@@ -913,6 +915,7 @@ static bool opt_rev_graph		= FALSE;
 static bool opt_show_refs		= TRUE;
 static int opt_num_interval		= NUMBER_INTERVAL;
 static double opt_hscroll		= 0.50;
+static double opt_scale_split_view	= SCALE_SPLIT_VIEW;
 static int opt_tab_size			= TAB_SIZE;
 static int opt_author_cols		= AUTHOR_COLS-1;
 static char opt_path[SIZEOF_STR]	= "";
@@ -1594,6 +1597,9 @@ option_set_command(int argc, const char *argv[])
 	if (!strcmp(argv[0], "horizontal-scroll"))
 		return parse_step(&opt_hscroll, argv[2]);
 
+	if (!strcmp(argv[0], "split-view-height"))
+		return parse_step(&opt_scale_split_view, argv[2]);
+
 	if (!strcmp(argv[0], "tab-size"))
 		return parse_int(&opt_tab_size, argv[2], 1, 1024);
 
@@ -2223,6 +2229,15 @@ update_view_title(struct view *view)
 	wnoutrefresh(view->title);
 }
 
+static int
+apply_step(double step, int value)
+{
+	if (step >= 1)
+		return (int) step;
+	value *= step + 0.01;
+	return value ? value : 1;
+}
+
 static void
 resize_display(void)
 {
@@ -2240,7 +2255,9 @@ resize_display(void)
 	if (view != base) {
 		/* Horizontal split. */
 		view->width   = base->width;
-		view->height  = SCALE_SPLIT_VIEW(base->height);
+		view->height  = apply_step(opt_scale_split_view, base->height);
+		view->height  = MAX(view->height, MIN_VIEW_HEIGHT);
+		view->height  = MIN(view->height, base->height - MIN_VIEW_HEIGHT);
 		base->height -= view->height;
 
 		/* Make room for the title bar. */
@@ -2353,15 +2370,6 @@ goto_view_line(struct view *view, unsigned long offset, unsigned long lineno)
 	return FALSE;
 }
 
-static int
-apply_step(double step, int value)
-{
-	if (step >= 1)
-		return (int) step;
-	value *= step + 0.01;
-	return value ? value : 1;
-}
-
 /* Scrolling backend */
 static void
 do_scroll_view(struct view *view, int lines)
diff --git a/tigrc.5.txt b/tigrc.5.txt
index 8b9628f..e5de692 100644
--- a/tigrc.5.txt
+++ b/tigrc.5.txt
@@ -125,6 +125,14 @@ The following variables can be set:
 	always ensured that at least one column is scrolled. The default is to
 	scroll '50%' of the view width.
 
+'split-view-height' (mixed)::
+
+	Height of the lower view in a split view. Can be specified either as
+	the number of rows, e.g. '5', or as a percentage of the view height,
+	e.g. '80%', where the maximum is 100%. It is always ensured that the
+	smaller of the views is at least four rows high. The default is a view
+	height of '66%'.
+
 'commit-encoding' (string)::
 
 	The encoding used for commits. The default is UTF-8. Not this option
-- 
1.5.6.5
