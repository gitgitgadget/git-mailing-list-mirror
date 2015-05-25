From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 40/56] shallow: rewrite functions to take object_id arguments
Date: Mon, 25 May 2015 18:39:06 +0000
Message-ID: <1432579162-411464-41-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIr-00013c-WD
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbbEYSkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:40 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50724 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751472AbbEYSk2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:28 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D6A2E28099;
	Mon, 25 May 2015 18:40:26 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269860>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 shallow.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/shallow.c b/shallow.c
index 9488edc..257d811 100644
--- a/shallow.c
+++ b/shallow.c
@@ -475,11 +475,10 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	free(tmp);
 }
 
-static int mark_uninteresting(const char *refname,
-			      const unsigned char *sha1,
+static int mark_uninteresting(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	struct commit *commit = lookup_commit_reference_gently(oid->hash, 1);
 	if (!commit)
 		return 0;
 	commit->object.flags |= UNINTERESTING;
@@ -512,8 +511,6 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	unsigned int i, nr;
 	int *shallow, nr_shallow = 0;
 	struct paint_info pi;
-	struct each_ref_fn_sha1_adapter wrapped_mark_uninteresting =
-		{mark_uninteresting, NULL};
 
 	trace_printf_key(&trace_shallow, "shallow: assign_shallow_commits_to_refs\n");
 	shallow = xmalloc(sizeof(*shallow) * (info->nr_ours + info->nr_theirs));
@@ -544,8 +541,8 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	 * connect to old refs. If not (e.g. force ref updates) it'll
 	 * have to go down to the current shallow commits.
 	 */
-	head_ref(each_ref_fn_adapter, &wrapped_mark_uninteresting);
-	for_each_ref(each_ref_fn_adapter, &wrapped_mark_uninteresting);
+	head_ref(mark_uninteresting, NULL);
+	for_each_ref(mark_uninteresting, NULL);
 
 	/* Mark potential bottoms so we won't go out of bound */
 	for (i = 0; i < nr_shallow; i++) {
@@ -586,12 +583,12 @@ struct commit_array {
 	int nr, alloc;
 };
 
-static int add_ref(const char *refname,
-		   const unsigned char *sha1, int flags, void *cb_data)
+static int add_ref(const char *refname, const struct object_id *oid,
+		   int flags, void *cb_data)
 {
 	struct commit_array *ca = cb_data;
 	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
-	ca->commits[ca->nr] = lookup_commit_reference_gently(sha1, 1);
+	ca->commits[ca->nr] = lookup_commit_reference_gently(oid->hash, 1);
 	if (ca->commits[ca->nr])
 		ca->nr++;
 	return 0;
@@ -620,8 +617,6 @@ static void post_assign_shallow(struct shallow_info *info,
 	int dst, i, j;
 	int bitmap_nr = (info->ref->nr + 31) / 32;
 	struct commit_array ca;
-	struct each_ref_fn_sha1_adapter wrapped_add_ref =
-		{add_ref, &ca};
 
 	trace_printf_key(&trace_shallow, "shallow: post_assign_shallow\n");
 	if (ref_status)
@@ -645,8 +640,8 @@ static void post_assign_shallow(struct shallow_info *info,
 	info->nr_theirs = dst;
 
 	memset(&ca, 0, sizeof(ca));
-	head_ref(each_ref_fn_adapter, &wrapped_add_ref);
-	for_each_ref(each_ref_fn_adapter, &wrapped_add_ref);
+	head_ref(add_ref, &ca);
+	for_each_ref(add_ref, &ca);
 
 	/* Remove unreachable shallow commits from "ours" */
 	for (i = dst = 0; i < info->nr_ours; i++) {
@@ -678,12 +673,10 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 
 		if (!si->commits) {
 			struct commit_array ca;
-			struct each_ref_fn_sha1_adapter wrapped_add_ref =
-				{add_ref, &ca};
 
 			memset(&ca, 0, sizeof(ca));
-			head_ref(each_ref_fn_adapter, &wrapped_add_ref);
-			for_each_ref(each_ref_fn_adapter, &wrapped_add_ref);
+			head_ref(add_ref, &ca);
+			for_each_ref(add_ref, &ca);
 			si->commits = ca.commits;
 			si->nr_commits = ca.nr;
 		}
-- 
2.4.0
