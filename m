From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach fmt-patch about --keep-subject
Date: Fri, 5 May 2006 04:31:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605050431020.26082@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri May 05 04:31:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbq6X-0001Ky-5K
	for gcvg-git@gmane.org; Fri, 05 May 2006 04:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWEECbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 22:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWEECbb
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 22:31:31 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:46519 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932439AbWEECba (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 22:31:30 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 8C8391CC4;
	Fri,  5 May 2006 04:31:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 808901CB7;
	Fri,  5 May 2006 04:31:29 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 6D9AC10A3;
	Fri,  5 May 2006 04:31:29 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19595>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-log.c |   16 ++++++++++++----
 log-tree.c    |    5 ++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 43c7ecd..0027998 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -78,7 +78,7 @@ static int istitlechar(char c)
 static FILE *realstdout = NULL;
 static char *output_directory = NULL;
 
-static void reopen_stdout(struct commit *commit, int nr)
+static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
 {
 	char filename[1024];
 	char *sol;
@@ -100,7 +100,7 @@ static void reopen_stdout(struct commit 
 
 		sol += 2;
 		/* strip [PATCH] or [PATCH blabla] */
-		if (!strncmp(sol, "[PATCH", 6)) {
+		if (!keep_subject && !strncmp(sol, "[PATCH", 6)) {
 			char *eos = strchr(sol + 6, ']');
 			if (eos) {
 				while (isspace(*eos))
@@ -138,6 +138,7 @@ int cmd_format_patch(int argc, const cha
 	int nr = 0, total, i, j;
 	int use_stdout = 0;
 	int numbered = 0;
+	int keep_subject = 0;
 
 	init_revisions(&rev);
 	rev.commit_format = CMIT_FMT_EMAIL;
@@ -160,7 +161,11 @@ int cmd_format_patch(int argc, const cha
 		else if (!strcmp(argv[i], "-n") ||
 				!strcmp(argv[i], "--numbered"))
 			numbered = 1;
-		else if (!strcmp(argv[i], "-o")) {
+		else if (!strcmp(argv[i], "-k") ||
+				!strcmp(argv[i], "--keep-subject")) {
+			keep_subject = 1;
+			rev.total = -1;
+		} else if (!strcmp(argv[i], "-o")) {
 			if (argc < 3)
 				die ("Which directory?");
 			if (mkdir(argv[i + 1], 0777) < 0 && errno != EEXIST)
@@ -173,6 +178,9 @@ int cmd_format_patch(int argc, const cha
 	}
 	argc = j;
 
+	if (numbered && keep_subject < 0)
+		die ("-n and -k are mutually exclusive.");
+
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
@@ -197,7 +205,7 @@ int cmd_format_patch(int argc, const cha
 		commit = list[nr];
 		rev.nr = total - nr;
 		if (!use_stdout)
-			reopen_stdout(commit, rev.nr);
+			reopen_stdout(commit, rev.nr, keep_subject);
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
 		commit->buffer = NULL;
diff --git a/log-tree.c b/log-tree.c
index cec7068..526d578 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -58,8 +58,11 @@ void show_log(struct rev_info *opt, stru
 					"Subject: [PATCH %d/%d] ",
 					opt->nr, opt->total);
 			subject = buffer;
-		} else
+		} else if (opt->total == 0)
 			subject = "Subject: [PATCH] ";
+		else
+			subject = "Subject: ";
+
 		printf("From %s  Thu Apr 7 15:13:13 2005\n",
 		       sha1_to_hex(commit->object.sha1));
 	} else {
-- 
1.3.1.g5f039
