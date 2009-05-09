From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/10] bisect: remove too much function nesting
Date: Sat, 09 May 2009 17:55:42 +0200
Message-ID: <20090509155548.5387.95855.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:03:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p1m-00065t-PS
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbZEIQDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbZEIQDs
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:48 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:60655 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbZEIQDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:40 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 22F4AE08083;
	Sat,  9 May 2009 18:03:34 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 2AC4DE0806A;
	Sat,  9 May 2009 18:03:32 +0200 (CEST)
X-git-sha1: e1c69ac48ed6cfe862ff916e474eefd62a8b3aa5 
X-Mailer: git-mail-commits v0.4.0
In-Reply-To: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118666>

This patch moves some function calls into "bisect_next_exit" so
that functions are nesting less.

The call to "bisect_rev_setup" is moved from "bisect_common" into
"bisect_next_exit" and the call to "read_bisect_refs" from
"bisect_rev_setup" into "bisect_next_exit".

While at it, "rev_argv" is moved into "bisect_rev_setup".

This will make it easier and cleaner to implement checking merge
bases.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index 8e34186..9e01b9e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -26,8 +26,6 @@ struct argv_array {
 	int argv_alloc;
 };
 
-struct argv_array rev_argv;
-
 static const char *argv_diff_tree[] = {"diff-tree", "--pretty", NULL, NULL};
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
@@ -539,15 +537,13 @@ struct commit_list *filter_skipped(struct commit_list *list,
 
 static void bisect_rev_setup(struct rev_info *revs, const char *prefix)
 {
+	struct argv_array rev_argv = { NULL, 0, 0 };
 	int i;
 
 	init_revisions(revs, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
-	if (read_bisect_refs())
-		die("reading bisect refs failed");
-
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
 	argv_array_push(&rev_argv, xstrdup("bisect_rev_setup"));
 	argv_array_push_sha1(&rev_argv, current_bad_sha1, "%s");
@@ -561,11 +557,8 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix)
 	revs->limited = 1;
 }
 
-static void bisect_common(struct rev_info *revs, const char *prefix,
-			  int *reaches, int *all)
+static void bisect_common(struct rev_info *revs, int *reaches, int *all)
 {
-	bisect_rev_setup(revs, prefix);
-
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 	if (revs->tree_objects)
@@ -636,7 +629,12 @@ int bisect_next_exit(const char *prefix)
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[41];
 
-	bisect_common(&revs, prefix, &reaches, &all);
+	if (read_bisect_refs())
+		die("reading bisect refs failed");
+
+	bisect_rev_setup(&revs, prefix);
+
+	bisect_common(&revs, &reaches, &all);
 
 	revs.commits = filter_skipped(revs.commits, &tried, 0);
 
-- 
1.6.3.rc1.112.g17e25
