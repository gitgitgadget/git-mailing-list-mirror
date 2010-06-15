From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/3] revert: do not rebuild argv on heap
Date: Tue, 15 Jun 2010 05:29:51 +0200
Message-ID: <20100615032952.3977.88455.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 05:38:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOMzC-000767-RJ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 05:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab0FODio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 23:38:44 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39630 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab0FODin (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 23:38:43 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1028681806A;
	Tue, 15 Jun 2010 05:38:35 +0200 (CEST)
X-git-sha1: 646466927d8eaf140e0ebc6a21c6dd544908701a 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149157>

From: Jonathan Nieder <jrnieder@gmail.com>

Set options in struct rev_info directly so we can reuse the
arguments collected from parse_options without modification.

This is just a cleanup; no noticeable change is intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c              |   33 ++++++++++++++++-----------------
 t/t3501-revert-cherry-pick.sh |   18 ++++++++++++++++++
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 3f4a20e..b6b4152 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -50,10 +50,14 @@ static const char *strategy;
 
 static char *get_encoding(const char *message);
 
+static const char * const *revert_or_cherry_pick_usage(void)
+{
+	return action == REVERT ? revert_usage : cherry_pick_usage;
+}
+
 static void parse_args(int argc, const char **argv)
 {
-	const char * const * usage_str =
-		action == REVERT ?  revert_usage : cherry_pick_usage;
+	const char * const * usage_str = revert_or_cherry_pick_usage();
 	int noop;
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
@@ -79,8 +83,8 @@ static void parse_args(int argc, const char **argv)
 	}
 
 	commit_argc = parse_options(argc, argv, NULL, options, usage_str,
-				    PARSE_OPT_KEEP_UNKNOWN);
-	if (commit_argc < 1)
+				    PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
+	if (commit_argc < 2)
 		usage_with_options(usage_str, options);
 
 	commit_argv = argv;
@@ -526,27 +530,22 @@ static int do_pick_commit(void)
 
 static void prepare_revs(struct rev_info *revs)
 {
-	int argc = 0;
-	int i;
-	const char **argv = xmalloc((commit_argc + 4) * sizeof(*argv));
+	int argc;
 
-	argv[argc++] = NULL;
-	argv[argc++] = "--no-walk";
+	init_revisions(revs, NULL);
+	revs->no_walk = 1;
 	if (action != REVERT)
-		argv[argc++] = "--reverse";
-	for (i = 0; i < commit_argc; i++)
-		argv[argc++] = commit_argv[i];
-	argv[argc++] = NULL;
+		revs->reverse = 1;
+
+	argc = setup_revisions(commit_argc, commit_argv, revs, NULL);
+	if (argc > 1)
+		usage(*revert_or_cherry_pick_usage());
 
-	init_revisions(revs, NULL);
-	setup_revisions(argc - 1, argv, revs, NULL);
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 
 	if (!revs->commits)
 		die("empty commit set passed");
-
-	free(argv);
 }
 
 static int revert_or_cherry_pick(int argc, const char **argv)
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index e4fbf7a..bc7aedd 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -41,6 +41,24 @@ test_expect_success setup '
 	git tag rename2
 '
 
+test_expect_success 'cherry-pick --nonsense' '
+
+	pos=$(git rev-parse HEAD) &&
+	git diff --exit-code HEAD &&
+	test_must_fail git cherry-pick --nonsense 2>msg &&
+	git diff --exit-code HEAD "$pos" &&
+	grep '[Uu]sage:' msg
+'
+
+test_expect_success 'revert --nonsense' '
+
+	pos=$(git rev-parse HEAD) &&
+	git diff --exit-code HEAD &&
+	test_must_fail git revert --nonsense 2>msg &&
+	git diff --exit-code HEAD "$pos" &&
+	grep '[Uu]sage:' msg
+'
+
 test_expect_success 'cherry-pick after renaming branch' '
 
 	git checkout rename2 &&
-- 
1.7.1.530.g14dc.dirty
