From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 08/19] pull: pass git-fetch's options to git-fetch
Date: Sun, 14 Jun 2015 16:41:55 +0800
Message-ID: <1434271326-11349-9-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:43:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43Vm-0006Uq-Tg
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbbFNInP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:15 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33251 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbbFNImv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:42:51 -0400
Received: by pdjn11 with SMTP id n11so51429453pdj.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=57CSbcaFPQ4Wz2PjLpYfxTkyA2xgiXMOuiF14WezZEc=;
        b=vvgBtP5DaPCCRWvg6yY/xBlIanfh4PfYY/gwh3HVSbefBo7aLo5bi0a2oNLLoc+74S
         0EfOUyyokQ7nXjnuc+EBPPIGox6DPAc5mnwXYNrXc3e9B5hXhgZFHXrBVtGt+/L9oU6e
         0ZDNXUoJTeD9kAexuS5hHZrKOb/eGJZSqqVGuRbwarzQqfCC1LrP6iQvIH6AMmQpHWXH
         m3xGFJ1hIcTYbTLFigqgaawVKjL5GA08WFEoLMzzhg7kKDJfcIbZ7PkYvSSMRAxADia3
         n3mJIKx9WRqgVQsltkFPDn7BEFfk9x/q/f5/J/ebUMBDRtYfHONoMeP556r8Q06wVhjx
         /erQ==
X-Received: by 10.66.154.233 with SMTP id vr9mr38003542pab.124.1434271370421;
        Sun, 14 Jun 2015 01:42:50 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.42.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:42:49 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271622>

Since eb2a8d9 (pull: handle git-fetch's options as well, 2015-06-02),
git-pull knows about and handles git-fetch's options, passing them to
git-fetch. Re-implement this behavior.

Since 29609e6 (pull: do nothing on --dry-run, 2010-05-25) git-pull
supported the --dry-run option, exiting after git-fetch if --dry-run is
set. Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 0442da9..731e2a6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -32,6 +32,21 @@ static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
 static char *opt_gpg_sign;
 
+/* Options passed to git-fetch */
+static char *opt_all;
+static char *opt_append;
+static char *opt_upload_pack;
+static int opt_force;
+static char *opt_tags;
+static char *opt_prune;
+static char *opt_recurse_submodules;
+static int opt_dry_run;
+static char *opt_keep;
+static char *opt_depth;
+static char *opt_unshallow;
+static char *opt_update_shallow;
+static char *opt_refmap;
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -82,6 +97,46 @@ static struct option pull_options[] = {
 		N_("GPG sign commit"),
 		PARSE_OPT_OPTARG),
 
+	/* Options passed to git-fetch */
+	OPT_GROUP(N_("Options related to fetching")),
+	OPT_PASSTHRU(0, "all", &opt_all, 0,
+		N_("fetch from all remotes"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU('a', "append", &opt_append, 0,
+		N_("append to .git/FETCH_HEAD instead of overwriting"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "upload-pack", &opt_upload_pack, N_("path"),
+		N_("path to upload pack on remote end"),
+		0),
+	OPT__FORCE(&opt_force, N_("force overwrite of local branch")),
+	OPT_PASSTHRU('t', "tags", &opt_tags, 0,
+		N_("fetch all tags and associated objects"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU('p', "prune", &opt_prune, 0,
+		N_("prune remote-tracking branches no longer on remote"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "recurse-submodules", &opt_recurse_submodules,
+		N_("on-demand"),
+		N_("control recursive fetching of submodules"),
+		PARSE_OPT_OPTARG),
+	OPT_BOOL(0, "dry-run", &opt_dry_run,
+		N_("dry run")),
+	OPT_PASSTHRU('k', "keep", &opt_keep, 0,
+		N_("keep downloaded pack"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "depth", &opt_depth, N_("depth"),
+		N_("deepen history of shallow clone"),
+		0),
+	OPT_PASSTHRU(0, "unshallow", &opt_unshallow, 0,
+		N_("convert to a complete repository"),
+		PARSE_OPT_NONEG | PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "update-shallow", &opt_update_shallow, 0,
+		N_("accept refs that update .git/shallow"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "refmap", &opt_refmap, N_("refmap"),
+		N_("specify fetch refmap"),
+		PARSE_OPT_NONEG),
+
 	OPT_END()
 };
 
@@ -100,6 +155,16 @@ static void argv_push_verbosity(struct argv_array *arr)
 }
 
 /**
+ * Pushes "-f" switches into arr to match the opt_force level.
+ */
+static void argv_push_force(struct argv_array *arr)
+{
+	int force = opt_force;
+	while (force-- > 0)
+		argv_array_push(arr, "-f");
+}
+
+/**
  * Parses argv into [<repo> [<refspecs>...]], returning their values in `repo`
  * as a string and `refspecs` as a null-terminated array of strings. If `repo`
  * is not provided in argv, it is set to NULL.
@@ -131,6 +196,33 @@ static int run_fetch(const char *repo, const char **refspecs)
 	if (opt_progress)
 		argv_array_push(&args, opt_progress);
 
+	/* Options passed to git-fetch */
+	if (opt_all)
+		argv_array_push(&args, opt_all);
+	if (opt_append)
+		argv_array_push(&args, opt_append);
+	if (opt_upload_pack)
+		argv_array_push(&args, opt_upload_pack);
+	argv_push_force(&args);
+	if (opt_tags)
+		argv_array_push(&args, opt_tags);
+	if (opt_prune)
+		argv_array_push(&args, opt_prune);
+	if (opt_recurse_submodules)
+		argv_array_push(&args, opt_recurse_submodules);
+	if (opt_dry_run)
+		argv_array_push(&args, "--dry-run");
+	if (opt_keep)
+		argv_array_push(&args, opt_keep);
+	if (opt_depth)
+		argv_array_push(&args, opt_depth);
+	if (opt_unshallow)
+		argv_array_push(&args, opt_unshallow);
+	if (opt_update_shallow)
+		argv_array_push(&args, opt_update_shallow);
+	if (opt_refmap)
+		argv_array_push(&args, opt_refmap);
+
 	if (repo) {
 		argv_array_push(&args, repo);
 		argv_array_pushv(&args, refspecs);
@@ -200,5 +292,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (run_fetch(repo, refspecs))
 		return 1;
 
+	if (opt_dry_run)
+		return 0;
+
 	return run_merge();
 }
-- 
2.1.4
