From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 12 Oct 2006 03:03:09 -0700
Message-ID: <7vy7rlq2aq.fsf@assigned-by-dhcp.cox.net>
References: <egdge3$t12$1@sea.gmane.org>
	<7v1wpfwg92.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 12:04:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXxPn-0007kg-1P
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 12:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422854AbWJLKDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 06:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422853AbWJLKDM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 06:03:12 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:58535 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1422854AbWJLKDK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 06:03:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061012100310.OUAR28934.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 06:03:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZN2z1V00C1kojtg0000000
	Thu, 12 Oct 2006 06:02:59 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7v1wpfwg92.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 10 Oct 2006 22:52:57 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28775>

Junio C Hamano <junkio@cox.net> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>>  * add summary of number of lines changed for each file (a la darcsview)
>>    in the difftree part of commit and *diff* views, e.g.
>>
>>         blame.c   +1 -0  diff | history | blame
>>
>>    or something like that.
>
> I'll place "diff --numstat" to the stack of "things to do on the
> core side".  Should be trivial.

This is only lightly tested. I haven't done test suite nor
documentation, which the list should be able to take care of,
now my git day for this week is over ;-).

-- >8 --
[PATCH] diff --numstat

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 combine-diff.c |    9 ++++++---
 diff.c         |   29 +++++++++++++++++++++++++++--
 diff.h         |   15 ++++++++-------
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 46d9121..65c7868 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -856,8 +856,10 @@ void diff_tree_combined(const unsigned c
 		/* show stat against the first parent even
 		 * when doing combined diff.
 		 */
-		if (i == 0 && opt->output_format & DIFF_FORMAT_DIFFSTAT)
-			diffopts.output_format = DIFF_FORMAT_DIFFSTAT;
+		int stat_opt = (opt->output_format &
+				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
+		if (i == 0 && stat_opt)
+			diffopts.output_format = stat_opt;
 		else
 			diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 		diff_tree_sha1(parent[i], sha1, "", &diffopts);
@@ -887,7 +889,8 @@ void diff_tree_combined(const unsigned c
 			}
 			needsep = 1;
 		}
-		else if (opt->output_format & DIFF_FORMAT_DIFFSTAT)
+		else if (opt->output_format &
+			 (DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT))
 			needsep = 1;
 		if (opt->output_format & DIFF_FORMAT_PATCH) {
 			if (needsep)
diff --git a/diff.c b/diff.c
index fb82432..2dcad19 100644
--- a/diff.c
+++ b/diff.c
@@ -795,6 +795,23 @@ static void show_stats(struct diffstat_t
 	       set, total_files, adds, dels, reset);
 }
 
+static void show_numstat(struct diffstat_t* data, struct diff_options *options)
+{
+	int i;
+
+	for (i = 0; i < data->nr; i++) {
+		struct diffstat_file *file = data->files[i];
+
+		printf("%d\t%d\t", file->added, file->deleted);
+		if (options->line_termination &&
+		    quote_c_style(file->name, NULL, NULL, 0))
+			quote_c_style(file->name, NULL, stdout, 0);
+		else
+			fputs(file->name, stdout);
+		putchar(options->line_termination);
+	}
+}
+
 struct checkdiff_t {
 	struct xdiff_emit_state xm;
 	const char *filename;
@@ -1731,6 +1748,7 @@ int diff_setup_done(struct diff_options 
 				      DIFF_FORMAT_CHECKDIFF |
 				      DIFF_FORMAT_NO_OUTPUT))
 		options->output_format &= ~(DIFF_FORMAT_RAW |
+					    DIFF_FORMAT_NUMSTAT |
 					    DIFF_FORMAT_DIFFSTAT |
 					    DIFF_FORMAT_SUMMARY |
 					    DIFF_FORMAT_PATCH);
@@ -1740,6 +1758,7 @@ int diff_setup_done(struct diff_options 
 	 * recursive bits for other formats here.
 	 */
 	if (options->output_format & (DIFF_FORMAT_PATCH |
+				      DIFF_FORMAT_NUMSTAT |
 				      DIFF_FORMAT_DIFFSTAT |
 				      DIFF_FORMAT_CHECKDIFF))
 		options->recursive = 1;
@@ -1828,6 +1847,9 @@ int diff_opt_parse(struct diff_options *
 	else if (!strcmp(arg, "--patch-with-raw")) {
 		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW;
 	}
+	else if (!strcmp(arg, "--numstat")) {
+		options->output_format |= DIFF_FORMAT_NUMSTAT;
+	}
 	else if (!strncmp(arg, "--stat", 6)) {
 		char *end;
 		int width = options->stat_width;
@@ -2602,7 +2624,7 @@ void diff_flush(struct diff_options *opt
 		separator++;
 	}
 
-	if (output_format & DIFF_FORMAT_DIFFSTAT) {
+	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_NUMSTAT)) {
 		struct diffstat_t diffstat;
 
 		memset(&diffstat, 0, sizeof(struct diffstat_t));
@@ -2612,7 +2634,10 @@ void diff_flush(struct diff_options *opt
 			if (check_pair_status(p))
 				diff_flush_stat(p, options, &diffstat);
 		}
-		show_stats(&diffstat, options);
+		if (output_format & DIFF_FORMAT_NUMSTAT)
+			show_numstat(&diffstat, options);
+		if (output_format & DIFF_FORMAT_DIFFSTAT)
+			show_stats(&diffstat, options);
 		separator++;
 	}
 
diff --git a/diff.h b/diff.h
index b48c991..435c70c 100644
--- a/diff.h
+++ b/diff.h
@@ -26,20 +26,21 @@ typedef void (*diff_format_fn_t)(struct 
 
 #define DIFF_FORMAT_RAW		0x0001
 #define DIFF_FORMAT_DIFFSTAT	0x0002
-#define DIFF_FORMAT_SUMMARY	0x0004
-#define DIFF_FORMAT_PATCH	0x0008
+#define DIFF_FORMAT_NUMSTAT	0x0004
+#define DIFF_FORMAT_SUMMARY	0x0008
+#define DIFF_FORMAT_PATCH	0x0010
 
 /* These override all above */
-#define DIFF_FORMAT_NAME	0x0010
-#define DIFF_FORMAT_NAME_STATUS	0x0020
-#define DIFF_FORMAT_CHECKDIFF	0x0040
+#define DIFF_FORMAT_NAME	0x0100
+#define DIFF_FORMAT_NAME_STATUS	0x0200
+#define DIFF_FORMAT_CHECKDIFF	0x0400
 
 /* Same as output_format = 0 but we know that -s flag was given
  * and we should not give default value to output_format.
  */
-#define DIFF_FORMAT_NO_OUTPUT	0x0080
+#define DIFF_FORMAT_NO_OUTPUT	0x0800
 
-#define DIFF_FORMAT_CALLBACK	0x0100
+#define DIFF_FORMAT_CALLBACK	0x1000
 
 struct diff_options {
 	const char *filter;
-- 
1.4.3.rc2.gdce3
