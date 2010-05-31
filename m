From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/8] revert: allow cherry-picking more than one commit
Date: Mon, 31 May 2010 21:42:36 +0200
Message-ID: <20100531194240.28729.9164.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 05:04:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJHmQ-0000XE-W6
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 05:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab0FADEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 23:04:30 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:42044 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260Ab0FADE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 23:04:26 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 63A1481805D;
	Tue,  1 Jun 2010 05:04:18 +0200 (CEST)
X-git-sha1: f07c772e414ebbb9900fbba7fa3bc55a4a677d7e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148066>

This makes it possible to pass many commits or ranges of
commits to "git cherry-pick" and to "git revert" to process
many commits instead of just one.

In fact commits are now enumerated with an equivalent of

	git rev-list --no-walk "$@"

so all the following are now possible:

	git cherry-pick master~2..master
	git cherry-pick ^master~2 master
	git cherry-pick master^ master

The following should be possible but does not work:

	git cherry-pick -2 master

because "git rev-list --no-walk -2 master" only outputs
one commit as "--no-walk" seems to take over "-2".

And there is currently no way to continue cherry-picking or
reverting if there is a problem with one commit. It's also
not possible to abort the whole process. Some future work
should provide the --continue and --abort options to do
just that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   49 +++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f0d78e5..b90955f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -39,7 +39,8 @@ static const char * const cherry_pick_usage[] = {
 static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
-static const char *commit_name;
+static int commit_argc;
+static const char **commit_argv;
 static int allow_rerere_auto;
 
 static const char *me;
@@ -53,7 +54,6 @@ static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str =
 		action == REVERT ?  revert_usage : cherry_pick_usage;
-	unsigned char sha1[20];
 	int noop;
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
@@ -78,15 +78,11 @@ static void parse_args(int argc, const char **argv)
 			die("program error");
 	}
 
-	if (parse_options(argc, argv, NULL, options, usage_str, 0) != 1)
+	commit_argc = parse_options(argc, argv, NULL, options, usage_str, 0);
+	if (commit_argc < 1)
 		usage_with_options(usage_str, options);
 
-	commit_name = argv[0];
-	if (get_sha1(commit_name, sha1))
-		die ("Cannot find '%s'", commit_name);
-	commit = lookup_commit_reference(sha1);
-	if (!commit)
-		exit(1);
+	commit_argv = argv;
 }
 
 struct commit_message {
@@ -520,8 +516,33 @@ static int do_pick_commit()
 	return 0;
 }
 
+static void prepare_revs(struct rev_info *revs)
+{
+	int argc = 0;
+	int i;
+	const char **argv = xmalloc((commit_argc + 4) * sizeof(*argv));
+
+	argv[argc++] = NULL;
+	argv[argc++] = "--no-walk";
+	if (action != REVERT)
+		argv[argc++] = "--reverse";
+	for (i = 0; i < commit_argc; i++)
+		argv[argc++] = commit_argv[i];
+	argv[argc++] = NULL;
+
+	init_revisions(revs, NULL);
+	setup_revisions(argc - 1, argv, revs, NULL);
+	if (prepare_revision_walk(revs))
+		die("revision walk setup failed");
+
+	if (!revs->commits)
+		die("empty commit set passed");
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
+	struct rev_info revs;
+
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
@@ -541,7 +562,15 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	if (read_cache() < 0)
 		die("git %s: failed to read the index", me);
 
-	return do_pick_commit();
+	prepare_revs(&revs);
+
+	while ((commit = get_revision(&revs))) {
+		int res = do_pick_commit();
+		if (res)
+			return res;
+	}
+
+	return 0;
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
-- 
1.7.1.361.g42de.dirty
