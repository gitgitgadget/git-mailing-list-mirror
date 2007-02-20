From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach diff -B about colours
Date: Tue, 20 Feb 2007 15:08:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702201506551.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070220100846.GA7928@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 15:09:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJVft-0002C7-Mh
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 15:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbXBTOIu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 09:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbXBTOIt
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 09:08:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:35001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964914AbXBTOIs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 09:08:48 -0500
Received: (qmail invoked by alias); 20 Feb 2007 14:08:47 -0000
X-Provags-ID: V01U2FsdGVkX18+9CkG2lQ+1FlST8wr0Q9NotVsk9TEKePUbYQIfL
	7NGg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070220100846.GA7928@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40239>


Matthias Lederhofer noticed that `diff -B` did not pick up on diff 
colournig.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Tue, 20 Feb 2007, Matthias Lederhofer wrote:

	> I found that git diff -B does not always use colors and I don't 
	> have time to figure out what it is atm.
	> 
	> The bug can be triggered by this two files and running git diff 
	> with -B.

	Thanks to this excellent bug report, it was very easy to find and 
	fix that bug.

 diff.c |   39 +++++++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 6f8b742..5094dcd 100644
--- a/diff.c
+++ b/diff.c
@@ -184,30 +184,40 @@ static void print_line_count(int count)
 	}
 }
 
-static void copy_file(int prefix, const char *data, int size)
+static void copy_file(int prefix, const char *data, int size,
+		const char *set, const char *reset)
 {
 	int ch, nl_just_seen = 1;
 	while (0 < size--) {
 		ch = *data++;
-		if (nl_just_seen)
+		if (nl_just_seen) {
+			fputs(set, stdout);
 			putchar(prefix);
-		putchar(ch);
-		if (ch == '\n')
+		}
+		if (ch == '\n') {
 			nl_just_seen = 1;
-		else
+			fputs(reset, stdout);
+		} else
 			nl_just_seen = 0;
+		putchar(ch);
 	}
 	if (!nl_just_seen)
-		printf("\n\\ No newline at end of file\n");
+		printf("%s\n\\ No newline at end of file\n", reset);
 }
 
 static void emit_rewrite_diff(const char *name_a,
 			      const char *name_b,
 			      struct diff_filespec *one,
-			      struct diff_filespec *two)
+			      struct diff_filespec *two,
+			      int color_diff)
 {
 	int lc_a, lc_b;
 	const char *name_a_tab, *name_b_tab;
+	const char *metainfo = diff_get_color(color_diff, DIFF_METAINFO);
+	const char *fraginfo = diff_get_color(color_diff, DIFF_FRAGINFO);
+	const char *old = diff_get_color(color_diff, DIFF_FILE_OLD);
+	const char *new = diff_get_color(color_diff, DIFF_FILE_NEW);
+	const char *reset = diff_get_color(color_diff, DIFF_RESET);
 
 	name_a_tab = strchr(name_a, ' ') ? "\t" : "";
 	name_b_tab = strchr(name_b, ' ') ? "\t" : "";
@@ -216,17 +226,17 @@ static void emit_rewrite_diff(const char *name_a,
 	diff_populate_filespec(two, 0);
 	lc_a = count_lines(one->data, one->size);
 	lc_b = count_lines(two->data, two->size);
-	printf("--- a/%s%s\n+++ b/%s%s\n@@ -",
-	       name_a, name_a_tab,
-	       name_b, name_b_tab);
+	printf("%s--- a/%s%s%s\n%s+++ b/%s%s%s\n%s@@ -",
+	       metainfo, name_a, name_a_tab, reset,
+	       metainfo, name_b, name_b_tab, reset, fraginfo);
 	print_line_count(lc_a);
 	printf(" +");
 	print_line_count(lc_b);
-	printf(" @@\n");
+	printf(" @@%s\n", reset);
 	if (lc_a)
-		copy_file('-', one->data, one->size);
+		copy_file('-', one->data, one->size, old, reset);
 	if (lc_b)
-		copy_file('+', two->data, two->size);
+		copy_file('+', two->data, two->size, new, reset);
 }
 
 static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
@@ -1084,7 +1094,8 @@ static void builtin_diff(const char *name_a,
 		if ((one->mode ^ two->mode) & S_IFMT)
 			goto free_ab_and_return;
 		if (complete_rewrite) {
-			emit_rewrite_diff(name_a, name_b, one, two);
+			emit_rewrite_diff(name_a, name_b, one, two,
+					o->color_diff);
 			goto free_ab_and_return;
 		}
 	}
-- 
1.5.0.1.2160.g5bd9-dirty
