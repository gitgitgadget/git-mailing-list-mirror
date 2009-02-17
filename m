From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH] Use DIFF_XDL_SET/DIFF_OPT_SET instead of raw bit-masking
Date: Mon, 16 Feb 2009 19:26:49 -0800
Message-ID: <1234841209-3960-1-git-send-email-keith@cs.ucla.edu>
Cc: Pierre Habouzit <madcoder@madism.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 04:28:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZGdT-0001os-8d
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 04:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZBQD1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 22:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbZBQD1E
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 22:27:04 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:52139 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbZBQD1D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 22:27:03 -0500
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n1H3QnA7003994;
	Mon, 16 Feb 2009 19:26:49 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n1H3QnIh003993;
	Mon, 16 Feb 2009 19:26:49 -0800
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110304>


Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---
 diff.h |    3 +++
 diff.c |   17 ++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/diff.h b/diff.h
index 6703a4f..6616877 100644
--- a/diff.h
+++ b/diff.h
@@ -69,6 +69,9 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
+#define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
+#define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
+#define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
 
 struct diff_options {
 	const char *filter;
diff --git a/diff.c b/diff.c
index 006aa01..ff3624e 100644
--- a/diff.c
+++ b/diff.c
@@ -2567,13 +2567,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 
 	/* xdiff options */
 	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
-		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
+		DIFF_XDL_SET(options, IGNORE_WHITESPACE);
 	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
-		options->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
-		options->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--patience"))
-		options->xdl_opts |= XDF_PATIENCE_DIFF;
+		DIFF_XDL_SET(options, PATIENCE_DIFF);
 
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
@@ -2594,10 +2594,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, COLOR_DIFF);
 	else if (!strcmp(arg, "--no-color"))
 		DIFF_OPT_CLR(options, COLOR_DIFF);
-	else if (!strcmp(arg, "--color-words"))
-		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+	else if (!strcmp(arg, "--color-words")) {
+		DIFF_OPT_SET(options, COLOR_DIFF);
+		DIFF_OPT_SET(options, COLOR_DIFF_WORDS);
+	}
 	else if (!prefixcmp(arg, "--color-words=")) {
-		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+		DIFF_OPT_SET(options, COLOR_DIFF);
+		DIFF_OPT_SET(options, COLOR_DIFF_WORDS);
 		options->word_regex = arg + 14;
 	}
 	else if (!strcmp(arg, "--exit-code"))
-- 
1.6.1
