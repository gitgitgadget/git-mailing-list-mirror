From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 16/19] pull: configure --rebase via branch.<name>.rebase or pull.rebase
Date: Wed,  3 Jun 2015 14:49:00 +0800
Message-ID: <1433314143-4478-17-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Vf-0004wj-SH
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbbFCGuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:39 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33506 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbbFCGud (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:33 -0400
Received: by pdbqa5 with SMTP id qa5so810956pdb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PZk1QXqStWNrLa69scNLRXuL7SWR22D2WYKcqc5fkwI=;
        b=hjUT/BBBNu02SJuyzKpwOLs4WvxzxdgayXKiOZK9gfIjvuCJh6tj/gb0zhdV+Tki0I
         MM6TvGlTkJbpYqCv5KlcN3sxlGrVpxEfWGjifWBYb2CyvriEp+Qu1gR/2Z+X4yRHE5/i
         P6xgqjUmET2gX89yo3MMgC4HE0DpA1Jd3y1OHEqAtj9WEd+VlsnzlO6MFGBsNS5YVRbZ
         a/DMRrZgTStdvM9LghxLn+NLDHT0vuqBc/j+UDZk4p4mPYwEfKIAxdukMh0ume5sl5XN
         CtLpB6lqzzUfJK4p7OgzIdStVFn4JnDNEooob9zdwg7Idno3VYWXyRpdJncOnXb9juSb
         BeWQ==
X-Received: by 10.66.124.195 with SMTP id mk3mr56624342pab.111.1433314232756;
        Tue, 02 Jun 2015 23:50:32 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:31 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270653>

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
    v2
    
    * Previously, config_get_rebase() attempted to do too many things. It:
    
      1. Checked if there was a configuration for
         branch.$curr_branch.rebase, and if not, then pull.rebase
    
      2. Parsed the configuration value and died if the value is invalid.
    
      These 2 functions have been split into config_get_rebase_default() and
      config_get_rebase() respectively.

 builtin/pull.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 7645937..9759720 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -258,6 +258,52 @@ static void config_get_ff(struct strbuf *sb)
 }
 
 /**
+ * Sets `value` to the REBASE_* value for the configuration setting `key`.
+ * Returns 0 is `key` exists, -1 if it does not. Dies if the value of `key` is
+ * invalid.
+ */
+static int config_get_rebase(const char *key, enum rebase_type *value)
+{
+	const char *str_value;
+
+	if (git_config_get_value(key, &str_value))
+		return -1;
+	*value = parse_config_rebase(str_value);
+	if (*value == REBASE_INVALID)
+		die(_("Invalid value for %s: %s"), key, str_value);
+	return 0;
+}
+
+/**
+ * Returns the default configured value for --rebase. It first looks for the
+ * value of "branch.$curr_branch.rebase", where $curr_branch is the current
+ * branch, and if HEAD is detached or the configuration key does not exist,
+ * looks for the value of "pull.rebase". If both configuration keys do not
+ * exist, returns REBASE_FALSE.
+ */
+static enum rebase_type config_get_rebase_default(void)
+{
+	struct branch *curr_branch = branch_get("HEAD");
+	enum rebase_type rebase_type;
+
+	if (curr_branch) {
+		int ret;
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_addf(&sb, "branch.%s.rebase", curr_branch->name);
+		ret = config_get_rebase(sb.buf, &rebase_type);
+		strbuf_release(&sb);
+		if (!ret)
+			return rebase_type;
+	}
+
+	if (!config_get_rebase("pull.rebase", &rebase_type))
+		return rebase_type;
+
+	return REBASE_FALSE;
+}
+
+/**
  * Appends merge candidates from FETCH_HEAD that are not marked not-for-merge
  * into merge_heads.
  */
@@ -691,6 +737,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
+	opt_rebase = config_get_rebase_default();
+
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
-- 
2.1.4
