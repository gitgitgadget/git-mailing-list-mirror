From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v2 3/4] format-patch: introduce --base=auto option
Date: Wed, 23 Mar 2016 16:52:26 +0800
Message-ID: <1458723147-7335-4-git-send-email-xiaolong.ye@intel.com>
References: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 09:53:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aieXg-0006rI-QK
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 09:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbcCWIxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 04:53:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:13327 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343AbcCWIxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 04:53:21 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP; 23 Mar 2016 01:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,381,1455004800"; 
   d="scan'208";a="939795355"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2016 01:53:19 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289606>

Introduce --base=auto to record the base commit info automatically, the base_commit
will be the tip commit of the upstream branch. If upstream branch cannot be determined,
it will just record the parent's commit id and patch id.

Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 builtin/log.c | 70 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d3804b3..e8a3964 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1187,6 +1187,8 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
 
 struct base_tree_info {
 	struct object_id base_commit;
+	struct object_id parent_commit;
+	struct object_id parent_patch_id;
 	int nr_patch_id, alloc_patch_id;
 	struct object_id *patch_id;
 };
@@ -1199,15 +1201,38 @@ static void prepare_bases(struct base_tree_info *bases,
 	struct rev_info revs;
 	struct diff_options diffopt;
 	struct object_id *patch_id;
+	struct branch *curr_branch;
+	const char *upstream;
 	unsigned char sha1[20];
 	int pos = 0;
 
 	if (!prerequisite_head)
 		return;
-	base = lookup_commit_reference_by_name(base_commit);
-	if (!base)
-		die(_("Unknown commit %s"), base_commit);
-	oidcpy(&bases->base_commit, &base->object.oid);
+
+	diff_setup(&diffopt);
+	DIFF_OPT_SET(&diffopt, RECURSIVE);
+	diff_setup_done(&diffopt);
+
+	if (!strcmp(base_commit, "auto")) {
+		curr_branch = branch_get(NULL);
+		upstream = branch_get_upstream(curr_branch, NULL);
+		if (upstream) {
+			if (get_sha1(upstream, sha1))
+				die(_("Failed to resolve '%s' as a valid ref."), upstream);
+			base = lookup_commit_or_die(sha1, "upstream base");
+			oidcpy(&bases->base_commit, &base->object.oid);
+		} else {
+			commit_patch_id(prerequisite_head, &diffopt, sha1);
+			oidcpy(&bases->parent_commit, &prerequisite_head->object.oid);
+			hashcpy(bases->parent_patch_id.hash, sha1);
+			return;
+		}
+	} else {
+		base = lookup_commit_reference_by_name(base_commit);
+		if (!base)
+			die(_("Unknown commit %s"), base_commit);
+		oidcpy(&bases->base_commit, &base->object.oid);
+	}
 
 	if (base == prerequisite_head)
 		return;
@@ -1223,10 +1248,6 @@ static void prepare_bases(struct base_tree_info *bases,
 	prerequisite_head->object.flags |= 0;
 	add_pending_object(&revs, &prerequisite_head->object, "prerequisite-head");
 
-	diff_setup(&diffopt);
-	DIFF_OPT_SET(&diffopt, RECURSIVE);
-	diff_setup_done(&diffopt);
-
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 	/*
@@ -1249,22 +1270,33 @@ static void print_bases(struct base_tree_info *bases)
 	int i;
 
 	/* Only do this once, either for the cover or for the first one */
-	if (is_null_oid(&bases->base_commit))
+	if (is_null_oid(&bases->base_commit) && is_null_oid(&bases->parent_commit))
 		return;
 
-	printf("** base-commit-info **\n");
+	if (!is_null_oid(&bases->base_commit)) {
+		printf("** base-commit-info **\n");
+
+		/* Show the base commit */
+		printf("base-commit: %s\n", oid_to_hex(&bases->base_commit));
 
-	/* Show the base commit */
-	printf("base-commit: %s\n", oid_to_hex(&bases->base_commit));
+		/* Show the prerequisite patches */
+		for (i = 0; i < bases->nr_patch_id; i++)
+			printf("prerequisite-patch-id: %s\n", oid_to_hex(&bases->patch_id[i]));
 
-	/* Show the prerequisite patches */
-	for (i = 0; i < bases->nr_patch_id; i++)
-		printf("prerequisite-patch-id: %s\n", oid_to_hex(&bases->patch_id[i]));
+		free(bases->patch_id);
+		bases->nr_patch_id = 0;
+		bases->alloc_patch_id = 0;
+		oidclr(&bases->base_commit);
+	} else if (!is_null_oid(&bases->parent_commit)) {
+		printf("** parent-commit-info **\n");
 
-	free(bases->patch_id);
-	bases->nr_patch_id = 0;
-	bases->alloc_patch_id = 0;
-	oidclr(&bases->base_commit);
+		/* Show the parent commit */
+		printf("parent-commit: %s\n", oid_to_hex(&bases->parent_commit));
+		/* Show the parent patch id */
+		printf("parent-patch-id: %s\n", oid_to_hex(&bases->parent_patch_id));
+
+		oidclr(&bases->parent_commit);
+	}
 }
 
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
-- 
2.8.0.rc4.4.ga41a987
