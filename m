From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 16/19] pull: configure --rebase via branch.<name>.rebase or pull.rebase
Date: Sun, 14 Jun 2015 16:42:03 +0800
Message-ID: <1434271326-11349-17-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:43:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43WC-0006gG-DL
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbbFNInp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:45 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33410 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbbFNInP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:43:15 -0400
Received: by pdjn11 with SMTP id n11so51433067pdj.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=McWuXzx7Ngcm1UZgBWTeIs11QBQFnnQonmmjqCoMyqs=;
        b=H4oTZ5VqzSv/EV7K2Q+L1qMsL0QSVrDzYfJDPwVNZNYR/HuQoO5IW1vqmrBdQ9smci
         tVRqFFfIkDTAg1U+MMrWb+rKktSPERL4Svr4b9U+Lbhh6veUL+VnQEq01D5tJm2GXatX
         NfV1EFlPyHW2Gessx+ohy4hM6jsoAzh2P5I538mA0+sRCEVvx6QahkfynC3hh7/WUtHf
         uNivdXtYtFVJL7m85pecD/E4F2HSHFs5Etlzh+zHJsChoII9jNHCHSdYPrV4bC3DuV5i
         N9dhCykoz/2WQCPbCy51X+Y/LflCx+YXV2gTWlRHLPmyoW3GKBmuJzfVvboXWlwh/h0Y
         wqGg==
X-Received: by 10.66.136.78 with SMTP id py14mr15015601pab.1.1434271394807;
        Sun, 14 Jun 2015 01:43:14 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.43.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:43:13 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271630>

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

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v3
    
    * Now that parse_config_rebase() takes care of the die()-ing and
      error()-ing, we only need one function again. Yay!
    
    * The free()s is ugly though. Ideally, I would like to have a xstrfmt()
      function that returns a static buffer.
    
    * We now don't lookup the pull.rebase config if the --rebase option is
      provided on the command-line.

 builtin/pull.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 8915947..e4098d0 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -72,7 +72,7 @@ static int opt_verbosity;
 static char *opt_progress;
 
 /* Options passed to git-merge or git-rebase */
-static enum rebase_type opt_rebase;
+static enum rebase_type opt_rebase = -1;
 static char *opt_diffstat;
 static char *opt_log;
 static char *opt_squash;
@@ -266,6 +266,35 @@ static const char *config_get_ff(void)
 }
 
 /**
+ * Returns the default configured value for --rebase. It first looks for the
+ * value of "branch.$curr_branch.rebase", where $curr_branch is the current
+ * branch, and if HEAD is detached or the configuration key does not exist,
+ * looks for the value of "pull.rebase". If both configuration keys do not
+ * exist, returns REBASE_FALSE.
+ */
+static enum rebase_type config_get_rebase(void)
+{
+	struct branch *curr_branch = branch_get("HEAD");
+	const char *value;
+
+	if (curr_branch) {
+		char *key = xstrfmt("branch.%s.rebase", curr_branch->name);
+
+		if (!git_config_get_value(key, &value)) {
+			free(key);
+			return parse_config_rebase(key, value, 1);
+		}
+
+		free(key);
+	}
+
+	if (!git_config_get_value("pull.rebase", &value))
+		return parse_config_rebase("pull.rebase", value, 1);
+
+	return REBASE_FALSE;
+}
+
+/**
  * Appends merge candidates from FETCH_HEAD that are not marked not-for-merge
  * into merge_heads.
  */
@@ -707,6 +736,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
+	if (opt_rebase < 0)
+		opt_rebase = config_get_rebase();
+
 	git_config(git_default_config, NULL);
 
 	if (read_cache_unmerged())
-- 
2.1.4
