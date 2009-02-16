From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [DRY HUMOR PATCH] Add a few more values for
 receive.denyCurrentBranch
Date: Mon, 16 Feb 2009 22:52:05 +0100 (CET)
Message-ID: <bfeaa5d164c9dc2d1080545e4bb9480920762ff2.1234820890u.git.johannes.schindelin@gmx.de>
References: <cover.1234820890u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 22:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZBPH-0002fh-Bn
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbZBPVwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbZBPVwK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:52:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:49570 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751777AbZBPVwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:52:08 -0500
Received: (qmail invoked by alias); 16 Feb 2009 21:52:06 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp057) with SMTP; 16 Feb 2009 22:52:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BIKI2HfRBFLbdmbLOliBr1X1wC6cnSJhMTCOpP8
	WO6bZIOPD685mn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1234820890u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110251>

Some people insist on work flows where they push into their checked-out
branches.

Now, everybody should agree that these people better know what they
are doing, and that most users are Better Of Avoiding That.

However, it seems that the existing users of the feature-not-a-bug that
you can push into non-bare repositories are preparing to give the Git
developers as much grief as for the dashed -> undashed migration, and
therefore it may be wise to give them a gift in return.

The gift consists of two new options you can give the config variable
receive.denyCurrentBranch:

'updateInstead':
	Try to merge the working tree with the new tip of the branch
	(which can lead to really horrible merge conflicts).

'detachInstead':
	Detach the HEAD, thereby avoiding a disagreement between the
	HEAD and the index (as well as the working tree), possibly
	leaving the local user wondering how on earth her HEAD became
	so detached.

And now everybody, sing!

	Gimme rope, Johannes,
	Gimme rope, Johannes,
	Gimme rope, Johannes,
	'fore the moaning come,
	Gimme rope, Johannes,
	Rope, Johannes,
	Rope before the moaning come.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |    5 ++++
 builtin-receive-pack.c   |   47 +++++++++++++++++++++++++++++++++++++++++++++-
 t/t5516-fetch-push.sh    |   36 +++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3117d65..441c595 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1201,6 +1201,11 @@ receive.denyCurrentBranch::
 	print a warning of such a push to stderr, but allow the push to
 	proceed. If set to false or "ignore", allow such pushes with no
 	message. Defaults to "warn".
++
+There are two more options that are meant for Git experts: "updateInstead"
+which will run `read-tree -u -m HEAD` and "detachInstead" which will detach
+the HEAD so it does not need to change.  Both options come with their own
+set of possible *complications*, but can be appropriate in rare workflows.
 
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index f7e04c4..23b8ceb 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -16,6 +16,8 @@ enum deny_action {
 	DENY_IGNORE,
 	DENY_WARN,
 	DENY_REFUSE,
+	DENY_UPDATE_INSTEAD,
+	DENY_DETACH_INSTEAD,
 };
 
 static int deny_deletes;
@@ -75,7 +77,12 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
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
 
@@ -273,6 +280,35 @@ static void warn_unconfigured_deny_delete_current(void)
 		warning(warn_unconfigured_deny_delete_current_msg[i]);
 }
 
+static void merge_worktree(unsigned char *sha1)
+{
+	const char *argv_read_tree[] = {
+		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
+	};
+	struct child_process read_tree;
+	struct strbuf git_env = STRBUF_INIT;
+	const char *env[2];
+
+	if (is_bare_repository())
+		die ("denyCurrentBranch = updateInstead needs a worktree");
+
+	strbuf_addf(&git_env, "GIT_DIR=%s", make_absolute_path(get_git_dir()));
+	env[0] = git_env.buf;
+	env[1] = NULL;
+
+	memset(&read_tree, 0, sizeof(read_tree));
+	read_tree.argv = argv_read_tree;
+	read_tree.env = env;
+	read_tree.dir = git_work_tree_cfg ? git_work_tree_cfg : "..";
+	read_tree.no_stdin = 1;
+	read_tree.no_stdout = 1;
+	read_tree.git_cmd = 1;
+	if (run_command(&read_tree))
+		die ("Could not merge working tree with new HEAD.  Good luck.");
+
+	strbuf_release(&git_env);
+}
+
 static const char *update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
@@ -299,6 +335,13 @@ static const char *update(struct command *cmd)
 		case DENY_REFUSE:
 			error("refusing to update checked out branch: %s", name);
 			return "branch is currently checked out";
+		case DENY_UPDATE_INSTEAD:
+			merge_worktree(new_sha1);
+			break;
+		case DENY_DETACH_INSTEAD:
+			update_ref("push into current branch (detach)", "HEAD",
+				old_sha1, NULL, REF_NODEREF, DIE_ON_ERR);
+			break;
 		}
 	}
 
@@ -327,6 +370,8 @@ static const char *update(struct command *cmd)
 			case DENY_REFUSE:
 				error("refusing to delete the current branch: %s", name);
 				return "deletion of the current branch prohibited";
+			default:
+				die ("Invalid denyDeleteCurrent setting");
 			}
 		}
 	}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 89649e7..40b98d3 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -573,4 +573,40 @@ test_expect_success 'push with branches containing #' '
 	git checkout master
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
1.6.1.1.825.g72a9f
