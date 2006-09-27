From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] diff --stat: color output.
Date: Tue, 26 Sep 2006 19:40:49 -0700
Message-ID: <7vlko6jaku.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 27 04:40:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPLz-0002XV-JO
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 04:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWI0Ckv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 22:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWI0Ckv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 22:40:51 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42734 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932272AbWI0Cku (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 22:40:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927024049.QUAO2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 22:40:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TEgm1V00G1kojtg0000000
	Tue, 26 Sep 2006 22:40:47 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27852>

Under --color option, diffstat shows '+' and '-' in the graph
the same color as added and deleted lines.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is unsolicited but while I was touching the vicinity of
   the code I thought some people might find it cool.

 diff.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 6101365..13aac2d 100644
--- a/diff.c
+++ b/diff.c
@@ -555,17 +555,20 @@ static int scale_linear(int it, int widt
 	return (it * width * 2 + max_change) / (max_change * 2);
 }
 
-static void show_name(const char *prefix, const char *name, int len)
+static void show_name(const char *prefix, const char *name, int len,
+		      const char *reset, const char *set)
 {
-	printf(" %s%-*s |", prefix, len, name);
+	printf(" %s%s%-*s%s |", set, prefix, len, name, reset);
 }
 
-static void show_graph(char ch, int cnt)
+static void show_graph(char ch, int cnt, const char *set, const char *reset)
 {
 	if (!cnt)
 		return;
+	printf("%s", set);
 	while (cnt--)
 		putchar(ch);
+	printf("%s", reset);
 }
 
 static void show_stats(struct diffstat_t* data, struct diff_options *options)
@@ -574,6 +577,7 @@ static void show_stats(struct diffstat_t
 	int max_change = 0, max_len = 0;
 	int total_files = data->nr;
 	int width, name_width;
+	const char *reset, *set, *add_c, *del_c;
 
 	if (data->nr == 0)
 		return;
@@ -592,6 +596,11 @@ static void show_stats(struct diffstat_t
 	}
 
 	/* Find the longest filename and max number of changes */
+	reset = diff_get_color(options->color_diff, DIFF_RESET);
+	set = diff_get_color(options->color_diff, DIFF_PLAIN);
+	add_c = diff_get_color(options->color_diff, DIFF_FILE_NEW);
+	del_c = diff_get_color(options->color_diff, DIFF_FILE_OLD);
+
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 		int change = file->added + file->deleted;
@@ -649,12 +658,12 @@ static void show_stats(struct diffstat_t
 		}
 
 		if (data->files[i]->is_binary) {
-			show_name(prefix, name, len);
+			show_name(prefix, name, len, reset, set);
 			printf("  Bin\n");
 			goto free_diffstat_file;
 		}
 		else if (data->files[i]->is_unmerged) {
-			show_name(prefix, name, len);
+			show_name(prefix, name, len, reset, set);
 			printf("  Unmerged\n");
 			goto free_diffstat_file;
 		}
@@ -680,18 +689,18 @@ static void show_stats(struct diffstat_t
 			add = scale_linear(add, width, max_change);
 			del = total - add;
 		}
-		show_name(prefix, name, len);
+		show_name(prefix, name, len, reset, set);
 		printf("%5d ", added + deleted);
-		show_graph('+', add);
-		show_graph('-', del);
+		show_graph('+', add, add_c, reset);
+		show_graph('-', del, del_c, reset);
 		putchar('\n');
 	free_diffstat_file:
 		free(data->files[i]->name);
 		free(data->files[i]);
 	}
 	free(data->files);
-	printf(" %d files changed, %d insertions(+), %d deletions(-)\n",
-	       total_files, adds, dels);
+	printf("%s %d files changed, %d insertions(+), %d deletions(-)%s\n",
+	       set, total_files, adds, dels, reset);
 }
 
 struct checkdiff_t {
-- 
1.4.2.1.gf80a
