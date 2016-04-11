From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v4 3/4] format-patch: introduce --base=auto option
Date: Mon, 11 Apr 2016 10:47:52 +0800
Message-ID: <1460342873-28900-4-git-send-email-xiaolong.ye@intel.com>
References: <1460342873-28900-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 04:49:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apRuq-0004Py-16
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 04:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbcDKCtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 22:49:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:9937 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbcDKCtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 22:49:22 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP; 10 Apr 2016 19:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,462,1455004800"; 
   d="scan'208";a="955872823"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2016 19:48:57 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1460342873-28900-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291202>

Introduce --base=auto to record the base commit info automatically, the
base_commit will be the merge base of tip commit of the upstream branch
and revision-range specified in cmdline.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 32 ++++++++++++++++++++++++++++----
 t/t4014-format-patch.sh            | 14 ++++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 2a4c293..8283eea 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -577,6 +577,10 @@ The submitter could also use `git format-patch --base=P -3 C` to generate
 patches for A, B and C, and the identifiers for P, X, Y, Z are appended
 at the end of the _first_ message.
 
+If set `--base=auto` in cmdline, it will track base commit automatically,
+the base commit will be the merge base of tip commit of the remote-tracking
+branch and revision-range specified in cmdline.
+
 EXAMPLES
 --------
 
diff --git a/builtin/log.c b/builtin/log.c
index 73bc36d..510a427 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1205,6 +1205,9 @@ static void prepare_bases(struct base_tree_info *bases,
 	struct commit *base = NULL, *commit;
 	struct rev_info revs;
 	struct diff_options diffopt;
+	struct branch *curr_branch;
+	struct commit_list *base_list;
+	const char *upstream;
 	unsigned char sha1[20];
 	int i;
 
@@ -1212,10 +1215,31 @@ static void prepare_bases(struct base_tree_info *bases,
 	DIFF_OPT_SET(&diffopt, RECURSIVE);
 	diff_setup_done(&diffopt);
 
-	base = lookup_commit_reference_by_name(base_commit);
-	if (!base)
-		die(_("Unknown commit %s"), base_commit);
-	oidcpy(&bases->base_commit, &base->object.oid);
+	if (!strcmp(base_commit, "auto")) {
+		curr_branch = branch_get(NULL);
+		upstream = branch_get_upstream(curr_branch, NULL);
+		if (upstream) {
+			if (get_sha1(upstream, sha1))
+				die(_("Failed to resolve '%s' as a valid ref."), upstream);
+			commit = lookup_commit_or_die(sha1, "upstream base");
+			base_list = get_merge_bases_many(commit, total, list);
+			/* There should be one and only one merge base. */
+			if (!base_list || base_list->next)
+				die(_("Could not find exact merge base."));
+			base = base_list->item;
+			free_commit_list(base_list);
+			oidcpy(&bases->base_commit, &base->object.oid);
+		} else {
+			die(_("Failed to get upstream, if you want to record base commit automatically,\n"
+			      "please use git branch --set-upstream-to to track a remote branch.\n"
+			      "Or you could specify base commit by --base=<base-commit-id> manually."));
+		}
+	} else {
+		base = lookup_commit_reference_by_name(base_commit);
+		if (!base)
+			die(_("Unknown commit %s"), base_commit);
+		oidcpy(&bases->base_commit, &base->object.oid);
+	}
 
 	init_revisions(&revs, NULL);
 	revs.max_parents = 1;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index a6ce727..4603915 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1475,4 +1475,18 @@ test_expect_success 'format-patch --base error handling' '
 	! git format-patch --base=HEAD~ -3
 '
 
+test_expect_success 'format-patch --base=auto' '
+	git checkout -b new master &&
+	git branch --set-upstream-to=master &&
+	echo "A" >>file &&
+	git add file &&
+	git commit -m "New change #A" &&
+	echo "B" >>file &&
+	git add file &&
+	git commit -m "New change #B" &&
+	git format-patch --stdout --base=auto -2 >patch &&
+	grep -e "^base-commit:" patch >actual &&
+	echo "base-commit: $(git rev-parse master)" >expected &&
+	test_cmp expected actual
+'
 test_done
-- 
2.8.1.120.g24d6b3f
