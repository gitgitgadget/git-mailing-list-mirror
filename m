From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 05/19] pull: implement fetch + merge
Date: Sun, 14 Jun 2015 16:41:52 +0800
Message-ID: <1434271326-11349-6-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:42:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43VI-0006Ga-87
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbbFNImu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:42:50 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36204 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbbFNIml (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:42:41 -0400
Received: by pabqy3 with SMTP id qy3so46551794pab.3
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K691xmH4ocIHf7i10y7tYJAm71IPV0Sfu2Z33LSZkhM=;
        b=JqvqeXWL383T0W2zSU351yOGOBd4AKC6/CGJ0Sy7HplCNvs/ty0vDuvjNvIp/lAS71
         xvWfojYQOaeoJ3gqVJadyHlN6GneP4RQnrC4xTU9+jOHhSiphNBlkCM6eZsqmeirqbDU
         fF2ykEcWksAn9nMNCXi/f5oR4KcWg4pWDY46hZGP6vXhLocEUmtxzIS8Gp9OhqYRn5RM
         6nyhDBcY9N5ZFFM2b+7KSTmpIgg3Pt0Oij8XMB4cvfEJc/S4HUheKDE4bJ+jYpa4LsZl
         ogKCqdUDrBAiv3iit+MNLxNycSRZIFHfuqZewBCCu3HkIpjGk7QiQtkjpExp1sDQpy+P
         2d4w==
X-Received: by 10.68.229.40 with SMTP id sn8mr37414039pbc.59.1434271361005;
        Sun, 14 Jun 2015 01:42:41 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.42.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:42:39 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271618>

Implement the fetch + merge functionality of git-pull, by first running
git-fetch with the repo and refspecs provided on the command line, then
running git-merge on FETCH_HEAD to merge the fetched refs into the
current branch.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v3
    
    * Catch bug where there is are refspecs but no repo.

 builtin/pull.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index cabeed4..9157536 100644
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
 
@@ -18,8 +20,61 @@ static struct option pull_options[] = {
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
+	if (repo) {
+		argv_array_push(&args, repo);
+		argv_array_pushv(&args, refspecs);
+	} else if (*refspecs)
+		die("BUG: refspecs without repo?");
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
 
@@ -29,5 +84,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
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
