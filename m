From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach diff machinery to display other prefixes than "a/"
 and "b/"
Date: Tue, 18 Dec 2007 16:21:45 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181619550.23902@racer.site>
References: <1197992574-3464-1-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, pascal@obry.net
To: Pascal Obry <pascal.obry@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4fDH-00016s-Ay
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbXLRQWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 11:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbXLRQWD
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:22:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:60936 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752859AbXLRQWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 11:22:01 -0500
Received: (qmail invoked by alias); 18 Dec 2007 16:21:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 18 Dec 2007 17:21:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9/p5a8hD98lJlOZB8+W2KLKZWCTBGYdIJDHhhoV
	Devmcb0go/U6vW
X-X-Sender: gene099@racer.site
In-Reply-To: <1197992574-3464-1-git-send-email-pascal@obry.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68774>


With the new option "--prefix=<prefix1>[:<prefix2>]" you can change
the shown prefix, or suppress it (by specifying the empty string).

Initial patch by Pascal Obry.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 18 Dec 2007, Pascal Obry wrote:

	> This option can be used to generate a patch file
	> where file names are relative to the Git root
	> directory. Such a patch can then be applied with
	> the standard patch tool using option -p0.

	How about this instead?  It is not much longer, but more 
	versatile, as you can actually change the prefix, and not only in 
	format-patch.

	Oh, and if somebody has a better idea for the name of the option, 
	I would appreciate your input.

 Documentation/diff-options.txt |    4 ++++
 diff.c                         |   29 +++++++++++++++++++++--------
 diff.h                         |    1 +
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9ecc1d7..672a2d0 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -211,5 +211,9 @@ endif::git-format-patch[]
 --no-ext-diff::
 	Disallow external diff drivers.
 
+--prefix=<prefix1>[:<prefix2>]::
+	Show the given path prefixes instead of "a/" and "b/".  Leave
+	it empty to show no prefix at all.
+
 For more detailed explanation on these common options, see also
 link:diffcore.html[diffcore documentation].
diff --git a/diff.c b/diff.c
index e26584c..404ba91 100644
--- a/diff.c
+++ b/diff.c
@@ -290,9 +290,10 @@ static void emit_rewrite_diff(const char *name_a,
 			      const char *name_b,
 			      struct diff_filespec *one,
 			      struct diff_filespec *two,
-			      int color_diff)
+			      struct diff_options *o)
 {
 	int lc_a, lc_b;
+	int color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
 	const char *name_a_tab, *name_b_tab;
 	const char *metainfo = diff_get_color(color_diff, DIFF_METAINFO);
 	const char *fraginfo = diff_get_color(color_diff, DIFF_FRAGINFO);
@@ -309,9 +310,9 @@ static void emit_rewrite_diff(const char *name_a,
 	diff_populate_filespec(two, 0);
 	lc_a = count_lines(one->data, one->size);
 	lc_b = count_lines(two->data, two->size);
-	printf("%s--- a/%s%s%s\n%s+++ b/%s%s%s\n%s@@ -",
-	       metainfo, name_a, name_a_tab, reset,
-	       metainfo, name_b, name_b_tab, reset, fraginfo);
+	printf("%s--- %s%s%s%s\n%s+++ %s%s%s%s\n%s@@ -",
+	       metainfo, o->a_prefix, name_a, name_a_tab, reset,
+	       metainfo, o->b_prefix, name_b, name_b_tab, reset, fraginfo);
 	print_line_count(lc_a);
 	printf(" +");
 	print_line_count(lc_b);
@@ -1212,8 +1213,8 @@ static void builtin_diff(const char *name_a,
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 
-	a_one = quote_two("a/", name_a + (*name_a == '/'));
-	b_two = quote_two("b/", name_b + (*name_b == '/'));
+	a_one = quote_two(o->a_prefix, name_a + (*name_a == '/'));
+	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
 	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
@@ -1242,8 +1243,7 @@ static void builtin_diff(const char *name_a,
 		if ((one->mode ^ two->mode) & S_IFMT)
 			goto free_ab_and_return;
 		if (complete_rewrite) {
-			emit_rewrite_diff(name_a, name_b, one, two,
-					DIFF_OPT_TST(o, COLOR_DIFF));
+			emit_rewrite_diff(name_a, name_b, one, two, o);
 			o->found_changes = 1;
 			goto free_ab_and_return;
 		}
@@ -2020,6 +2020,9 @@ void diff_setup(struct diff_options *options)
 	else
 		DIFF_OPT_CLR(options, COLOR_DIFF);
 	options->detect_rename = diff_detect_rename_default;
+
+	options->a_prefix = "a/";
+	options->b_prefix = "b/";
 }
 
 int diff_setup_done(struct diff_options *options)
@@ -2291,6 +2294,16 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		else if (40 < options->abbrev)
 			options->abbrev = 40;
 	}
+	else if (!strcmp(arg, "--prefix=")) {
+		char *colon = strchr(arg + 9, ':');
+		options->a_prefix = arg + 9;
+		if (colon) {
+			*colon = '\0';
+			options->b_prefix = colon + 1;
+		}
+		else
+			options->b_prefix = options->a_prefix;
+	}
 	else
 		return 0;
 	return 1;
diff --git a/diff.h b/diff.h
index 7e8000a..beccf85 100644
--- a/diff.h
+++ b/diff.h
@@ -69,6 +69,7 @@ struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
 	const char *single_follow;
+	const char *a_prefix, *b_prefix;
 	unsigned flags;
 	int context;
 	int break_opt;
-- 
1.5.4.rc0.70.g30f7
