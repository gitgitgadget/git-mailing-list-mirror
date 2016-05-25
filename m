From: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Subject: [RFC/PATCH] pull: set-upstream implementation
Date: Wed, 25 May 2016 17:25:28 +0200
Message-ID: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
Cc: tom.russello@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Jordan De Gea <jordan.de-gea@grenoble-inp.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 17:26:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5ahv-0006eB-1n
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 17:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbcEYP0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 11:26:38 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:55962 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbcEYP0g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 11:26:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 319B820F2;
	Wed, 25 May 2016 17:26:32 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w1gCRhmqCFNF; Wed, 25 May 2016 17:26:32 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2107B20D9;
	Wed, 25 May 2016 17:26:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 1AF962077;
	Wed, 25 May 2016 17:26:32 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3vK2v-YwTbZz; Wed, 25 May 2016 17:26:32 +0200 (CEST)
Received: from machin-portable.grenet.fr (eduroam-033094.grenet.fr [130.190.33.94])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id E61C92055;
	Wed, 25 May 2016 17:26:31 +0200 (CEST)
X-Mailer: git-send-email 2.8.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295574>

Implements pull [--set-upstream | -u] which sets the remote tracking
branch to the one the user just pulled from.

	git pull [--set-upstream | -u] <remote> <branch>

After successfully fetched from <remote>, sets branch.<name>.remote to
<remote> and branch.<name>.merge to follow <remote>/<branch>

Signed-off-by: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Signed-off-by: Jordan De Gea <jordan.de-gea@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
Hello,

`git push --set-upstream <remote> <branch>` sets the remote and merge config
variables for <branch> after successfully pushed.

This patch implements an equivalent for `git pull` or
`git branch --set-upstream-to=<remote>/<branch>`.

Difficulties:
	- I can't figure out what remote branch sould be tracked
	in that case: `git pull -u origin :master`
	- Is the result of 'resolve_ref_unsafe' should be freed ?

What's your opinion ?


 Documentation/git-pull.txt |  7 +++++
 builtin/pull.c             | 61 +++++++++++++++++++++++++++++++++++++
 t/t5544-pull-upstream.sh   | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100755 t/t5544-pull-upstream.sh

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d033b25..3a2e0b7 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -93,6 +93,13 @@ OPTIONS
 	has to be called afterwards to bring the work tree up to date with the
 	merge result.
 
+-u::
+--set-upstream::
+	For each branch that is successfully pulled, add
+	upstream (tracking) reference, used by argument-less
+	linkgit:git-push[1] and other commands. For more information,
+	see 'branch.<name>.merge' in linkgit:git-config[1].
+
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 1d7333c..e096858 100644
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
@@ -829,6 +836,57 @@ static int run_rebase(const unsigned char *curr_head,
 	return ret;
 }
 
+static int set_pull_upstream(const char *repo, const char **refspecs_name)
+{
+	unsigned char sha1[GIT_SHA1_RAWSZ];
+	const char *local_branch, *remote_branch;
+	struct strbuf remote_name;
+	struct refspec *refspecs;
+	int nr_refspec, i;
+
+	if (repo == NULL) {
+		warning(N_("no remote was specified"));
+		return 1;
+	}
+
+	for (nr_refspec = 0; refspecs_name[nr_refspec] != NULL; nr_refspec++);
+
+	if (nr_refspec == 0) {
+		warning(N_("no refspec was specified"));
+		return 1;
+	}
+
+	refspecs = parse_fetch_refspec(nr_refspec, refspecs_name);
+
+	for (i = 0; i < nr_refspec; i++) {
+		if (refspecs[i].src != NULL && strlen(refspecs[i].src) > 0) {
+			remote_branch = refspecs[i].src;
+		} else {
+			warning(N_("not yet implemented"));
+			continue;
+		}
+
+		if (refspecs[i].dst != NULL && strlen(refspecs[i].dst) > 0) {
+			local_branch = refspecs[i].dst;
+		} else {
+			// TODO : Should it be freed ?
+			local_branch = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
+			skip_prefix(local_branch, "refs/heads/", &local_branch);
+		}
+
+		strbuf_init(&remote_name, strlen(repo) + strlen(remote_branch) + 1);
+		strbuf_addf(&remote_name, "%s/%s", repo, remote_branch);
+
+		create_branch(local_branch, local_branch, remote_name.buf, 0, 0, 0, opt_verbosity < 0, BRANCH_TRACK_OVERRIDE);
+
+		strbuf_release(&remote_name);
+	}
+
+	free_refspec(nr_refspec, refspecs);
+
+	return 0;
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
@@ -884,6 +942,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_dry_run)
 		return 0;
 
+	if (opt_set_upstream)
+		set_pull_upstream(repo, refspecs);
+
 	if (get_sha1("HEAD", curr_head))
 		hashclr(curr_head);
 
diff --git a/t/t5544-pull-upstream.sh b/t/t5544-pull-upstream.sh
new file mode 100755
index 0000000..38eb51d
--- /dev/null
+++ b/t/t5544-pull-upstream.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description='pull with --set-upstream'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+
+ensure_fresh_upstream() {
+	rm -rf parent &&
+	git init parent &&
+	cd parent &&
+	(
+		echo content >file &&
+		git add file &&
+		git commit -m one &&
+		git checkout -b other &&
+		echo content >file2 &&
+		git add file2 &&
+		git commit -m two &&
+		git checkout -b master2 &&
+		git checkout master
+	) &&
+	cd ..
+}
+
+test_expect_success 'setup bare parent' '
+	ensure_fresh_upstream &&
+	git remote add upstream parent &&
+	git pull upstream master
+'
+
+check_config() {
+	(echo $2; echo $3) >expect.$1
+	(git config branch.$1.remote
+	 git config branch.$1.merge) >actual.$1
+	test_cmp expect.$1 actual.$1
+}
+
+test_expect_success 'pull -u master' '
+	git pull -u upstream master &&
+	check_config master upstream refs/heads/master
+'
+
+test_expect_success 'pull -u master:other' '
+	git pull -u upstream master:other &&
+	check_config other upstream refs/heads/master
+'
+
+test_expect_success 'pull -u --dry-run other:other' '
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
+test_expect_success 'pull -u HEAD' '
+	git clone parent son &&
+	cd son &&
+	git checkout -b headbranch &&
+	git pull -u origin HEAD &&
+	check_config headbranch origin refs/heads/master
+'
+
+test_expect_success TTY 'quiet pull' '
+	ensure_fresh_upstream &&
+
+	test_terminal git pull -u --quiet upstream master 2>&1 | tee output &&
+	test_cmp /dev/null output
+'
+
+test_done
-- 
2.8.2.562.gdbf6e3e
