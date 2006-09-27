From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Tue, 26 Sep 2006 19:40:53 -0700
Message-ID: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Wed Sep 27 04:41:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPM3-0002Y1-MK
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 04:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWI0Ck4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 22:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWI0Ck4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 22:40:56 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:48622 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932271AbWI0Ckz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 22:40:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927024054.QUDK2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 22:40:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TEgr1V0091kojtg0000000
	Tue, 26 Sep 2006 22:40:52 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27854>

When some files have big changes and others are touched only
slightly, diffstat graph did not show differences among smaller
changes that well.  This changes the graph scaling to non-linear
algorithm in such a case.

Without this, "git show --stat fd88d9c" gives:

 .gitignore                       |    1
 Documentation/git-tar-tree.txt   |    3 +
 Documentation/git-upload-tar.txt |   39 -----------
 Documentation/git.txt            |    4 -
 Makefile                         |    1
 builtin-tar-tree.c               |  130 +++++++++++++++-----------------------
 builtin-upload-tar.c             |   74 ----------------------
 git.c                            |    1
 8 files changed, 53 insertions(+), 200 deletions(-)

while with this, it shows:

 .gitignore                       |    1
 Documentation/git-tar-tree.txt   |    3 +++++++++
 Documentation/git-upload-tar.txt |   39 -----------------------------
 Documentation/git.txt            |    4 -----------
 Makefile                         |    1
 builtin-tar-tree.c               |  130 +++++++++++++++-----------------------
 builtin-upload-tar.c             |   74 ----------------------------------
 git.c                            |    1
 8 files changed, 53 insertions(+), 200 deletions(-)

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Jan Engelhardt wondered about doing non-linear scaling on the
   kernel list and this is an experimental patch to do so.  I do
   not seriously consider this for inclusion but it is more of a
   "see if people like it" patch.

 Makefile |    2 +-
 diff.c   |   29 +++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 28091d6..0fc59c4 100644
--- a/Makefile
+++ b/Makefile
@@ -304,7 +304,7 @@ BUILTIN_OBJS = \
 	builtin-write-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
-LIBS = $(GITLIBS) -lz
+LIBS = $(GITLIBS) -lz -lm
 
 #
 # Platform specific tweaks
diff --git a/diff.c b/diff.c
index 13aac2d..163ef48 100644
--- a/diff.c
+++ b/diff.c
@@ -4,6 +4,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <signal.h>
+#include <math.h>
 #include "cache.h"
 #include "quote.h"
 #include "diff.h"
@@ -555,6 +556,16 @@ static int scale_linear(int it, int widt
 	return (it * width * 2 + max_change) / (max_change * 2);
 }
 
+static int scale_non_linear(int it, int width, int max_change)
+{
+	/*
+	 * round(width * log(it)/log(max_change))
+	 */
+	if (!it || !max_change)
+		return 0;
+	return (int)(0.5 + width * log(it) / log(max_change));
+}
+
 static void show_name(const char *prefix, const char *name, int len,
 		      const char *reset, const char *set)
 {
@@ -574,10 +585,11 @@ static void show_graph(char ch, int cnt,
 static void show_stats(struct diffstat_t* data, struct diff_options *options)
 {
 	int i, len, add, del, total, adds = 0, dels = 0;
-	int max_change = 0, max_len = 0;
+	int max_change = 0, max_len = 0, min_change = 0;
 	int total_files = data->nr;
 	int width, name_width;
 	const char *reset, *set, *add_c, *del_c;
+	int non_linear_scale = 0;
 
 	if (data->nr == 0)
 		return;
@@ -595,12 +607,12 @@ static void show_stats(struct diffstat_t
 			width = name_width + 15;
 	}
 
-	/* Find the longest filename and max number of changes */
 	reset = diff_get_color(options->color_diff, DIFF_RESET);
 	set = diff_get_color(options->color_diff, DIFF_PLAIN);
 	add_c = diff_get_color(options->color_diff, DIFF_FILE_NEW);
 	del_c = diff_get_color(options->color_diff, DIFF_FILE_OLD);
 
+	/* Find the longest filename and max/min number of changes */
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 		int change = file->added + file->deleted;
@@ -620,6 +632,8 @@ static void show_stats(struct diffstat_t
 			continue;
 		if (max_change < change)
 			max_change = change;
+		if (0 < change && (!min_change || change < min_change))
+			min_change = change;
 	}
 
 	/* Compute the width of the graph part;
@@ -635,6 +649,12 @@ static void show_stats(struct diffstat_t
 	else
 		width = max_change;
 
+	/* See if the minimum change is shown with the normal scale
+	 * and if not switch to non-linear scale
+	 */
+	if (min_change && !scale_linear(min_change, width, max_change))
+		non_linear_scale = 1;
+
 	for (i = 0; i < data->nr; i++) {
 		const char *prefix = "";
 		char *name = data->files[i]->name;
@@ -684,6 +704,11 @@ static void show_stats(struct diffstat_t
 
 		if (max_change < width)
 			;
+		else if (non_linear_scale) {
+			total = scale_non_linear(total, width, max_change);
+			add = scale_linear(add, total, add + del);
+			del = total - add;
+		}
 		else {
 			total = scale_linear(total, width, max_change);
 			add = scale_linear(add, width, max_change);
-- 
1.4.2.1.gf80a
