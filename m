From: Sergey Organov <sorganov@gmail.com>
Subject: [RFC/PATCH] git-merge: implement --ff-only-merge option.
Date: Tue,  7 Oct 2014 20:35:10 +0400
Message-ID: <1412699710-3480-1-git-send-email-sorganov@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 18:45:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbXst-0003rB-V4
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 18:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbaJGQpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 12:45:06 -0400
Received: from mail.javad.com ([54.86.164.124]:42350 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbaJGQpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 12:45:05 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Oct 2014 12:45:04 EDT
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id A80CC61878;
	Tue,  7 Oct 2014 16:35:12 +0000 (UTC)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
	by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id s97GZAte003523;
	Tue, 7 Oct 2014 20:35:10 +0400
Received: (from osv@localhost)
	by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id s97GZA3O003519;
	Tue, 7 Oct 2014 20:35:10 +0400
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257932>

This option allows to create merge commit when fast-forward is
possible, and abort otherwise. I.e. it's equivalent to --ff-only,
except that it finally creates merge commit instead of
fast-forwarding.

One may also consider this option to be equivalent to --no-ff with
additional check that the command without --no-ff  would indeed result
in fast-forward.

Useful to incorporate topic branch as single merge commit, ensuring
the left-side of the merge has no changes (our-diff-empty-merge).

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/merge.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index dff043d..39d0f1e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -79,7 +79,8 @@ static const char *pull_twohead, *pull_octopus;
 enum ff_type {
 	FF_NO,
 	FF_ALLOW,
-	FF_ONLY
+	FF_ONLY,
+	FF_ONLY_MERGE
 };
 
 static enum ff_type fast_forward = FF_ALLOW;
@@ -206,6 +207,9 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_SET_INT, 0, "ff-only", &fast_forward, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
+	{ OPTION_SET_INT, 0, "ff-only-merge", &fast_forward, NULL,
+		N_("create merge commit when fast-forward is possible, abort otherwise"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY_MERGE },
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
 		N_("Verify that the named commit has a valid GPG signature")),
@@ -591,6 +595,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 			fast_forward = boolval ? FF_ALLOW : FF_NO;
 		} else if (v && !strcmp(v, "only")) {
 			fast_forward = FF_ONLY;
+		} else if (v && !strcmp(v, "merge")) {
+			fast_forward = FF_ONLY_MERGE;
 		} /* do not barf on values from future versions of git */
 		return 0;
 	} else if (!strcmp(k, "merge.defaulttoupstream")) {
@@ -866,7 +872,7 @@ static int finish_automerge(struct commit *head,
 
 	free_commit_list(common);
 	parents = remoteheads;
-	if (!head_subsumed || fast_forward == FF_NO)
+	if (!head_subsumed || (fast_forward == FF_NO || fast_forward == FF_ONLY_MERGE))
 		commit_list_insert(head, &parents);
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
@@ -1162,6 +1168,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (squash) {
 		if (fast_forward == FF_NO)
 			die(_("You cannot combine --squash with --no-ff."));
+		if (fast_forward == FF_ONLY_MERGE)
+			die(_("You cannot combine --squash with --ff-only-merge."));
 		option_commit = 0;
 	}
 
@@ -1206,7 +1214,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				"empty head"));
 		if (squash)
 			die(_("Squash commit into empty head not supported yet"));
-		if (fast_forward == FF_NO)
+		if (fast_forward == FF_NO || fast_forward == FF_ONLY_MERGE)
 			die(_("Non-fast-forward commit does not make sense into "
 			    "an empty head"));
 		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
@@ -1292,6 +1300,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		setenv(buf.buf, merge_remote_util(commit)->name, 1);
 		strbuf_reset(&buf);
 		if (fast_forward != FF_ONLY &&
+		    fast_forward != FF_ONLY_MERGE &&
 		    merge_remote_util(commit) &&
 		    merge_remote_util(commit)->obj &&
 		    merge_remote_util(commit)->obj->type == OBJ_TAG)
@@ -1312,7 +1321,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < use_strategies_nr; i++) {
 		if (use_strategies[i]->attr & NO_FAST_FORWARD)
-			fast_forward = FF_NO;
+			if(fast_forward != FF_ONLY_MERGE)
+				fast_forward = FF_NO;
 		if (use_strategies[i]->attr & NO_TRIVIAL)
 			allow_trivial = 0;
 	}
@@ -1342,9 +1352,19 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 */
 		finish_up_to_date("Already up-to-date.");
 		goto done;
-	} else if (fast_forward != FF_NO && !remoteheads->next &&
-			!common->next &&
-			!hashcmp(common->item->object.sha1, head_commit->object.sha1)) {
+	} else if (fast_forward != FF_NO &&
+		   !remoteheads->next &&
+		   !common->next &&
+		   !hashcmp(common->item->object.sha1, head_commit->object.sha1)) {
+
+		if (fast_forward == FF_ONLY_MERGE) {
+			/*
+			 * We are going to fast-forward, but options force us to create
+			 * merge commit instead.
+			 */
+			goto commit;
+		}
+
 		/* Again the most common case of merging one remote. */
 		struct strbuf msg = STRBUF_INIT;
 		struct commit *commit;
@@ -1389,7 +1409,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * only one common.
 		 */
 		refresh_cache(REFRESH_QUIET);
-		if (allow_trivial && fast_forward != FF_ONLY) {
+		if (allow_trivial && fast_forward != FF_ONLY && fast_forward != FF_ONLY_MERGE) {
 			/* See if it is really trivial. */
 			git_committer_info(IDENT_STRICT);
 			printf(_("Trying really trivial in-index merge...\n"));
@@ -1430,9 +1450,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (fast_forward == FF_ONLY)
+	if (fast_forward == FF_ONLY || fast_forward == FF_ONLY_MERGE)
 		die(_("Not possible to fast-forward, aborting."));
 
+commit:	
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
 
-- 
1.9.3
