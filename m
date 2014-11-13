From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/1] Support updating working trees when pushing into
 non-bare repos
Date: Thu, 13 Nov 2014 12:03:41 +0100 (CET)
Message-ID: <cover.1415876330.git.johannes.schindelin@gmx.de>
References: <cover.1415629053.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 13 12:04:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XosC1-0006jF-OX
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbaKMLDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 06:03:50 -0500
Received: from mout.gmx.net ([212.227.15.19]:62260 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932581AbaKMLDr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:03:47 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MX16a-1XRrha1MCy-00Vtlp;
 Thu, 13 Nov 2014 12:03:42 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1415629053.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:gXf0M8LvRcTATWiDofNxbRK6e8nbNz7scHSQlEC1zzbTmVLs2VY
 tr3kWJxsNrlL0yHkNlukJxKpfmaLe1JsjYTl/cm4iOkVmAbIR48xMfUfG9Qqx0pdfIuGpMd
 pckYAGBF5cMwjg0EQ7YEXUHmkRUnb6l0iQj0ZzpNMLRnn91YFDN/GO1tnXSCA1w9wIvhEY1
 WQOiOKLTbDpHywC1Jw9dQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds support for a new receive.denyCurrentBranch setting
to update the working directory (which must be clean, i.e. there must not be
any uncommitted changes) when pushing into the current branch.

The scenario in which the 'updateInstead' setting became a boon in this
developer's daily work is when trying to get a bug fix from a Windows
computer, a virtual machine or a user's machine onto his main machine (in
all of those cases it is only possible to connect via ssh in one direction,
but not in the reverse direction).

Interdiff vs v2 below the diffstat.

Johannes Schindelin (1):
  Add another option for receive.denyCurrentBranch

 Documentation/config.txt |  5 ++++
 builtin/receive-pack.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t5516-fetch-push.sh    | 17 +++++++++++
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4f9fe81..c384515 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2134,10 +2134,6 @@ Another option is "updateInstead" which will update the working
 directory (must be clean) if pushing into the current branch. This option is
 intended for synchronizing working directories when one side is not easily
 accessible via ssh (e.g. inside a VM).
-+
-Yet another option is "detachInstead" which will detach the HEAD if updates
-are pushed into the current branch; That way, the current revision, the
-index and the working directory are always left untouched by pushes.
 
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4534e88..836720f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -27,8 +27,7 @@ enum deny_action {
 	DENY_IGNORE,
 	DENY_WARN,
 	DENY_REFUSE,
-	DENY_UPDATE_INSTEAD,
-	DENY_DETACH_INSTEAD
+	DENY_UPDATE_INSTEAD
 };
 
 static int deny_deletes;
@@ -78,6 +77,8 @@ static enum deny_action parse_deny_action(const char *var, const char *value)
 			return DENY_WARN;
 		if (!strcasecmp(value, "refuse"))
 			return DENY_REFUSE;
+		if (!strcasecmp(value, "updateinstead"))
+			return DENY_UPDATE_INSTEAD;
 	}
 	if (git_config_bool(var, value))
 		return DENY_REFUSE;
@@ -122,12 +123,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "receive.denycurrentbranch")) {
-		if (value && !strcasecmp(value, "updateinstead"))
-			deny_current_branch = DENY_UPDATE_INSTEAD;
-		else if (value && !strcasecmp(value, "detachinstead"))
-			deny_current_branch = DENY_DETACH_INSTEAD;
-		else
-			deny_current_branch = parse_deny_action(var, value);
+		deny_current_branch = parse_deny_action(var, value);
 		return 0;
 	}
 
@@ -737,36 +733,66 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
-static const char *merge_worktree(unsigned char *sha1)
+static const char *update_worktree(unsigned char *sha1)
 {
 	const char *update_refresh[] = {
 		"update-index", "--ignore-submodules", "--refresh", NULL
 	};
+	const char *diff_index[] = {
+		"diff-index", "--quiet", "--cached", "--ignore-submodules",
+		"HEAD", "--", NULL
+	};
 	const char *read_tree[] = {
 		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
 	};
+	const char *work_tree = git_work_tree_cfg ? git_work_tree_cfg : "..";
+	struct argv_array env = ARGV_ARRAY_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	if (is_bare_repository())
 		return "denyCurrentBranch = updateInstead needs a worktree";
 
-	argv_array_pushf(&child.env_array, "GIT_DIR=%s", absolute_path(get_git_dir()));
+	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));
+
 	child.argv = update_refresh;
