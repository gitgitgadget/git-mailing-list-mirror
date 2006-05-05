From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fmt-patch: implement -o <dir>
Date: Fri, 5 May 2006 03:33:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605050333150.25591@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri May 05 03:33:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbpCL-0001aw-9w
	for gcvg-git@gmane.org; Fri, 05 May 2006 03:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWEEBde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 21:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWEEBde
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 21:33:34 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40882 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932287AbWEEBde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 21:33:34 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 0E47E2062;
	Fri,  5 May 2006 03:33:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 02F3C2061;
	Fri,  5 May 2006 03:33:33 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E3640205D;
	Fri,  5 May 2006 03:33:32 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19593>


I had to move the command line parsing around a little; setup_revisions()
could mistaken <dir> for a valid ref.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-log.c |   44 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1649f49..53a47c9 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -76,15 +76,22 @@ static int istitlechar(char c)
 }
 
 static FILE *realstdout = NULL;
+static char *output_directory = NULL;
 
 static void reopen_stdout(struct commit *commit, int nr)
 {
 	char filename[1024];
 	char *sol;
-	int len;
+	int len = 0;
 
+	if (output_directory) {
+		strncpy(filename, output_directory, 1010);
+		len = strlen(filename);
+		if (filename[len - 1] != '/')
+			filename[len++] = '/';
+	}
 
-	sprintf(filename, "%04d", nr);
+	sprintf(filename + len, "%04d", nr);
 	len = strlen(filename);
 
 	sol = strstr(commit->buffer, "\n\n");
@@ -128,7 +135,7 @@ int cmd_format_patch(int argc, const cha
 	struct commit *commit;
 	struct commit **list = NULL;
 	struct rev_info rev;
-	int nr = 0, total;
+	int nr = 0, total, i, j;
 	int use_stdout = 0;
 
 	init_revisions(&rev);
@@ -140,16 +147,31 @@ int cmd_format_patch(int argc, const cha
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
-	argc = setup_revisions(argc, argv, &rev, "HEAD");
 
-	while (argc > 1) {
-		if (!strcmp(argv[1], "--stdout"))
+	/*
+	 * Parse the arguments before setup_revisions(), or something
+	 * like "git fmt-patch -o a123 HEAD^.." may fail; a123 is
+	 * possibly a valid SHA1.
+	 */
+	for (i = 1, j = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--stdout"))
 			use_stdout = 1;
-		else
-			die ("unrecognized argument: %s", argv[1]);
-		argc--;
-		argv++;
+		else if (!strcmp(argv[i], "-o")) {
+			if (argc < 3)
+				die ("Which directory?");
+			if (mkdir(argv[i + 1], 0777) < 0 && errno != EEXIST)
+				die("Could not create directory %s",
+						argv[i + 1]);
+			output_directory = strdup(argv[i + 1]);
+			i++;
+		} else
+			argv[j++] = argv[i];
 	}
+	argc = j;
+
+	argc = setup_revisions(argc, argv, &rev, "HEAD");
+	if (argc > 1)
+		die ("unrecognized argument: %s", argv[1]);
 
 	if (!use_stdout)
 		realstdout = fdopen(dup(1), "w");
@@ -177,6 +199,8 @@ int cmd_format_patch(int argc, const cha
 		if (!use_stdout)
 			fclose(stdout);
 	}
+	if (output_directory)
+		free(output_directory);
 	free(list);
 	return 0;
 }
-- 
1.3.1.g6d0e-dirty
