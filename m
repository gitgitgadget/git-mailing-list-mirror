From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v6 3/4] format-patch: introduce --base=auto option
Date: Tue, 26 Apr 2016 15:51:23 +0800
Message-ID: <1461657084-9223-4-git-send-email-xiaolong.ye@intel.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 09:52:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auxna-0007zh-TL
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 09:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbcDZHwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 03:52:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:45363 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbcDZHwl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 03:52:41 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 26 Apr 2016 00:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,536,1455004800"; 
   d="scan'208";a="962812077"
Received: from yexl-desktop.sh.intel.com ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2016 00:52:39 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292595>

Introduce --base=auto to record the base commit info automatically, the
base_commit will be the merge base of tip commit of the upstream branch
and revision-range specified in cmdline.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 Documentation/git-format-patch.txt |  6 ++++++
 builtin/log.c                      | 30 ++++++++++++++++++++++++++---
 t/t4014-format-patch.sh            | 39 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 3 deletions(-)

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
index ee332ab..db27135 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1205,9 +1205,33 @@ static struct commit *get_base_commit(const char *base_commit,
 	struct commit **rev;
 	int i = 0, rev_nr = 0;
 
-	base = lookup_commit_reference_by_name(base_commit);
-	if (!base)
-		die(_("Unknown commit %s"), base_commit);
+	if (!strcmp(base_commit, "auto")) {
+		struct branch *curr_branch = branch_get(NULL);
+		const char *upstream = branch_get_upstream(curr_branch, NULL);
+		if (upstream) {
+			struct commit_list *base_list;
+			struct commit *commit;
+			unsigned char sha1[20];
+
+			if (get_sha1(upstream, sha1))
+				die(_("Failed to resolve '%s' as a valid ref."), upstream);
+			commit = lookup_commit_or_die(sha1, "upstream base");
+			base_list = get_merge_bases_many(commit, total, list);
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
index 5dcf24f..8102158 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1507,4 +1507,43 @@ test_expect_success 'format-patch --base errors out when base commit is not ance
 	test_cmp expected actual
 '
 
+test_expect_success 'format-patch --base=auto' '
+	git checkout -b upstream master &&
+	git checkout -b local upstream &&
+	git branch --set-upstream-to=upstream &&
+	test_commit N1 &&
+	test_commit N2 &&
+	git format-patch --stdout --base=auto -2 >patch &&
+	grep "^base-commit:" patch >actual &&
+	echo "base-commit: $(git rev-parse upstream)" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'format-patch errors out when history involves criss-cross' '
+	# setup criss-cross history
+	#
+	#   B---M1---D
+	#  / \ /
+	# A   X
+	#  \ / \
+	#   C---M2---E
+	#
+	git checkout master &&
+	test_commit A &&
+	git checkout -b xb master &&
+	test_commit B &&
+	git checkout -b xc master &&
+	test_commit C &&
+	git checkout -b xbc xb -- &&
+	git merge xc &&
+	git checkout -b xcb xc -- &&
+	git branch --set-upstream-to=xbc &&
+	git merge xb &&
+	git checkout xbc &&
+	test_commit D &&
+	git checkout xcb &&
+	test_commit E &&
+	test_must_fail 	git format-patch --base=auto -1
+'
+
 test_done
-- 
2.8.1.343.gda643e5
