From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix add_files_to_cache() to take pathspec, not user specified list of files
Date: Sun, 18 Nov 2007 02:21:26 -0800
Message-ID: <1195381287-26823-3-git-send-email-gitster@pobox.com>
References: <1195381287-26823-1-git-send-email-gitster@pobox.com>
 <1195381287-26823-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:22:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IthHs-0007vO-AN
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 11:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbXKRKVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 05:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbXKRKVi
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 05:21:38 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44239 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbXKRKVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 05:21:35 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E0A4B2F0
	for <git@vger.kernel.org>; Sun, 18 Nov 2007 05:21:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5651896154
	for <git@vger.kernel.org>; Sun, 18 Nov 2007 05:21:56 -0500 (EST)
X-Mailer: git-send-email 1.5.3.5.1815.g9445b
In-Reply-To: <1195381287-26823-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65358>

This separates the logic to limit the extent of change to the
index by where you are (controlled by "prefix") and what you
specify from the command line (controlled by "pathspec").

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c |    8 +++++---
 cache.h       |    4 +++-
 commit.h      |    1 -
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 45b14e8..16f8557 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -111,12 +111,12 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
-void add_files_to_cache(int verbose, const char *prefix, const char **files)
+void add_files_to_cache(int verbose, const char *prefix, const char **pathspec)
 {
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-	rev.prune_data = get_pathspec(prefix, files);
+	rev.prune_data = pathspec;
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &verbose;
@@ -198,9 +198,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	newfd = hold_locked_index(&lock_file, 1);
 
 	if (take_worktree_changes) {
+		const char **pathspec;
 		if (read_cache() < 0)
 			die("index file corrupt");
-		add_files_to_cache(verbose, prefix, argv);
+		pathspec = get_pathspec(prefix, argv);
+		add_files_to_cache(verbose, prefix, pathspec);
 		goto finish;
 	}
 
diff --git a/cache.h b/cache.h
index a84f343..24e7b72 100644
--- a/cache.h
+++ b/cache.h
@@ -597,13 +597,15 @@ extern void trace_argv_printf(const char **argv, int count, const char *format,
 extern int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst);
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 
+/* add */
+void add_files_to_cache(int verbose, const char *prefix, const char **pathspec);
+
 /* diff.c */
 extern int diff_auto_refresh_index;
 
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
 
-
 /* ls-files */
 int pathspec_match(const char **spec, char *matched, const char *filename, int skiplen);
 int report_path_error(const char *ps_matched, const char **pathspec, int prefix_offset);
diff --git a/commit.h b/commit.h
index 13b5372..e22aa77 100644
--- a/commit.h
+++ b/commit.h
@@ -132,7 +132,6 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 int in_merge_bases(struct commit *, struct commit **, int);
 
 extern int interactive_add(void);
-extern void add_files_to_cache(int verbose, const char *prefix, const char **files);
 extern int rerere(void);
 
 #endif /* COMMIT_H */
-- 
1.5.3.5.1815.g9445b
