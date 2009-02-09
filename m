From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Generalize and libify index_is_dirty() to index_differs_from(...)
Date: Tue, 10 Feb 2009 00:40:43 +0100
Message-ID: <1234222843-15577-1-git-send-email-s-beyer@gmx.net>
Cc: gitster@pobox.com, Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 00:42:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWflr-0002Aw-84
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 00:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbZBIXkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 18:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbZBIXkv
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 18:40:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:32818 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbZBIXku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 18:40:50 -0500
Received: (qmail invoked by alias); 09 Feb 2009 23:40:47 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp048) with SMTP; 10 Feb 2009 00:40:47 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18h9dlQKnYhuYc4b7ombZMWwPJC2n87HYKUsqRzA1
	V3DBK9sbUE3ipG
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LWfk3-0002mG-31; Tue, 10 Feb 2009 00:40:43 +0100
X-Mailer: git-send-email 1.6.2.rc0.458.g97dd
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109162>

index_is_dirty() in builtin-revert.c checks if the index is dirty.
This patch generalizes this function to check if the index differs
from a revision, i.e. the former index_is_dirty() behavior can now be
achieved by index_differs_from("HEAD", 0).

The second argument "diff_flags" allows to set further diff option
flags like DIFF_OPT_IGNORE_SUBMODULES. See DIFF_OPT_* macros in diff.h
for a list.

index_differs_from() seems to be useful for more than builtin-revert.c,
so it is moved into revision.c and also used in builtin-commit.c to
remove code duplication.

Yet to mention:

 - "rev.abbrev = 0;" in builtin-commit.c can be safely removed.
   This has no impact on performance or functioning of neither
   setup_revisions() nor run_diff_index().

 - rev.pending.objects is free()d because this fixes a leak.
   (Also see 295dd2ad "Fix memory leak in traverse_commit_list")

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

  This is one of the sequencer-preparing patches.
  (The function is used in sequencer several times, most of the time
   with diff_flags set to DIFF_OPT_IGNORE_SUBMODULES.)

  Alex is on Cc because he introduced the "Is commitable?" (i.e.
  "Is index dirty?") part in builtin-commit.c.

  Peff is on Cc because he introduced index_is_dirty() in
  builtin-revert.c.

 builtin-commit.c |   13 ++-----------
 builtin-revert.c |   13 +------------
 revision.c       |   15 +++++++++++++++
 revision.h       |    2 ++
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index d6a3a62..46e649c 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -561,7 +561,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		commitable = run_status(fp, index_file, prefix, 1);
 		wt_status_use_color = saved_color_setting;
 	} else {
-		struct rev_info rev;
 		unsigned char sha1[20];
 		const char *parent = "HEAD";
 
@@ -573,16 +572,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 
 		if (get_sha1(parent, sha1))
 			commitable = !!active_nr;
-		else {
-			init_revisions(&rev, "");
-			rev.abbrev = 0;
-			setup_revisions(0, NULL, &rev, parent);
-			DIFF_OPT_SET(&rev.diffopt, QUIET);
-			DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
-			run_diff_index(&rev, 1 /* cached */);
-
-			commitable = !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
-		}
+		else
+			commitable = index_differs_from(parent, 0);
 	}
 
 	fclose(fp);
diff --git a/builtin-revert.c b/builtin-revert.c
index d48313c..d210150 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -223,17 +223,6 @@ static char *help_msg(const unsigned char *sha1)
 	return helpbuf;
 }
 
-static int index_is_dirty(void)
-{
-	struct rev_info rev;
-	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, "HEAD");
-	DIFF_OPT_SET(&rev.diffopt, QUIET);
-	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
-	run_diff_index(&rev, 1);
-	return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
-}
-
 static struct tree *empty_tree(void)
 {
 	struct tree *tree = xcalloc(1, sizeof(struct tree));
@@ -279,7 +268,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	} else {
 		if (get_sha1("HEAD", head))
 			die ("You do not have a valid HEAD");
-		if (index_is_dirty())
+		if (index_differs_from("HEAD", 0))
 			die ("Dirty index: cannot %s", me);
 	}
 	discard_cache();
diff --git a/revision.c b/revision.c
index 8603c14..de489db 100644
--- a/revision.c
+++ b/revision.c
@@ -1926,3 +1926,18 @@ struct commit *get_revision(struct rev_info *revs)
 		graph_update(revs->graph, c);
 	return c;
 }
+
+int index_differs_from(const char *def, int diff_flags)
+{
+	struct rev_info rev;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, def);
+	DIFF_OPT_SET(&rev.diffopt, QUIET);
+	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+	rev.diffopt.flags |= diff_flags;
+	run_diff_index(&rev, 1);
+	if (rev.pending.alloc)
+		free(rev.pending.objects);
+	return (DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0);
+}
diff --git a/revision.h b/revision.h
index 7cf8487..bc17949 100644
--- a/revision.h
+++ b/revision.h
@@ -164,4 +164,6 @@ enum commit_action {
 
 extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
 
+extern int index_differs_from(const char *def, int diff_flags);
+
 #endif
-- 
1.6.2.rc0.458.g97dd
