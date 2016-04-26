From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v6 4/4] format-patch: introduce format.useAutoBase configuration
Date: Tue, 26 Apr 2016 15:51:24 +0800
Message-ID: <1461657084-9223-5-git-send-email-xiaolong.ye@intel.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 09:52:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auxnh-00082T-29
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 09:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbcDZHwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 03:52:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:45363 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbcDZHwo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 03:52:44 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 26 Apr 2016 00:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,536,1455004800"; 
   d="scan'208";a="962812093"
Received: from yexl-desktop.sh.intel.com ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2016 00:52:42 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292596>

This allows to record the base commit automatically, it is equivalent
to set --base=auto in cmdline.

The format.useAutoBase has lower priority than command line option,
so if user set format.useAutoBase and pass the command line option in
the meantime, base_commit will be the one passed to command line
option.

Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 Documentation/config.txt |  5 +++++
 builtin/log.c            | 17 +++++++++++------
 t/t4014-format-patch.sh  | 19 +++++++++++++++++++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..1fe2a85 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1259,6 +1259,11 @@ format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
 	current working directory.
 
+format.useAutoBase::
+	A boolean value which lets you enable the `--base=auto` option of
+	format-patch by default.
+
+
 filter.<driver>.clean::
 	The command which is used to convert the content of a worktree
 	file to a blob upon checkin.  See linkgit:gitattributes[5] for
diff --git a/builtin/log.c b/builtin/log.c
index db27135..099f4f7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -702,6 +702,7 @@ static void add_header(const char *value)
 #define THREAD_DEEP 2
 static int thread;
 static int do_signoff;
+static int base_auto;
 static const char *signature = git_version_string;
 static const char *signature_file;
 static int config_cover_letter;
@@ -786,6 +787,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.outputdirectory"))
 		return git_config_string(&config_output_directory, var, value);
+	if (!strcmp(var, "format.useautobase")) {
+		base_auto = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1205,7 +1210,11 @@ static struct commit *get_base_commit(const char *base_commit,
 	struct commit **rev;
 	int i = 0, rev_nr = 0;
 
-	if (!strcmp(base_commit, "auto")) {
+	if (base_commit && strcmp(base_commit, "auto")) {
+		base = lookup_commit_reference_by_name(base_commit);
+		if (!base)
+			die(_("Unknown commit %s"), base_commit);
+	} else if ((base_commit && !strcmp(base_commit, "auto")) || base_auto) {
 		struct branch *curr_branch = branch_get(NULL);
 		const char *upstream = branch_get_upstream(curr_branch, NULL);
 		if (upstream) {
@@ -1227,10 +1236,6 @@ static struct commit *get_base_commit(const char *base_commit,
 			      "please use git branch --set-upstream-to to track a remote branch.\n"
 			      "Or you could specify base commit by --base=<base-commit-id> manually."));
 		}
-	} else {
-		base = lookup_commit_reference_by_name(base_commit);
-		if (!base)
-			die(_("Unknown commit %s"), base_commit);
 	}
 
 	ALLOC_ARRAY(rev, total);
@@ -1669,7 +1674,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 
 	memset(&bases, 0, sizeof(bases));
-	if (base_commit) {
+	if (base_commit || base_auto) {
 		struct commit *base = get_base_commit(base_commit, list, nr);
 		reset_revision_walk();
 		prepare_bases(&bases, base, list, nr);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 8102158..8049cad 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1546,4 +1546,23 @@ test_expect_success 'format-patch errors out when history involves criss-cross'
 	test_must_fail 	git format-patch --base=auto -1
 '
 
+test_expect_success 'format-patch format.useAutoBaseoption' '
+	test_when_finished "git config --unset format.useAutoBase" &&
+	git checkout local &&
+	git config format.useAutoBase true &&
+	git format-patch --stdout -1 >patch &&
+	grep "^base-commit:" patch >actual &&
+	echo "base-commit: $(git rev-parse upstream)" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'format-patch --base overrides format.useAutoBase' '
+	test_when_finished "git config --unset format.useAutoBase" &&
+	git config format.useAutoBase true &&
+	git format-patch --stdout --base=HEAD~1 -1 >patch &&
+	grep "^base-commit:" patch >actual &&
+	echo "base-commit: $(git rev-parse HEAD~1)" >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.8.1.343.gda643e5
