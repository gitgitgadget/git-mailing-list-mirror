From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v5 3/4] format-patch: introduce --base=auto option
Date: Fri, 22 Apr 2016 13:42:35 +0800
Message-ID: <1461303756-25975-4-git-send-email-xiaolong.ye@intel.com>
References: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 07:44:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atTt0-0001Zw-RG
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 07:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbcDVFoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 01:44:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:18374 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbcDVFoA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 01:44:00 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 21 Apr 2016 22:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,516,1455004800"; 
   d="scan'208";a="950498177"
Received: from yexl-desktop.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2016 22:43:56 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292171>

Introduce --base=auto to record the base commit info automatically, the
base_commit will be the merge base of tip commit of the upstream branch
and revision-range specified in cmdline.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 Documentation/git-format-patch.txt |  6 ++++++
 builtin/log.c                      | 27 ++++++++++++++++++++++++---
 t/t4014-format-patch.sh            | 15 +++++++++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1d790f1..bdeecd5 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -575,6 +575,12 @@ You can also use `git format-patch --base=P -3 C` to generate patches
 for A, B and C, and the identifiers for P, X, Y, Z are appended at the
 end of the first message.
 
+If set `--base=auto` in cmdline, it will track base commit automatically,
+the base commit will be the merge base of tip commit of the remote-tracking
+branch and revision-range specified in cmdline.
+For a local branch, you need to track a remote branch by `git branch
+--set-upstream-to` before using this option.
+
 EXAMPLES
 --------
 
diff --git a/builtin/log.c b/builtin/log.c
index ee332ab..7851d20 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1205,9 +1205,30 @@ static struct commit *get_base_commit(const char *base_commit,
 	struct commit **rev;
 	int i = 0, rev_nr = 0;
 
-	base = lookup_commit_reference_by_name(base_commit);
-	if (!base)
-		die(_("Unknown commit %s"), base_commit);
+	if (!strcmp(base_commit, "auto")) {
+		struct branch *curr_branch = branch_get(NULL);
+		const char *upstream = branch_get_upstream(curr_branch, NULL);
+		if (upstream) {
+			unsigned char sha1[20];
+			if (get_sha1(upstream, sha1))
+				die(_("Failed to resolve '%s' as a valid ref."), upstream);
+			struct commit *commit = lookup_commit_or_die(sha1, "upstream base");
+			struct commit_list *base_list = get_merge_bases_many(commit, total, list);
+			/* There should be one and only one merge base. */
+			if (!base_list || base_list->next)
+				die(_("Could not find exact merge base."));
+			base = base_list->item;
+			free_commit_list(base_list);
+		} else {
+			die(_("Failed to get upstream, if you want to record base commit automatically,\n"
+			      "please use git branch --set-upstream-to to track a remote branch.\n"
+			      "Or you could specify base commit by --base=<base-commit-id> manually."));
+		}
+	} else {
+		base = lookup_commit_reference_by_name(base_commit);
+		if (!base)
+			die(_("Unknown commit %s"), base_commit);
+	}
 
 	ALLOC_ARRAY(rev, total);
 	for (i = 0; i < total; i++)
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index a6ce727..afcf8b8 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1475,4 +1475,19 @@ test_expect_success 'format-patch --base error handling' '
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
+
 test_done
-- 
2.8.1.221.ga4c6ba7
