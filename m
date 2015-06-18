From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 16/19] pull: configure --rebase via branch.<name>.rebase or pull.rebase
Date: Thu, 18 Jun 2015 18:54:09 +0800
Message-ID: <1434624852-6869-17-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:08:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XgC-000571-EN
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbbFRLHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:07:30 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33876 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbbFRKzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:33 -0400
Received: by pdbki1 with SMTP id ki1so64224682pdb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zq/ZdtpMi8ZxyFrBMCxPGT8z3v1XMao4Q9x1U+yNcx0=;
        b=wtHgq5+Tox3qaNNroV1ANxd3MboRyE92k7YZ5XAFe3Fo9BZ6MW1oIqtqcDDxvKpg32
         VvvVSkum8XinDP4cM6SpRiuy87THZsi3f3iyLUXTbPKJlk6A8dzCY52FjyqqsmHaLEQv
         LyIzxU3ieX85aqrK6TIbpyOTpHNQp8pjClInc9En4fWV1rlOv59n/i+q7/nQmjRs/Q3S
         yDx6Ul42PYhM9tDFZt5p1+F2hRvcI+X5idtB1ujZUf3SNjOhWsOqha30oHDrGXbt4fhX
         Zf59fl2kRgWLymQ2Vw5K3FSk1EsYvxibz+LW9md1I4CVIhBQoz2201vg+0jx74jE+s4A
         +lsQ==
X-Received: by 10.70.88.43 with SMTP id bd11mr19935479pdb.7.1434624932698;
        Thu, 18 Jun 2015 03:55:32 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:31 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271961>

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
Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v4
    
    * Fixed the use-after-free. Thanks Duy for catching it.

 builtin/pull.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 33a7b98..1c4fb44 100644
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
@@ -266,6 +266,36 @@ static const char *config_get_ff(void)
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
+			enum rebase_type ret = parse_config_rebase(key, value, 1);
+			free(key);
+			return ret;
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
@@ -707,6 +737,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
+	if (opt_rebase < 0)
+		opt_rebase = config_get_rebase();
+
 	git_config(git_default_config, NULL);
 
 	if (read_cache_unmerged())
-- 
2.1.4
