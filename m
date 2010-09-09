From: Thomas Rast <trast@student.ethz.ch>
Subject: [Alt. PATCH] format-patch: do not use diff UI config
Date: Thu, 9 Sep 2010 10:36:54 +0200
Message-ID: <2a6b8c51903fd6a22606b8f592b1a2e11ea68741.1284020917.git.trast@student.ethz.ch>
References: <1284019625-14096-1-git-send-email-ods15@ods15.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>, <git@vger.kernel.org>
To: Oded Shimon <ods15@ods15.dyndns.org>
X-From: git-owner@vger.kernel.org Thu Sep 09 10:37:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otccx-0007T7-7Y
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 10:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab0IIIg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 04:36:58 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:5045 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab0IIIg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 04:36:56 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 9 Sep
 2010 10:36:54 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 9 Sep
 2010 10:36:54 +0200
X-Mailer: git-send-email 1.7.3.rc0.289.gcd076
In-Reply-To: <1284019625-14096-1-git-send-email-ods15@ods15.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155851>

format-patch read and used the diff UI config, such as diff.renames,
diff.noprefix and diff.mnemnoicprefix.  These have a history of
breaking rebase and patch application in general; cf. 840b3ca (rebase:
protect against diff.renames configuration, 2008-11-10).

Instead of continually putting more options inside git-rebase to avoid
these issues, this patch takes the stance that output from
format-patch is intended primarily for git-am and only as a side
effect also for human consumption.  Hence, ignore the diff UI config
entirely when coming from format-patch.

Note that all existing calls to git_log_config except for the one in
git_format_config use a NULL callback.

Reported-by: Oded Shimon <ods15@ods15.dyndns.org>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is a bolder approach that just outright ignores the backwards
compatibility complaints Junio had in 840b3ca.  Among the variables
parsed in git_diff_ui_config, namely

  color.diff (and its legacy alias diff.color)
  diff.renames
  diff.autorefreshindex
  diff.mnemonicprefix
  diff.noprefix
  diff.external
  diff.wordregex
  diff.ignoresubmodules

arguably only diff.renames (and perhaps diff.ignoresubmodules, I don't
use them) should affect format-patch.  Everything else undermines the
guarantee (by having a consistent format) that format-patch|am works.

So now I'm not so sure about diff.renames.  Perhaps it needs to be
retained, but that requires a special case since we cannot move it to
git_diff_basic_config() (which affects diff-* plumbing too).

In any case I also made a test.  If you decide to go for the original
patch, please feel free to "steal" it.



 builtin/log.c     |   20 ++++++++++++++++++--
 t/t3400-rebase.sh |    7 +++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f2d9d61..a1079fe 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -385,8 +385,19 @@ static int cmd_log_walk(struct rev_info *rev)
 	return diff_result_code(&rev->diffopt, 0);
 }
 
+struct log_config_cb_data
+{
+	/*
+	 * If no_diff_ui_config is set, we use diff_basic_config
+	 * instead, ignoring the plumbing-specific UI settings.
+	 */
+	int no_diff_ui_config;
+};
+
 static int git_log_config(const char *var, const char *value, void *cb)
 {
+	struct log_config_cb_data *cb_data = cb;
+
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
@@ -406,7 +417,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	if (!prefixcmp(var, "color.decorate."))
 		return parse_decorate_color_config(var, 15, value);
 
-	return git_diff_ui_config(var, value, cb);
+	if (!cb_data || !cb_data->no_diff_ui_config)
+		return git_diff_ui_config(var, value, cb);
+	else
+		return git_diff_basic_config(var, value, cb);
 }
 
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
@@ -1099,6 +1113,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	char *add_signoff = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	int use_patch_format = 0;
+	struct log_config_cb_data config_cb_data;
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
 			    "use [PATCH n/m] even with a single patch",
@@ -1160,7 +1175,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_hdr.strdup_strings = 1;
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
-	git_config(git_format_config, NULL);
+	config_cb_data.no_diff_ui_config = 1;
+	git_config(git_format_config, &config_cb_data);
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 349eebd..0e2fe71 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -144,6 +144,13 @@ test_expect_success 'rebase is not broken by diff.renames' '
 	GIT_TRACE=1 git rebase force-3way
 '
 
+test_expect_success 'rebase is not broken by diff.noprefix' '
+	git config diff.noprefix true &&
+	test_when_finished "git config --unset diff.noprefix" &&
+	git checkout -b noprefix side &&
+	GIT_TRACE=1 git rebase master
+'
+
 test_expect_success 'setup: recover' '
 	test_might_fail git rebase --abort &&
 	git reset --hard &&
-- 
1.7.3.rc0.289.gcd076
