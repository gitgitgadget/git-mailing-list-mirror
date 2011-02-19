From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] merge: improve inexact rename limit warning
Date: Sat, 19 Feb 2011 05:20:51 -0500
Message-ID: <20110219102051.GA22508@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 11:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqjvw-0003cP-W5
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 11:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab1BSKUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 05:20:55 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37587 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534Ab1BSKUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 05:20:53 -0500
Received: (qmail 8615 invoked by uid 111); 19 Feb 2011 10:20:53 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 19 Feb 2011 10:20:53 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Feb 2011 05:20:51 -0500
Content-Disposition: inline
In-Reply-To: <20110219101936.GB20577@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167265>

The warning is generated deep in the diffcore code, which
means that it will come first, followed possibly by a spew
of conflicts, making it hard to see.

Instead, let's have diffcore pass back the information about
how big the rename limit would needed to have been, and then
the caller can provide a more appropriate message (and at a
more appropriate time).

No refactoring of other non-merge callers is necessary,
because nobody else was even using the warn_on_rename_limit
feature.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.h            |    2 +-
 diffcore-rename.c |    5 +++--
 merge-recursive.c |   10 +++++++++-
 merge-recursive.h |    1 +
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/diff.h b/diff.h
index 0083d92..f774c9a 100644
--- a/diff.h
+++ b/diff.h
@@ -110,7 +110,7 @@ struct diff_options {
 	int pickaxe_opts;
 	int rename_score;
 	int rename_limit;
-	int warn_on_too_large_rename;
+	int needed_rename_limit;
 	int dirstat_percent;
 	int setup;
 	int abbrev;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0cd4c13..1d3d5cd 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -518,12 +518,13 @@ void diffcore_rename(struct diff_options *options)
 	 * but handles the potential overflow case specially (and we
 	 * assume at least 32-bit integers)
 	 */
+	options->needed_rename_limit = 0;
 	if (rename_limit <= 0 || rename_limit > 32767)
 		rename_limit = 32767;
 	if ((num_create > rename_limit && num_src > rename_limit) ||
 	    (num_create * num_src > rename_limit * rename_limit)) {
-		if (options->warn_on_too_large_rename)
-			warning("too many files (created: %d deleted: %d), skipping inexact rename detection", num_create, num_src);
+		options->needed_rename_limit =
+			num_src > num_create ? num_src : num_create;
 		goto cleanup;
 	}
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 16c2dbe..2ecd456 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -22,6 +22,11 @@
 #include "dir.h"
 #include "submodule.h"
 
+static const char rename_limit_advice[] =
+"inexact rename detection was skipped because there were too many\n"
+"  files. You may want to set your merge.renamelimit variable to at least\n"
+"  %d and retry this merge.";
+
 static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 				      const char *subtree_shift)
 {
@@ -436,12 +441,13 @@ static struct string_list *get_renames(struct merge_options *o,
 			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
 			    500;
 	opts.rename_score = o->rename_score;
-	opts.warn_on_too_large_rename = 1;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
 		die("diff setup failed");
 	diff_tree_sha1(o_tree->object.sha1, tree->object.sha1, "", &opts);
 	diffcore_std(&opts);
+	if (opts.needed_rename_limit > o->needed_rename_limit)
+		o->needed_rename_limit = opts.needed_rename_limit;
 	for (i = 0; i < diff_queued_diff.nr; ++i) {
 		struct string_list_item *item;
 		struct rename *re;
@@ -1666,6 +1672,8 @@ int merge_recursive(struct merge_options *o,
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
 	flush_output(o);
+	if (o->needed_rename_limit)
+		warning(rename_limit_advice, o->needed_rename_limit);
 	return clean;
 }
 
diff --git a/merge-recursive.h b/merge-recursive.h
index 981ed6a..1a113e2 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -20,6 +20,7 @@ struct merge_options {
 	int diff_rename_limit;
 	int merge_rename_limit;
 	int rename_score;
+	int needed_rename_limit;
 	int call_depth;
 	struct strbuf obuf;
 	struct string_list current_file_set;
-- 
1.7.4.1.26.g5e991
