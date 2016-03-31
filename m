From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v3 3/4] format-patch: introduce --base=auto option
Date: Thu, 31 Mar 2016 09:46:15 +0800
Message-ID: <1459388776-18066-4-git-send-email-xiaolong.ye@intel.com>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 03:48:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alRig-0004YJ-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 03:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbcCaBsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 21:48:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:36728 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbcCaBsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 21:48:09 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP; 30 Mar 2016 18:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,419,1455004800"; 
   d="scan'208";a="76271090"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2016 18:48:08 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290367>

Introduce --base=auto to record the base commit info automatically, the base_commit
will be the merge base of tip commit of the upstream branch and revision-range
specified in cmdline.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 31 +++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 067d562..d8fe651 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -290,6 +290,10 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 	patches for A, B and C, and the identifiers for P, X, Y, Z are appended
 	at the end of the _first_ message.
 
+	If set '--base=auto' in cmdline, it will track base commit automatically,
+	the base commit will be the merge base of tip commit of the remote-tracking
+	branch and revision-range specified in cmdline.
+
 --root::
 	Treat the revision argument as a <revision range>, even if it
 	is just a single commit (that would normally be treated as a
diff --git a/builtin/log.c b/builtin/log.c
index 03cbab0..c5efe73 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1200,6 +1200,9 @@ static void prepare_bases(struct base_tree_info *bases,
 	struct rev_info revs;
 	struct diff_options diffopt;
 	struct object_id *patch_id;
+	struct branch *curr_branch;
+	struct commit_list *base_list;
+	const char *upstream;
 	unsigned char sha1[20];
 	int i;
 
@@ -1207,10 +1210,30 @@ static void prepare_bases(struct base_tree_info *bases,
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
+			if (!bases)
+				die(_("Could not find merge base."));
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
-- 
2.8.0.4.gcb5a9af
