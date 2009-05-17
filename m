From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] bisect: check ancestors without forking a "git rev-list"
	process
Date: Sun, 17 May 2009 17:36:46 +0200
Message-ID: <20090517153647.6403.64994.chriscool@tuxfamily.org>
References: <20090517153307.6403.73576.>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 17:40:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5iTO-0006mY-Iq
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 17:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbZEQPjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 11:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbZEQPjw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 11:39:52 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:39083 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393AbZEQPjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 11:39:51 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id D01E2D4819E;
	Sun, 17 May 2009 17:39:46 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id CAD5DD48148;
	Sun, 17 May 2009 17:39:43 +0200 (CEST)
X-git-sha1: 384fd98273a931d4a9771536222be8a18e5f887a 
X-Mailer: git-mail-commits v0.4.3
In-Reply-To: <20090517153307.6403.73576.>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119396>

We must save the pending commits that will be used during revision
walking and unparse them after, because we want to leave a clean
state for the next revision walking that will try to find the best
bisection point.

As we don't fork a process anymore to call "git rev-list", we need
to remove the use of GIT_TRACE to check how "git rev-list" is
called from the t6030 test that uses it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c                    |   54 +++++++++++++++++-------------------------
 t/t6030-bisect-porcelain.sh |   13 +---------
 2 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/bisect.c b/bisect.c
index dc4e1bb..c43c120 100644
--- a/bisect.c
+++ b/bisect.c
@@ -750,42 +750,31 @@ static void check_merge_bases(void)
 	free_commit_list(result);
 }
 
-/*
- * This function runs the command "git rev-list $_good ^$_bad"
- * and returns 1 if it produces some output, 0 otherwise.
- */
-static int check_ancestors(void)
+static int check_ancestors(const char *prefix)
 {
-	struct argv_array rev_argv = { NULL, 0, 0 };
-	struct strbuf str = STRBUF_INIT;
-	int i, result = 0;
-	struct child_process rls;
-	FILE *rls_fout;
+	struct rev_info revs;
+	struct object_array pending_copy;
+	int i, res;
 
-	argv_array_push(&rev_argv, xstrdup("rev-list"));
-	argv_array_push_sha1(&rev_argv, current_bad_sha1, "^%s");
-	for (i = 0; i < good_revs.sha1_nr; i++)
-		argv_array_push_sha1(&rev_argv, good_revs.sha1[i], "%s");
-	argv_array_push(&rev_argv, NULL);
+	bisect_rev_setup(&revs, prefix, "^%s", "%s", 0);
 
-	memset(&rls, 0, sizeof(rls));
-	rls.argv = rev_argv.argv;
-	rls.out = -1;
-	rls.git_cmd = 1;
-	if (start_command(&rls))
-		die("Could not launch 'git rev-list' command.");
-	rls_fout = fdopen(rls.out, "r");
-	while (strbuf_getline(&str, rls_fout, '\n') != EOF) {
-		strbuf_trim(&str);
-		if (*str.buf) {
-			result = 1;
-			break;
-		}
+	/* Save pending objects, so they can be cleaned up later. */
+	memset(&pending_copy, 0, sizeof(pending_copy));
+	for (i = 0; i < revs.pending.nr; i++)
+		add_object_array(revs.pending.objects[i].item,
+				 revs.pending.objects[i].name,
+				 &pending_copy);
+
+	bisect_common(&revs);
+	res = (revs.commits != NULL);
+
+	/* Clean up objects used, as they will be reused. */
+	for (i = 0; i < pending_copy.nr; i++) {
+		struct object *o = pending_copy.objects[i].item;
+		unparse_commit((struct commit *)o);
 	}
-	fclose(rls_fout);
-	finish_command(&rls);
 
-	return result;
+	return res;
 }
 
 /*
@@ -813,7 +802,8 @@ static void check_good_are_ancestors_of_bad(const char *prefix)
 	if (good_revs.sha1_nr == 0)
 		return;
 
-	if (check_ancestors())
+	/* Check if all good revs are ancestor of the bad rev. */
+	if (check_ancestors(prefix))
 		check_merge_bases();
 
 	/* Create file BISECT_ANCESTORS_OK. */
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 54b7ea6..5254b23 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -482,28 +482,17 @@ test_expect_success 'good merge bases when good and bad are siblings' '
 	git bisect reset
 '
 
-check_trace() {
-	grep "$1" "$GIT_TRACE" | grep "\^$2" | grep "$3" >/dev/null
-}
-
 test_expect_success 'optimized merge base checks' '
-	GIT_TRACE="$(pwd)/trace.log" &&
-	export GIT_TRACE &&
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
 	grep "merge base must be tested" my_bisect_log.txt &&
 	grep "$HASH4" my_bisect_log.txt &&
-	check_trace "rev-list" "$HASH7" "$SIDE_HASH7" &&
 	git bisect good > my_bisect_log2.txt &&
 	test -f ".git/BISECT_ANCESTORS_OK" &&
 	test "$HASH6" = $(git rev-parse --verify HEAD) &&
-	: > "$GIT_TRACE" &&
 	git bisect bad > my_bisect_log3.txt &&
-	test_must_fail check_trace "rev-list" "$HASH6" "$SIDE_HASH7" &&
 	git bisect good "$A_HASH" > my_bisect_log4.txt &&
 	grep "merge base must be tested" my_bisect_log4.txt &&
-	test_must_fail test -f ".git/BISECT_ANCESTORS_OK" &&
-	check_trace "rev-list" "$HASH6" "$A_HASH" &&
-	unset GIT_TRACE
+	test_must_fail test -f ".git/BISECT_ANCESTORS_OK"
 '
 
 # This creates another side branch called "parallel" with some files
-- 
1.6.3.rc1.112.g17e25
