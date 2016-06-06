From: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Subject: [RFC/PATCH v2] pull: add --set-upstream
Date: Mon,  6 Jun 2016 11:34:37 +0200
Message-ID: <20160606093437.1992-1-erwan.mathoniere@grenoble-inp.org>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
Cc: jordan.de-gea@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, tom.russello@grenoble-inp.org,
	gitster@pobox.com, Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 11:36:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9qxF-0006ZP-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 11:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbcFFJgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 05:36:07 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:60726 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcFFJgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 05:36:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0507520B4;
	Mon,  6 Jun 2016 11:35:59 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzRz8ZgbONsR; Mon,  6 Jun 2016 11:35:58 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E7FB9204E;
	Mon,  6 Jun 2016 11:35:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id E4BD82066;
	Mon,  6 Jun 2016 11:35:58 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4StJStpTOUxl; Mon,  6 Jun 2016 11:35:58 +0200 (CEST)
Received: from machin-portable.grenet.fr (eduroam-032088.grenet.fr [130.190.32.88])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id CADF02055;
	Mon,  6 Jun 2016 11:35:58 +0200 (CEST)
X-Mailer: git-send-email 2.8.0.GIT
In-Reply-To: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296488>

Implement `git pull [--set-upstream | -u] <remote> <refspecs>` that set
tracking to the remote branch the user just pulled from.

After successfully pulling from `<remote>`, for each `<refspec>`
described in format `<remote_branch>:<local_branch>`, set
`branch.<local_branch>.remote` to `<remote>` and
`branch.<local_branch>.merge` to `refs/heads/<remote_branch>`. If
`<refspec>` lacks `<local_branch>` in the previous format or directly
refers to a branch, use the current branch as `<local_branch>` in the
above configuration setting.

`git push` has already its `--set-upstream`, it makes sense to have its
symmetrical for `git pull`.

For a beginner, when trying to use argumentless `git pull` without
tracking information set, advising to use 
`git branch --set-upstream-to` to set upstream can be quite confusing.
Using this `git pull --set-upstream` is easier and more natural.

Signed-off-by: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Signed-off-by: Jordan De Gea <jordan.de-gea@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---

Changes from v1:
- Code reshaped to :
  * warn + no-op when pulling from or to something that isn't a branch
or a configured remote
  * set upstream only after successfully merging/rebasing
- More relevant documentation
- Tests reshaped to be more independent from each others
- More tests (tags, detached heads, non-configured remote...)


For now, the documentation is quite hard to understand, but I didn't
figure how to explain without using too technical words. Should it stay
as it is or should I write something similar the above commit message?

Allowing to set non-configured repository as upstream isn't easy to
handle since the type of refspec must be checked and this is done by
verifying the existence of the remote-tracking branch at
`refs/remotes/<remote>/<branch>`.


 Documentation/git-pull.txt |  18 +++++
 builtin/pull.c             | 106 ++++++++++++++++++++++++++++-
 t/t5544-pull-upstream.sh   | 164 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+), 3 deletions(-)
 create mode 100755 t/t5544-pull-upstream.sh

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d033b25..6ae5e58 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -93,6 +93,24 @@ OPTIONS
 	has to be called afterwards to bring the work tree up to date with the
 	merge result.
 
