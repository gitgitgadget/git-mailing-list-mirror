From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] merge: enable progress reporting for rename detection
Date: Sun, 20 Feb 2011 04:53:21 -0500
Message-ID: <20110220095320.GB1082@sigill.intra.peff.net>
References: <20110220094803.GA988@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 20 10:53:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr5yq-0006O4-UG
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 10:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015Ab1BTJxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 04:53:24 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35682 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654Ab1BTJxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 04:53:23 -0500
Received: (qmail 16536 invoked by uid 111); 20 Feb 2011 09:53:23 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 20 Feb 2011 09:53:23 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Feb 2011 04:53:21 -0500
Content-Disposition: inline
In-Reply-To: <20110220094803.GA988@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167409>

The user can enable or disable it explicitly with the new
--progress, but it defaults to checking isatty(2).

This works only with merge-recursive and subtree. In theory
we could pass a progress flag to other strategies, but none
of them support progress at this point, so let's wait until
they grow such a feature before worrying about propagating
it.

Signed-off-by: Jeff King <peff@peff.net>
---
In theory somebody could have a third-party strategy that cares about
progress. Passing the information would probably have to go through the
environment, as strategies will barf on command lines they don't
understand.

I punted on it until somebody shows up who actually cares.

 Documentation/merge-options.txt |   10 +++++++++-
 builtin/merge.c                 |    7 +++++++
 merge-recursive.c               |    1 +
 merge-recursive.h               |    1 +
 4 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index e33e0f8..b613d4e 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -75,9 +75,17 @@ option can be used to override --squash.
 ifndef::git-pull[]
 -q::
 --quiet::
-	Operate quietly.
+	Operate quietly. Implies --no-progress.
 
 -v::
 --verbose::
 	Be verbose.
+
+--progress::
+--no-progress::
+	Turn progress on/off explicitly. If neither is specified,
+	progress is shown if standard error is connected to a terminal.
+	Note that not all merge strategies may support progress
+	reporting.
+
 endif::git-pull[]
diff --git a/builtin/merge.c b/builtin/merge.c
index 8c58c3c..d81bee3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -58,6 +58,7 @@ static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
+static int show_progress = -1;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -200,6 +201,7 @@ static struct option builtin_merge_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOLEAN(0, "abort", &abort_current_merge,
 		"abort the current in-progress merge"),
+	OPT_SET_INT(0, "progress", &show_progress, "force progress reporting", 1),
 	OPT_END()
 };
 
@@ -660,6 +662,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			o.subtree_shift = "";
 
 		o.renormalize = option_renormalize;
+		o.show_rename_progress =
+			show_progress == -1 ? isatty(2) : show_progress;
 
 		for (x = 0; x < xopts_nr; x++)
 			if (parse_merge_opt(&o, xopts[x]))
@@ -946,6 +950,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
 			builtin_merge_usage, 0);
 
+	if (verbosity < 0 && show_progress == -1)
+		show_progress = 0;
+
 	if (abort_current_merge) {
 		int nargc = 2;
 		const char *nargv[] = {"reset", "--merge", NULL};
diff --git a/merge-recursive.c b/merge-recursive.c
index 089aa10..6c8f957 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -441,6 +441,7 @@ static struct string_list *get_renames(struct merge_options *o,
 			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
 			    1000;
 	opts.rename_score = o->rename_score;
+	opts.show_rename_progress = o->show_rename_progress;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
 		die("diff setup failed");
diff --git a/merge-recursive.h b/merge-recursive.h
index 1a113e2..7e1e972 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -21,6 +21,7 @@ struct merge_options {
 	int merge_rename_limit;
 	int rename_score;
 	int needed_rename_limit;
+	int show_rename_progress;
 	int call_depth;
 	struct strbuf obuf;
 	struct string_list current_file_set;
-- 
1.7.4.1.26.g5e991
