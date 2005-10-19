From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Do not send "want" lines for complete objects
Date: Thu, 20 Oct 2005 00:07:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 20 00:09:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESM66-0003T1-Pc
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 00:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbVJSWHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 18:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbVJSWHn
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 18:07:43 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:5293 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751519AbVJSWHn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 18:07:43 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 32EB713F0B5; Thu, 20 Oct 2005 00:07:42 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 19DA99EEF5; Thu, 20 Oct 2005 00:07:42 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F14DD9EEC5; Thu, 20 Oct 2005 00:07:41 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D122A13F0B5; Thu, 20 Oct 2005 00:07:41 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10317>

It was all good and well to check if all remote refs are complete (local 
refs or descendants thereof), but we can just as easily use the same 
information to avoid sending "want" lines just for the complete objects in 
the case that not all remote refs are complete (or their names differ).

Also, git-fetch-pack does not have to ask for descendants of remote refs 
which are complete (for now, git-rev-list is told to ignore only the first 
parent). That change also eliminates a code path where a popen()ed handle 
was not pclose()ed.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	With this patch, in a particular setup, git-fetch got 805 objects 
	instead of 8404, i.e. 10 times less! This setup involves 691 
	tags...

	NOTE: I'd rather have git-rev-list circumvented, so that 
	descendants of ack'ed objects are not sent via "have" lines.

	2nd NOTE: If this patch reminds you of my "has_ref()" patch: Yes,
	it is the next generation of that idea.

 fetch-pack.c |   33 +++++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 8 deletions(-)

applies-to: f76de7f266b0b7feb38c73c7ccb635d6da18a582
f22af070becd6546eeff44895769b8299a6ddb5e
diff --git a/fetch-pack.c b/fetch-pack.c
index 969e72a..9dfd072 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -12,31 +12,49 @@ static const char fetch_pack_usage[] =
 "git-fetch-pack [-q] [-v] [--exec=upload-pack] [host:]directory <refs>...";
 static const char *exec = "git-upload-pack";
 
+#define COMPLETE	(1U << 0)
+
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
 	int fetching;
 	static char line[1000];
-	int count = 0, flushes = 0, retval;
+	static char rev_command[1024];
+	int count = 0, flushes = 0, retval, rev_command_len;
 	FILE *revs;
 
-	revs = popen("git-rev-list $(git-rev-parse --all)", "r");
-	if (!revs)
-		die("unable to run 'git-rev-list'");
-
+	strcpy(rev_command, "git-rev-list $(git-rev-parse --all)");
+	rev_command_len = strlen(rev_command);
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
 		unsigned char *remote = refs->old_sha1;
-		unsigned char *local = refs->new_sha1;
 
-		if (!memcmp(remote, local, 20))
+		/*
+		   If that object is complete (i.e. it is a descendant of a
+		   local ref), we don't want it, nor its descendants.
+		*/
+		if (has_sha1_file(remote)
+				&& parse_object(remote)->flags & COMPLETE) {
+			if (rev_command_len + 44 < sizeof(rev_command)) {
+				snprintf(rev_command + rev_command_len, 44,
+					" ^%s^", sha1_to_hex(remote));
+				rev_command_len += 43;
+			}
+
 			continue;
+		}
+
 		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
 		fetching++;
 	}
 	packet_flush(fd[1]);
 	if (!fetching)
 		return 1;
+
+	revs = popen(rev_command, "r");
+	if (!revs)
+		die("unable to run 'git-rev-list'");
+
 	flushes = 1;
 	retval = -1;
 	while (fgets(line, sizeof(line), revs) != NULL) {
@@ -81,7 +99,6 @@ static int find_common(int fd[2], unsign
 	return retval;
 }
 
-#define COMPLETE	(1U << 0)
 static struct commit_list *complete = NULL;
 
 static int mark_complete(const char *path, const unsigned char *sha1)
---
0.99.8.GIT
