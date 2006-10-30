X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/5] upload-pack: no longer call rev-list
Date: Mon, 30 Oct 2006 20:08:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0610302008320.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 30 Oct 2006 19:18:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30507>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GecVX-0005rW-6T for gcvg-git@gmane.org; Mon, 30 Oct
 2006 20:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161425AbWJ3TI4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 14:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161463AbWJ3TI4
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 14:08:56 -0500
Received: from mail.gmx.de ([213.165.64.20]:52683 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1161425AbWJ3TIy (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 14:08:54 -0500
Received: (qmail invoked by alias); 30 Oct 2006 19:08:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 30 Oct 2006 20:08:49 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


It is trivial to do now, and it is needed for the upcoming shallow
clone stuff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 upload-pack.c |   93 ++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 4572fff..7f7df2a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -9,6 +9,9 @@
 #include "object.h"
 #include "commit.h"
 #include "exec_cmd.h"
+#include "diff.h"
+#include "revision.h"
+#include "list-objects.h"
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
@@ -57,6 +60,40 @@ static ssize_t send_client_data(int fd,
 	return safe_write(fd, data, sz);
 }
 
+FILE *pack_pipe = NULL;
+static void show_commit(struct commit *commit)
+{
+	if (commit->object.flags & BOUNDARY)
+		fputc('-', pack_pipe);
+	if (fputs(sha1_to_hex(commit->object.sha1), pack_pipe) < 0)
+		die("broken output pipe");
+	fputc('\n', pack_pipe);
+	fflush(pack_pipe);
+	free(commit->buffer);
+	commit->buffer = NULL;
+}
+
+static void show_object(struct object_array_entry *p)
+{
+	/* An object with name "foo\n0000000..." can be used to
+	 * confuse downstream git-pack-objects very badly.
+	 */
+	const char *ep = strchr(p->name, '\n');
+	if (ep) {
+		fprintf(pack_pipe, "%s %.*s\n", sha1_to_hex(p->item->sha1),
+		       (int) (ep - p->name),
+		       p->name);
+	}
+	else
+		fprintf(pack_pipe, "%s %s\n",
+				sha1_to_hex(p->item->sha1), p->name);
+}
+
+static void show_edge(struct commit *commit)
+{
+	fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
+}
+
 static void create_pack_file(void)
 {
 	/* Pipes between rev-list to pack-objects, pack-objects to us
@@ -78,48 +115,38 @@ static void create_pack_file(void)
 
 	if (!pid_rev_list) {
 		int i;
-		int args;
-		const char **argv;
-		const char **p;
-		char *buf;
+		struct rev_info revs;
 
-		if (create_full_pack) {
-			args = 10;
-			use_thin_pack = 0; /* no point doing it */
-		}
-		else
-			args = have_obj.nr + want_obj.nr + 5;
-		p = xmalloc(args * sizeof(char *));
-		argv = (const char **) p;
-		buf = xmalloc(args * 45);
+		pack_pipe = fdopen(lp_pipe[1], "w");
 
-		dup2(lp_pipe[1], 1);
-		close(0);
-		close(lp_pipe[0]);
-		close(lp_pipe[1]);
-		*p++ = "rev-list";
-		*p++ = use_thin_pack ? "--objects-edge" : "--objects";
 		if (create_full_pack)
-			*p++ = "--all";
-		else {
+			use_thin_pack = 0; /* no point doing it */
+		init_revisions(&revs, NULL);
+		revs.tag_objects = 1;
+		revs.tree_objects = 1;
+		revs.blob_objects = 1;
+		if (use_thin_pack)
+			revs.edge_hint = 1;
+
+		if (create_full_pack) {
+			const char *args[] = {"rev-list", "--all", NULL};
+			setup_revisions(2, args, &revs, NULL);
+		} else {
 			for (i = 0; i < want_obj.nr; i++) {
 				struct object *o = want_obj.objects[i].item;
-				*p++ = buf;
-				memcpy(buf, sha1_to_hex(o->sha1), 41);
-				buf += 41;
+				add_pending_object(&revs, o, NULL);
 			}
-		}
-		if (!create_full_pack)
 			for (i = 0; i < have_obj.nr; i++) {
 				struct object *o = have_obj.objects[i].item;
-				*p++ = buf;
-				*buf++ = '^';
-				memcpy(buf, sha1_to_hex(o->sha1), 41);
-				buf += 41;
+				o->flags |= UNINTERESTING;
+				add_pending_object(&revs, o, NULL);
 			}
-		*p++ = NULL;
-		execv_git_cmd(argv);
-		die("git-upload-pack: unable to exec git-rev-list");
+			setup_revisions(0, NULL, &revs, NULL);
+		}
+		prepare_revision_walk(&revs);
+		mark_edges_uninteresting(revs.commits, &revs, show_edge);
+		traverse_commit_list(&revs, show_commit, show_object);
+		exit(0);
 	}
 
 	if (pipe(pu_pipe) < 0)
-- 
1.4.3.3.gca42
