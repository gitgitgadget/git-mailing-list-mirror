From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Refactor dirty submodule detection in diff-lib.c
Date: Thu, 11 Mar 2010 22:50:25 +0100
Message-ID: <4B9965A1.60403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 22:53:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpqJh-00028J-Am
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 22:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab0CKVxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 16:53:10 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:56039 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab0CKVxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 16:53:09 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 44A0E153A4D0B;
	Thu, 11 Mar 2010 22:50:26 +0100 (CET)
Received: from [80.128.84.109] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NpqGv-0005Vy-00; Thu, 11 Mar 2010 22:50:26 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19cr7TkiNhK8sdAD/2OYlc49JdZnZRjfEcee1pO
	wK98k5du4ndsA0VKfuXgxOqxtCsGjY+wRsUFBF+FJivCb62AhA
	ENTEiLSI/ENit8tUpeug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142002>

Moving duplicated code into the new function match_stat_with_submodule().
Replacing the implicit activation of detailed checks for the dirtiness of
submodules when DIFF_FORMAT_PATCH was selected with explicitly setting
the recently added DIFF_OPT_DIRTY_SUBMODULES option in diff_setup_done().

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

All tests run fine with this patch. All other callsites where the option
DIFF_FORMAT_PATCH is set look like they don't deal with the work tree
or they call diff_setup_done() shortly after.
I am pretty sure about builtin/log.c, as this can't use the work tree
but only already commited stuff, no?
But then there is edit_patch() in buitin/add.c, I am not sure it makes
sense to set DIRTY_SUBMODULES there too. Opinions?


 diff-lib.c |   45 +++++++++++++++++++++++++++------------------
 diff.c     |    6 ++++++
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 1ab286a..64be827 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -55,6 +55,29 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 	return 0;
 }

+/*
+ * Has a file changed or has a submodule new commits or a dirty work tree?
+ *
+ * Return 1 when changes are detected, 0 otherwise. If the DIRTY_SUBMODULES
+ * option is set, the caller does not only want to know if a submodule is
+ * modified at all but wants to know all the conditions that are met (new
+ * commits, untracked content and/or modified content).
+ */
+static int match_stat_with_submodule(struct diff_options *diffopt,
+				      struct cache_entry *ce, struct stat *st,
+				      unsigned ce_option, unsigned *dirty_submodule)
+{
+	int changed = ce_match_stat(ce, st, ce_option);
+	if (S_ISGITLINK(ce->ce_mode)
+	    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
+	    && (!changed || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES))) {
+		*dirty_submodule = is_submodule_modified(ce->name);
+		if (*dirty_submodule)
+			changed = 1;
+	}
+	return changed;
+}
+
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
@@ -177,15 +200,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				       ce->sha1, ce->name, 0);
 			continue;
 		}
-		changed = ce_match_stat(ce, &st, ce_option);
-		if (S_ISGITLINK(ce->ce_mode)
-		    && !DIFF_OPT_TST(&revs->diffopt, IGNORE_SUBMODULES)
-		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH)
-			|| DIFF_OPT_TST(&revs->diffopt, DIRTY_SUBMODULES))) {
-			dirty_submodule = is_submodule_modified(ce->name);
-			if (dirty_submodule)
-				changed = 1;
-		}
+		changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
+    	    					    ce_option, &dirty_submodule);
 		if (!changed) {
 			ce_mark_uptodate(ce);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
@@ -241,15 +257,8 @@ static int get_stat_data(struct cache_entry *ce,
 			}
 			return -1;
 		}
-		changed = ce_match_stat(ce, &st, 0);
-		if (S_ISGITLINK(ce->ce_mode)
-		    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
-		    && (!changed || (diffopt->output_format & DIFF_FORMAT_PATCH)
-			|| DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES))) {
-			*dirty_submodule = is_submodule_modified(ce->name);
-			if (*dirty_submodule)
-				changed = 1;
-		}
+		changed = match_stat_with_submodule(diffopt, ce, &st,
+     	   					    0, dirty_submodule);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			sha1 = null_sha1;
diff --git a/diff.c b/diff.c
index dfdfa1a..5aefdcb 100644
--- a/diff.c
+++ b/diff.c
@@ -2628,6 +2628,12 @@ int diff_setup_done(struct diff_options *options)
 	 */
 	if (options->pickaxe)
 		DIFF_OPT_SET(options, RECURSIVE);
+	/*
+	 * When patches are generated, submodules diffed against the work tree
+	 * must be checked for dirtiness too so it can be shown in the output
+	 */
+	if (options->output_format & DIFF_FORMAT_PATCH)
+		DIFF_OPT_SET(options, DIRTY_SUBMODULES);

 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit = diff_rename_limit_default;
-- 
1.7.0.2.385.g964e
