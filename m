From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4] Teach diff machinery to display other prefixes than "a/"
 and "b/"
Date: Tue, 18 Dec 2007 19:32:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181930130.23902@racer.site>
References: <1197992574-3464-1-git-send-email-pascal@obry.net>
 <4767ED52.9010004@viscovery.net> <4767EE6D.5070509@obry.net>
 <alpine.LFD.0.9999.0712180840060.21557@woody.linux-foundation.org>
 <Pine.LNX.4.64.0712181703560.23902@racer.site> <476809EA.6080608@obry.net>
 <Pine.LNX.4.64.0712181855020.23902@racer.site>
 <alpine.LFD.0.9999.0712181059220.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, Pascal Obry <pascal@obry.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 20:32:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4iBS-0002Rb-CI
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 20:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbXLRTca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 14:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbXLRTca
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 14:32:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:59146 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751025AbXLRTc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 14:32:29 -0500
Received: (qmail invoked by alias); 18 Dec 2007 19:32:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 18 Dec 2007 20:32:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/50+li5hD530jt6csxQvOZR02LcRRPVu81woxng7
	O61WqPDez+DpfN
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0712181059220.21557@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68796>


With the new options "--src-prefix=<prefix>", "--dst-prefix=<prefix>"
and "--no-prefix", you can now control the path prefixes of the diff
machinery.  These used to by hardwired to "a/" for the source prefix
and "b/" for the destination prefix.

Initial patch by Pascal Obry.  Sane option names suggested by Linus.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 18 Dec 2007, Linus Torvalds wrote:

	> On Tue, 18 Dec 2007, Johannes Schindelin wrote:
	> > 
	> > With the new options "--src-prefix <prefix>", "--dst-prefix 
	> > <prefix>"
	> 
	> I really would prefer "--[src|dst]-prefix=<prefix>" as a single 
	> argument.
	> 
	> I think that's the more common form for long arguments, isn't it 
	> (with any short-format arguments usually using the "-L <prefix>" 
	> kind of form)?

	Incidentally, this fixes src-prefix and dst-prefix (I wrote av[1] 
	instead of arg + 1, but forgot to commit).

	So now, it is tested at least once per option.

 Documentation/diff-options.txt |    9 +++++++++
 diff.c                         |   25 +++++++++++++++++--------
 diff.h                         |    1 +
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9ecc1d7..1a78635 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -211,5 +211,14 @@ endif::git-format-patch[]
 --no-ext-diff::
 	Disallow external diff drivers.
 
+--src-prefix=<prefix>::
+	Show the given source prefix instead of "a/".
+
+--dst-prefix=<prefix>::
+	Show the given destination prefix instead of "b/".
+
+--no-prefix::
+	Do not show any source or destination prefix.
+
 For more detailed explanation on these common options, see also
 link:diffcore.html[diffcore documentation].
diff --git a/diff.c b/diff.c
index e26584c..61fd492 100644
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
@@ -2291,6 +2294,12 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		else if (40 < options->abbrev)
 			options->abbrev = 40;
 	}
+	else if (!prefixcmp(arg, "--src-prefix="))
+		options->a_prefix = arg + 13;
+	else if (!prefixcmp(arg, "--dst-prefix="))
+		options->b_prefix = arg + 13;
+	else if (!strcmp(arg, "--no-prefix"))
+		options->a_prefix = options->b_prefix = "";
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
