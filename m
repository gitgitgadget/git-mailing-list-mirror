From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 3/2] Fix small memory leaks induced by diff_tree_setup_paths
Date: Tue, 11 Dec 2007 22:59:55 +0100
Message-ID: <1197410395-30045-1-git-send-email-mh@glandium.org>
References: <1197407997-22945-2-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:00:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2D9N-0003dg-73
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 23:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbXLKV76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbXLKV76
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:59:58 -0500
Received: from smtp28.orange.fr ([80.12.242.99]:17773 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbXLKV75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:59:57 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2803.orange.fr (SMTP Server) with ESMTP id 167E5800009C
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 22:59:56 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2803.orange.fr (SMTP Server) with ESMTP id DA06E800009A;
	Tue, 11 Dec 2007 22:59:55 +0100 (CET)
X-ME-UUID: 20071211215955893.DA06E800009A@mwinf2803.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J2D8t-0007pj-BL; Tue, 11 Dec 2007 22:59:55 +0100
X-Mailer: git-send-email 1.5.3.7.1164.ga23bb-dirty
In-Reply-To: <1197407997-22945-2-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67954>

Run diff_tree_release_paths in the appropriate places, and add a test to
avoid NULL dereference. Better safe than sorry.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 There are a few more occurrences of diff_tree_setup_paths for which I don't
 know the code enough to correctly place the corresponding
 diff_tree_release_paths. Interesting the function existed but was never
 actually used ;)

 builtin-blame.c |    4 +++-
 builtin-reset.c |    1 +
 tree-diff.c     |    4 +++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 523e55a..041901b 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -388,6 +388,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 		}
 	}
 	diff_flush(&diff_opts);
+	diff_tree_release_paths(&diff_opts);
 	if (porigin) {
 		/*
 		 * Create a freestanding copy that is not part of
@@ -444,6 +445,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 		}
 	}
 	diff_flush(&diff_opts);
+	diff_tree_release_paths(&diff_opts);
 	return porigin;
 }
 
@@ -1167,7 +1169,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-
+	diff_tree_release_paths(&diff_opts);
 	return retval;
 }
 
diff --git a/builtin-reset.c b/builtin-reset.c
index 4c61025..713c2d5 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -158,6 +158,7 @@ static int read_from_tree(const char *prefix, const char **argv,
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
+	diff_tree_release_paths(&opt);
 
 	if (!index_was_discarded)
 		/* The index is still clobbered from do_diff_cache() */
diff --git a/tree-diff.c b/tree-diff.c
index aa0a100..a2fdf86 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -326,6 +326,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 		die("unable to set up diff options to follow renames");
 	diff_tree(t1, t2, base, &diff_opts);
 	diffcore_std(&diff_opts);
+	diff_tree_release_paths(&diff_opts);
 
 	/* Go through the new set of filepairing, and see if we find a more interesting one */
 	for (i = 0; i < q->nr; i++) {
@@ -418,7 +419,8 @@ static int count_paths(const char **paths)
 
 void diff_tree_release_paths(struct diff_options *opt)
 {
-	free(opt->pathlens);
+	if (opt->pathlens)
+		free(opt->pathlens);
 }
 
 void diff_tree_setup_paths(const char **p, struct diff_options *opt)
-- 
1.5.3.7
