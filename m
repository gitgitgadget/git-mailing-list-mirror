From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 08/19] pull: pass git-fetch's options to git-fetch
Date: Thu, 18 Jun 2015 18:54:01 +0800
Message-ID: <1434624852-6869-9-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:55:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XTy-000210-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbbFRKz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:55:26 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32908 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbbFRKzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:07 -0400
Received: by padev16 with SMTP id ev16so59040986pad.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+psfM/jPDVA/E1vZdydMyGxWLK927EgG0UXWM83R/DY=;
        b=z7DKEFxTendIVXK2QM6VJ8+90xCeVvLprLnOH/OCCeMlf9MQvvJlC9d04uh3InrW6H
         jDvtL/m8JyGA7v4wcoTnBhVpZBFz2X34RLBrwm6TKEiy009pXLQ8HidBYcoP1OQnz7gg
         r6KRY6CzIKiJWGc7ac41vI9fbOZpDZ7gYxkYMLhh9RRYClYeRUNBJ3qnaPj7I+0Xdien
         fRuflVaQmKW9sHEZTGzbe54XRw1AR9WTI9M7JUaflYtquYhzS2GqscfSpzLAfqt18Gbh
         M31AYKXU8+a08MYNiy8ikJZcLikXG1DdtOlcTvqVhw7Zm7OHFXP4HyRm276nSARDKpzo
         WXKA==
X-Received: by 10.70.127.140 with SMTP id ng12mr20303662pdb.94.1434624905274;
        Thu, 18 Jun 2015 03:55:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:03 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271951>

Since eb2a8d9 (pull: handle git-fetch's options as well, 2015-06-02),
git-pull knows about and handles git-fetch's options, passing them to
git-fetch. Re-implement this behavior.

Since 29609e6 (pull: do nothing on --dry-run, 2010-05-25) git-pull
supported the --dry-run option, exiting after git-fetch if --dry-run is
set. Re-implement this behavior.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 0442da9..f35649c 100644
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
+	OPT_PASSTHRU(0, "all", &opt_all, NULL,
+		N_("fetch from all remotes"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU('a', "append", &opt_append, NULL,
+		N_("append to .git/FETCH_HEAD instead of overwriting"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "upload-pack", &opt_upload_pack, N_("path"),
+		N_("path to upload pack on remote end"),
+		0),
+	OPT__FORCE(&opt_force, N_("force overwrite of local branch")),
+	OPT_PASSTHRU('t', "tags", &opt_tags, NULL,
+		N_("fetch all tags and associated objects"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU('p', "prune", &opt_prune, NULL,
+		N_("prune remote-tracking branches no longer on remote"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "recurse-submodules", &opt_recurse_submodules,
+		N_("on-demand"),
+		N_("control recursive fetching of submodules"),
+		PARSE_OPT_OPTARG),
+	OPT_BOOL(0, "dry-run", &opt_dry_run,
+		N_("dry run")),
+	OPT_PASSTHRU('k', "keep", &opt_keep, NULL,
+		N_("keep downloaded pack"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "depth", &opt_depth, N_("depth"),
+		N_("deepen history of shallow clone"),
+		0),
+	OPT_PASSTHRU(0, "unshallow", &opt_unshallow, NULL,
+		N_("convert to a complete repository"),
+		PARSE_OPT_NONEG | PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "update-shallow", &opt_update_shallow, NULL,
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
