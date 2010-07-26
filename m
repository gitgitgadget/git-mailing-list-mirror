From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] Submodules: Use "ignore" settings from .gitmodules too
 for diff and status
Date: Mon, 26 Jul 2010 20:28:31 +0200
Message-ID: <4C4DD3CF.9070906@web.de>
References: <4C4DD33F.4020104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:28:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSPo-0003kg-9F
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab0GZS2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:28:34 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45868 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab0GZS2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:28:33 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 11B2715C5815C;
	Mon, 26 Jul 2010 20:28:32 +0200 (CEST)
Received: from [80.128.109.213] (helo=[192.168.178.29])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OdSPf-0000LD-00; Mon, 26 Jul 2010 20:28:31 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <4C4DD33F.4020104@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/lKXsGFSrO1yx1iG2Ja7FDVJRa39Or9g/cdJF1
	JXGJY71B7UXgB7Cv5fZdWKYAJAoQV8hU/wiGjjnvmB5aBx1xo/
	s/LuoMV0CHBePZnD2rrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151872>

The .gitmodules file is parsed for "submodule.<name>.ignore" entries
before looking for them in .git/config. Thus settings found in .git/config
will override those from .gitmodules, thereby allowing the local developer
to ignore settings given by the remote side while also letting upstream
set defaults for those users who don't have special needs.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/config.txt       |    3 ++
 Documentation/diff-options.txt |    2 +-
 Documentation/git-status.txt   |    2 +-
 Documentation/gitmodules.txt   |   15 +++++++++
 builtin/commit.c               |    2 +
 builtin/diff-files.c           |    2 +
 builtin/diff-index.c           |    2 +
 builtin/diff-tree.c            |    2 +
 builtin/diff.c                 |    2 +
 submodule.c                    |   12 +++++++
 submodule.h                    |    1 +
 t/t4027-diff-submodule.sh      |   66 ++++++++++++++++++++++++++++++++++++++++
 t/t7508-status.sh              |   63 +++++++++++++++++++++++++++++++++++++-
 13 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 783f264..06e70cb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1756,6 +1756,9 @@ submodule.<submodulename>.ignore::
 	let submodules with modified tracked files in their work tree show up.
 	Using "none" (the default when this option is not set) also shows
 	submodules that have untracked files in their work tree as changed.
+	This setting overrides any setting made in .gitmodules for this submodule,
+	both settings can be overriden on the command line by using the
+	"--ignore-submodule" option.

 tar.umask::
 	This variable can be used to restrict the permission bits of
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9cf7506..faa467b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -334,7 +334,7 @@ endif::git-format-patch[]
 	Using "none" will consider the submodule modified when it either contains
 	untracked or modified files or its HEAD differs from the commit recorded
 	in the superproject and can be used to override any settings of the
-	'ignore' option in linkgit:git-config[1]. When
+	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
 	"untracked" is used submodules are not considered dirty when they only
 	contain untracked content (but they are still scanned for modified
 	content). Using "dirty" ignores all changes to the work tree of submodules,
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index a7a5d79..dae190a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -59,7 +59,7 @@ specified.
 	Using "none" will consider the submodule modified when it either contains
 	untracked or modified files or its HEAD differs from the commit recorded
 	in the superproject and can be used to override any settings of the
-	'ignore' option in linkgit:git-config[1]. When
+	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
 	"untracked" is used submodules are not considered dirty when they only
 	contain untracked content (but they are still scanned for modified
 	content). Using "dirty" ignores all changes to the work tree of submodules,
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 72a13d1..8ae107d 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -44,6 +44,21 @@ submodule.<name>.update::
 	This config option is overridden if 'git submodule update' is given
 	the '--merge' or '--rebase' options.

+submodule.<name>.ignore::
+	Defines under what circumstances "git status" and the diff family show
+	a submodule as modified. When set to "all", it will never be considered
+	modified, "dirty" will ignore all changes to the submodules work tree and
+	takes only differences between the HEAD of the submodule and the commit
+	recorded in the superproject into account. "untracked" will additionally
+	let submodules with modified tracked files in their work tree show up.
+	Using "none" (the default when this option is not set) also shows
+	submodules that have untracked files in their work tree as changed.
+	If this option is also present in the submodules entry in .git/config of
+	the superproject, the setting there will override the one found in
+	.gitmodules.
+	Both settings can be overriden on the command line by using the
+	"--ignore-submodule" option.
+

 EXAMPLES
 --------
diff --git a/builtin/commit.c b/builtin/commit.c
index a78dbd8..9456f4a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -25,6 +25,7 @@
 #include "rerere.h"
 #include "unpack-trees.h"
 #include "quote.h"
+#include "submodule.h"

 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -1073,6 +1074,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		status_format = STATUS_FORMAT_PORCELAIN;

 	wt_status_prepare(&s);
