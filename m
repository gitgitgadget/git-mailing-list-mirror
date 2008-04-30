From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Wed, 30 Apr 2008 13:25:53 -0400
Message-ID: <20080430172553.GC23747@sigill.intra.peff.net>
References: <20080430172136.GA22601@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:26:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrG4p-0004xZ-RW
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758202AbYD3RZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757175AbYD3RZ4
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:25:56 -0400
Received: from peff.net ([208.65.91.99]:3526 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758156AbYD3RZz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:25:55 -0400
Received: (qmail 28075 invoked by uid 111); 30 Apr 2008 17:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Apr 2008 13:25:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2008 13:25:53 -0400
Content-Disposition: inline
In-Reply-To: <20080430172136.GA22601@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80856>

In many cases, the warning ends up as clutter, because the
diff is being done "behind the scenes" from the user (e.g.,
when generating a commit diffstat), and whether we show
renames or not is not particularly interesting to the user.

However, in the case of a merge (which is what motivated the
warning in the first place), it is a useful hint as to why a
merge with renames might have failed.

This patch makes the warning optional based on the code
calling into diffcore. We default to not showing the
warning, but turn it on for merges.

Signed-off-by: Jeff King <peff@peff.net>
---
This neglects the case where the user specifically does a diff asking
for renames, but we turn it off. Maybe when "-M" is specified on the
commandline to git-diff, we should set this option as well.

 builtin-merge-recursive.c |    1 +
 diff.h                    |    1 +
 diffcore-rename.c         |    3 ++-
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 3902e91..46e636f 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -365,6 +365,7 @@ static struct path_list *get_renames(struct tree *tree,
 	opts.rename_limit = merge_rename_limit >= 0 ? merge_rename_limit :
 			    diff_rename_limit >= 0 ? diff_rename_limit :
 			    500;
+	opts.warn_on_too_large_rename = 1;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
 		die("diff setup failed");
diff --git a/diff.h b/diff.h
index f2c7739..8931116 100644
--- a/diff.h
+++ b/diff.h
@@ -83,6 +83,7 @@ struct diff_options {
 	int pickaxe_opts;
 	int rename_score;
 	int rename_limit;
+	int warn_on_too_large_rename;
 	int dirstat_percent;
 	int setup;
 	int abbrev;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1369a5e..1b2ebb4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -492,7 +492,8 @@ void diffcore_rename(struct diff_options *options)
 		rename_limit = 32767;
 	if ((num_create > rename_limit && num_src > rename_limit) ||
 	    (num_create * num_src > rename_limit * rename_limit)) {
-		warning("too many files, skipping inexact rename detection");
+		if (options->warn_on_too_large_rename)
+			warning("too many files, skipping inexact rename detection");
 		goto cleanup;
 	}
 
-- 
1.5.5.1.177.g8182d.dirty
