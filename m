From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] show: turn on rename detection progress reporting
Date: Thu, 24 Mar 2011 13:49:16 -0400
Message-ID: <20110324174916.GC30685@sigill.intra.peff.net>
References: <20110324174556.GA30661@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:49:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2ofM-0000ew-LJ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 18:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170Ab1CXRtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 13:49:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37291
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756911Ab1CXRtS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 13:49:18 -0400
Received: (qmail 4201 invoked by uid 107); 24 Mar 2011 17:49:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Mar 2011 13:49:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2011 13:49:16 -0400
Content-Disposition: inline
In-Reply-To: <20110324174556.GA30661@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169932>

For large commits, it is nice to have some eye candy for the
rename detection.

However, because show can display multiple commits, we have
to be careful not to clutter existing output. We show the
progress report only before we have generated any actual
output; once we have sent output to the terminal or pager,
we turn off progress reporting.

This also makes it safe to use with "git log", though it
will only be useful if the first commit is the slow one.
So this patch actually enables it for all of the
log/whatchanged/show/reflog family.

We also handle the usual --{no-}progress option and check
that stderr goes to a terminal before turning on progress.

Signed-off-by: Jeff King <peff@peff.net>
---
Changes since the last iteration:

  - only show progress for the first commit
  - check isatty(2)
  - --{no-}progress

 Documentation/git-log.txt |    7 +++++++
 builtin/log.c             |   17 ++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2c84028..c0f763e 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -73,6 +73,13 @@ produced by --stat etc.
 	to be prefixed with "\-- " to separate them from options or
 	refnames.
 
+--no-progress::
+--progress::
+	Disable or enable progress reporting during long computations;
+	the default is to enable progress reporting when stderr is a
+	terminal. Currently the only computation with progress support
+	is inexact rename detection.
+
 include::rev-list-options.txt[]
 
 include::pretty-formats.txt[]
diff --git a/builtin/log.c b/builtin/log.c
index 796e9e5..4d52e99 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -27,6 +27,7 @@ static int default_show_root = 1;
 static int decoration_style;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
+static int progress = -1;
 
 static const char * const builtin_log_usage =
 	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
@@ -109,10 +110,17 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 			rev->show_source = 1;
 		} else if (!strcmp(arg, "-h")) {
 			usage(builtin_log_usage);
+		} else if (!strcmp(arg, "--progress")) {
+			progress = 1;
+		} else if (!strcmp(arg, "--no-progress")) {
+			progress = 0;
 		} else
 			die("unrecognized argument: %s", arg);
 	}
 
+	if (progress == -1)
+		progress = isatty(2);
+
 	/*
 	 * defeat log.decorate configuration interacting with --pretty=raw
 	 * from the command line.
@@ -257,19 +265,26 @@ static int cmd_log_walk(struct rev_info *rev)
 	if (rev->early_output)
 		finish_early_output(rev);
 
+	if (progress)
+		rev->diffopt.show_rename_progress = 1;
+
 	/*
 	 * For --check and --exit-code, the exit code is based on CHECK_FAILED
 	 * and HAS_CHANGES being accumulated in rev->diffopt, so be careful to
 	 * retain that state information if replacing rev->diffopt in this loop
 	 */
 	while ((commit = get_revision(rev)) != NULL) {
-		if (!log_tree_commit(rev, commit) &&
+		int showed = log_tree_commit(rev, commit);
+		if (showed &&
 		    rev->max_count >= 0)
 			/*
 			 * We decremented max_count in get_revision,
 			 * but we didn't actually show the commit.
 			 */
 			rev->max_count++;
+		/* Once we have output, progress will clutter the terminal. */
+		if (showed)
+			rev->diffopt.show_rename_progress = 0;
 		if (!rev->reflog_info) {
 			/* we allow cycles in reflog ancestry */
 			free(commit->buffer);
-- 
1.7.4.41.g423da
