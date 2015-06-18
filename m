From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 09/19] pull: error on no merge candidates
Date: Thu, 18 Jun 2015 18:54:02 +0800
Message-ID: <1434624852-6869-10-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:56:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XV3-0002xH-6F
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbbFRK4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:56:08 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34112 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbbFRKzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:09 -0400
Received: by pabvl15 with SMTP id vl15so12902180pab.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vRTt/JiAzTnK2rveSEqj70wp0DSb8cZDYtgpuaA/bd0=;
        b=Ud2e8hxFlsOxvxjdYoXByZadUYLbCjFGIKhujGq5QMTcVw3zleQek6EMhAa+UP5WRu
         7VSnkqfMIQRzATzm7F1d7r2gVBwD/yHQtQfxTl0uhHCkh+kpQ/R7TqhbJWfSmtzuLMqS
         MNUkPodUqrWjBHEZcKIrmDk7n4dDRD+JDOcKC0jI20Ogcb4talPpxZtkMKpW386rgM4I
         5zUtwYb3CBkeD8mURcHk43b+VRg4WuLLj4Cz/H6tNVV85L/EO+GNNAGII0lhDl14IVjp
         vnK7rsPGtuEr4TYDsBTqmqPIjtDd/i8g9Y7SSI1GdZ/A7HFwhyBLPZkt10t9cPjScZ7e
         vuVQ==
X-Received: by 10.66.139.138 with SMTP id qy10mr20522078pab.30.1434624908643;
        Thu, 18 Jun 2015 03:55:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:07 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271954>

Commit a8c9bef (pull: improve advice for unconfigured error case,
2009-10-05) fully established the current advices given by git-pull for
the different cases where git-fetch will not have anything marked for
merge:

1. We fetched from a specific remote, and a refspec was given, but it
   ended up not fetching anything. This is usually because the user
   provided a wildcard refspec which had no matches on the remote end.

2. We fetched from a non-default remote, but didn't specify a branch to
   merge. We can't use the configured one because it applies to the
   default remote, and thus the user must specify the branches to merge.

3. We fetched from the branch's or repo's default remote, but:

   a. We are not on a branch, so there will never be a configured branch
      to merge with.

   b. We are on a branch, but there is no configured branch to merge
      with.

4. We fetched from the branch's or repo's default remote, but the
   configured branch to merge didn't get fetched (either it doesn't
   exist, or wasn't part of the configured fetch refspec)

Re-implement the above behavior by implementing get_merge_heads() to
parse the heads in FETCH_HEAD for merging, and implementing
die_no_merge_candidates(), which will be called when FETCH_HEAD has no
heads for merging.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index f35649c..647bcb9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -10,6 +10,8 @@
 #include "parse-options.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+#include "sha1-array.h"
