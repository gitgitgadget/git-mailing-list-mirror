From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 3/4] revert: allow cherry-picking a range of commits
Date: Sat, 29 May 2010 06:40:42 +0200
Message-ID: <20100529044044.569.7874.chriscool@tuxfamily.org>
References: <20100529043738.569.85482.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 29 06:41:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIDrc-0007PG-4M
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 06:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225Ab0E2El1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 00:41:27 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56292 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab0E2El0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 00:41:26 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 94E1C818049;
	Sat, 29 May 2010 06:41:19 +0200 (CEST)
X-git-sha1: 56ceb9a9d3543a1d02992286449eb0f6be6ac8f6 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100529043738.569.85482.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147951>

This makes it possible to pass a range of commits like A..B
to "git cherry-pick" and to "git revert" to process many
commits instead of just one.

But there is currently no way to continue cherry-picking or
reverting if there is a problem with one commit. It's also
not possible to abort the whole process. Some future work
should provide the --continue and --abort options to do
just that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   43 +++++++++++++++++++++++++++++++++++++------
 1 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 70372dc..c281a80 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -53,7 +53,6 @@ static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str =
 		action == REVERT ?  revert_usage : cherry_pick_usage;
-	unsigned char sha1[20];
 	int noop;
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
@@ -82,11 +81,6 @@ static void parse_args(int argc, const char **argv)
 		usage_with_options(usage_str, options);
 
 	commit_name = argv[0];
-	if (get_sha1(commit_name, sha1))
-		die ("Cannot find '%s'", commit_name);
-	commit = lookup_commit_reference(sha1);
-	if (!commit)
-		exit(1);
 }
 
 struct commit_message {
@@ -522,6 +516,9 @@ static int do_pick_commit()
 
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
+	const char *dotdot;
+	unsigned char sha1[20];
+
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
@@ -545,6 +542,40 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	if (read_cache() < 0)
 		die("git %s: failed to read the index", me);
 
+	dotdot = strstr(commit_name, "..");
+	if (dotdot) {
+		struct rev_info revs;
+		const char *argv[4];
+		int argc = 0;
+
+		argv[argc++] = NULL;
+		if (action != REVERT)
+			argv[argc++] = "--reverse";
+		argv[argc++] = commit_name;
+		argv[argc++] = NULL;
+
+		init_revisions(&revs, NULL);
+		setup_revisions(argc - 1, argv, &revs, NULL);
+		if (prepare_revision_walk(&revs))
+			die("revision walk setup failed");
+
+		if (!revs.commits)
+			die("empty range passed");
+
+		while ( (commit = get_revision(&revs)) ) {
+			int res = do_pick_commit();
+			if (res)
+				return res;
+		}
+		return 0;
+	}
+
+	if (get_sha1(commit_name, sha1))
+		die ("Cannot find '%s'", commit_name);
+	commit = lookup_commit_reference(sha1);
+	if (!commit)
+		exit(1);
+
 	return do_pick_commit();
 }
 
-- 
1.7.1.346.g7c1d7.dirty
