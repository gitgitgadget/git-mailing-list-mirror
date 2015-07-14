From: Sunil Kata <katasunil@gmail.com>
Subject: [PATCH] rerere-autocommit option is added to facilitate auto-merge when rerere resolves all the conflicts automatically.
Date: Tue, 14 Jul 2015 16:07:08 +0530
Message-ID: <1436870228-54075-1-git-send-email-katasunil@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 12:34:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZExXe-00082e-7y
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 12:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbbGNKeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 06:34:21 -0400
Received: from 121.244.95.222.static-Banglore.vsnl.net.in ([121.244.95.222]:5306
	"EHLO flip-ad.local" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753219AbbGNKeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 06:34:20 -0400
Received: by flip-ad.local (Postfix, from userid 1533623177)
	id 6F4123DC977E; Tue, 14 Jul 2015 16:07:08 +0530 (IST)
X-Mailer: git-send-email 2.3.2 (Apple Git-55)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273951>

Signed-off-by: Sunil Kata <katasunil@gmail.com>
---
 Documentation/git-merge.txt | 8 +++++++-
 builtin/merge.c             | 8 +++++++-
 rerere.h                    | 2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 273a100..6c60286 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[-s <strategy>] [-X <strategy-option>] [-S[<key-id>]]
-	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
+	[--[no-]rerere-autoupdate] [--rerere-autocommit]
+	[-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
 
@@ -84,6 +85,11 @@ invocations.
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
+--rerere-autocommit::
+	Allow the rerere mechanism to auto merge after updating
+	the index with the result of auto-conflict resolution
+	if possible
+
 --abort::
 	Abort the current conflict resolution process, and
 	try to reconstruct the pre-merge state.
diff --git a/builtin/merge.c b/builtin/merge.c
index 85c54dc..7142567 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -63,6 +63,7 @@ static char *branch_mergeoptions;
 static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
+static int allow_rerere_commit;
 static int abort_current_merge;
 static int show_progress = -1;
 static int default_to_upstream = 1;
@@ -209,6 +210,7 @@ static struct option builtin_merge_options[] = {
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
+	OPT_RERERE_AUTOCOMMIT(&allow_rerere_commit),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
 		N_("Verify that the named commit has a valid GPG signature")),
 	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
@@ -1553,6 +1555,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * handle the given merge at all.
 			 */
 			if (ret == 1) {
+				if(allow_rerere_commit) {
+					rerere(RERERE_AUTOUPDATE);
+					goto automerge;
+				}
 				int cnt = evaluate_result();
 
 				if (best_cnt <= 0 || cnt <= best_cnt) {
@@ -1565,7 +1571,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			else
 				continue;
 		}
-
+automerge:
 		/* Automerge succeeded. */
 		write_tree_trivial(result_tree);
 		automerge_was_ok = 1;
diff --git a/rerere.h b/rerere.h
index 2956c2e..4b36570 100644
--- a/rerere.h
+++ b/rerere.h
@@ -25,5 +25,7 @@ extern void rerere_gc(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
 	N_("update the index with reused conflict resolution if possible"))
+#define OPT_RERERE_AUTOCOMMIT(v) OPT_BOOL(0 , "rerere-autocommit", (v), \
+	N_("autocommit with reused conflict resolution if possible"))
 
 #endif
-- 
2.3.2 (Apple Git-55)
