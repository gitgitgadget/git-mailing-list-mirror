From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fetch-pack should not ask for a ref which is already there
Date: Thu, 29 Sep 2005 01:49:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 29 01:50:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKlgP-0001E4-VH
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 01:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVI1Xtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 19:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVI1Xtv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 19:49:51 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19674 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751250AbVI1Xtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 19:49:50 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id A74A6136815
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 01:49:47 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 8406CB3CFC
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 01:49:47 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 5E3C2A885D
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 01:49:47 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 25BD8136815
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 01:49:47 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9450>

With this patch, instead of blindly asking for every remote ref, fetch-pack
first looks in the local repository if that ref is already there.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 fetch-pack.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

6bf41421bed0d640677c5233d2be6813b2211979
diff --git a/fetch-pack.c b/fetch-pack.c
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -16,20 +16,27 @@ static int find_common(int fd[2], unsign
 	int count = 0, flushes = 0, retval;
 	FILE *revs;
 
-	revs = popen("git-rev-list $(git-rev-parse --all)", "r");
-	if (!revs)
-		die("unable to run 'git-rev-list'");
-
 	while (refs) {
 		unsigned char *remote = refs->old_sha1;
-		if (verbose)
-			fprintf(stderr,
-				"want %s (%s)\n", sha1_to_hex(remote),
-				refs->name);
-		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+		if(!has_sha1_file(remote)) {
+			if (verbose)
+				fprintf(stderr,
+					"want %s (%s)\n", sha1_to_hex(remote),
+					refs->name);
+			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+			count++;
+		}
 		refs = refs->next;
 	}
 	packet_flush(fd[1]);
+
+	if(count==0)
+		return 1;
+
+	revs = popen("git-rev-list $(git-rev-parse --all)", "r");
+	if (!revs)
+		die("unable to run 'git-rev-list'");
+
 	flushes = 1;
 	retval = -1;
 	while (fgets(line, sizeof(line), revs) != NULL) {
@@ -86,7 +93,10 @@ static int fetch_pack(int fd[2], int nr_
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	if (find_common(fd, sha1, ref) < 0)
+	status = find_common(fd, sha1, ref);
+	if(status > 0)
+		return 0;
+	if(status < 0)
 		fprintf(stderr, "warning: no common commits\n");
 	pid = fork();
 	if (pid < 0)
