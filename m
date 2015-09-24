From: Jeff King <peff@peff.net>
Subject: [PATCH 51/68] stat_tracking_info: convert to argv_array
Date: Thu, 24 Sep 2015 17:07:58 -0400
Message-ID: <20150924210758.GV30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:09:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDlQ-00032s-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbbIXVIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:08:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:36015 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754255AbbIXVIB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:08:01 -0400
Received: (qmail 12109 invoked by uid 102); 24 Sep 2015 21:08:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:08:00 -0500
Received: (qmail 29444 invoked by uid 107); 24 Sep 2015 21:08:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:58 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278615>

In addition to dropping the magic number for the fixed-size
argv, we can also drop a fixed-length buffer and some
strcpy's into it.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/remote.c b/remote.c
index a01f13a..1101f82 100644
--- a/remote.c
+++ b/remote.c
@@ -8,6 +8,7 @@
 #include "tag.h"
 #include "string-list.h"
 #include "mergesort.h"
+#include "argv-array.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
@@ -1997,10 +1998,9 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 {
 	unsigned char sha1[20];
 	struct commit *ours, *theirs;
-	char symmetric[84];
 	struct rev_info revs;
-	const char *rev_argv[10], *base;
-	int rev_argc;
+	const char *base;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	/* Cannot stat unless we are marked to build on top of somebody else. */
 	base = branch_get_upstream(branch, NULL);
@@ -2029,19 +2029,15 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	}
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
-	rev_argc = 0;
-	rev_argv[rev_argc++] = NULL;
-	rev_argv[rev_argc++] = "--left-right";
-	rev_argv[rev_argc++] = symmetric;
-	rev_argv[rev_argc++] = "--";
-	rev_argv[rev_argc] = NULL;
-
-	strcpy(symmetric, sha1_to_hex(ours->object.sha1));
-	strcpy(symmetric + 40, "...");
-	strcpy(symmetric + 43, sha1_to_hex(theirs->object.sha1));
+	argv_array_push(&argv, ""); /* ignored */
+	argv_array_push(&argv, "--left-right");
+	argv_array_pushf(&argv, "%s...%s",
+			 sha1_to_hex(ours->object.sha1),
+			 sha1_to_hex(theirs->object.sha1));
+	argv_array_push(&argv, "--");
 
 	init_revisions(&revs, NULL);
-	setup_revisions(rev_argc, rev_argv, &revs, NULL);
+	setup_revisions(argv.argc, argv.argv, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 
@@ -2061,6 +2057,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	/* clear object flags smudged by the above traversal */
 	clear_commit_marks(ours, ALL_REV_FLAGS);
 	clear_commit_marks(theirs, ALL_REV_FLAGS);
+
+	argv_array_clear(&argv);
 	return 0;
 }
 
-- 
2.6.0.rc3.454.g204ad51
