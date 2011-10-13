From: Brad King <brad.king@kitware.com>
Subject: [PATCH 2/2] submodule: Search for merges only at end of recursive merge
Date: Thu, 13 Oct 2011 08:59:05 -0400
Message-ID: <e74e6d5fbff37c22d06329f63183cac766adcfd7.1318509069.git.brad.king@kitware.com>
References: <7vipnu9hbj.fsf@alter.siamese.dyndns.org> <cover.1318509069.git.brad.king@kitware.com>
Cc: Junio C Hamano <gitster@pobox.com>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 15:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REL2Q-0004ph-Ru
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab1JMNJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:09:11 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:57808 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752990Ab1JMNJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:09:10 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Oct 2011 09:09:10 EDT
Received: from vesper (vesper.kitwarein.com [192.168.1.207])
	by public.kitware.com (Postfix) with ESMTP id 78B553B2D9;
	Thu, 13 Oct 2011 08:59:07 -0400 (EDT)
Received: by vesper (Postfix, from userid 1000)
	id A16C81A40; Thu, 13 Oct 2011 08:59:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1318509069.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183477>

The submodule merge search is not useful during virtual merges because
the results cannot be used automatically.  Furthermore any suggestions
made by the search may apply to commits different than HEAD:sub and
MERGE_HEAD:sub, thus confusing the user.  Skip searching for submodule
merges during a virtual merge such as that between B and C while merging
the heads of:

    B---BC
   / \ /
  A   X
   \ / \
    C---CB

Run the search only when the recursion level is zero (!o->call_depth).
This fixes known breakage tested in t7405-submodule-merge.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 merge-recursive.c          |    6 ++++--
 submodule.c                |    6 +++++-
 submodule.h                |    2 +-
 t/t7405-submodule-merge.sh |    2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c34a4f1..cc664c3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -946,8 +946,10 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			free(result_buf.ptr);
 			result.clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result.clean = merge_submodule(result.sha, one->path, one->sha1,
-						       a->sha1, b->sha1);
+			result.clean = merge_submodule(result.sha,
+						       one->path, one->sha1,
+						       a->sha1, b->sha1,
+						       !o->call_depth);
 		} else if (S_ISLNK(a->mode)) {
 			hashcpy(result.sha, a->sha1);
 
diff --git a/submodule.c b/submodule.c
index 0b709bc..0fd10a0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -794,7 +794,7 @@ static void print_commit(struct commit *commit)
 
 int merge_submodule(unsigned char result[20], const char *path,
 		    const unsigned char base[20], const unsigned char a[20],
-		    const unsigned char b[20])
+		    const unsigned char b[20], int search)
 {
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
@@ -849,6 +849,10 @@ int merge_submodule(unsigned char result[20], const char *path,
 	 * user needs to confirm the resolution.
 	 */
 
+	/* Skip the search if makes no sense to the calling context.  */
+	if (!search)
+		return 0;
+
 	/* find commit which merges them */
 	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
 	switch (parent_count) {
diff --git a/submodule.h b/submodule.h
index 799c22d..80e04f3 100644
--- a/submodule.h
+++ b/submodule.h
@@ -28,7 +28,7 @@ int fetch_populated_submodules(int num_options, const char **options,
 			       int quiet);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
-		    const unsigned char a[20], const unsigned char b[20]);
+		    const unsigned char a[20], const unsigned char b[20], int search);
 int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name);
 
 #endif
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 14da2e3..0d5b42a 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -269,7 +269,7 @@ test_expect_success 'setup for recursive merge with submodule' '
 '
 
 # merge should leave submodule unmerged in index
-test_expect_failure 'recursive merge with submodule' '
+test_expect_success 'recursive merge with submodule' '
 	(cd merge-recursive &&
 	 test_must_fail git merge top-bc &&
 	 echo "160000 $(git rev-parse top-cb:sub) 2	sub" > expect2 &&
-- 
1.7.5.4
