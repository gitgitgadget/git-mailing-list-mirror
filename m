From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v3 4/4] format-patch: introduce format.base configuration
Date: Thu, 31 Mar 2016 09:46:16 +0800
Message-ID: <1459388776-18066-5-git-send-email-xiaolong.ye@intel.com>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 03:48:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alRih-0004YJ-E1
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 03:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbcCaBsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 21:48:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:36728 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbcCaBsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 21:48:12 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP; 30 Mar 2016 18:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,419,1455004800"; 
   d="scan'208";a="76271102"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2016 18:48:11 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290368>

We can set format.base=auto to record the base commit info automatically,
it is equivalent to set --base=auto in cmdline.

The format.base has lower priority than command line option, so if user
set format.base=auto and pass the command line option in the meantime,
base_commit will be the one passed to command line option.

Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 Documentation/git-format-patch.txt |  2 ++
 builtin/log.c                      | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index d8fe651..10149ab 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -293,6 +293,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 	If set '--base=auto' in cmdline, it will track base commit automatically,
 	the base commit will be the merge base of tip commit of the remote-tracking
 	branch and revision-range specified in cmdline.
+	If 'format.base=auto' is set in configuration file, it is equivalent
+	to set '--base=auto' in cmdline.
 
 --root::
 	Treat the revision argument as a <revision range>, even if it
diff --git a/builtin/log.c b/builtin/log.c
index c5efe73..821a778 100644
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
@@ -1210,7 +1217,12 @@ static void prepare_bases(struct base_tree_info *bases,
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
@@ -1228,11 +1240,6 @@ static void prepare_bases(struct base_tree_info *bases,
 			      "please use git branch --set-upstream-to to track a remote branch.\n"
 			      "Or you could specify base commit by --base=<base-commit-id> manually."));
 		}
-	} else {
-		base = lookup_commit_reference_by_name(base_commit);
-		if (!base)
-			die(_("Unknown commit %s"), base_commit);
-		oidcpy(&bases->base_commit, &base->object.oid);
 	}
 
 	init_revisions(&revs, NULL);
@@ -1611,7 +1618,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		signature = strbuf_detach(&buf, NULL);
 	}
 
-	if (base_commit) {
+	if (base_commit || config_base_commit) {
 		memset(&bases, 0, sizeof(bases));
 		reset_revision_walk();
 		prepare_bases(&bases, base_commit, list, nr);
-- 
2.8.0.4.gcb5a9af
