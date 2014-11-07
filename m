From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] Add a few more values for receive.denyCurrentBranch
Date: Fri, 7 Nov 2014 14:58:17 +0100 (CET)
Message-ID: <f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 07 14:58:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmk3g-0000Ot-1A
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 14:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbaKGN6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 08:58:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:51597 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbaKGN6U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 08:58:20 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MdoR7-1XNeWC37UL-00PaFg;
 Fri, 07 Nov 2014 14:58:17 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1415368490.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:8TONXUU3G01zKo1G8zN08UElLzfKfbjkPwX9xtVLta834QAU+2g
 0x/AWz6TapSIWvkMATmWu1DVCjlsjug4WNai8UN7hbROnnsFOGW9ENmLG4D/KggTAIPI3O/
 S3dB3KVWFVF8kpmyGdfhS3ypqB1Z45g7/1QGhFn7c2bowup05/xksbm4TWWkroN0KK+Gv+f
 qbfOtUaCIlKZ0zY2RS7Nw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Under certain circumstances, it makes a *lot* of sense to allow pushing
into the current branch. For example, when two machines with different
Operating Systems are required for testing, it makes much more sense to
synchronize between working directories than having to go via a third
server.

Under different circumstances, the working directory needs to be left
untouched, for example when a bunch of VMs need to be shut down to save
RAM and one needs to push everything out into the host's non-bare
repositories quickly.

This change supports both workflows by offering two new values for the
denyCurrentBranch setting:

'updateInstead':
	Update the working tree accordingly, but refuse to do so if there
	are any uncommitted changes.

'detachInstead':
	Detach the HEAD, thereby keeping currently checked-out revision,
	index and working directory unchanged.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  5 +++++
 builtin/receive-pack.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t5516-fetch-push.sh    | 36 ++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e8dd76d..6fc0d6d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2129,6 +2129,11 @@ receive.denyCurrentBranch::
 	print a warning of such a push to stderr, but allow the push to
 	proceed. If set to false or "ignore", allow such pushes with no
 	message. Defaults to "refuse".
++
+There are two more options: "updateInstead" which will update the working
+directory (must be clean) if pushing into the current branch, and
+"detachInstead" which will leave the working directory untouched, detaching
+the HEAD so it does not need to change.
 
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..be4172f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -26,7 +26,9 @@ enum deny_action {
 	DENY_UNCONFIGURED,
 	DENY_IGNORE,
 	DENY_WARN,
-	DENY_REFUSE
+	DENY_REFUSE,
+	DENY_UPDATE_INSTEAD,
+	DENY_DETACH_INSTEAD,
 };
 
 static int deny_deletes;
@@ -120,7 +122,12 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "receive.denycurrentbranch")) {
-		deny_current_branch = parse_deny_action(var, value);
+		if (value && !strcasecmp(value, "updateinstead"))
+			deny_current_branch = DENY_UPDATE_INSTEAD;
+		else if (value && !strcasecmp(value, "detachinstead"))
+			deny_current_branch = DENY_DETACH_INSTEAD;
+		else
+			deny_current_branch = parse_deny_action(var, value);
 		return 0;
 	}
 
@@ -730,6 +737,44 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
+static void merge_worktree(unsigned char *sha1)
+{
+	const char *update_refresh[] = {
+		"update-index", "--refresh", NULL
+	};
+	const char *read_tree[] = {
+		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
+	};
+	struct child_process child;
+	struct strbuf git_env = STRBUF_INIT;
+	const char *env[2];
+
+	if (is_bare_repository())
+		die ("denyCurrentBranch = updateInstead needs a worktree");
+
+	strbuf_addf(&git_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
+	env[0] = git_env.buf;
+	env[1] = NULL;
+
+	memset(&child, 0, sizeof(child));
+	child.argv = update_refresh;
+	child.env = env;
+	child.dir = git_work_tree_cfg ? git_work_tree_cfg : "..";
+	child.stdout_to_stderr = 1;
+	child.git_cmd = 1;
+	if (run_command(&child))
+		die ("Could not refresh the index");
+
+	child.argv = read_tree;
+	child.no_stdin = 1;
+	child.no_stdout = 1;
+	child.stdout_to_stderr = 0;
+	if (run_command(&child))
+		die ("Could not merge working tree with new HEAD.  Good luck.");
+
+	strbuf_release(&git_env);
+}
+
 static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
@@ -760,6 +805,13 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			if (deny_current_branch == DENY_UNCONFIGURED)
 				refuse_unconfigured_deny();
 			return "branch is currently checked out";
+		case DENY_UPDATE_INSTEAD:
+			merge_worktree(new_sha1);
+			break;
+		case DENY_DETACH_INSTEAD:
+			update_ref("push into current branch (detach)", "HEAD",
+				old_sha1, NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+			break;
 		}
 	}
 
@@ -788,6 +840,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 					refuse_unconfigured_deny_delete_current();
 				rp_error("refusing to delete the current branch: %s", name);
 				return "deletion of the current branch prohibited";
+			default:
+				die ("Invalid denyDeleteCurrent setting");
 			}
 		}
 	}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f4da20a..3981d1b 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1330,4 +1330,40 @@ test_expect_success 'fetch into bare respects core.logallrefupdates' '
 	)
 '
 
+test_expect_success 'receive.denyCurrentBranch = updateInstead' '
+	git push testrepo master &&
+	(cd testrepo &&
+		git reset --hard &&
+		git config receive.denyCurrentBranch updateInstead
+	) &&
+	test_commit third path2 &&
+	git push testrepo master &&
+	test $(git rev-parse HEAD) = $(cd testrepo && git rev-parse HEAD) &&
+	test third = "$(cat testrepo/path2)" &&
+	(cd testrepo &&
+		git update-index --refresh &&
+		git diff-files --quiet &&
+		git diff-index --cached HEAD --
+	)
+'
+
+test_expect_success 'receive.denyCurrentBranch = detachInstead' '
+	(cd testrepo &&
+		git reset --hard &&
+		git config receive.denyCurrentBranch detachInstead
+	) &&
+	OLDHEAD=$(cd testrepo && git rev-parse HEAD) &&
+	test_commit fourth path2 &&
+	test fourth = "$(cat path2)" &&
+	git push testrepo master &&
+	test $OLDHEAD = $(cd testrepo && git rev-parse HEAD) &&
+	test fourth != "$(cat testrepo/path2)" &&
+	(cd testrepo &&
+		test_must_fail git symbolic-ref HEAD &&
+		git update-index --refresh &&
+		git diff-files --quiet &&
+		git diff-index --cached HEAD --
+	)
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9
