From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] bisect: rework some rev related functions to make them
	more reusable
Date: Sun, 17 May 2009 17:36:44 +0200
Message-ID: <20090517153647.6403.35442.chriscool@tuxfamily.org>
References: <20090517153307.6403.73576.>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 17:40:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5iTP-0006mY-6A
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 17:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbZEQPjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 11:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbZEQPjx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 11:39:53 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:39078 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbZEQPjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 11:39:51 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id E8BDFD480BB;
	Sun, 17 May 2009 17:39:45 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id F1887D48109;
	Sun, 17 May 2009 17:39:42 +0200 (CEST)
X-git-sha1: d1a45ff9a3658f8914c20e7ee550fd195790aad4 
X-Mailer: git-mail-commits v0.4.3
In-Reply-To: <20090517153307.6403.73576.>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119395>

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
1.6.3.rc1.112.g17e25
