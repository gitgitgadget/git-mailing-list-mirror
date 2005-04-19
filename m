From: Greg KH <greg@kroah.com>
Subject: [PATCH] provide better committer information to commit-tree.c
Date: Mon, 18 Apr 2005 17:11:27 -0700
Message-ID: <20050419001126.GB21170@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 02:07:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgHP-00025y-VV
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVDSALy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDSALy
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:11:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:10439 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261186AbVDSALu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 20:11:50 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3J0Bmi16296;
	Mon, 18 Apr 2005 17:11:48 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DNgKt-5Yw-00; Mon, 18 Apr 2005 17:11:27 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here's a small patch to commit-tree.c that does two things:
	- allows the committer email address and name to be overridden
	  by environment variables (if you don't like the environment
	  variable names I've used (COMMIT_AUTHOR_NAME,
	  COMMIT_AUTHOR_EMAIL), feel free to change them.)
	- provide the proper domainname to the author/committer email
	  address (otherwise, my address was only showing up as from the
	  hostname.)

This allows people to set sane values for the commit names and email
addresses, preventing odd, private hostnames and domains from being
exposed to the world.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- a/commit-tree.c.orig	2005-04-18 17:02:50.000000000 -0700
+++ b/commit-tree.c	2005-04-18 17:03:19.000000000 -0700
@@ -284,8 +284,8 @@
 	unsigned char tree_sha1[20];
 	unsigned char parent_sha1[MAXPARENT][20];
 	unsigned char commit_sha1[20];
-	char *gecos, *realgecos;
-	char *email, realemail[1000];
+	char *gecos, *realgecos, *commitgecos;
+	char *email, *commitemail, realemail[1000];
 	char date[20], realdate[20];
 	char *audate;
 	char comment[1000];
@@ -317,20 +317,24 @@
 	memcpy(realemail, pw->pw_name, len);
 	realemail[len] = '@';
 	gethostname(realemail+len+1, sizeof(realemail)-len-1);
+	strcat(realemail, ".");
+	getdomainname(realemail+strlen(realemail), sizeof(realemail)-strlen(realemail)-1);
 	time(&now);
 	tm = localtime(&now);
 
 	strftime(realdate, sizeof(realdate), "%s %z", tm);
 	strcpy(date, realdate);
 
+	commitgecos = getenv("COMMIT_AUTHOR_NAME") ? : realgecos;
+	commitemail = getenv("COMMIT_AUTHOR_EMAIL") ? : realemail;
 	gecos = getenv("AUTHOR_NAME") ? : realgecos;
 	email = getenv("AUTHOR_EMAIL") ? : realemail;
 	audate = getenv("AUTHOR_DATE");
 	if (audate)
 		parse_rfc2822_date(audate, date, sizeof(date));
 
-	remove_special(gecos); remove_special(realgecos);
-	remove_special(email); remove_special(realemail);
+	remove_special(gecos); remove_special(realgecos); remove_special(commitgecos);
+	remove_special(email); remove_special(realemail); remove_special(commitemail);
 
 	init_buffer(&buffer, &size);
 	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
@@ -345,7 +349,7 @@
 
 	/* Person/date information */
 	add_buffer(&buffer, &size, "author %s <%s> %s\n", gecos, email, date);
-	add_buffer(&buffer, &size, "committer %s <%s> %s\n\n", realgecos, realemail, realdate);
+	add_buffer(&buffer, &size, "committer %s <%s> %s\n\n", commitgecos, commitemail, realdate);
 
 	/* And add the comment */
 	while (fgets(comment, sizeof(comment), stdin) != NULL)