+	gitmodules_config();
 	git_config(git_status_config, &s);
 	in_merge = file_exists(git_path("MERGE_HEAD"));
 	argc = parse_options(argc, argv, prefix,
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 5b64011..951c7c8 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -8,6 +8,7 @@
 #include "commit.h"
 #include "revision.h"
 #include "builtin.h"
+#include "submodule.h"

 static const char diff_files_usage[] =
 "git diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
@@ -20,6 +21,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	unsigned options = 0;

 	init_revisions(&rev, prefix);
+	gitmodules_config();
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 0483749..2eb32bd 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "revision.h"
 #include "builtin.h"
+#include "submodule.h"

 static const char diff_cache_usage[] =
 "git diff-index [-m] [--cached] "
@@ -17,6 +18,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	int result;

 	init_revisions(&rev, prefix);
+	gitmodules_config();
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 3c78bda..0d2a3e9 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "log-tree.h"
 #include "builtin.h"
+#include "submodule.h"

 static struct rev_info log_tree_opt;

@@ -112,6 +113,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	int read_stdin = 0;

 	init_revisions(opt, prefix);
+	gitmodules_config();
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt->abbrev = 0;
 	opt->diff = 1;
diff --git a/builtin/diff.c b/builtin/diff.c
index 89ae89c..a43d326 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -13,6 +13,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
+#include "submodule.h"

 struct blobinfo {
 	unsigned char sha1[20];
@@ -279,6 +280,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 */

 	prefix = setup_git_directory_gently(&nongit);
+	gitmodules_config();
 	git_config(git_diff_ui_config, NULL);

 	if (diff_use_color_default == -1)
diff --git a/submodule.c b/submodule.c
index d35a14d..1bcb0e9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -65,6 +65,18 @@ static int submodule_config(const char *var, const char *value, void *cb)
 	return 0;
 }

+void gitmodules_config()
+{
+	const char *work_tree = get_git_work_tree();
+	if (work_tree) {
+		struct strbuf gitmodules_path = STRBUF_INIT;
+		strbuf_addstr(&gitmodules_path, work_tree);
+		strbuf_addstr(&gitmodules_path, "/.gitmodules");
+		git_config_from_file(submodule_config, gitmodules_path.buf, NULL);
+		strbuf_release(&gitmodules_path);
+	}
+}
+
 int parse_submodule_config_option(const char *var, const char *value)
 {
 	int len;
diff --git a/submodule.h b/submodule.h
index 185a5ce..8ac4037 100644
--- a/submodule.h
+++ b/submodule.h
@@ -5,6 +5,7 @@ struct diff_options;

 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
+void gitmodules_config();
 int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 void show_submodule_summary(FILE *f, const char *path,
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 5022fa0..dccdd23 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -138,6 +138,32 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)
 	git config --remove-section submodule.sub
 '

+test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.gitmodules]' '
+	git config --add -f .gitmodules submodule.sub.ignore none &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body &&
+	git config -f .gitmodules submodule.sub.ignore all &&
+	git diff HEAD >actual2 &&
+	! test -s actual2 &&
+	git config -f .gitmodules submodule.sub.ignore untracked &&
+	git diff HEAD >actual3 &&
+	sed -e "1,/^@@/d" actual3 >actual3.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual3.body &&
+	git config -f .gitmodules submodule.sub.ignore dirty &&
+	git diff HEAD >actual4 &&
+	! test -s actual4 &&
+	git config submodule.sub.ignore none &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body &&
+	git config --remove-section submodule.sub &&
+	rm .gitmodules
+'
+
 test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
 	(
 		cd sub &&
@@ -187,6 +213,25 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)
 	git config --remove-section submodule.sub
 '

+test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.gitmodules]' '
+	git config --add -f .gitmodules submodule.sub.ignore all &&
+	git diff HEAD >actual2 &&
+	! test -s actual2 &&
+	git config -f .gitmodules submodule.sub.ignore untracked &&
+	git diff HEAD >actual3 &&
+	! test -s actual3 &&
+	git config -f .gitmodules submodule.sub.ignore dirty &&
+	git diff HEAD >actual4 &&
+	! test -s actual4 &&
+	git config submodule.sub.ignore none &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body &&
+	git config --remove-section submodule.sub &&
+	rm .gitmodules
+'
+
 test_expect_success 'git diff between submodule commits' '
 	git diff HEAD^..HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
@@ -219,6 +264,27 @@ test_expect_success 'git diff between submodule commits [.git/config]' '
 	git config --remove-section submodule.sub
 '

