From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 12/14] pull: configure --rebase via branch.<name>.rebase or pull.rebase
Date: Mon, 18 May 2015 23:06:09 +0800
Message-ID: <1431961571-20370-13-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:08:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMea-0004kO-Nd
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbbERPIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:08:14 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33119 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbbERPIG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:08:06 -0400
Received: by pdbqa5 with SMTP id qa5so153156402pdb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sMfeG6Ct8wQo2js5e+jY6vCv3ws7UzkNDv89t9lCCL8=;
        b=a4rlDc+R1kO+fFICh+tQqQRUhjMz50LISj7rD6Y8lWj4ptKHfRrJFfS2fIG/8q4X52
         rTkDCQmbiGohQ6y8PGBW/F9AHletV/8qAKcIIdbEi2hKEDx4xlqq4gklRZAFVyGeBIBX
         fPerhMGgvP5/00YWv43/ITIy+PcAHQR2wPb2WP4LJVkBTScRiWdhuToMzP/ULtLmLzEe
         l4xWuQ9ZDc52wmIiBlL+YjTiDAuE8GCNRiVgsetoFJnqCTVz3697M19KiT1Vu/nygExB
         Jqva6w9SLtApg4aygYky5Vl3HOyzHylL0DU1kre/aNZd7G2PzVuJ+S4yAwJp/gFYC+5F
         ON7A==
X-Received: by 10.70.45.16 with SMTP id i16mr45027296pdm.51.1431961684651;
        Mon, 18 May 2015 08:08:04 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.08.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:08:03 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269271>

Since cd67e4d (Teach 'git pull' about --rebase, 2007-11-28),
fetch+rebase could be set by default by defining the config variable
branch.<name>.rebase. This setting can be overriden on the command line
by --rebase and --no-rebase.

Since 6b37dff (pull: introduce a pull.rebase option to enable --rebase,
2011-11-06), git-pull --rebase can also be configured via the
pull.rebase configuration option.

Re-implement support for these two configuration settings by introducing
config_get_rebase() which is called before parse_options() to set the
default value of opt_rebase.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c  | 35 +++++++++++++++++++++++++++++++++++
 t/t5520-pull.sh | 12 ++++++------
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index f18a21c..a0958a7 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -294,6 +294,39 @@ static const char *config_get_ff(void)
 	die(_("Invalid value for pull.ff: %s"), value);
 }
 
+/**
+ * Returns the default configured value for --rebase. It first looks for the
+ * value of "branch.$curr_branch.rebase", where $curr_branch is the current
+ * branch, and if HEAD is detached or the configuration key does not exist,
+ * looks for the value of "pull.rebase". If both configuration keys do not
+ * exist, returns REBASE_FALSE.
+ */
+static int config_get_rebase(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct branch *curr_branch = branch_get("HEAD");
+	const char *key, *str;
+	int ret = -1, value;
+
+	if (curr_branch) {
+		strbuf_addf(&sb, "branch.%s.rebase", curr_branch->name);
+		key = sb.buf;
+		ret = git_config_get_value(sb.buf, &str);
+	}
+	if (ret) {
+		key = "pull.rebase";
+		ret = git_config_get_value(key, &str);
+	}
+	if (ret) {
+		strbuf_release(&sb);
+		return REBASE_FALSE;
+	}
+	if ((value = parse_config_rebase(str)) < 0)
+		die(_("Invalid value for %s: %s"), key, str);
+	strbuf_release(&sb);
+	return value;
+}
+
 struct known_remote {
 	struct known_remote *next;
 	struct remote *remote;
@@ -730,6 +763,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
+	opt_rebase = config_get_rebase();
+
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 3798b96..17254ee 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -234,7 +234,7 @@ test_expect_success '--rebase fails with multiple branches' '
 	test modified = "$(git show HEAD:file)"
 '
 
-test_expect_failure 'pull.rebase' '
+test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
@@ -242,7 +242,7 @@ test_expect_failure 'pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
-test_expect_failure 'branch.to-rebase.rebase' '
+test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
 	test_config branch.to-rebase.rebase true &&
 	git pull . copy &&
@@ -280,7 +280,7 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_failure 'pull.rebase=true flattens keep-merge' '
+test_expect_success 'pull.rebase=true flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
@@ -288,7 +288,7 @@ test_expect_failure 'pull.rebase=true flattens keep-merge' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_failure 'pull.rebase=1 is treated as true and flattens keep-merge' '
+test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase 1 &&
 	git pull . copy &&
@@ -296,7 +296,7 @@ test_expect_failure 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_failure 'pull.rebase=preserve rebases and merges keep-merge' '
+test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull . copy &&
@@ -304,7 +304,7 @@ test_expect_failure 'pull.rebase=preserve rebases and merges keep-merge' '
 	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
 '
 
-test_expect_failure 'pull.rebase=invalid fails' '
+test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
 	! git pull . copy
-- 
2.1.4
