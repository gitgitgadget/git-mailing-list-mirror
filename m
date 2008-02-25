From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Improve collection of information for format-patch
 --cover-letter
Date: Mon, 25 Feb 2008 18:24:17 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802251822240.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 00:25:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTmh5-0005qy-AF
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 00:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597AbYBYXYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 18:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757465AbYBYXYT
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 18:24:19 -0500
Received: from iabervon.org ([66.92.72.58]:59584 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756297AbYBYXYS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 18:24:18 -0500
Received: (qmail 21598 invoked by uid 1000); 25 Feb 2008 23:24:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2008 23:24:17 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75088>

Use the "boundary" feature to find the origin (or find that there are
multiple origins), and use the actual list of commits to pass to
shortlog.

This makes all cover letter include shortlogs, and all cover letters
for series with a single boundary commit include diffstats (if there
are multiple boundary commits it's unclear what would be meaningful as
a diffstat). Note that the single boundary test is empirical, not 
theoretical; even a -2 limiting condition will give a diffstat if there's 
only one boundary commit in this particular case.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-log.c |   49 ++++++++++++++++++++++++++-----------------------
 1 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 2b70aa9..3209ea5 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -16,6 +16,7 @@
 #include "patch-ids.h"
 #include "refs.h"
 #include "run-command.h"
+#include "shortlog.h"
 
 static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
@@ -640,9 +641,10 @@ static void gen_message_id(struct rev_info *info, char *base)
 	info->message_id = strbuf_detach(&buf, NULL);
 }
 
-static void make_cover_letter(struct rev_info *rev,
-		int use_stdout, int numbered, int numbered_files,
-			      struct commit *origin, struct commit *head)
+static void make_cover_letter(struct rev_info *rev, int use_stdout,
+			      int numbered, int numbered_files,
+			      struct commit *origin,
+			      int nr, struct commit **list, struct commit *head)
 {
 	const char *committer;
 	const char *origin_sha1, *head_sha1;
@@ -651,7 +653,9 @@ static void make_cover_letter(struct rev_info *rev,
 	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
 	const char *msg;
 	const char *extra_headers = rev->extra_headers;
+	struct shortlog log;
 	struct strbuf sb;
+	int i;
 	const char *encoding = "utf-8";
 
 	if (rev->commit_format != CMIT_FMT_EMAIL)
@@ -661,7 +665,6 @@ static void make_cover_letter(struct rev_info *rev,
 				NULL : "cover-letter", 0, rev->total))
 		return;
 
-	origin_sha1 = sha1_to_hex(origin ? origin->object.sha1 : null_sha1);
 	head_sha1 = sha1_to_hex(head->object.sha1);
 
 	log_write_email_headers(rev, head_sha1, &subject_start, &extra_headers);
@@ -679,21 +682,19 @@ static void make_cover_letter(struct rev_info *rev,
 
 	strbuf_release(&sb);
 
+	shortlog_init(&log);
+	for (i = 0; i < nr; i++)
+		shortlog_add_commit(&log, list[i]);
+
+	shortlog_output(&log);
+
 	/*
-	 * We can only do diffstat with a unique reference point, and
-	 * log is a bit tricky, so just skip it.
+	 * We can only do diffstat with a unique reference point
 	 */
 	if (!origin)
 		return;
 
-	argv[0] = "shortlog";
-	argv[1] = head_sha1;
-	argv[2] = "--not";
-	argv[3] = origin_sha1;
-	argv[4] = "--";
-	argv[5] = NULL;
-	fflush(stdout);
-	run_command_v_opt(argv, RUN_GIT_CMD);
+	origin_sha1 = sha1_to_hex(origin->object.sha1);
 
 	argv[0] = "diff";
 	argv[1] = "--stat";
@@ -746,6 +747,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int ignore_if_in_upstream = 0;
 	int thread = 0;
 	int cover_letter = 0;
+	int boundary_count = 0;
 	struct commit *origin = NULL, *head = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
@@ -936,19 +938,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 	if (cover_letter) {
 		/* remember the range */
-		int negative_count = 0;
 		int i;
 		for (i = 0; i < rev.pending.nr; i++) {
 			struct object *o = rev.pending.objects[i].item;
-			if (o->flags & UNINTERESTING) {
-				origin = (struct commit *)o;
-				negative_count++;
-			} else
+			if (!(o->flags & UNINTERESTING))
 				head = (struct commit *)o;
 		}
-		/* Multiple origins don't work for diffstat. */
-		if (negative_count > 1)
-			origin = NULL;
 		/* We can't generate a cover letter without any patches */
 		if (!head)
 			return 0;
@@ -962,7 +957,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
+	rev.boundary = 1;
 	while ((commit = get_revision(&rev)) != NULL) {
+		if (commit->object.flags & BOUNDARY) {
+			fprintf(stderr, "Boundary %s\n", sha1_to_hex(commit->object.sha1));
+			boundary_count++;
+			origin = (boundary_count == 1) ? commit : NULL;
+			continue;
+		}
+
 		/* ignore merges */
 		if (commit->parents && commit->parents->next)
 			continue;
@@ -986,7 +989,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout, numbered, numbered_files,
-				  origin, head);
+				  origin, nr, list, head);
 		total++;
 		start_number--;
 	}
-- 
1.5.4.3.330.g53ab.dirty