+test_expect_success 'git diff between submodule commits [.gitmodules]' '
+	git diff HEAD^..HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body &&
+	git config --add -f .gitmodules submodule.sub.ignore dirty &&
+	git diff HEAD^..HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body &&
+	git config -f .gitmodules submodule.sub.ignore all &&
+	git diff HEAD^..HEAD >actual &&
+	! test -s actual &&
+	git config submodule.sub.ignore dirty &&
+	git diff  HEAD^..HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	git config --remove-section submodule.sub &&
+	rm .gitmodules
+'
+
 test_expect_success 'git diff (empty submodule dir)' '
 	: >empty &&
 	rm -rf sub/* sub/.git &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 3896808..bc3138c 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -848,10 +848,19 @@ test_expect_success '--ignore-submodules=untracked suppresses submodules with un
 	test_cmp expect output
 '

+test_expect_success '.gitmodules ignore=untracked suppresses submodules with untracked content' '
+	git config --add -f .gitmodules submodule.sm.ignore untracked &&
+	git status > output &&
+	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm
+'
+
 test_expect_success '.git/config ignore=untracked suppresses submodules with untracked content' '
+	git config --add -f .gitmodules submodule.sm.ignore none &&
 	git config --add submodule.sm.ignore untracked &&
 	git status > output &&
 	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm &&
 	git config --remove-section submodule.sm
 '

@@ -860,10 +869,19 @@ test_expect_success '--ignore-submodules=dirty suppresses submodules with untrac
 	test_cmp expect output
 '

+test_expect_success '.gitmodules ignore=dirty suppresses submodules with untracked content' '
+	git config --add -f .gitmodules submodule.sm.ignore dirty &&
+	git status > output &&
+	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm
+'
+
 test_expect_success '.git/config ignore=dirty suppresses submodules with untracked content' '
+	git config --add -f .gitmodules submodule.sm.ignore none &&
 	git config --add submodule.sm.ignore dirty &&
 	git status > output &&
 	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm &&
 	git config --remove-section submodule.sm
 '

@@ -873,10 +891,19 @@ test_expect_success '--ignore-submodules=dirty suppresses submodules with modifi
 	test_cmp expect output
 '

+test_expect_success '.gitmodules ignore=dirty suppresses submodules with modified content' '
+	git config --add -f .gitmodules submodule.sm.ignore dirty &&
+	git status > output &&
+	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm
+'
+
 test_expect_success '.git/config ignore=dirty suppresses submodules with modified content' '
+	git config --add -f .gitmodules submodule.sm.ignore none &&
 	git config --add submodule.sm.ignore dirty &&
 	git status > output &&
 	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm &&
 	git config --remove-section submodule.sm
 '

@@ -917,10 +944,19 @@ test_expect_success "--ignore-submodules=untracked doesn't suppress submodules w
 	test_cmp expect output
 '

+test_expect_success ".gitmodules ignore=untracked doesn't suppress submodules with modified content" '
+	git config --add -f .gitmodules submodule.sm.ignore untracked &&
+	git status > output &&
+	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm
+'
+
 test_expect_success ".git/config ignore=untracked doesn't suppress submodules with modified content" '
+	git config --add -f .gitmodules submodule.sm.ignore none &&
 	git config --add submodule.sm.ignore untracked &&
 	git status > output &&
 	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm &&
 	git config --remove-section submodule.sm
 '

@@ -967,10 +1003,19 @@ test_expect_success "--ignore-submodules=untracked doesn't suppress submodule su
 	test_cmp expect output
 '

+test_expect_success ".gitmodules ignore=untracked doesn't suppress submodule summary" '
+	git config --add -f .gitmodules submodule.sm.ignore untracked &&
+	git status > output &&
+	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm
+'
+
 test_expect_success ".git/config ignore=untracked doesn't suppress submodule summary" '
+	git config --add -f .gitmodules submodule.sm.ignore none &&
 	git config --add submodule.sm.ignore untracked &&
 	git status > output &&
 	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm &&
 	git config --remove-section submodule.sm
 '

@@ -978,15 +1023,22 @@ test_expect_success "--ignore-submodules=dirty doesn't suppress submodule summar
 	git status --ignore-submodules=dirty > output &&
 	test_cmp expect output
 '
+test_expect_success ".gitmodules ignore=dirty doesn't suppress submodule summary" '
+	git config --add -f .gitmodules submodule.sm.ignore dirty &&
+	git status > output &&
+	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm
+'

 test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary" '
+	git config --add -f .gitmodules submodule.sm.ignore none &&
 	git config --add submodule.sm.ignore dirty &&
 	git status > output &&
 	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm &&
 	git config --remove-section submodule.sm
 '

-
 cat > expect << EOF
 # On branch master
 # Changed but not updated:
@@ -1013,10 +1065,19 @@ test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 	test_cmp expect output
 '

+test_expect_failure '.gitmodules ignore=all suppresses submodule summary' '
+	git config --add -f .gitmodules submodule.sm.ignore all &&
+	git status > output &&
+	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm
+'
+
 test_expect_failure '.git/config ignore=all suppresses submodule summary' '
+	git config --add -f .gitmodules submodule.sm.ignore none &&
 	git config --add submodule.sm.ignore all &&
 	git status > output &&
 	test_cmp expect output &&
+	git config -f .gitmodules  --remove-section submodule.sm &&
 	git config --remove-section submodule.sm
 '

-- 
1.7.2.223.g830604.dirty