+#include "remote.h"
 
 static const char * const pull_usage[] = {
 	N_("git pull [options] [<repository> [<refspec>...]]"),
@@ -165,6 +167,111 @@ static void argv_push_force(struct argv_array *arr)
 }
 
 /**
+ * Appends merge candidates from FETCH_HEAD that are not marked not-for-merge
+ * into merge_heads.
+ */
+static void get_merge_heads(struct sha1_array *merge_heads)
+{
+	const char *filename = git_path("FETCH_HEAD");
+	FILE *fp;
+	struct strbuf sb = STRBUF_INIT;
+	unsigned char sha1[GIT_SHA1_RAWSZ];
+
+	if (!(fp = fopen(filename, "r")))
+		die_errno(_("could not open '%s' for reading"), filename);
+	while (strbuf_getline(&sb, fp, '\n') != EOF) {
+		if (get_sha1_hex(sb.buf, sha1))
+			continue;  /* invalid line: does not start with SHA1 */
+		if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge\t"))
+			continue;  /* ref is not-for-merge */
+		sha1_array_append(merge_heads, sha1);
+	}
+	fclose(fp);
+	strbuf_release(&sb);
+}
+
+/**
+ * Used by die_no_merge_candidates() as a for_each_remote() callback to
+ * retrieve the name of the remote if the repository only has one remote.
+ */
+static int get_only_remote(struct remote *remote, void *cb_data)
+{
+	const char **remote_name = cb_data;
+
+	if (*remote_name)
+		return -1;
+
+	*remote_name = remote->name;
+	return 0;
+}
+
+/**
+ * Dies with the appropriate reason for why there are no merge candidates:
+ *
+ * 1. We fetched from a specific remote, and a refspec was given, but it ended
+ *    up not fetching anything. This is usually because the user provided a
+ *    wildcard refspec which had no matches on the remote end.
+ *
+ * 2. We fetched from a non-default remote, but didn't specify a branch to
+ *    merge. We can't use the configured one because it applies to the default
+ *    remote, thus the user must specify the branches to merge.
+ *
+ * 3. We fetched from the branch's or repo's default remote, but:
+ *
+ *    a. We are not on a branch, so there will never be a configured branch to
+ *       merge with.
+ *
+ *    b. We are on a branch, but there is no configured branch to merge with.
+ *
+ * 4. We fetched from the branch's or repo's default remote, but the configured
+ *    branch to merge didn't get fetched. (Either it doesn't exist, or wasn't
+ *    part of the configured fetch refspec.)
+ */
+static void NORETURN die_no_merge_candidates(const char *repo, const char **refspecs)
+{
+	struct branch *curr_branch = branch_get("HEAD");
+	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
+
+	if (*refspecs) {
+		fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
+		fprintf_ln(stderr, _("Generally this means that you provided a wildcard refspec which had no\n"
+					"matches on the remote end."));
+	} else if (repo && curr_branch && (!remote || strcmp(repo, remote))) {
+		fprintf_ln(stderr, _("You asked to pull from the remote '%s', but did not specify\n"
+			"a branch. Because this is not the default configured remote\n"
+			"for your current branch, you must specify a branch on the command line."),
+			repo);
+	} else if (!curr_branch) {
+		fprintf_ln(stderr, _("You are not currently on a branch."));
+		fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
+		fprintf_ln(stderr, _("See git-pull(1) for details."));
+		fprintf(stderr, "\n");
+		fprintf_ln(stderr, "    git pull <remote> <branch>");
+		fprintf(stderr, "\n");
+	} else if (!curr_branch->merge_nr) {
+		const char *remote_name = NULL;
+
+		if (for_each_remote(get_only_remote, &remote_name) || !remote_name)
+			remote_name = "<remote>";
+
+		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
+		fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
+		fprintf_ln(stderr, _("See git-pull(1) for details."));
+		fprintf(stderr, "\n");
+		fprintf_ln(stderr, "    git pull <remote> <branch>");
+		fprintf(stderr, "\n");
+		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:\n"
+				"\n"
+				"    git branch --set-upstream-to=%s/<branch> %s\n"),
+				remote_name, curr_branch->name);
+	} else
+		fprintf_ln(stderr, _("Your configuration specifies to merge with the ref '%s'\n"
+			"from the remote, but no such ref was fetched."),
+			*curr_branch->merge_name);
+	exit(1);
+}
+
+/**
  * Parses argv into [<repo> [<refspecs>...]], returning their values in `repo`
  * as a string and `refspecs` as a null-terminated array of strings. If `repo`
  * is not provided in argv, it is set to NULL.
@@ -277,6 +384,7 @@ static int run_merge(void)
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
+	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
 
 	if (!getenv("_GIT_USE_BUILTIN_PULL")) {
 		const char *path = mkpath("%s/git-pull", git_exec_path());
@@ -295,5 +403,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_dry_run)
 		return 0;
 
+	get_merge_heads(&merge_heads);
+
+	if (!merge_heads.nr)
+		die_no_merge_candidates(repo, refspecs);
+
 	return run_merge();
 }
-- 
2.1.4
