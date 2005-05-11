From: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 21:38:30 +0000
Organization: linutronix
Message-ID: <1115847510.22180.108.camel@tglx>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 11 23:34:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVypE-0000BT-Rb
	for gcvg-git@gmane.org; Wed, 11 May 2005 23:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVEKVjR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 17:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVEKVjQ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 17:39:16 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:24194
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261270AbVEKVhm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 17:37:42 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id C70FC65C003
	for <git@vger.kernel.org>; Wed, 11 May 2005 23:37:37 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 64805282A1
	for <git@vger.kernel.org>; Wed, 11 May 2005 23:37:39 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is an initial attempt to enable history tracking for multiple
repositories in a consistent state. At the moment this can only be done
by heuristic guessing on the parent dates and the committer names. 
This fails for example with Dave Millers net-2.6 and sparc-2.6 trees, as
in both cases the committer name is the same. It fails also completely
in cases where the system clock of the committer is wrong and the merge
is a head forward. The old bk repository contains entries from 1999 and
2027, which will happen also with git over the time. 

To identify a repository commit-tree tries to read an environment
variable "GIT_REPOSITORY_ID" and has a fallback to the current working
directory. The environment variable keeps the door open for managed
repository id's, but the current working directory is certainly a quite
helpful information to solve the origin decision for history tracking.

Adding a line after the committer should not break any existing tools
AFAICS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

--- a/commit-tree.c
+++ b/commit-tree.c
@@ -110,6 +110,7 @@ int main(int argc, char **argv)
 	char *gecos, *realgecos, *commitgecos;
 	char *email, *commitemail, realemail[1000];
 	char date[20], realdate[20];
+	char *repoid, repoidbuf[MAXPATHLEN];
 	char *audate;
 	char comment[1000];
 	struct passwd *pw;
@@ -154,6 +155,14 @@ int main(int argc, char **argv)
 	if (audate)
 		parse_date(audate, date, sizeof(date));
 
+	repoid = getenv("GIT_REPOSITORY_ID");
+	if (!repoid)
+		repoid = getcwd(repoidbuf, MAXPATHLEN);
+	else {
+		if (strlen(repoid) == 0)
+			die("GIT_REPOSITORY_ID is empty. Fix it !");
+	}
+
 	remove_special(gecos); remove_special(realgecos); remove_special(commitgecos);
 	remove_special(email); remove_special(realemail); remove_special(commitemail);
 
@@ -170,7 +179,8 @@ int main(int argc, char **argv)
 
 	/* Person/date information */
 	add_buffer(&buffer, &size, "author %s <%s> %s\n", gecos, email, date);
-	add_buffer(&buffer, &size, "committer %s <%s> %s\n\n", commitgecos, commitemail, realdate);
+	add_buffer(&buffer, &size, "committer %s <%s> %s\n", commitgecos, commitemail, realdate);
+	add_buffer(&buffer, &size, "repoid %s\n\n", repoid);
 
 	/* And add the comment */
 	while (fgets(comment, sizeof(comment), stdin) != NULL)