+-u::
+--set-upstream::
+	After successfully pulling from explicitly given <repository> and
+	<refspecs>, set the configuration of the local branches pulled on, so
+	that each one tracks the remote branch pulled from. If a configuration
+	already exists, it is overwriten. For example, with `git pull -u origin
+	branch` the current branch will track `branch` from `origin`.
++
+If two or more branches are pulled on the same local branch, only the last one
+in arguments will be tracked.
++
+The given <repository> must be a configured remote. Can only set tracking to
+remote branches (e.g. can't set upstream to remote HEAD).
++
+Works symmetrically as `--set-upstream` for linkgit:git-push[1]. Allow using
+argumentless linkgit:git-pull[1] and other commands.  For more information, see
+`branch.<name>.merge` in linkgit:git-config[1].
+
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 1d7333c..d9823d5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -17,6 +17,7 @@
 #include "revision.h"
 #include "tempfile.h"
 #include "lockfile.h"
+#include "branch.h"
 
 enum rebase_type {
 	REBASE_INVALID = -1,
@@ -109,6 +110,9 @@ static char *opt_unshallow;
 static char *opt_update_shallow;
 static char *opt_refmap;
 
+/* Options about upstream */
+static int opt_set_upstream;
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -116,6 +120,9 @@ static struct option pull_options[] = {
 		N_("force progress reporting"),
 		PARSE_OPT_NOARG),
 
+	/* Options about upstream */
+	OPT_BOOL('u', "set-upstream", &opt_set_upstream, N_("set upstream for git pull/status")),
+
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
@@ -497,6 +504,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:"));
 		fprintf(stderr, "\n");
+		fprintf_ln(stderr, "    git pull -u %s %s", _("<remote>"), _("<branch>"));
+		fprintf(stderr, "\n");
+		fprintf_ln(stderr, _("or"));
+		fprintf(stderr, "\n");
 		fprintf_ln(stderr, "    git branch --set-upstream-to=%s/%s %s\n",
 				remote_name, _("<branch>"), curr_branch->name);
 	} else
@@ -829,8 +840,92 @@ static int run_rebase(const unsigned char *curr_head,
 	return ret;
 }
 
+static void set_pull_upstream(const char *repo, const char **refspecs_name)
+{
+	unsigned char sha1[GIT_SHA1_RAWSZ];
+	struct refspec *refspec;
+	struct branch *branch;
+	struct remote *remote;
+	struct strbuf buf;
+	struct refspec tracking_refspec;
+	int nr_refspec, i, flags;
+
+	if (!repo) {
+		warning(_("a remote must be specified to set the upstream"));
+		return;
+	}
+
+	remote = remote_get(repo);
+	if (!remote) {
+		warning(_("cannot set upstream: "
+			"'%s' is not a configured remote"), repo);
+	}
+
+	for (nr_refspec = 0; refspecs_name[nr_refspec] != NULL; nr_refspec++)
+		; /* just counting */
+
+	if (nr_refspec == 0) {
+		warning(_("a remote branch must be specified to set the upstream"));
+		return;
+	}
+
+	strbuf_init(&buf, 0);
+	refspec = parse_fetch_refspec(nr_refspec, refspecs_name);
+
+	for (i = 0; i < nr_refspec; i++) {
+		if (refspec[i].pattern) {
+			warning(_("upstream cannot be set for patterns"));
+			continue;
+		}
+
+		branch = branch_get(refspec[i].dst);
+		if (!branch || !ref_exists(branch->refname)) {
+			if (!refspec[i].dst || !*refspec[i].dst)
+				warning(_("could not set upstream of HEAD when "
+					"it does not point to any branch."));
+			else
+				warning(_("cannot set upstream: "
+					"'%s' is not a branch"), refspec[i].dst);
+
+			continue;
+		}
+
+		if (!refspec[i].src || !*refspec[i].src) {
+			warning(_("remote branch must be specified "
+				"to set upstream"));
+			continue;
+		}
+		
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/heads/%s", refspec[i].src);
+		memset(&tracking_refspec, 0, sizeof(struct refspec));
+		tracking_refspec.src = buf.buf;
+
+		if (remote_find_tracking(remote, &tracking_refspec)) {
+			warning(_("cannot set upstream: "
+				"no such remote branch '%s'"), refspec[i].src);
+			continue;
+		}
+
+		if (!resolve_ref_unsafe(tracking_refspec.dst, RESOLVE_REF_READING,
+					sha1, &flags)
+				|| (flags & REF_ISSYMREF)) {
+			warning(_("cannot set upstream: "
+				"no such remote branch '%s'"), refspec[i].src);
+			continue;
+		}
+
+		install_branch_config((opt_verbosity >= 0 ? BRANCH_CONFIG_VERBOSE : 0),
+		      branch->name, repo, buf.buf);
+	}
+
+	free_refspec(nr_refspec, refspec);
+	strbuf_release(&buf);
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
+	int ret;
 	const char *repo, **refspecs;
 	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
 	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
@@ -918,11 +1013,16 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (is_null_sha1(orig_head)) {
 		if (merge_heads.nr > 1)
 			die(_("Cannot merge multiple branches into empty head."));
-		return pull_into_void(*merge_heads.sha1, curr_head);
+		ret = pull_into_void(*merge_heads.sha1, curr_head);
 	} else if (opt_rebase) {
 		if (merge_heads.nr > 1)
 			die(_("Cannot rebase onto multiple branches."));
-		return run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
+		ret = run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
 	} else
-		return run_merge();
+		ret = run_merge();
+
+	if (opt_set_upstream && ret < 128)
+		set_pull_upstream(repo, refspecs);
+
+	return ret;
 }
diff --git a/t/t5544-pull-upstream.sh b/t/t5544-pull-upstream.sh
new file mode 100755
index 0000000..59f009d
--- /dev/null
+++ b/t/t5544-pull-upstream.sh
@@ -0,0 +1,164 @@
+#!/bin/sh
+
+test_description='pull with --set-upstream'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+
+test_config_unchanged () {
+	git config --list --local >original
+	"$@"
+	git config --list --local >modified
+	test_cmp original modified
+}
+
+check_config () {
+	(echo "$2"; echo "$3") >expect
+	(git config branch.$1.remote
+	 git config branch.$1.merge) >actual
+	test_cmp expect actual
+}
+
+test_expect_success 'setup repos' '
+	git init parent &&
+	(
+		cd parent &&
+		echo content >file &&
+		git add file &&
+		git commit -am one &&
+		git tag initial_tag &&
+		git checkout -b master2 &&
+		echo content_modified >file &&
+		git commit -am "file modification"
+		git checkout -b other master &&
+		echo content >file2 &&
+		git add file2 &&
+		git commit -am two &&
+		git checkout -b other2
+	) &&
+	git init step_parent &&
+	(
+		cd step_parent &&
+		echo step_content >step_file &&
+		git add step_file &&
+		git commit -m step_one
+	) &&
+	git remote add upstream parent &&
+	git remote add step_upstream step_parent &&
+	git pull upstream master &&
+	git branch other
+'
+
+test_expect_success 'pull -u master' '
+	git pull -u upstream master &&
+	check_config master upstream refs/heads/master
+'
+
+test_expect_success 'pull -u takes the last branch as upstream' '
+	test_might_fail git config --unset branch.master.merge &&
+	test_might_fail git config --unset branch.master.remote &&
+	git pull -u upstream master master2 &&
+	check_config master upstream refs/heads/master2
+'
+
+test_expect_success 'pull -u master:other' '
+	git pull -u upstream master:other &&
+	check_config other upstream refs/heads/master
+'
+
+
+test_expect_success 'pull -u tracking non-local branch' '
+	git checkout -b master2_local &&
+	git pull -u upstream master2 &&
+	check_config master2_local upstream refs/heads/master2
+'
+
+
+test_expect_success 'pull -u --dry-run other:other' '
+	git config branch.other.merge refs/heads/master &&
+	git config branch.other.remote upstream &&
+	git pull -u --dry-run upstream other:other &&
+	check_config other upstream refs/heads/master
+'
+
+test_expect_success 'pull -u master2:master2 master:other' '
+	git branch master2 &&
+	git pull -u upstream master2:master2 master:other &&
+	check_config master2 upstream refs/heads/master2 &&
+	check_config other upstream refs/heads/master
+'
+
+test_expect_success 'pull -u HEAD does not track origin/HEAD nor remote HEAD on origin' '
+	git checkout -b other_head master &&
+	git fetch upstream other &&
+	git remote set-head upstream other &&
+	test_config_unchanged git pull -u upstream HEAD
+'
+
+test_expect_success 'pull -u sets upstream when merge conflicts occur' '
+	git checkout -b master_edited master &&
+	echo conflict >file2 &&
+	git add file2 &&
+	git commit -am conflict &&
+	test_must_fail git pull -u upstream other &&
+	git rm file2 &&
+	git commit &&
+	check_config master_edited upstream refs/heads/other
+'
+
+test_expect_success 'pull -u should not work when merging unrelated histories' '
+	git checkout master &&
+	test_config_unchanged test_must_fail git pull -u step_parent master
+'
+
+test_expect_success 'pull -u sets upstream after rebasing' '
+	git checkout -b other_rebased other &&
+	git config branch.other_rebased.merge master &&
+	ls .git/refs/remotes/upstream &&
+	git pull -r -u upstream master2 &&
+	git branch --set-upstream-to=upstream/master2 &&
+	ls .git/refs/remotes/upstream &&
+	check_config other_rebased upstream refs/heads/master2
+'
+
+test_expect_success 'pull -u refs/heads/*:refs/remotes/origin/* should not work' '
+	git checkout master &&
+	test_config_unchanged git pull -u upstream "refs/heads/*:refs/remotes/upstream/*"
+'
+
+test_expect_success 'pull -u master:refs/remotes/origin/master should not work' '
+	test_config_unchanged git pull -u upstream master:refs/remotes/upstream/master
+'
+
+test_expect_success 'pull -u with a tag should not work' '
+	git checkout master &&
+	test_config_unchanged git pull -u upstream initial_tag
+'
+
+test_expect_success 'pull -u on detached head should not work' '
+	git checkout HEAD^0 &&
+	test_config_unchanged git pull -u upstream master2 &&
+	git checkout -
+'
+
+test_expect_success 'pull -u with an unconfigured remote should not work' '
+	git checkout master &&
+	git clone parent unconfigured_parent &&
+	test_config_unchanged git pull -u "$(pwd)/unconfigured_parent" other2
+'
+
+test_expect_success 'pull -u with a modified remote.fetch' '
+	git remote add origin_modified parent &&
+	git push upstream master:custom_branch &&
+	git config remote.origin_modified.fetch "+refs/heads/*:refs/remotes/custom/*" &&
+	git checkout -b lonely_branch master &&
+	git pull -u origin_modified custom_branch &&
+	check_config lonely_branch origin_modified refs/heads/custom_branch
+'
+
+test_expect_success TTY 'quiet pull' '
+	git checkout master &&
+	test_terminal git pull -u --quiet upstream master 2>&1 | tee output &&
+	test_cmp /dev/null output
+'
+
+test_done
-- 
2.8.2.662.g22d3535.dirty
