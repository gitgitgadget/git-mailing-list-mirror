From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Share color list between graph and show-branch
Date: Tue,  5 Apr 2011 00:40:23 -0500
Message-ID: <1301982023-891-1-git-send-email-dpmcgee@gmail.com>
References: <BANLkTint1+c0h9DExydWeeafdgawEJPuMw@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 07:40:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6z0F-0003py-Vq
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 07:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab1DEFkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 01:40:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47548 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1DEFka (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 01:40:30 -0400
Received: by iwn34 with SMTP id 34so32736iwn.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 22:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=CJVE8j/RKWqitIMZzEFVJJUDkO+XaANl4yHpAMN2TrE=;
        b=siVO5vn4Eq7uqHCCZxUwvNIZ6xAPyHGnMqx2df5ZeAM5ZBn6O3n12yFWRD4w2eC6qs
         dYUl/ovCVVL459HIog6MGBoqeqz/9QMK8Hqf5sP9m+Re0iN9JyDdc0e2e6rPvT574bVo
         yRLYsFw/8gMe58yMBzqktlLeDRvv/Yq9qhlL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nhXvT0qagxCBQqcLT5chfKdFajOYR884n8eDmpiFjGj9sKDjoI9hSBjtIJQwPX2k7E
         kzlS92X7O+TPkKQVvgLUtsMiY3wBiz00fwKQTyHIMTw9lXViphi+KzpoGIH6HzToMG10
         DEQNT6CnqTTMyn8pc8SI5DKn1Scq79uqu11vA=
Received: by 10.231.206.67 with SMTP id ft3mr3897267ibb.40.1301982029369;
        Mon, 04 Apr 2011 22:40:29 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id c1sm383921ibe.34.2011.04.04.22.40.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 22:40:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <BANLkTint1+c0h9DExydWeeafdgawEJPuMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170867>

This also adds the new colors to show-branch that were added a while
back for graph output.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

Updated to not require a static length definition of the array anywhere.

 builtin/show-branch.c |   16 +++-------------
 color.c               |   22 ++++++++++++++++++++++
 color.h               |    3 +++
 graph.c               |   23 +----------------------
 4 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index da69581..1abcd9e 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -12,16 +12,6 @@ static const char* show_branch_usage[] = {
 };
 
 static int showbranch_use_color = -1;
-static char column_colors[][COLOR_MAXLEN] = {
-	GIT_COLOR_RED,
-	GIT_COLOR_GREEN,
-	GIT_COLOR_YELLOW,
-	GIT_COLOR_BLUE,
-	GIT_COLOR_MAGENTA,
-	GIT_COLOR_CYAN,
-};
-
-#define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors))
 
 static int default_num;
 static int default_alloc;
@@ -37,7 +27,7 @@ static const char **default_arg;
 static const char *get_color_code(int idx)
 {
 	if (showbranch_use_color)
-		return column_colors[idx];
+		return column_colors_ansi[idx % column_colors_ansi_max];
 	return "";
 }
 
@@ -892,7 +882,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				for (j = 0; j < i; j++)
 					putchar(' ');
 				printf("%s%c%s [%s] ",
-				       get_color_code(i % COLUMN_COLORS_MAX),
+				       get_color_code(i),
 				       is_head ? '*' : '!',
 				       get_color_reset_code(), ref_name[i]);
 			}
@@ -954,7 +944,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				else
 					mark = '+';
 				printf("%s%c%s",
-				       get_color_code(i % COLUMN_COLORS_MAX),
+				       get_color_code(i),
 				       mark, get_color_reset_code());
 			}
 			putchar(' ');
diff --git a/color.c b/color.c
index 417cf8f..3db214c 100644
--- a/color.c
+++ b/color.c
@@ -3,6 +3,28 @@
 
 int git_use_color_default = 0;
 
+/*
+ * The list of available column colors.
+ */
+const char *column_colors_ansi[] = {
+	GIT_COLOR_RED,
+	GIT_COLOR_GREEN,
+	GIT_COLOR_YELLOW,
+	GIT_COLOR_BLUE,
+	GIT_COLOR_MAGENTA,
+	GIT_COLOR_CYAN,
+	GIT_COLOR_BOLD_RED,
+	GIT_COLOR_BOLD_GREEN,
+	GIT_COLOR_BOLD_YELLOW,
+	GIT_COLOR_BOLD_BLUE,
+	GIT_COLOR_BOLD_MAGENTA,
+	GIT_COLOR_BOLD_CYAN,
+	GIT_COLOR_RESET,
+};
+
+/* Ignore the RESET at the end when giving the size */
+const int column_colors_ansi_max = ARRAY_SIZE(column_colors_ansi) - 1;
+
 static int parse_color(const char *name, int len)
 {
 	static const char * const color_names[] = {
diff --git a/color.h b/color.h
index c0528cf..68a926a 100644
--- a/color.h
+++ b/color.h
@@ -53,6 +53,9 @@ struct strbuf;
  */
 extern int git_use_color_default;
 
+/* A default list of colors to use for commit graphs and show-branch output */
+extern const char *column_colors_ansi[];
+extern const int column_colors_ansi_max;
 
 /*
  * Use this instead of git_default_config if you need the value of color.ui.
diff --git a/graph.c b/graph.c
index ef2e24e..2f6893d 100644
--- a/graph.c
+++ b/graph.c
@@ -59,27 +59,6 @@ enum graph_state {
 	GRAPH_COLLAPSING
 };
 
-/*
- * The list of available column colors.
- */
-static const char *column_colors_ansi[] = {
-	GIT_COLOR_RED,
-	GIT_COLOR_GREEN,
-	GIT_COLOR_YELLOW,
-	GIT_COLOR_BLUE,
-	GIT_COLOR_MAGENTA,
-	GIT_COLOR_CYAN,
-	GIT_COLOR_BOLD_RED,
-	GIT_COLOR_BOLD_GREEN,
-	GIT_COLOR_BOLD_YELLOW,
-	GIT_COLOR_BOLD_BLUE,
-	GIT_COLOR_BOLD_MAGENTA,
-	GIT_COLOR_BOLD_CYAN,
-	GIT_COLOR_RESET,
-};
-
-#define COLUMN_COLORS_ANSI_MAX (ARRAY_SIZE(column_colors_ansi) - 1)
-
 static const char **column_colors;
 static unsigned short column_colors_max;
 
@@ -228,7 +207,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 
 	if (!column_colors)
 		graph_set_column_colors(column_colors_ansi,
-					COLUMN_COLORS_ANSI_MAX);
+					column_colors_ansi_max);
 
 	graph->commit = NULL;
 	graph->revs = opt;
-- 
1.7.4.2
