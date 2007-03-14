From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/5] diff --quiet
Date: Wed, 14 Mar 2007 14:26:49 -0700
Message-ID: <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 22:27:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRazl-0002Og-Rr
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbXCNV0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbXCNV0v
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:26:51 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53353 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbXCNV0u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:26:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314212649.YBOL1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 17:26:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id alSp1W0121kojtg0000000; Wed, 14 Mar 2007 17:26:50 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42231>

This adds the command line option 'quiet' to tell 'git diff-*'
that we are not interested in the actual diff contents but only
want to know if there is any change.  This option automatically
turns --exit-code on, and turns off output formatting, as it
does not make much sense to show the first hit we happened to
have found.

The --quiet option is silently turned off (but --exit-code is
still in effect, so is silent output) if postprocessing filters
such as pickaxe and diff-filter are used.  For all practical
purposes I do not think of a reason to want to use these filters
and not viewing the diff output.

The backends have not been taught about the option with this patch.
That is a topic for later rounds.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff.c |   27 +++++++++++++++++++++++++--
 diff.h |    4 ++--
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 7d938c1..d8f9242 100644
--- a/diff.c
+++ b/diff.c
@@ -1958,6 +1958,23 @@ int diff_setup_done(struct diff_options *options)
 	if (options->abbrev <= 0 || 40 < options->abbrev)
 		options->abbrev = 40; /* full */
 
+	/*
+	 * It does not make sense to show the first hit we happened
+	 * to have found.  It does not make sense not to return with
+	 * exit code in such a case either.
+	 */
+	if (options->quiet) {
+		options->output_format = DIFF_FORMAT_NO_OUTPUT;
+		options->exit_with_status = 1;
+	}
+
+	/*
+	 * If we postprocess in diffcore, we cannot simply return
+	 * upon the first hit.  We need to run diff as usual.
+	 */
+	if (options->pickaxe || options->filter)
+		options->quiet = 0;
+
 	return 0;
 }
 
@@ -2136,6 +2153,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->detect_rename = 0;
 	else if (!strcmp(arg, "--exit-code"))
 		options->exit_with_status = 1;
+	else if (!strcmp(arg, "--quiet"))
+		options->quiet = 1;
 	else
 		return 0;
 	return 1;
@@ -2900,6 +2919,8 @@ static void diffcore_apply_filter(const char *filter)
 
 void diffcore_std(struct diff_options *options)
 {
+	if (options->quiet)
+		return;
 	if (options->break_opt != -1)
 		diffcore_break(options->break_opt);
 	if (options->detect_rename)
@@ -2912,8 +2933,8 @@ void diffcore_std(struct diff_options *options)
 		diffcore_order(options->orderfile);
 	diff_resolve_rename_copy();
 	diffcore_apply_filter(options->filter);
-	if (options->exit_with_status)
-		options->has_changes = !!diff_queued_diff.nr;
+
+	options->has_changes = !!diff_queued_diff.nr;
 }
 
 
@@ -2952,6 +2973,7 @@ void diff_addremove(struct diff_options *options,
 		fill_filespec(two, sha1, mode);
 
 	diff_queue(&diff_queued_diff, one, two);
+	options->has_changes = 1;
 }
 
 void diff_change(struct diff_options *options,
@@ -2977,6 +2999,7 @@ void diff_change(struct diff_options *options,
 	fill_filespec(two, new_sha1, new_mode);
 
 	diff_queue(&diff_queued_diff, one, two);
+	options->has_changes = 1;
 }
 
 void diff_unmerge(struct diff_options *options,
diff --git a/diff.h b/diff.h
index 81fa265..a0d2ce1 100644
--- a/diff.h
+++ b/diff.h
@@ -57,6 +57,8 @@ struct diff_options {
 		 find_copies_harder:1,
 		 color_diff:1,
 		 color_diff_words:1,
+		 has_changes:1,
+		 quiet:1,
 		 exit_with_status:1;
 	int context;
 	int break_opt;
@@ -72,8 +74,6 @@ struct diff_options {
 	const char *msg_sep;
 	const char *stat_sep;
 	long xdl_opts;
-	/* 0 - no differences; only meaningful if exit_with_status set */
-	int has_changes;
 
 	int stat_width;
 	int stat_name_width;
-- 
1.5.0.3.1036.g6baf1