-	child.dir = git_work_tree_cfg ? git_work_tree_cfg : "..";
+	child.env = env.argv;
+	child.dir = work_tree;
+	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
 	child.git_cmd = 1;
-	if (run_command(&child))
-		die("Could not refresh the index");
+	if (run_command(&child)) {
+		argv_array_clear(&env);
+		return "Up-to-date check failed";
+	}
 
-	/* finish_command cleared the environment; reinitialize */
-	argv_array_pushf(&child.env_array, "GIT_DIR=%s", absolute_path(get_git_dir()));
+	/* run_command() does not clean up completely; reinitialize */
+	child_process_init(&child);
+	child.argv = diff_index;
+	child.env = env.argv;
+	child.no_stdin = 1;
+	child.no_stdout = 1;
+	child.stdout_to_stderr = 0;
+	child.git_cmd = 1;
+	if (run_command(&child)) {
+		argv_array_clear(&env);
+		return "Working directory not clean";
+	}
+
+	/* run_command() does not clean up completely; reinitialize */
+	child_process_init(&child);
 	child.argv = read_tree;
+	child.env = env.argv;
+	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
 	child.stdout_to_stderr = 0;
-	if (run_command(&child))
-		die("Could not merge working tree with new HEAD.");
+	child.git_cmd = 1;
+	if (run_command(&child)) {
+		argv_array_clear(&env);
+		return "Could not update working tree to new HEAD";
+	}
 
+	argv_array_clear(&env);
 	return NULL;
 }
 
@@ -801,15 +827,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				refuse_unconfigured_deny();
 			return "branch is currently checked out";
 		case DENY_UPDATE_INSTEAD:
-			ret = merge_worktree(new_sha1);
-			if (ret)
-				return ret;
-			break;
-		case DENY_DETACH_INSTEAD:
-			ret = update_ref("push into current branch (detach)",
-				"HEAD", old_sha1, NULL, REF_NODEREF,
-				UPDATE_REFS_DIE_ON_ERR) ?
-				"Could not detach HEAD" : NULL;
+			ret = update_worktree(new_sha1);
 			if (ret)
 				return ret;
 			break;
@@ -837,12 +855,13 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				break;
 			case DENY_REFUSE:
 			case DENY_UNCONFIGURED:
+			case DENY_UPDATE_INSTEAD:
 				if (deny_delete_current == DENY_UNCONFIGURED)
 					refuse_unconfigured_deny_delete_current();
 				rp_error("refusing to delete the current branch: %s", name);
 				return "deletion of the current branch prohibited";
 			default:
-				die ("Invalid denyDeleteCurrent setting");
+				return "Invalid denyDeleteCurrent setting";
 			}
 		}
 	}
diff --git a/run-command.c b/run-command.c
index 551c6c2..a476999 100644
--- a/run-command.c
+++ b/run-command.c
@@ -555,9 +555,6 @@ int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0]);
 	argv_array_clear(&cmd->args);
-	/* Avoid pointing to a stale environment */
-	if (cmd->env == cmd->env_array.argv)
-		cmd->env = NULL;
 	argv_array_clear(&cmd->env_array);
 	return ret;
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3981d1b..ba002a9 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1347,23 +1347,4 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 	)
 '
 
-test_expect_success 'receive.denyCurrentBranch = detachInstead' '
-	(cd testrepo &&
-		git reset --hard &&
-		git config receive.denyCurrentBranch detachInstead
-	) &&
-	OLDHEAD=$(cd testrepo && git rev-parse HEAD) &&
-	test_commit fourth path2 &&
-	test fourth = "$(cat path2)" &&
-	git push testrepo master &&
-	test $OLDHEAD = $(cd testrepo && git rev-parse HEAD) &&
-	test fourth != "$(cat testrepo/path2)" &&
-	(cd testrepo &&
-		test_must_fail git symbolic-ref HEAD &&
-		git update-index --refresh &&
-		git diff-files --quiet &&
-		git diff-index --cached HEAD --
-	)
-'
-
 test_done

-- 
2.0.0.rc3.9669.g840d1f9
