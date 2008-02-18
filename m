From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 3/3] check return code of prepare_revision_walk
Date: Mon, 18 Feb 2008 08:31:56 +0100
Message-ID: <12033199168-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033199162949-git-send-email-mkoegler@auto.tuwien.ac.at>
 <1203319916670-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 08:32:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR0Uc-0007Jg-2b
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 08:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbYBRHcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 02:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbYBRHcD
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 02:32:03 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58474 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbYBRHb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 02:31:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id C55686800674;
	Mon, 18 Feb 2008 08:31:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dpWA07mEQXdd; Mon, 18 Feb 2008 08:31:56 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 79F3A680BF7C; Mon, 18 Feb 2008 08:31:56 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <1203319916670-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74237>

A failure in prepare_revision_walk can be caused by
a not parseable object.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-blame.c         |    3 ++-
 builtin-fast-export.c   |    3 ++-
 builtin-fmt-merge-msg.c |    3 ++-
 builtin-log.c           |   12 ++++++++----
 builtin-pack-objects.c  |    3 ++-
 builtin-rev-list.c      |    3 ++-
 builtin-shortlog.c      |    3 ++-
 bundle.c                |    3 ++-
 http-push.c             |    3 ++-
 reachable.c             |    3 ++-
 upload-pack.c           |    3 ++-
 11 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index ee45d8a..59d7237 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2367,7 +2367,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	 * bottom commits we would reach while traversing as
 	 * uninteresting.
 	 */
-	prepare_revision_walk(&revs);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
 
 	if (is_null_sha1(sb.final->object.sha1)) {
 		char *buf;
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index ef27eee..f741df5 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -383,7 +383,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
 
-	prepare_revision_walk(&revs);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
 	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
 	while ((commit = get_revision(&revs))) {
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 6163bd4..ebb3f37 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -187,7 +187,8 @@ static void shortlog(const char *name, unsigned char *sha1,
 	add_pending_object(rev, branch, name);
 	add_pending_object(rev, &head->object, "^HEAD");
 	head->object.flags |= UNINTERESTING;
-	prepare_revision_walk(rev);
+	if (prepare_revision_walk(rev))
+		die("revision walk setup failed");
 	while ((commit = get_revision(rev)) != NULL) {
 		char *oneline, *bol, *eol;
 
diff --git a/builtin-log.c b/builtin-log.c
index 99d69f0..5fea64a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -197,7 +197,8 @@ static int cmd_log_walk(struct rev_info *rev)
 	if (rev->early_output)
 		setup_early_output(rev);
 
-	prepare_revision_walk(rev);
+	if (prepare_revision_walk(rev))
+		die("revision walk setup failed");
 
 	if (rev->early_output)
 		finish_early_output(rev);
@@ -556,7 +557,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
 	o2->flags ^= UNINTERESTING;
 	add_pending_object(&check_rev, o1, "o1");
 	add_pending_object(&check_rev, o2, "o2");
-	prepare_revision_walk(&check_rev);
+	if (prepare_revision_walk(&check_rev))
+		die("revision walk setup failed");
 
 	while ((commit = get_revision(&check_rev)) != NULL) {
 		/* ignore merges */
@@ -781,7 +783,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!use_stdout)
 		realstdout = xfdopen(xdup(1), "w");
 
-	prepare_revision_walk(&rev);
+	if (prepare_revision_walk(&rev))
+		die("revision walk setup failed");
 	while ((commit = get_revision(&rev)) != NULL) {
 		/* ignore merges */
 		if (commit->parents && commit->parents->next)
@@ -923,7 +926,8 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		die("Unknown commit %s", limit);
 
 	/* reverse the list of commits */
-	prepare_revision_walk(&revs);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
 	while ((commit = get_revision(&revs)) != NULL) {
 		/* ignore merges */
 		if (commit->parents && commit->parents->next)
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index acb0555..fe95305 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2042,7 +2042,8 @@ static void get_object_list(int ac, const char **av)
 			die("bad revision '%s'", line);
 	}
 
-	prepare_revision_walk(&revs);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
 	traverse_commit_list(&revs, show_commit, show_object);
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index de80158..9426081 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -609,7 +609,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list)
 		revs.limited = 1;
 
-	prepare_revision_walk(&revs);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
 	if (revs.tree_objects)
 		mark_edges_uninteresting(revs.commits, &revs, show_edge);
 
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index fa8bc7d..0055a57 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -136,7 +136,8 @@ static void get_from_rev(struct rev_info *rev, struct path_list *list)
 {
 	struct commit *commit;
 
-	prepare_revision_walk(rev);
+	if (prepare_revision_walk(rev))
+		die("revision walk setup failed");
 	while ((commit = get_revision(rev)) != NULL) {
 		const char *author = NULL, *buffer;
 
diff --git a/bundle.c b/bundle.c
index 5c95eca..bd12ec8 100644
--- a/bundle.c
+++ b/bundle.c
@@ -128,7 +128,8 @@ int verify_bundle(struct bundle_header *header, int verbose)
 		add_object_array(e->item, e->name, &refs);
 	}
 
-	prepare_revision_walk(&revs);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
 
 	i = req_nr;
 	while (i && (commit = get_revision(&revs)))
diff --git a/http-push.c b/http-push.c
index b2b410d..63ff218 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2383,7 +2383,8 @@ int main(int argc, char **argv)
 
 		/* Generate a list of objects that need to be pushed */
 		pushing = 0;
-		prepare_revision_walk(&revs);
+		if (prepare_revision_walk(&revs))
+			die("revision walk setup failed");
 		mark_edges_uninteresting(revs.commits);
 		objects_to_send = get_delta(&revs, ref_lock);
 		finish_all_active_slots();
diff --git a/reachable.c b/reachable.c
index 00f289f..823e324 100644
--- a/reachable.c
+++ b/reachable.c
@@ -215,6 +215,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog)
 	 * Set up the revision walk - this will move all commits
 	 * from the pending list to the commit walking list.
 	 */
-	prepare_revision_walk(revs);
+	if (prepare_revision_walk(revs))
+		die("revision walk setup failed");
 	walk_commit_list(revs);
 }
diff --git a/upload-pack.c b/upload-pack.c
index 2307f58..53676ee 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -129,7 +129,8 @@ static int do_rev_list(int fd, void *create_full_pack)
 		}
 		setup_revisions(0, NULL, &revs, NULL);
 	}
-	prepare_revision_walk(&revs);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
 	traverse_commit_list(&revs, show_commit, show_object);
 	return 0;
-- 
1.5.4.1.gaf0ae
