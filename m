From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v2 4/4] format-patch: introduce format.base configuration
Date: Wed, 23 Mar 2016 16:52:27 +0800
Message-ID: <1458723147-7335-5-git-send-email-xiaolong.ye@intel.com>
References: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 09:53:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aieXs-0006wi-8M
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 09:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbcCWIx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 04:53:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:13327 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194AbcCWIxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 04:53:25 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP; 23 Mar 2016 01:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,381,1455004800"; 
   d="scan'208";a="939795373"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2016 01:53:22 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289607>

We can set format.base=auto to record the base commit info automatically,
it is equivalent to set --base=auto in cmdline.

The format.base has lower priority than command line option, so if user
set format.base=auto and pass the command line option in the meantime,
base_commit will be the one passed to command line option.

Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 Documentation/git-format-patch.txt |  5 +++++
 builtin/log.c                      | 21 ++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index a5f145e..7c7a61a 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -279,6 +279,11 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 	"Z..C" instead of "-3 C" to specify the range), and the identifiers
 	for P, X, Y, Z are appended at the end of the _first_ message (either
 	the cover letter or the first patch in the series).
+	If 'format.base=auto' is set in configuration file, it is equivalent
+	to set '--base=auto' in cmdline, it will track the base commit
+	automatically, the base commit will be the tip commit of upstream
+	branch, if upstream branch cannot be determined, it will just record
+	the parent's commit id and patch id.
 
 --root::
 	Treat the revision argument as a <revision range>, even if it
diff --git a/builtin/log.c b/builtin/log.c
index e8a3964..fc468ce 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -699,6 +699,7 @@ static int do_signoff;
 static const char *signature = git_version_string;
 static const char *signature_file;
 static int config_cover_letter;
+static int config_base_commit;
 static const char *config_output_directory;
 
 enum {
@@ -780,6 +781,12 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.outputdirectory"))
 		return git_config_string(&config_output_directory, var, value);
+	if (!strcmp(var, "format.base")){
+		if (value && !strcasecmp(value, "auto")) {
+			config_base_commit = 1;
+			return 0;
+		}
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1213,7 +1220,12 @@ static void prepare_bases(struct base_tree_info *bases,
 	DIFF_OPT_SET(&diffopt, RECURSIVE);
 	diff_setup_done(&diffopt);
 
-	if (!strcmp(base_commit, "auto")) {
+	if (base_commit && strcmp(base_commit, "auto")) {
+		base = lookup_commit_reference_by_name(base_commit);
+		if (!base)
+			die(_("Unknown commit %s"), base_commit);
+		oidcpy(&bases->base_commit, &base->object.oid);
+	} else if ((base_commit && !strcmp(base_commit, "auto")) || config_base_commit) {
 		curr_branch = branch_get(NULL);
 		upstream = branch_get_upstream(curr_branch, NULL);
 		if (upstream) {
@@ -1227,11 +1239,6 @@ static void prepare_bases(struct base_tree_info *bases,
 			hashcpy(bases->parent_patch_id.hash, sha1);
 			return;
 		}
-	} else {
-		base = lookup_commit_reference_by_name(base_commit);
-		if (!base)
-			die(_("Unknown commit %s"), base_commit);
-		oidcpy(&bases->base_commit, &base->object.oid);
 	}
 
 	if (base == prerequisite_head)
@@ -1626,7 +1633,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		signature = strbuf_detach(&buf, NULL);
 	}
 
-	if (base_commit) {
+	if (base_commit || config_base_commit) {
 		struct commit *prerequisite_head = NULL;
 		if (list[nr - 1]->parents)
 			prerequisite_head = list[nr - 1]->parents->item;
-- 
2.8.0.rc4.4.ga41a987
