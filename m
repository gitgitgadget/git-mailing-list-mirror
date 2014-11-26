From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5] Support updating working trees when pushing into non-bare
 repos
Date: Wed, 26 Nov 2014 23:44:13 +0100 (CET)
Message-ID: <cover.1417041787.git.johannes.schindelin@gmx.de>
References: <cover.1417033080.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 26 23:44:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtlK2-0006Bv-2h
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 23:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbaKZWoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 17:44:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:52796 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807AbaKZWoY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 17:44:24 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LeuUB-1YGjz82AJD-00qfnp;
 Wed, 26 Nov 2014 23:44:13 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1417033080.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:9AaVRO84XIBSlu4SDlx9niN0n9+wZ8jYa/+Hm7oW9mUCvizuKR3
 SqBuGVbcdZuzjiYjoMYB+lJKuKUf2E0lML6Y7VN14rRQEWUC3DwRsYkTvAHuiPnsakwPFFy
 4Xw+FJNjvumIj7TOSa5Ds93+Y/GR6m5GAAibtq6BjSKDRqbWMv4hA8/0FNZEDE9KC05AGtL
 cMf+1YK6GVs/nRsyZEkTg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260318>

This patch series adds support for a new receive.denyCurrentBranch setting
to update the working directory (which must be clean, i.e. there must not be
any uncommitted changes) when pushing into the current branch.

The scenario in which the 'updateInstead' setting became a boon in this
developer's daily work is when trying to get a bug fix from a Windows
computer, a virtual machine, or when getting a bug fix from a user's machine
onto his main machine (in all of those cases it is only possible to connect
via ssh in one direction, but not in the reverse direction). It also comes
in handy when updating a live web site via push (in which case a clean
working directory is an absolute must).

Interdiff vs v4 below diffstat.

Johannes Schindelin (1):
  Add another option for receive.denyCurrentBranch

 Documentation/config.txt |  7 ++++
 builtin/receive-pack.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t5516-fetch-push.sh    | 26 ++++++++++++++
 3 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7ff8be5..bbd9ba3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -736,7 +736,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 static const char *update_worktree(unsigned char *sha1)
 {
 	const char *update_refresh[] = {
-		"update-index", "--ignore-submodules", "--refresh", "-q", NULL
+		"update-index", "-q", "--ignore-submodules", "--refresh", NULL
 	};
 	const char *diff_files[] = {
 		"diff-files", "--quiet", "--ignore-submodules", "--", NULL
@@ -746,7 +746,7 @@ static const char *update_worktree(unsigned char *sha1)
 		"HEAD", "--", NULL
 	};
 	const char *read_tree[] = {
-		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
+		"read-tree", "-u", "-m", NULL, NULL
 	};
 	const char *work_tree = git_work_tree_cfg ? git_work_tree_cfg : "..";
 	struct argv_array env = ARGV_ARRAY_INIT;
@@ -778,10 +778,9 @@ static const char *update_worktree(unsigned char *sha1)
 	child.git_cmd = 1;
 	if (run_command(&child)) {
 		argv_array_clear(&env);
-		return "Working directory not clean";
+		return "Working directory has unstaged changes";
 	}
 
-	/* run_command() does not clean up completely; reinitialize */
 	child_process_init(&child);
 	child.argv = diff_index;
 	child.env = env.argv;
@@ -791,10 +790,10 @@ static const char *update_worktree(unsigned char *sha1)
 	child.git_cmd = 1;
 	if (run_command(&child)) {
 		argv_array_clear(&env);
-		return "Working directory not clean";
+		return "Working directory has staged changes";
 	}
 
-	/* run_command() does not clean up completely; reinitialize */
+	read_tree[3] = sha1_to_hex(sha1);
 	child_process_init(&child);
 	child.argv = read_tree;
 	child.env = env.argv;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b8df39c..7b353d0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1341,14 +1341,19 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 	test $(git rev-parse HEAD) = $(cd testrepo && git rev-parse HEAD) &&
 	test third = "$(cat testrepo/path2)" &&
 	(cd testrepo &&
-		git update-index --refresh &&
-		git diff-files --quiet &&
-		git diff-index --cached HEAD -- &&
-		echo changed > path2 &&
+		git update-index -q --refresh &&
+		git diff-files --quiet -- &&
+		git diff-index --quiet --cached HEAD -- &&
+		echo changed >path2 &&
 		git add path2
 	) &&
 	test_commit fourth path2 &&
-	test_must_fail git push testrepo master
+	test_must_fail git push testrepo master &&
+	test $(git rev-parse HEAD^) = $(git -C testrepo rev-parse HEAD) &&
+	(cd testrepo &&
+		git diff --quiet &&
+		test changed = "$(cat path2)"
+	)
 '
 
 test_done

-- 
2.0.0.rc3.9669.g840d1f9
