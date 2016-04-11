From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v4 4/4] format-patch: introduce format.base configuration
Date: Mon, 11 Apr 2016 10:47:53 +0800
Message-ID: <1460342873-28900-5-git-send-email-xiaolong.ye@intel.com>
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
	id 1apRuq-0004Py-Jj
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 04:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbcDKCtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 22:49:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:9937 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbcDKCtX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 22:49:23 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP; 10 Apr 2016 19:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,462,1455004800"; 
   d="scan'208";a="955872831"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2016 19:48:59 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1460342873-28900-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291201>

We can set format.base=auto to record the base commit info automatically,
it is equivalent to set --base=auto in cmdline.

The format.base has lower priority than command line option, so if user
set format.base=auto and pass the command line option in the meantime,
base_commit will be the one passed to command line option.

Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 21 ++++++++++++++-------
 t/t4014-format-patch.sh            | 19 +++++++++++++++++++
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 8283eea..738121d 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -581,6 +581,10 @@ If set `--base=auto` in cmdline, it will track base commit automatically,
 the base commit will be the merge base of tip commit of the remote-tracking
 branch and revision-range specified in cmdline.
 
+If 'format.base=auto' is set in configuration file, it is equivalent
+to set '--base=auto' in cmdline.
+
+
 EXAMPLES
 --------
 
diff --git a/builtin/log.c b/builtin/log.c
index 510a427..489434a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -705,6 +705,7 @@ static int do_signoff;
 static const char *signature = git_version_string;
 static const char *signature_file;
 static int config_cover_letter;
+static int config_base_commit;
 static const char *config_output_directory;
 
 enum {
@@ -786,6 +787,12 @@ static int git_format_config(const char *var, const char *value, void *cb)
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
@@ -1215,7 +1222,12 @@ static void prepare_bases(struct base_tree_info *bases,
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
@@ -1234,11 +1246,6 @@ static void prepare_bases(struct base_tree_info *bases,
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
@@ -1622,7 +1629,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 
 	memset(&bases, 0, sizeof(bases));
-	if (base_commit) {
+	if (base_commit || config_base_commit) {
 		reset_revision_walk();
 		prepare_bases(&bases, base_commit, list, nr);
 	}
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 4603915..6005b7c 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1489,4 +1489,23 @@ test_expect_success 'format-patch --base=auto' '
 	echo "base-commit: $(git rev-parse master)" >expected &&
 	test_cmp expected actual
 '
+
+test_expect_success 'format-patch format.base option' '
+	test_when_finished "git config --unset format.base" &&
+	git config format.base auto &&
+	git format-patch --stdout -1 >patch &&
+	grep -e "^base-commit:" patch >actual &&
+	echo "base-commit: $(git rev-parse master)" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'format-patch --base overrides format.base' '
+	test_when_finished "git config --unset format.base" &&
+	git config format.base auto &&
+	git format-patch --stdout --base=HEAD~ -1 >patch &&
+	grep -e "^base-commit:" patch >actual &&
+	echo "base-commit: $(git rev-parse HEAD~)" >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.8.1.120.g24d6b3f
