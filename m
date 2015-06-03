From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 09/19] pull: error on no merge candidates
Date: Wed,  3 Jun 2015 14:48:53 +0800
Message-ID: <1433314143-4478-10-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02VM-0004jD-21
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbbFCGuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:17 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34337 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbbFCGuM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:12 -0400
Received: by payr10 with SMTP id r10so751236pay.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dx1GYGLTxVkfDhbEwGVaZQkdo1BDtK30+Jr/ExK5FCg=;
        b=jXMJzigPN9xlJtUHdIcGoMg1b2xquGy+bg0AmoVD2xWaZuiGB6dtBg7oXLZ2wZ3Ft4
         fdd+MH8odQD+KoXw+6E/mK2arxY/sg8GxZt1+GCQzp377S727mDB9hyUy8GpWCOOKCJC
         6TInYf7M/crIyLm+T58L3jvRwgkJLCAfbMbp//Qqej/zJ+qRvIRmAKRRjN8i/4pr/2dG
         MsjUcjfW80SW2Nx91bAukJZ7UWUy0pJ88ps5O44x5VAfAplsV/NV/aDHwatxCsja5Rgg
         5KPa841N6NrEdYdBwjGucLRlAjVEUpRx9INPV8FCCphOETquyzPKucW1W1Uy4SRFgVYw
         zudg==
X-Received: by 10.69.25.41 with SMTP id in9mr19401506pbd.80.1433314211703;
        Tue, 02 Jun 2015 23:50:11 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:10 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270651>

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
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Switched to using fprintf_ln() which will append the trailing newline
      at the end for us.
    
    * The die_no_merge_candidates() code has been reorganized a bit to
      support the later patch which will tweak the messages to be aware of
      git-pull --rebase.

 builtin/pull.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 0b66b43..42a061d 100644
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
+	while(strbuf_getline(&sb, fp, '\n') != EOF) {
+		if (get_sha1_hex(sb.buf, sha1))
+			continue;  /* invalid line: does not start with SHA1 */
+		if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge"))
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
@@ -276,6 +383,7 @@ static int run_merge(void)
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
+	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
 
 	if (!getenv("_GIT_USE_BUILTIN_PULL")) {
 		const char *path = mkpath("%s/git-pull", git_exec_path());
@@ -294,5 +402,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
