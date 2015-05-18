From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 05/14] pull: error on no merge candidates
Date: Mon, 18 May 2015 23:06:02 +0800
Message-ID: <1431961571-20370-6-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:07:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMdz-0004Ni-QS
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbbERPHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:07:47 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33485 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbbERPHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:42 -0400
Received: by pdbqa5 with SMTP id qa5so153144793pdb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m9rDHBAIH+98fJZj0AQ21/Rw61z2F3Gh0Mty0fHb0aI=;
        b=fthYGFBUm7ORM1oKtQTxPhh/yUSngf4Q/Mg6MgP76ofTokxfkDG9akuayiFuVZqm/M
         GzxFMAi54MOFCfmSHQYFuoUXdBO+ON2tBmo8zy2H3g/7duTDK33gzuHljCEfaFVWXnjf
         X9KlDApA1b70OpU5bjkSL0Iotza6sX0/lIxyEajp0FncsT25kOa7vH8bc7uvqkCD0mSn
         zymsyiWWstqBc3J7N/Wb7R9ViCrox/5sZc6T8eHOaxU4A3vfKg4oPBBXvRoUxymrM8YH
         64ktGr7WWbJ/ZItwb95MsmRej1uZE4f8A6FL/NEjJlk5SMogg+XJY/gHsxDrLRJXYiVe
         eHLQ==
X-Received: by 10.68.221.70 with SMTP id qc6mr44668711pbc.76.1431961662443;
        Mon, 18 May 2015 08:07:42 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:41 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269264>

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

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c  | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5520-pull.sh |  10 ++---
 2 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 07ad783..8982fdf 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -10,6 +10,8 @@
 #include "parse-options.h"
 #include "argv-array.h"
 #include "run-command.h"
+#include "sha1-array.h"
+#include "remote.h"
 
 /**
  * Given an option opt, where opt->value points to a char* and opt->defval is a
@@ -207,6 +209,130 @@ static void argv_push_force(struct argv_array *arr)
 		argv_array_push(arr, "-f");
 }
 
+struct known_remote {
+	struct known_remote *next;
+	struct remote *remote;
+};
+
+/**
+ * Use this callback with for_each_remote() to get the configured remotes as
+ * a singly linked known_remote list. cb_data must be a pointer to a
+ * struct known_remote*, which must be initialized to NULL. For example,
+ * For example:
+ *
+ *     struct known_remote *list = NULL;
+ *     for_each_remote(add_known_remote, &list);
+ */
+static int add_known_remote(struct remote *remote, void *cb_data)
+{
+	struct known_remote **list = cb_data;
+	struct known_remote *item;
+
+	item = xmalloc(sizeof(*item));
+	item->remote = remote;
+	item->next = *list;
+	*list = item;
+	return 0;
+}
+
+/**
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
+		fprintf(stderr,
+			_("There are no candidates for merging among the refs that you just fetched.\n"
+			"Generally this means that you provided a wildcard refspec which had no\n"
+			"matches on the remote end.\n"));
+	} else if (repo && curr_branch && (!remote || strcmp(repo, remote))) {
+		fprintf(stderr,
+			_("You asked to pull from the remote '%s', but did not specify\n"
+			"a branch. Because this is not the default configured remote\n"
+			"for your current branch, you must specify a branch on the command line.\n"),
+			repo);
+	} else if (!curr_branch) {
+		fprintf(stderr,
+			_("You are not currently on a branch. Please specify which\n"
+			"branch you want to merge with. See git-pull(1) for details.\n"
+			"\n"
+			"    git pull <remote> <branch>\n"
+			"\n"));
+	} else if (!curr_branch->merge_nr) {
+		struct known_remote *remotes = NULL;
+		const char *remote_name = "<remote>";
+
+		for_each_remote(add_known_remote, &remotes);
+		if (remotes && !remotes->next)
+			remote_name = remotes->remote->name;
+
+		fprintf(stderr,
+			_("There is no tracking information for the current branch.\n"
+			"Please specify which branch you want to merge with.\n"
+			"See git-pull(1) for details.\n"
+			"\n"
+			"    git pull <remote> <branch>\n"
+			"\n"
+			"If you wish to set tracking information for this branch you can do so with:\n"
+			"\n"
+			"    git branch --set-upstream-to=%s/<branch> %s\n"
+			"\n"),
+			remote_name, curr_branch->name);
+	} else
+		fprintf(stderr,
+			_("Your configuration specifies to merge with the ref '%s'\n"
+			"from the remote, but no such ref was fetched.\n"
+			"\n"),
+			*curr_branch->merge_name);
+	exit(1);
+}
+
 /**
  * Parses argv into [<repo> [<refspecs>...]], returning their values in `repo`
  * as a string and `refspecs` as a null-terminated array of strings. If `repo`
@@ -318,6 +444,7 @@ static int run_merge(void)
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
+	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
@@ -328,5 +455,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_dry_run)
 		return 0;
 
+	get_merge_heads(&merge_heads);
+
+	if (!merge_heads.nr)
+		die_no_merge_candidates(repo, refspecs);
+
 	return run_merge();
 }
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f32b8cb..0ff5df3 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -116,7 +116,7 @@ test_expect_failure 'the default remote . should not break explicit pull' '
 	test_cmp reflog.expected reflog.fuzzy
 '
 
-test_expect_failure 'fail if wildcard spec does not match any refs' '
+test_expect_success 'fail if wildcard spec does not match any refs' '
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
 	test "$(cat file)" = file &&
@@ -125,7 +125,7 @@ test_expect_failure 'fail if wildcard spec does not match any refs' '
 	test "$(cat file)" = file
 '
 
-test_expect_failure 'fail if no branches specified with non-default remote' '
+test_expect_success 'fail if no branches specified with non-default remote' '
 	git remote add test_remote . &&
 	test_when_finished "git remote remove test_remote" &&
 	git checkout -b test copy^ &&
@@ -137,7 +137,7 @@ test_expect_failure 'fail if no branches specified with non-default remote' '
 	test "$(cat file)" = file
 '
 
-test_expect_failure 'fail if not on a branch' '
+test_expect_success 'fail if not on a branch' '
 	git remote add origin . &&
 	test_when_finished "git remote remove origin" &&
 	git checkout HEAD^ &&
@@ -148,7 +148,7 @@ test_expect_failure 'fail if not on a branch' '
 	test "$(cat file)" = file
 '
 
-test_expect_failure 'fail if no configuration for current branch' '
+test_expect_success 'fail if no configuration for current branch' '
 	git remote add test_remote . &&
 	test_when_finished "git remote remove test_remote" &&
 	git checkout -b test copy^ &&
@@ -160,7 +160,7 @@ test_expect_failure 'fail if no configuration for current branch' '
 	test "$(cat file)" = file
 '
 
-test_expect_failure 'fail if upstream branch does not exist' '
+test_expect_success 'fail if upstream branch does not exist' '
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
 	test_config branch.test.remote . &&
-- 
2.1.4
