From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git status: ignoring untracked files must apply to submodules
 too
Date: Sat, 13 Mar 2010 23:00:27 +0100
Message-ID: <4B9C0AFB.1050306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sergio Callegari <sergio.callegari@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 23:00:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZNv-0003e3-6g
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 23:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758536Ab0CMWAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 17:00:34 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:57945 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab0CMWAe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 17:00:34 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7CE7114D319AE;
	Sat, 13 Mar 2010 23:00:32 +0100 (CET)
Received: from [80.128.109.251] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NqZNo-00041k-00; Sat, 13 Mar 2010 23:00:32 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18oBXFtxbqpKB6H7fYCaVSc1EK9b4P+HxNAYK3a
	cHrEGNFiaLqxVOwNTp9ZOFOGU57FzgxioXaDOCFErw/ZxS71ig
	oRVbzh99C8jdMhV/2wYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142113>

Since 1.7.0 submodules are considered dirty when they contain untracked
files. But when git status is called with the "-uno" option, the user
asked to ignore untracked files, so they must be ignored in submodules
too. To achieve this, the new flag DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES
is introduced.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

This patch applies on top of current pu.

I'm open to suggestions for a shorter name for the new diff option
IGNORE_UNTRACKED_IN_SUBMODULES; I did not manage to come up with a
shorter yet still descriptive enough name.


 diff-lib.c                  |    2 +-
 diff.h                      |    1 +
 submodule.c                 |    9 +++++++--
 submodule.h                 |    2 +-
 t/t7506-status-submodule.sh |    5 +++++
 wt-status.c                 |    2 ++
 6 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 4e30b8f..c9f6e05 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -71,7 +71,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	if (S_ISGITLINK(ce->ce_mode)
 	    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
 	    && (!changed || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES))) {
-		*dirty_submodule = is_submodule_modified(ce->name);
+		*dirty_submodule = is_submodule_modified(ce->name, DIFF_OPT_TST(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES));
 	}
 	return changed;
 }
diff --git a/diff.h b/diff.h
index 95ed7f8..6a71013 100644
--- a/diff.h
+++ b/diff.h
@@ -70,6 +70,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_DIFF_FROM_CONTENTS  (1 << 22)
 #define DIFF_OPT_SUBMODULE_LOG       (1 << 23)
 #define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
+#define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)

 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/submodule.c b/submodule.c
index 714ca97..b3b8bc1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -130,7 +130,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	strbuf_release(&sb);
 }

-unsigned is_submodule_modified(const char *path)
+unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	int i;
 	ssize_t len;
@@ -139,6 +139,7 @@ unsigned is_submodule_modified(const char *path)
 		"status",
 		"--porcelain",
 		NULL,
+		NULL,
 	};
 	const char *env[LOCAL_REPO_ENV_SIZE + 3];
 	struct strbuf buf = STRBUF_INIT;
@@ -163,6 +164,9 @@ unsigned is_submodule_modified(const char *path)
 	env[i++] = strbuf_detach(&buf, NULL);
 	env[i] = NULL;

+	if (ignore_untracked)
+		argv[2] = "-uno";
+
 	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
 	cp.env = env;
@@ -181,7 +185,8 @@ unsigned is_submodule_modified(const char *path)
 				break;
 		} else {
 			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-			if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+			if (ignore_untracked ||
+			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
 				break;
 		}
 		next_line = strchr(line, '\n');
diff --git a/submodule.h b/submodule.h
index 267881c..dbda270 100644
--- a/submodule.h
+++ b/submodule.h
@@ -5,6 +5,6 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
-unsigned is_submodule_modified(const char *path);
+unsigned is_submodule_modified(const char *path, int ignore_untracked);

 #endif
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index dc9150a..aeec1f6 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -67,6 +67,11 @@ test_expect_success 'status with untracked file in submodule' '
 	grep "modified:   sub (untracked content)" output
 '

+test_expect_success 'status -uno with untracked file in submodule' '
+	git status -uno >output &&
+	grep "^nothing to commit" output
+'
+
 test_expect_success 'status with untracked file in submodule (porcelain)' '
 	git status --porcelain >output &&
 	diff output - <<-\EOF
diff --git a/wt-status.c b/wt-status.c
index cf90430..8ca59a2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -304,6 +304,8 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
+	if (!s->show_untracked_files)
+		DIFF_OPT_SET(&rev.diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.prune_data = s->pathspec;
-- 
1.7.0.2.399.g53a88
