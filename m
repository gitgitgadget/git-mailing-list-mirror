From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH (WIP)] Show a dirty working tree and a detached HEAD in
 status for submodule
Date: Mon, 11 Jan 2010 23:05:10 +0100
Message-ID: <4B4BA096.5000909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:05:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUSOb-0007kd-N8
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 23:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab0AKWFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 17:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027Ab0AKWFu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 17:05:50 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:47103 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab0AKWFt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 17:05:49 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id E272914BC4925;
	Mon, 11 Jan 2010 23:05:47 +0100 (CET)
Received: from [80.128.92.70] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NUSNr-0005Br-00; Mon, 11 Jan 2010 23:05:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/Qm+/kUXg6D8ceAXUhN57wM1pvAnsNjwQeop4b
	zfl4Rh6YzcpYTmpiRG+E0ZlU7dbcR7lUKuPd2M6W5TXa7uwVBv
	MGvaGGuSywRZi5VBQRjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136670>

Until now a submodule only showed up as changed in the supermodule when
the last commit in the submodule differed from the one in the index or
the last commit of the superproject. A dirty working tree or a detached
HEAD in a submodule were just ignored when looking at it from the
superproject.

This patch shows these changes when using git status or one of the diff
commands which compare against the working tree in the superproject.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


This is the first version of a patch letting git status and the git
diff family show dirty working directories and a detached HEAD in
directories. It is not intended to be merged in its present form but
to be used as a starting point for discussion if this is going in
the right direction.


What the patch does:

* It makes git show submodules as modified in the superproject when
  one or more of these conditions are met:

    a) The submodule contains untracked files
    b) The submodule contains modified files
    c) The submodules HEAD is not on a local or remote branch

  That can be seen when using either "git status", "git diff[-files]"
  & "git diff[-index] HEAD" (and with "git gui" & gitk).


What the patch doesn't do (yet):

* It still breaks tests t7400-submodule-basic.sh &
  t7407-submodule-foreach.sh.

* It doesn't give detailed output when doing a "git diff* -p" with or
  without the --submodule option. It should show something like

    diff --git a/sub b/sub
    index 5431f52..3f35670 160000
    --- a/sub
    +++ b/sub
    @@ -1 +1 @@
    -Subproject commit 5431f529197f3831cdfbba1354a819a79f948f6f
    +Subproject commit 3f356705649b5d566d97ff843cf193359229a453-dirty

  for "git diff* -p" (notice the "-dirty" in the last line) or

      Submodule sub contains untracked files
      Submodule sub contains modified files
      Submodule sub contains a HEAD not on any branch
      Submodule sub 5431f52..3f35670:
      > commit message 1

  when using the --submodule option of the diff family.

* This behavior is not configurable but activated by default. A config
  option is needed here.

* It doesn't give optimal performance:

  - Apart from the fact that checking submodules this way will always
    be slower than ignoring their changes as git does until now, doing
    two run_command() calls for each submodule is not going to help at
    all (especially when running on Windows).

  - AFAICS the check for a detached HEAD would be faster for the most
    probable case if it would check against remotes/origin/master first.
    And it could stop when the first branch was found instead of
    continuing to look for others too as "git branch --contains" does.

  - Similar for the test for a dirty working directory, no need to have
    the full list of new and modified files, it could stop at the first
    one it finds.

  - If no detailed output is wanted the examination of HEAD and the
    working directory is not necessary when the HEAD and the commit in
    the index of the superproject already don't match.


What do you think?




 diff-lib.c                  |    7 +++-
 submodule.c                 |  103 +++++++++++++++++++++++++++++++++++++++++++
 submodule.h                 |    1 +
 t/t7506-status-submodule.sh |   45 ++++++++++++++++++-
 4 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 1c7e652..323305a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -159,7 +159,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}

-		if (ce_uptodate(ce) || ce_skip_worktree(ce))
+		if ((ce_uptodate(ce) && !S_ISGITLINK(ce->ce_mode)) || ce_skip_worktree(ce))
 			continue;

 		/* If CE_VALID is set, don't look at workdir for file removal */
@@ -176,6 +176,11 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			continue;
 		}
 		changed = ce_match_stat(ce, &st, ce_option);
