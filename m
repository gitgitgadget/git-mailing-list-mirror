From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 10/18] revert: make read_and_refresh_cache() and
	prepare_revs() return errors
Date: Thu, 25 Nov 2010 22:20:41 +0100
Message-ID: <20101125212050.5188.69211.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIe-0007NM-K1
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab0KZFzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:55:08 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47695 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab0KZFzH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:55:07 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F1DBBA6163;
	Fri, 26 Nov 2010 06:54:59 +0100 (CET)
X-git-sha1: 3c7f150dd038d9f75c5eee877acb7dc486d3e828 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162195>

They used to "die" in case of problems which is bad if we want to
take some action in case of error.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 57d4300..8b50e0c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -543,7 +543,7 @@ static int do_pick_commit(struct args_info *info, struct commit *commit)
 	return res;
 }
 
-static void prepare_revs(struct rev_info *revs, struct args_info *info)
+static int prepare_revs(struct rev_info *revs, struct args_info *info)
 {
 	int argc;
 
@@ -553,29 +553,34 @@ static void prepare_revs(struct rev_info *revs, struct args_info *info)
 		revs->reverse = 1;
 
 	argc = setup_revisions(info->commit_argc, info->commit_argv, revs, NULL);
-	if (argc > 1)
-		usage(*revert_or_cherry_pick_usage(info));
+	if (argc > 1) {
+		fprintf(stderr, "usage: %s", *revert_or_cherry_pick_usage(info));
+		return 129;
+	}
 
 	if (prepare_revision_walk(revs))
-		die("revision walk setup failed");
+		return error("revision walk setup failed");
 
 	if (!revs->commits)
-		die("empty commit set passed");
+		return error("empty commit set passed");
+
+	return 0;
 }
 
-static void read_and_refresh_cache(const char *me)
+static int read_and_refresh_cache(const char *me)
 {
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
-		die("git %s: failed to read the index", me);
+		return error("git %s: failed to read the index", me);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed) {
 		if (write_index(&the_index, index_fd) ||
 		    commit_locked_index(&index_lock))
-			die("git %s: failed to refresh the index", me);
+			return error("git %s: failed to refresh the index", me);
 	}
 	rollback_lock_file(&index_lock);
+	return 0;
 }
 
 static int ff_incompatible(int val, const char *opt)
@@ -596,9 +601,9 @@ static int pick_commits(struct args_info *infos)
 	     (res = ff_incompatible(infos->edit, "--edit"))))
 			return res;
 
-	read_and_refresh_cache(me);
-
-	prepare_revs(&revs, infos);
+	if ((res = read_and_refresh_cache(me)) ||
+	    (res = prepare_revs(&revs, infos)))
+		return res;
 
 	while ((commit = get_revision(&revs)) &&
 	       !(res = do_pick_commit(infos, commit)))
-- 
1.7.3.2.504.g59d466
