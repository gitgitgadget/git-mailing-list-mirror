From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] git-diff/git-apply: make diff output a bit friendlier to GNU patch
Date: Fri, 22 Sep 2006 17:44:32 -0700
Message-ID: <7vu02zxvgv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Sep 23 02:44:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQvdG-0005Iz-43
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 02:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWIWAof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 20:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWIWAoe
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 20:44:34 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32163 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964979AbWIWAod (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 20:44:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923004433.IICS6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 20:44:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rcka1V00Z1kojtg0000000
	Fri, 22 Sep 2006 20:44:35 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27549>

Somebody was wondering on #git channel why a git generated diff
does not apply with GNU patch when the filename contains a SP.
It is because GNU patch expects to find TAB (and trailing timestamp)
on ---/+++ (old_name and new_name) lines after the filenames.

The "diff --git" output format was carefully designed to be
compatible with GNU patch where it can, but whitespace
characters were always a pain.

This adds an extra TAB (but not trailing timestamp) to old_name
and new_name lines of git-diff output when the filename has a SP
in it.  When a filename contains a real tab, "diff --git" format
always c-quotes it as discussed on the list with GNU patch
maintainer previously:

	http://marc.theaimsgroup.com/?l=git&m=112927316408690&w=2

so there is no real room for confusion.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This patch, if people like its general direction, should be
   split into two parts, one to update "git-apply" so that it
   understands that old/new name lines may contain the extra TAB
   at the end, and another to update "git-diff" to actually
   generate such a patch.  We apply the former immediately to
   get people prepared, and when everybody's git-apply is ready
   then we can apply the latter to actually produce the new
   format.

 builtin-apply.c |    4 ++--
 diff.c          |   20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 25e90d8..84dbbc3 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -360,7 +360,7 @@ static int gitdiff_hdrend(const char *li
 static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, const char *oldnew)
 {
 	if (!orig_name && !isnull)
-		return find_name(line, NULL, 1, 0);
+		return find_name(line, NULL, 1, TERM_TAB);
 
 	if (orig_name) {
 		int len;
@@ -370,7 +370,7 @@ static char *gitdiff_verify_name(const c
 		len = strlen(name);
 		if (isnull)
 			die("git-apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
-		another = find_name(line, NULL, 1, 0);
+		another = find_name(line, NULL, 1, TERM_TAB);
 		if (!another || memcmp(another, name, len))
 			die("git-apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
 		free(another);
diff --git a/diff.c b/diff.c
index 443e248..37a4ce1 100644
--- a/diff.c
+++ b/diff.c
@@ -201,11 +201,18 @@ static void emit_rewrite_diff(const char
 			      struct diff_filespec *two)
 {
 	int lc_a, lc_b;
+	const char *name_a_tab, *name_b_tab;
+
+	name_a_tab = strchr(name_a, ' ') ? "\t" : "";
+	name_b_tab = strchr(name_b, ' ') ? "\t" : "";
+
 	diff_populate_filespec(one, 0);
 	diff_populate_filespec(two, 0);
 	lc_a = count_lines(one->data, one->size);
 	lc_b = count_lines(two->data, two->size);
-	printf("--- %s\n+++ %s\n@@ -", name_a, name_b);
+	printf("--- %s%s\n+++ %s%s\n@@ -",
+	       name_a, name_a_tab,
+	       name_b, name_b_tab);
 	print_line_count(lc_a);
 	printf(" +");
 	print_line_count(lc_b);
@@ -391,8 +398,15 @@ static void fn_out_consume(void *priv, c
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 
 	if (ecbdata->label_path[0]) {
-		printf("%s--- %s%s\n", set, ecbdata->label_path[0], reset);
-		printf("%s+++ %s%s\n", set, ecbdata->label_path[1], reset);
+		const char *name_a_tab, *name_b_tab;
+
+		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
+		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
+
+		printf("%s--- %s%s%s\n",
+		       set, ecbdata->label_path[0], reset, name_a_tab);
+		printf("%s+++ %s%s%s\n",
+		       set, ecbdata->label_path[1], reset, name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
-- 
1.4.2.1.gb6052
