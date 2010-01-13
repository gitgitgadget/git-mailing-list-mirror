From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Show submodules as modified when they contain a dirty work
 tree
Date: Wed, 13 Jan 2010 19:59:35 +0100
Message-ID: <4B4E1817.1070202@web.de>
References: <4B4BA096.5000909@web.de> <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de> <7vbpgyqy4a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:00:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV8S8-0006TB-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab0AMTAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634Ab0AMTAT
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:00:19 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:35535 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab0AMTAS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:00:18 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 62A55144E772D;
	Wed, 13 Jan 2010 20:00:16 +0100 (CET)
Received: from [80.128.77.35] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NV8RS-0006eV-00; Wed, 13 Jan 2010 19:59:42 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vbpgyqy4a.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19xY3YvI5f+4I/y1GSaECOppxkSWih2YKGCrtAP
	76alahRB2msjiIvL7FH0nhpBQ4RTu8+yzF3TtvrRfdwXZq09LC
	1jeEUSmm0zv7a/pfkHwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---

Thanks for your review, here is the updated patch. Changes to the RFC
version are:

  - Removed check for a dangling HEAD (now the testsuite runs fine)
  - Reworded the commit message
  - Inlined is_submodule_working_directory_dirty() into
    is_submodule_modified()
  - The new code will only be called when refs did match (when they
    didn't the submodule will already show up as modified)

What do you think?


 diff-lib.c                  |    4 ++-
 submodule.c                 |   49 +++++++++++++++++++++++++++++++++++++++++++
 submodule.h                 |    1 +
 t/t7506-status-submodule.sh |   31 ++++++++++++++++++++++++++-
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 1c7e652..6918920 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -159,7 +159,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}

-		if (ce_uptodate(ce) || ce_skip_worktree(ce))
+		if ((ce_uptodate(ce) && !S_ISGITLINK(ce->ce_mode)) || ce_skip_worktree(ce))
 			continue;

 		/* If CE_VALID is set, don't look at workdir for file removal */
@@ -176,6 +176,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			continue;
 		}
 		changed = ce_match_stat(ce, &st, ce_option);
+		if (S_ISGITLINK(ce->ce_mode) && !changed)
+			changed = is_submodule_modified(ce->name);
 		if (!changed) {
 			ce_mark_uptodate(ce);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
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
index 3ca17ab..47e205b 100755
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

@@ -23,6 +27,31 @@ test_expect_success 'commit --dry-run -a clean' '
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
 test_expect_success 'rm submodule contents' '
 	rm -rf sub/* sub/.git
 '
-- 
1.6.6.203.g28a8ba.dirty
