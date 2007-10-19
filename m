From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 10/14] upload-pack: Move the revision walker into a separate function.
Date: Fri, 19 Oct 2007 21:48:02 +0200
Message-ID: <1192823286-9654-11-git-send-email-johannes.sixt@telecom.at>
References: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-2-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-3-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-4-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-5-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-6-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-7-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-8-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-9-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-10-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iixqh-0002t3-G9
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934114AbXJSTsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933103AbXJSTs2
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:48:28 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44514 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbXJSTsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 15:48:11 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 6791597B0D;
	Fri, 19 Oct 2007 21:48:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.315.g2ce38
In-Reply-To: <1192823286-9654-10-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61758>

This allows us later to use start_async() with this function, and at
the same time is a nice cleanup that makes a long function
(create_pack_file()) shorter.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 upload-pack.c |   70 ++++++++++++++++++++++++++++++--------------------------
 1 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 5c0c0cc..ccdc306 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -97,6 +97,42 @@ static void show_edge(struct commit *commit)
 	fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
 }
 
+static void do_rev_list(int create_full_pack)
+{
+	int i;
+	struct rev_info revs;
+
+	if (create_full_pack)
+		use_thin_pack = 0; /* no point doing it */
+	init_revisions(&revs, NULL);
+	revs.tag_objects = 1;
+	revs.tree_objects = 1;
+	revs.blob_objects = 1;
+	if (use_thin_pack)
+		revs.edge_hint = 1;
+
+	if (create_full_pack) {
+		const char *args[] = {"rev-list", "--all", NULL};
+		setup_revisions(2, args, &revs, NULL);
+	} else {
+		for (i = 0; i < want_obj.nr; i++) {
+			struct object *o = want_obj.objects[i].item;
+			/* why??? */
+			o->flags &= ~UNINTERESTING;
+			add_pending_object(&revs, o, NULL);
+		}
+		for (i = 0; i < have_obj.nr; i++) {
+			struct object *o = have_obj.objects[i].item;
+			o->flags |= UNINTERESTING;
+			add_pending_object(&revs, o, NULL);
+		}
+		setup_revisions(0, NULL, &revs, NULL);
+	}
+	prepare_revision_walk(&revs);
+	mark_edges_uninteresting(revs.commits, &revs, show_edge);
+	traverse_commit_list(&revs, show_commit, show_object);
+}
+
 static void create_pack_file(void)
 {
 	/* Pipe from rev-list to pack-objects
@@ -119,41 +155,9 @@ static void create_pack_file(void)
 		die("git-upload-pack: unable to fork git-rev-list");
 
 	if (!pid_rev_list) {
-		int i;
-		struct rev_info revs;
-
 		close(lp_pipe[0]);
 		pack_pipe = fdopen(lp_pipe[1], "w");
-
-		if (create_full_pack)
-			use_thin_pack = 0; /* no point doing it */
-		init_revisions(&revs, NULL);
-		revs.tag_objects = 1;
-		revs.tree_objects = 1;
-		revs.blob_objects = 1;
-		if (use_thin_pack)
-			revs.edge_hint = 1;
-
-		if (create_full_pack) {
-			const char *args[] = {"rev-list", "--all", NULL};
-			setup_revisions(2, args, &revs, NULL);
-		} else {
-			for (i = 0; i < want_obj.nr; i++) {
-				struct object *o = want_obj.objects[i].item;
-				/* why??? */
-				o->flags &= ~UNINTERESTING;
-				add_pending_object(&revs, o, NULL);
-			}
-			for (i = 0; i < have_obj.nr; i++) {
-				struct object *o = have_obj.objects[i].item;
-				o->flags |= UNINTERESTING;
-				add_pending_object(&revs, o, NULL);
-			}
-			setup_revisions(0, NULL, &revs, NULL);
-		}
-		prepare_revision_walk(&revs);
-		mark_edges_uninteresting(revs.commits, &revs, show_edge);
-		traverse_commit_list(&revs, show_commit, show_object);
+		do_rev_list(create_full_pack);
 		exit(0);
 	}
 
-- 
1.5.3.4.315.g2ce38
