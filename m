From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2/RFC] submodule: Search for merges only at end of recursive merge
Date: Fri, 26 Aug 2011 15:30:56 -0400
Message-ID: <8e4e80f75d281c8bdd07b0a29eee9ad407661102.1314386859.git.brad.king@kitware.com>
References: <7vr548c7un.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 21:31:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx27L-0007Zt-4V
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 21:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab1HZTa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 15:30:58 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:47018 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751929Ab1HZTa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 15:30:57 -0400
Received: from vesper (vesper.kitwarein.com [192.168.1.207])
	by public.kitware.com (Postfix) with ESMTP id 4EF0536B24;
	Fri, 26 Aug 2011 15:30:56 -0400 (EDT)
Received: by vesper (Postfix, from userid 1000)
	id 491916098; Fri, 26 Aug 2011 15:30:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <7vr548c7un.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180192>

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
On 8/26/2011 3:04 PM, Junio C Hamano wrote:
> This is a knee-jerk reaction without thinking things thoroughly through,
> but wouldn't it make more sense to do this by conditionally calling
> merge_submodule() when !o->call_depth, leaving the callee oblivious to
> what is in the "merge_options" structure? That way, you do not have to
> touch submodule.c at all, I would think.

I originally considered that but I think merge_submodule is still useful
during virtual merges in the fast forward case.  I haven't thought that
through in detail though.

> After all, merge_submodule() should be usable in a future merge strategy
> that is different from recursive and has no notion of call_depth.

That's a worthwhile goal.  Perhaps instead we should pass in a parameter
to tell merge_submodule whether or not to do the search after the fast
forward case fails.

Brad

 merge-recursive.c          |    6 ++++--
 submodule.c                |    6 +++++-
 submodule.h                |    2 +-
 t/t7405-submodule-merge.sh |    2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0cc1e6f..390811e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -830,8 +830,10 @@ static struct merge_file_info merge_file(struct merge_options *o,
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
index 1ba9646..bf4f693 100644
--- a/submodule.c
+++ b/submodule.c
@@ -644,7 +644,7 @@ static void print_commit(struct commit *commit)
 
 int merge_submodule(unsigned char result[20], const char *path,
 		    const unsigned char base[20], const unsigned char a[20],
-		    const unsigned char b[20])
+		    const unsigned char b[20], int search)
 {
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
@@ -699,6 +699,10 @@ int merge_submodule(unsigned char result[20], const char *path,
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
index 5350b0d..d4344c8 100644
--- a/submodule.h
+++ b/submodule.h
@@ -28,6 +28,6 @@ int fetch_populated_submodules(int num_options, const char **options,
 			       int quiet);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
-		    const unsigned char a[20], const unsigned char b[20]);
+		    const unsigned char a[20], const unsigned char b[20], int search);
 
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
1.7.4.4
