From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 2/3] revision: change '--bisect' rev machinery argument to
	'bisect-refs'
Date: Wed, 04 Nov 2009 05:00:02 +0100
Message-ID: <20091104040004.4545.49960.chriscool@tuxfamily.org>
References: <20091104034312.4545.2176.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 04:59:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5X1U-0003jN-V2
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 04:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbZKDD6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 22:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbZKDD6c
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 22:58:32 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55895 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbZKDD6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 22:58:31 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2AE83818043;
	Wed,  4 Nov 2009 04:58:30 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F3D5A818052;
	Wed,  4 Nov 2009 04:58:27 +0100 (CET)
X-git-sha1: 9c277988f9677e70544df1eae880ea79d0a1d1cb 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091104034312.4545.2176.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132035>

Using '--bisect' as a revision machinery argument is bogus because
it conflicts with the special '--bisect' argument for "rev-list".
And as shown by a test case added by a previous commit, this cannot
be fixed by adding a special flag to "struct rev_info".

So this commit just renames the '--bisect' flag to the revision
machinery into '--bisect-refs', and reverts the changes that added
the special flag to "struct rev_info".

This makes the test case added previously pass.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c          |    2 --
 builtin-rev-parse.c         |    4 ++--
 revision.c                  |    5 ++---
 revision.h                  |    1 -
 t/t6030-bisect-porcelain.sh |    2 +-
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 9e736b4..2ccbfbb 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -320,8 +320,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	memset(&info, 0, sizeof(info));
 	info.revs = &revs;
-	if (revs.bisect)
-		bisect_list = 1;
 
 	quiet = DIFF_OPT_TST(&revs.diffopt, QUICK);
 	for (i = 1 ; i < argc; i++) {
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 9526aaf..201a458 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -39,7 +39,7 @@ static int is_rev_argument(const char *arg)
 {
 	static const char *rev_args[] = {
 		"--all",
-		"--bisect",
+		"--bisect-refs",
 		"--dense",
 		"--branches",
 		"--header",
@@ -554,7 +554,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_ref(show_reference, NULL);
 				continue;
 			}
-			if (!strcmp(arg, "--bisect")) {
+			if (!strcmp(arg, "--bisect-refs")) {
 				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
diff --git a/revision.c b/revision.c
index 5cedd15..d1a1edc 100644
--- a/revision.c
+++ b/revision.c
@@ -995,7 +995,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
 	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk") ||
-	    !strcmp(arg, "--bisect"))
+	    !strcmp(arg, "--bisect-refs"))
 	{
 		unkv[(*unkc)++] = arg;
 		return 1;
@@ -1270,10 +1270,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_refs(revs, flags, for_each_branch_ref);
 				continue;
 			}
-			if (!strcmp(arg, "--bisect")) {
+			if (!strcmp(arg, "--bisect-refs")) {
 				handle_refs(revs, flags, for_each_bad_bisect_ref);
 				handle_refs(revs, flags ^ UNINTERESTING, for_each_good_bisect_ref);
-				revs->bisect = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--tags")) {
diff --git a/revision.h b/revision.h
index 921656a..b6421a6 100644
--- a/revision.h
+++ b/revision.h
@@ -63,7 +63,6 @@ struct rev_info {
 			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
-			bisect:1,
 			first_parent_only:1;
 
 	/* Diff flags */
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 88a2877..4e4160e 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -392,7 +392,7 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	git branch -D bisect
 '
 
-test_expect_failure 'bisect and "rev-list --bisect"' '
+test_expect_success 'bisect and "rev-list --bisect"' '
 	rev_list2=$(git rev-list --bisect $HASH3 --not $HASH1) &&
 	test "$rev_list2" = "$HASH2" &&
 	rev_list4=$(git rev-list --bisect $HASH7 --not $HASH1) &&
-- 
1.6.5.1.gaf97d