+		if (S_ISGITLINK(ce->ce_mode)) {
+			/* TODO: This should not be executed when the submodule is changed
+			 * and only short ouptut is wanted for performance reasons. */
+			changed |= is_submodule_modified(ce->name);
+		}
 		if (!changed) {
 			ce_mark_uptodate(ce);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
diff --git a/submodule.c b/submodule.c
index 86aad65..b35f1b3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -4,6 +4,7 @@
 #include "diff.h"
 #include "commit.h"
 #include "revision.h"
+#include "run-command.h"

 int add_submodule_odb(const char *path)
 {
@@ -112,3 +113,105 @@ void show_submodule_summary(FILE *f, const char *path,
 	}
 	strbuf_release(&sb);
 }
+
+static int is_submodule_head_detached(const char *path)
+{
+	int retval, len;
+	struct child_process branch;
+	const char *argv[] = {
+		"branch",
+		"-a",
+		"--contains",
+		"HEAD",
+		NULL,
+	};
+	char *env[3];
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "GIT_WORK_TREE=%s", path);
+	env[0] = strbuf_detach(&buf, NULL);
+	strbuf_addf(&buf, "GIT_DIR=%s/.git", path);
+	env[1] = strbuf_detach(&buf, NULL);
+	env[2] = NULL;
+
+	memset(&branch, 0, sizeof(branch));
+	branch.argv = argv;
+	branch.env = (const char *const *)env;
+	branch.git_cmd = 1;
+	branch.no_stdin = 1;
+	branch.out = -1;
+	if (start_command(&branch))
+		die("Could not run git branch -a --contains HEAD");
+
+	len = strbuf_read(&buf, branch.out, 1024);
+	close(branch.out);
+
+	if (finish_command(&branch))
+		die("git branch -a --contains HEAD failed");
+
+	retval = (strncmp(buf.buf, "* (no branch)", 13) == 0);
+
+	free(env[0]);
+	free(env[1]);
+	strbuf_release(&buf);
+	return retval;
+}
+
+static int is_submodule_working_directory_dirty(const char *path)
+{
+	int len;
+	struct child_process branch;
+	const char *argv[] = {
+		"status",
+		"--porcelain",
+		NULL,
+	};
+	char *env[3];
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "GIT_WORK_TREE=%s", path);
+	env[0] = strbuf_detach(&buf, NULL);
+	strbuf_addf(&buf, "GIT_DIR=%s/.git", path);
+	env[1] = strbuf_detach(&buf, NULL);
+	env[2] = NULL;
+
+	memset(&branch, 0, sizeof(branch));
+	branch.argv = argv;
+	branch.env = (const char *const *)env;
+	branch.git_cmd = 1;
+	branch.no_stdin = 1;
+	branch.out = -1;
+	if (start_command(&branch))
+		die("Could not run git status --porcelain");
+
+	len = strbuf_read(&buf, branch.out, 1024);
+	close(branch.out);
+
+	if (finish_command(&branch))
+		die("git status --porcelain failed");
+
+	free(env[0]);
+	free(env[1]);
+	strbuf_release(&buf);
+	return len != 0;
+}
+
+int is_submodule_modified(const char *path)
+{
+	struct strbuf buffer = STRBUF_INIT;
+
+	strbuf_addf(&buffer, "%s/.git/", path);
+	if (!is_directory(buffer.buf)) {
+		strbuf_release(&buffer);
+		return 0;
+	}
+	strbuf_release(&buffer);
+
+	if (is_submodule_head_detached(path))
+		return 1;
+
+	if (is_submodule_working_directory_dirty(path))
+		return 1;
+
+	return 0;
+}
diff --git a/submodule.h b/submodule.h
index 4c0269d..0773121 100644
--- a/submodule.h
+++ b/submodule.h
@@ -4,5 +4,6 @@
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		const char *del, const char *add, const char *reset);
+int is_submodule_modified(const char *path);

 #endif
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 3ca17ab..509754a 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -10,8 +10,12 @@ test_expect_success 'setup' '
 	: >bar &&
 	git add bar &&
 	git commit -m " Add bar" &&
+	: >foo &&
+	git add foo &&
+	git commit -m " Add foo" &&
 	cd .. &&
-	git add sub &&
+	echo output > .gitignore
+	git add sub .gitignore &&
 	git commit -m "Add submodule sub"
 '

@@ -23,6 +27,45 @@ test_expect_success 'commit --dry-run -a clean' '
 	git commit --dry-run -a |
 	grep "nothing to commit"
 '
+
+echo "changed" > sub/foo
+test_expect_success 'status with modified file in submodule' '
+	git status | grep "modified:   sub"
+'
+test_expect_success 'status with modified file in submodule (porcelain)' '
+	git status --porcelain >output &&
+	diff output - <<-EOF
+ M sub
+EOF
+'
+(cd sub && git checkout foo)
+
+echo "content" > sub/new-file
+test_expect_success 'status with untracked file in submodule' '
+	git status | grep "modified:   sub"
+'
+test_expect_success 'status with untracked file in submodule (porcelain)' '
+	git status --porcelain >output &&
+	diff output - <<-EOF
+ M sub
+EOF
+'
+rm sub/new-file
+
+(cd sub && 2>/dev/null
+old_head=$(cat .git/refs/heads/master) &&
+git reset --hard HEAD^ &&
+git checkout $old_head 2>/dev/null)
+test_expect_success 'status with detatched HEAD in submodule' '
+	git status | grep "modified:   sub"
+'
+test_expect_success 'status with detatched HEAD in submodule (porcelain)' '
+	git status --porcelain >output &&
+	diff output - <<-EOF
+ M sub
+EOF
+'
+
 test_expect_success 'rm submodule contents' '
 	rm -rf sub/* sub/.git
 '
-- 
1.6.6.203.g6b27d.dirty
