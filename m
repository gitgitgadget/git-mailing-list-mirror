From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 05/19] pull: implement fetch + merge
Date: Wed,  3 Jun 2015 14:48:49 +0800
Message-ID: <1433314143-4478-6-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02V8-0004Wg-5J
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbbFCGuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:03 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32775 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbbFCGuA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:00 -0400
Received: by padj3 with SMTP id j3so771914pad.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/qcFvSCpGW2+6SBD0aIXCilLOaLgLEaBV2DCd9M6vrI=;
        b=VsNLzPMOL/BqDAe/S7y7iV1tEcq9tMgH91hTSLoF+9Wy+IWXNmKCZg2CeO4guYjDn4
         bsWa6IoGZ4EfSpXgMELAXYJ788+53gvY/UkWzVLUw5ff4Ndha5wXXAwaUbfi33l0xAXr
         1riKu3OBOBAfjsevAFQ+uTJqxgL5viNBZsY0C3tczlJRRjdlK9KdJwJXTwYCJZSq5AVy
         mk1F8LLXKIwFBrIrUdi0YdsZLTSRrB0lQQFx/VEeOqDHTXBs8xRgRyacn+F5Vul86iPt
         GXQjX07wJJoJkpdXvTrNH+VXPrsJ3ehYmdYWbTHfZOKcacysj2fKq59RXcKx6Fidyo14
         ZVwg==
X-Received: by 10.70.96.194 with SMTP id du2mr57747084pdb.108.1433314199779;
        Tue, 02 Jun 2015 23:49:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.49.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:49:58 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270644>

Implement the fetch + merge functionality of git-pull, by first running
git-fetch with the repo and refspecs provided on the command line, then
running git-merge on FETCH_HEAD to merge the fetched refs into the
current branch.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index f8b79a2..0ca23a3 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -9,8 +9,10 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "exec_cmd.h"
+#include "run-command.h"
 
 static const char * const pull_usage[] = {
+	N_("git pull [options] [<repository> [<refspec>...]]"),
 	NULL
 };
 
@@ -18,8 +20,60 @@ static struct option pull_options[] = {
 	OPT_END()
 };
 
+/**
+ * Parses argv into [<repo> [<refspecs>...]], returning their values in `repo`
+ * as a string and `refspecs` as a null-terminated array of strings. If `repo`
+ * is not provided in argv, it is set to NULL.
+ */
+static void parse_repo_refspecs(int argc, const char **argv, const char **repo,
+		const char ***refspecs)
+{
+	if (argc > 0) {
+		*repo = *argv++;
+		argc--;
+	} else
+		*repo = NULL;
+	*refspecs = argv;
+}
+
+/**
+ * Runs git-fetch, returning its exit status. `repo` and `refspecs` are the
+ * repository and refspecs to fetch, or NULL if they are not provided.
+ */
+static int run_fetch(const char *repo, const char **refspecs)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int ret;
+
+	argv_array_pushl(&args, "fetch", "--update-head-ok", NULL);
+	if (repo)
+		argv_array_push(&args, repo);
+	while (*refspecs)
+		argv_array_push(&args, *refspecs++);
+	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	argv_array_clear(&args);
+	return ret;
+}
+
+/**
+ * Runs git-merge, returning its exit status.
+ */
+static int run_merge(void)
+{
+	int ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+
+	argv_array_pushl(&args, "merge", NULL);
+	argv_array_push(&args, "FETCH_HEAD");
+	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	argv_array_clear(&args);
+	return ret;
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
+	const char *repo, **refspecs;
+
 	if (!getenv("_GIT_USE_BUILTIN_PULL")) {
 		const char *path = mkpath("%s/git-pull", git_exec_path());
 
@@ -29,5 +83,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
-	return 0;
+	parse_repo_refspecs(argc, argv, &repo, &refspecs);
+
+	if (run_fetch(repo, refspecs))
+		return 1;
+
+	return run_merge();
 }
-- 
2.1.4
