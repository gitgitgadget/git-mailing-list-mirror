From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 1/2] Show submodules as modified when they contain a dirty
 work tree
Date: Sat, 16 Jan 2010 18:42:24 +0100
Message-ID: <4B51FA80.8040109@web.de>
References: <4B51F9EB.5090202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 18:42:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWCfR-0004qa-JV
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 18:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab0APRm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 12:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738Ab0APRm2
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 12:42:28 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:52335 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab0APRm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 12:42:27 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id C066913C3203A;
	Sat, 16 Jan 2010 18:42:25 +0100 (CET)
Received: from [80.128.127.37] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NWCfJ-0003FL-00; Sat, 16 Jan 2010 18:42:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <4B51F9EB.5090202@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1//6kEvWAuHlI/7/hLlItPuSeI6HPtuwwa/h7Jd
	ciIdmTHuWhNBvFeN7N6E1wmoul6c0tIpm066fGbOdNSWxV71oW
	ptfmQw0yH1k7bN4m7srg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137239>

Until now a submodule only then showed up as modified in the supermodule
when the last commit in the submodule differed from the one in the index
or the diffed against commit of the superproject. A dirty work tree
containing new untracked or modified files in a submodule was
undetectable when looking at it from the superproject.

Now git status and git diff (against the work tree) in the superproject
will also display submodules as modified when they contain untracked or
modified files, even if the compared ref matches the HEAD of the
submodule.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

Changed since the last version:
- Added missing include (spotted by Junio)
- Made test 7506 more robust (thanks to Nanako)
- When diffing the work tree against a commit in the supermodule the
  submodule did not show up as modified when the refs matched


 diff-lib.c                  |    8 +++-
 submodule.c                 |   49 +++++++++++++++++++++++++
 submodule.h                 |    1 +
 t/t7506-status-submodule.sh |   83 +++++++++++++++++++++++++++++++++++--------
 4 files changed, 124 insertions(+), 17 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 274ff8c..29c5915 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -10,6 +10,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "refs.h"
+#include "submodule.h"

 /*
  * diff-files
@@ -159,7 +160,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}

-		if (ce_uptodate(ce) || ce_skip_worktree(ce))
+		if ((ce_uptodate(ce) && !S_ISGITLINK(ce->ce_mode)) || ce_skip_worktree(ce))
 			continue;

 		/* If CE_VALID is set, don't look at workdir for file removal */
@@ -176,6 +177,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			continue;
 		}
 		changed = ce_match_stat(ce, &st, ce_option);
+		if (S_ISGITLINK(ce->ce_mode) && !changed)
+			changed = is_submodule_modified(ce->name);
 		if (!changed) {
 			ce_mark_uptodate(ce);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
@@ -230,7 +233,8 @@ static int get_stat_data(struct cache_entry *ce,
 			return -1;
 		}
 		changed = ce_match_stat(ce, &st, 0);
-		if (changed) {
+		if (changed
+		    || (S_ISGITLINK(ce->ce_mode) && is_submodule_modified(ce->name))) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			sha1 = null_sha1;
 		}
diff --git a/submodule.c b/submodule.c
index 86aad65..3f851de 100644
--- a/submodule.c
+++ b/submodule.c
@@ -4,6 +4,7 @@
 #include "diff.h"
 #include "commit.h"
 #include "revision.h"
+#include "run-command.h"

 int add_submodule_odb(const char *path)
 {
@@ -112,3 +113,51 @@ void show_submodule_summary(FILE *f, const char *path,
 	}
 	strbuf_release(&sb);
 }
+
+int is_submodule_modified(const char *path)
+{
+	int len;
+	struct child_process cp;
+	const char *argv[] = {
+		"status",
+		"--porcelain",
+		NULL,
+	};
+	char *env[3];
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s/.git/", path);
+	if (!is_directory(buf.buf)) {
+		strbuf_release(&buf);
+		/* The submodule is not checked out, so it is not modified */
+		return 0;
+
+	}
+	strbuf_reset(&buf);
+
+	strbuf_addf(&buf, "GIT_WORK_TREE=%s", path);
+	env[0] = strbuf_detach(&buf, NULL);
+	strbuf_addf(&buf, "GIT_DIR=%s/.git", path);
+	env[1] = strbuf_detach(&buf, NULL);
+	env[2] = NULL;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = (const char *const *)env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.out = -1;
+	if (start_command(&cp))
+		die("Could not run git status --porcelain");
+
+	len = strbuf_read(&buf, cp.out, 1024);
+	close(cp.out);
+
+	if (finish_command(&cp))
+		die("git status --porcelain failed");
+
+	free(env[0]);
+	free(env[1]);
+	strbuf_release(&buf);
+	return len != 0;
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
index 3ca17ab..253c334 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -5,34 +5,87 @@ test_description='git status for submodule'
 . ./test-lib.sh

 test_expect_success 'setup' '
-	test_create_repo sub
-	cd sub &&
-	: >bar &&
-	git add bar &&
-	git commit -m " Add bar" &&
-	cd .. &&
-	git add sub &&
+	test_create_repo sub &&
+	(
+		cd sub &&
+		: >bar &&
+		git add bar &&
+		git commit -m " Add bar" &&
+		: >foo &&
+		git add foo &&
+		git commit -m " Add foo"
+	) &&
+	echo output > .gitignore &&
+	git add sub .gitignore &&
 	git commit -m "Add submodule sub"
 '

 test_expect_success 'status clean' '
-	git status |
-	grep "nothing to commit"
+	git status >output &&
+	grep "nothing to commit" output
 '
+
 test_expect_success 'commit --dry-run -a clean' '
-	git commit --dry-run -a |
-	grep "nothing to commit"
+	test_must_fail git commit --dry-run -a >output &&
+	grep "nothing to commit" output
+'
+
+test_expect_success 'status with modified file in submodule' '
+	(cd sub && git reset --hard) &&
+	echo "changed" >sub/foo &&
+	git status >output &&
+	grep "modified:   sub" output
+'
+
+test_expect_success 'status with modified file in submodule (porcelain)' '
+	(cd sub && git reset --hard) &&
+	echo "changed" >sub/foo &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with added file in submodule' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	git status >output &&
+	grep "modified:   sub" output
+'
+
+test_expect_success 'status with added file in submodule (porcelain)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with untracked file in submodule' '
+	(cd sub && git reset --hard) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	grep "modified:   sub" output
+'
+
+test_expect_success 'status with untracked file in submodule (porcelain)' '
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
 '
+
 test_expect_success 'rm submodule contents' '
 	rm -rf sub/* sub/.git
 '
+
 test_expect_success 'status clean (empty submodule dir)' '
-	git status |
-	grep "nothing to commit"
+	git status >output &&
+	grep "nothing to commit" output
 '
+
 test_expect_success 'status -a clean (empty submodule dir)' '
-	git commit --dry-run -a |
-	grep "nothing to commit"
+	test_must_fail git commit --dry-run -a >output &&
+	grep "nothing to commit" output
 '

 test_done
-- 
1.6.6.332.g1985b
