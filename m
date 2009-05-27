From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/2] bisect: rework some rev related functions to make them
	more reusable
Date: Wed, 27 May 2009 07:09:41 +0200
Message-ID: <20090527050943.3694.58743.chriscool@tuxfamily.org>
References: <20090527050656.3694.86787.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 07:13:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9BRo-0002xG-4E
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 07:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758776AbZE0FMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 01:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757567AbZE0FMv
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 01:12:51 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:50154 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757084AbZE0FMr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 01:12:47 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id D08E64B00B7;
	Wed, 27 May 2009 07:12:42 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id AC9494B00C1;
	Wed, 27 May 2009 07:12:39 +0200 (CEST)
X-git-sha1: d1a45ff9a3658f8914c20e7ee550fd195790aad4 
X-Mailer: git-mail-commits v0.4.5
In-Reply-To: <20090527050656.3694.86787.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120030>

This patches changes the "bisect_rev_setup" and "bisect_common"
functions to make it easier to reuse them in a later patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/bisect.c b/bisect.c
index f57b62c..dc4e1bb 100644
--- a/bisect.c
+++ b/bisect.c
@@ -553,7 +553,9 @@ struct commit_list *filter_skipped(struct commit_list *list,
 	return filtered;
 }
 
-static void bisect_rev_setup(struct rev_info *revs, const char *prefix)
+static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
+			     const char *bad_format, const char *good_format,
+			     int read_paths)
 {
 	struct argv_array rev_argv = { NULL, 0, 0 };
 	int i;
@@ -564,26 +566,24 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix)
 
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
 	argv_array_push(&rev_argv, xstrdup("bisect_rev_setup"));
-	argv_array_push_sha1(&rev_argv, current_bad_sha1, "%s");
+	argv_array_push_sha1(&rev_argv, current_bad_sha1, bad_format);
 	for (i = 0; i < good_revs.sha1_nr; i++)
-		argv_array_push_sha1(&rev_argv, good_revs.sha1[i], "^%s");
+		argv_array_push_sha1(&rev_argv, good_revs.sha1[i],
+				     good_format);
 	argv_array_push(&rev_argv, xstrdup("--"));
-	read_bisect_paths(&rev_argv);
+	if (read_paths)
+		read_bisect_paths(&rev_argv);
 	argv_array_push(&rev_argv, NULL);
 
 	setup_revisions(rev_argv.argv_nr, rev_argv.argv, revs, NULL);
-	revs->limited = 1;
 }
 
-static void bisect_common(struct rev_info *revs, int *reaches, int *all)
+static void bisect_common(struct rev_info *revs)
 {
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 	if (revs->tree_objects)
 		mark_edges_uninteresting(revs->commits, revs, NULL);
-
-	revs->commits = find_bisection(revs->commits, reaches, all,
-				       !!skipped_revs.sha1_nr);
 }
 
 static void exit_if_skipped_commits(struct commit_list *tried,
@@ -843,10 +843,13 @@ int bisect_next_all(const char *prefix)
 
 	check_good_are_ancestors_of_bad(prefix);
 
-	bisect_rev_setup(&revs, prefix);
+	bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
+	revs.limited = 1;
 
-	bisect_common(&revs, &reaches, &all);
+	bisect_common(&revs);
 
+	revs.commits = find_bisection(revs.commits, &reaches, &all,
+				       !!skipped_revs.sha1_nr);
 	revs.commits = filter_skipped(revs.commits, &tried, 0);
 
 	if (!revs.commits) {
-- 
1.6.3.GIT
