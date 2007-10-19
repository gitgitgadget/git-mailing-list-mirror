From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 11/14] upload-pack: Run rev-list in an asynchronous function.
Date: Fri, 19 Oct 2007 21:48:03 +0200
Message-ID: <1192823286-9654-12-git-send-email-johannes.sixt@telecom.at>
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
 <1192823286-9654-11-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iixql-0002t3-1d
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935293AbXJSTsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934770AbXJSTsh
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:48:37 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44520 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764582AbXJSTsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 15:48:11 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id A56B697D59;
	Fri, 19 Oct 2007 21:48:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.315.g2ce38
In-Reply-To: <1192823286-9654-11-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61757>

This gets rid of an explicit fork().

Since upload-pack has to coordinate two processes (rev-list and
pack-objects), we cannot use the normal finish_async(), but have to monitor
the process explicitly. Hence, there are no changes at this front.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 upload-pack.c |   46 ++++++++++++++++++----------------------------
 1 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index ccdc306..6799468 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -97,11 +97,12 @@ static void show_edge(struct commit *commit)
 	fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
 }
 
-static void do_rev_list(int create_full_pack)
+static int do_rev_list(int fd, void *create_full_pack)
 {
 	int i;
 	struct rev_info revs;
 
+	pack_pipe = fdopen(fd, "w");
 	if (create_full_pack)
 		use_thin_pack = 0; /* no point doing it */
 	init_revisions(&revs, NULL);
@@ -131,14 +132,12 @@ static void do_rev_list(int create_full_pack)
 	prepare_revision_walk(&revs);
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
 	traverse_commit_list(&revs, show_commit, show_object);
+	return 0;
 }
 
 static void create_pack_file(void)
 {
-	/* Pipe from rev-list to pack-objects
-	 */
-	int lp_pipe[2];
-	pid_t pid_rev_list;
+	struct async rev_list;
 	struct child_process pack_objects;
 	int create_full_pack = (nr_our_refs == want_obj.nr && !have_obj.nr);
 	char data[8193], progress[128];
@@ -148,22 +147,12 @@ static void create_pack_file(void)
 	const char *argv[10];
 	int arg = 0;
 
-	if (pipe(lp_pipe) < 0)
-		die("git-upload-pack: unable to create pipe");
-	pid_rev_list = fork();
-	if (pid_rev_list < 0)
+	rev_list.proc = do_rev_list;
+	/* .data is just a boolean: any non-NULL value will do */
+	rev_list.data = create_full_pack ? &rev_list : NULL;
+	if (start_async(&rev_list))
 		die("git-upload-pack: unable to fork git-rev-list");
 
-	if (!pid_rev_list) {
-		close(lp_pipe[0]);
-		pack_pipe = fdopen(lp_pipe[1], "w");
-		do_rev_list(create_full_pack);
-		exit(0);
-	}
-
-	/* writable pipe end must not be inherited by pack_objects */
-	close(lp_pipe[1]);
-
 	argv[arg++] = "pack-objects";
 	argv[arg++] = "--stdout";
 	if (!no_progress)
@@ -173,14 +162,15 @@ static void create_pack_file(void)
 	argv[arg++] = NULL;
 
 	memset(&pack_objects, 0, sizeof(pack_objects));
-	pack_objects.in = lp_pipe[0];	/* start_command closes it */
+	pack_objects.in = rev_list.out;	/* start_command closes it */
 	pack_objects.out = -1;
 	pack_objects.err = -1;
 	pack_objects.git_cmd = 1;
 	pack_objects.argv = argv;
+
 	if (start_command(&pack_objects)) {
 		/* daemon sets things up to ignore TERM */
-		kill(pid_rev_list, SIGKILL);
+		kill(rev_list.pid, SIGKILL);
 		die("git-upload-pack: unable to fork git-pack-objects");
 	}
 
@@ -280,11 +270,11 @@ static void create_pack_file(void)
 		}
 
 		/* See if the children are still there */
-		if (pid_rev_list || pack_objects.pid) {
+		if (rev_list.pid || pack_objects.pid) {
 			pid = waitpid(-1, &status, WNOHANG);
 			if (!pid)
 				continue;
-			who = ((pid == pid_rev_list) ? "git-rev-list" :
+			who = ((pid == rev_list.pid) ? "git-rev-list" :
 			       (pid == pack_objects.pid) ? "git-pack-objects" :
 			       NULL);
 			if (!who) {
@@ -302,11 +292,11 @@ static void create_pack_file(void)
 				      who);
 				goto fail;
 			}
-			if (pid == pid_rev_list)
-				pid_rev_list = 0;
+			if (pid == rev_list.pid)
+				rev_list.pid = 0;
 			if (pid == pack_objects.pid)
 				pack_objects.pid = 0;
-			if (pid_rev_list || pack_objects.pid)
+			if (rev_list.pid || pack_objects.pid)
 				continue;
 		}
 
@@ -329,8 +319,8 @@ static void create_pack_file(void)
  fail:
 	if (pack_objects.pid)
 		kill(pack_objects.pid, SIGKILL);
-	if (pid_rev_list)
-		kill(pid_rev_list, SIGKILL);
+	if (rev_list.pid)
+		kill(rev_list.pid, SIGKILL);
 	send_client_data(3, abort_msg, sizeof(abort_msg));
 	die("git-upload-pack: %s", abort_msg);
 }
-- 
1.5.3.4.315.g2ce38
