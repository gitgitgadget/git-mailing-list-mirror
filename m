From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 08/19] pull: pass git-fetch's options to git-fetch
Date: Wed,  3 Jun 2015 14:48:52 +0800
Message-ID: <1433314143-4478-9-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02VF-0004d5-1T
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbbFCGuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:15 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36332 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbbFCGuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:09 -0400
Received: by pabqy3 with SMTP id qy3so662748pab.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PZsCvbItE+eZQkNf0jpXgdzOeSLBrKZXsLhJai/0xBQ=;
        b=Slk8frgXUpNxHRhHTtZzI5dPNx2+1IEmNX96/4jFT3L9JSH+u0FXaihXYktrXcvkGu
         6n8RIAA4k/wi93B2LtzE4o+e43X+9rYrZPh0VwBSet4aKK2jRC+RAkyFLrRnqIiOZ4r0
         8Z3vOYWEUt3kPYzbHxB+5PfP5NYvWavSRPE/TzhGhITe+8yXaDYotbRean8p1iR8jJpS
         xKOvPakeW9egy/ik8z7/mDzFIzOYBTF3EVeIG4+4gtUDCKQaVYWzqzZ7X1Gmy3AWzsy1
         CijwPqyAo7yDivXeNVO9mUWK9GxofZcVix2DTEet2b26VyVy3B3cnl55XnbLHbzsfnAJ
         GeCA==
X-Received: by 10.70.101.2 with SMTP id fc2mr57601388pdb.77.1433314208721;
        Tue, 02 Jun 2015 23:50:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:07 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270647>

Since eb2a8d9 (pull: handle git-fetch's options as well, 2015-06-02),
git-pull knows about and handles git-fetch's options, passing them to
git-fetch. Re-implement this behavior.

Since 29609e6 (pull: do nothing on --dry-run, 2010-05-25) git-pull
supported the --dry-run option, exiting after git-fetch if --dry-run is
set. Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Use parse_opt_parse_strbuf()

 builtin/pull.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 5f08634..0b66b43 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -32,6 +32,21 @@ static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
 static struct strbuf opt_gpg_sign = STRBUF_INIT;
 
+/* Options passed to git-fetch */
+static struct strbuf opt_all = STRBUF_INIT;
+static struct strbuf opt_append = STRBUF_INIT;
+static struct strbuf opt_upload_pack = STRBUF_INIT;
+static int opt_force;
+static struct strbuf opt_tags = STRBUF_INIT;
+static struct strbuf opt_prune = STRBUF_INIT;
+static struct strbuf opt_recurse_submodules = STRBUF_INIT;
+static int opt_dry_run;
+static struct strbuf opt_keep = STRBUF_INIT;
+static struct strbuf opt_depth = STRBUF_INIT;
+static struct strbuf opt_unshallow = STRBUF_INIT;
+static struct strbuf opt_update_shallow = STRBUF_INIT;
+static struct strbuf opt_refmap = STRBUF_INIT;
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -82,6 +97,46 @@ static struct option pull_options[] = {
 	  N_("GPG sign commit"),
 	  PARSE_OPT_OPTARG, parse_opt_pass_strbuf },
 
+	/* Options passed to git-fetch */
+	OPT_GROUP(N_("Options related to fetching")),
+	{ OPTION_CALLBACK, 0, "all", &opt_all, 0,
+	  N_("fetch from all remotes"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 'a', "append", &opt_append, 0,
+	  N_("append to .git/FETCH_HEAD instead of overwriting"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "upload-pack", &opt_upload_pack, N_("path"),
+	  N_("path to upload pack on remote end"),
+	  0, parse_opt_pass_strbuf },
+	OPT__FORCE(&opt_force, N_("force overwrite of local branch")),
+	{ OPTION_CALLBACK, 't', "tags", &opt_tags, 0,
+	  N_("fetch all tags and associated objects"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 'p', "prune", &opt_prune, 0,
+	  N_("prune remote-tracking branches no longer on remote"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "recurse-submodules", &opt_recurse_submodules,
+	  N_("on-demand"),
+	  N_("control recursive fetching of submodules"),
+	  PARSE_OPT_OPTARG, parse_opt_pass_strbuf },
+	OPT_BOOL(0, "dry-run", &opt_dry_run,
+		N_("dry run")),
+	{ OPTION_CALLBACK, 'k', "keep", &opt_keep, 0,
+	  N_("keep downloaded pack"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "depth", &opt_depth, N_("depth"),
+	  N_("deepen history of shallow clone"),
+	  0, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "unshallow", &opt_unshallow, 0,
+	  N_("convert to a complete repository"),
+	  PARSE_OPT_NONEG | PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "update-shallow", &opt_update_shallow, 0,
+	  N_("accept refs that update .git/shallow"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "refmap", &opt_refmap, N_("refmap"),
+	  N_("specify fetch refmap"),
+	  PARSE_OPT_NONEG, parse_opt_pass_strbuf },
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
 	if (opt_progress.len)
 		argv_array_push(&args, opt_progress.buf);
 
+	/* Options passed to git-fetch */
+	if (opt_all.len)
+		argv_array_push(&args, opt_all.buf);
+	if (opt_append.len)
+		argv_array_push(&args, opt_append.buf);
+	if (opt_upload_pack.len)
+		argv_array_push(&args, opt_upload_pack.buf);
+	argv_push_force(&args);
+	if (opt_tags.len)
+		argv_array_push(&args, opt_tags.buf);
+	if (opt_prune.len)
+		argv_array_push(&args, opt_prune.buf);
+	if (opt_recurse_submodules.len)
+		argv_array_push(&args, opt_recurse_submodules.buf);
+	if (opt_dry_run)
+		argv_array_push(&args, "--dry-run");
+	if (opt_keep.len)
+		argv_array_push(&args, opt_keep.buf);
+	if (opt_depth.len)
+		argv_array_push(&args, opt_depth.buf);
+	if (opt_unshallow.len)
+		argv_array_push(&args, opt_unshallow.buf);
+	if (opt_update_shallow.len)
+		argv_array_push(&args, opt_update_shallow.buf);
+	if (opt_refmap.len)
+		argv_array_push(&args, opt_refmap.buf);
+
 	if (repo)
 		argv_array_push(&args, repo);
 	while (*refspecs)
@@ -199,5 +291,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (run_fetch(repo, refspecs))
 		return 1;
 
+	if (opt_dry_run)
+		return 0;
+
 	return run_merge();
 }
-- 
2.1.4
