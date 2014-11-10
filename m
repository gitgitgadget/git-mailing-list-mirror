From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/2] Support updating working trees when pushing into
 non-bare repos
Date: Mon, 10 Nov 2014 15:38:28 +0100 (CET)
Message-ID: <cover.1415629053.git.johannes.schindelin@gmx.de>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 10 15:38:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnq7C-00009i-0X
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 15:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbaKJOik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 09:38:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:51449 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbaKJOij (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 09:38:39 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MQ33z-1Xt5B01ltD-005GXO;
 Mon, 10 Nov 2014 15:38:29 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1415368490.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:cVeWGhKxPBrPTNpKhseUJDtKtNiqTVi7lWuXsfxp3NDXdN3V5FD
 fCza9aaSIRs0Z9n8d6248zYTxM5lFT1ihpc0TFMDVItio3RrO4dN5kwTOWDrhwa6h0RIGml
 MYUfiSsvchcSwntUAG8/G2z064NFfD80gpC2C4DiqE8IxYRwFPbkWw1roAtn4nNoMrBxkgI
 3+SdGsqBNDSGzsbri4OoQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds support for two new receive.denyCurrentBranch settings:
one to update the working directory (which must be clean, i.e. there must not
be any uncommitted changes) when pushing into the current branch, the other
setting detaches the HEAD instead.

The scenario in which in particular the 'updateInstead' setting became a
boon in this developer's daily work is when trying to get a bug fix from a
Windows computer, a virtual machine or a user's machine onto his main
machine (in all of those cases it is only possible to connect via ssh in one
direction, but not in the reverse direction).

Interdiff vs v1 below the diffstat.

Johannes Schindelin (2):
  Clean stale environment pointer in finish_command()
  Add a few more options for receive.denyCurrentBranch

 Documentation/config.txt |  9 ++++++++
 builtin/receive-pack.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
 run-command.c            |  3 +++
 t/t5516-fetch-push.sh    | 36 +++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6fc0d6d..fc9b8db 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2130,10 +2130,14 @@ receive.denyCurrentBranch::
 	proceed. If set to false or "ignore", allow such pushes with no
 	message. Defaults to "refuse".
 +
-There are two more options: "updateInstead" which will update the working
-directory (must be clean) if pushing into the current branch, and
-"detachInstead" which will leave the working directory untouched, detaching
-the HEAD so it does not need to change.
+Another option is "updateInstead" which will update the working
+directory (must be clean) if pushing into the current branch. This option is
+intended for synchronizing working directories when one side is not easily
+accessible via ssh (e.g. inside a VM).
++
+Yet another option is "detachInstead" which will detach the HEAD if updates
+are pushed into the current branch; That way, the current revision, the
+index and the working directory are always left untouched by pushes.
 
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 2b2d797..7db860f 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 GVF=GIT-VERSION-FILE
-DEF_VER=v2.2.0-rc0
+DEF_VER=v2.2.0-rc1
 
 LF='
 '
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4ba51df..4534e88 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -28,7 +28,7 @@ enum deny_action {
 	DENY_WARN,
 	DENY_REFUSE,
 	DENY_UPDATE_INSTEAD,
-	DENY_DETACH_INSTEAD,
+	DENY_DETACH_INSTEAD
 };
 
 static int deny_deletes;
@@ -737,7 +737,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
-static void merge_worktree(unsigned char *sha1)
+static const char *merge_worktree(unsigned char *sha1)
 {
 	const char *update_refresh[] = {
 		"update-index", "--ignore-submodules", "--refresh", NULL
@@ -745,41 +745,36 @@ static void merge_worktree(unsigned char *sha1)
 	const char *read_tree[] = {
 		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
 	};
-	struct child_process child;
-	struct strbuf git_env = STRBUF_INIT;
-	const char *env[2];
+	struct child_process child = CHILD_PROCESS_INIT;
 
 	if (is_bare_repository())
-		die ("denyCurrentBranch = updateInstead needs a worktree");
-
-	strbuf_addf(&git_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
-	env[0] = git_env.buf;
-	env[1] = NULL;
+		return "denyCurrentBranch = updateInstead needs a worktree";
 
-	memset(&child, 0, sizeof(child));
+	argv_array_pushf(&child.env_array, "GIT_DIR=%s", absolute_path(get_git_dir()));
 	child.argv = update_refresh;
-	child.env = env;
 	child.dir = git_work_tree_cfg ? git_work_tree_cfg : "..";
 	child.stdout_to_stderr = 1;
 	child.git_cmd = 1;
 	if (run_command(&child))
-		die ("Could not refresh the index");
+		die("Could not refresh the index");
 
+	/* finish_command cleared the environment; reinitialize */
+	argv_array_pushf(&child.env_array, "GIT_DIR=%s", absolute_path(get_git_dir()));
 	child.argv = read_tree;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
 	child.stdout_to_stderr = 0;
 	if (run_command(&child))
-		die ("Could not merge working tree with new HEAD.  Good luck.");
+		die("Could not merge working tree with new HEAD.");
 
-	strbuf_release(&git_env);
+	return NULL;
 }
 
 static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
 	struct strbuf namespaced_name_buf = STRBUF_INIT;
-	const char *namespaced_name;
+	const char *namespaced_name, *ret;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
 
@@ -806,11 +801,17 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				refuse_unconfigured_deny();
 			return "branch is currently checked out";
 		case DENY_UPDATE_INSTEAD:
-			merge_worktree(new_sha1);
+			ret = merge_worktree(new_sha1);
+			if (ret)
+				return ret;
 			break;
 		case DENY_DETACH_INSTEAD:
-			update_ref("push into current branch (detach)", "HEAD",
-				old_sha1, NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+			ret = update_ref("push into current branch (detach)",
+				"HEAD", old_sha1, NULL, REF_NODEREF,
+				UPDATE_REFS_DIE_ON_ERR) ?
+				"Could not detach HEAD" : NULL;
+			if (ret)
+				return ret;
 			break;
 		}
 	}
diff --git a/run-command.c b/run-command.c
index 79a0a76..85578da 100644
--- a/run-command.c
+++ b/run-command.c
@@ -555,6 +555,9 @@ int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0]);
 	argv_array_clear(&cmd->args);
+	/* Avoid pointing to a stale environment */
+	if (cmd->env == cmd->env_array.argv)
+		cmd->env = NULL;
 	argv_array_clear(&cmd->env_array);
 	return ret;
 }

-- 
2.0.0.rc3.9669.g840d1f9
