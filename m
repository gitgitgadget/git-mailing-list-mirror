From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 05/19] pull: implement fetch + merge
Date: Thu, 18 Jun 2015 18:53:58 +0800
Message-ID: <1434624852-6869-6-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:55:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XTU-0001Zx-LW
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbbFRKzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:55:07 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34427 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbbFRKy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:54:56 -0400
Received: by pdbki1 with SMTP id ki1so64214770pdb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cuwi4vzzv1WYucndzN7ZRmYbPE4fg1XFr/W8q/xRCiY=;
        b=wJT0pdEZSWBQJTlunLa5MLgd4CrQ9sJCJU/r1lV/4J1jckkK6Jonk9PjmiL96KBoGO
         FM0VXjqYSi+//Y3N4buYPkP3GS9ASlKcLcQ+antYy6E2kQxtBBRvyp2KJN8AWlv50ZB5
         XtO0fSdxr2Q7WpDE1E5h836Bb7THzLw79YHKIkVjaXgczBvSJocGSXeeODTwFk/eAm1a
         ATaWZ9VpuorT/BDYwXQpzP9Wj9wt8R0OeiN1sV6Ekxj9JVdfWFlHiAkXyEk2gP+65O41
         TrMEdxptsFGSzI3lclPqZVu1XhebJDhccYMxN1887rDh80RmA5uoz+KdSdzIYL/XNlNH
         abOA==
X-Received: by 10.70.43.10 with SMTP id s10mr20165711pdl.57.1434624895458;
        Thu, 18 Jun 2015 03:54:55 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.54.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:54:54 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271947>

Implement the fetch + merge functionality of git-pull, by first running
git-fetch with the repo and refspecs provided on the command line, then
running git-merge on FETCH_HEAD to merge the fetched refs into the
current branch.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
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
