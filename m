From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fix reflog entries for "git-branch"
Date: Fri, 19 Jan 2007 11:51:29 -0800
Message-ID: <7vy7nyg5ha.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 19 20:51:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7zlv-0004Jb-0L
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 20:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932863AbXASTvb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 14:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbXASTvb
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 14:51:31 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:49506 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932862AbXASTvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 14:51:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119195130.XXHM3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 14:51:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id D7rn1W00m1kojtg0000000; Fri, 19 Jan 2007 14:51:48 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37197>

Even when -l is not given from the command line, the repository
may have the configuration variable core.logallrefupdates set,
or an old-timer might have done ": >.git/logs/refs/heads/new"
before running "git branch new".  In these cases, the code gave
an uninitialized msg[] from the stack to be written out as the
reflog message.

This also passes a different message when '-f' option is used.
Saying "git branch -f branch some-commit" is a moral equilvalent
of doing "git-reset some-commit" while on the branch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/builtin-branch.c b/builtin-branch.c
index c760e18..bbac9dc 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -316,6 +316,7 @@ static void create_branch(const char *name, const char *start_name,
 	struct commit *commit;
 	unsigned char sha1[20];
 	char ref[PATH_MAX], msg[PATH_MAX + 20];
+	int forcing = 0;
 
 	snprintf(ref, sizeof ref, "refs/heads/%s", name);
 	if (check_ref_format(ref))
@@ -326,6 +327,7 @@ static void create_branch(const char *name, const char *start_name,
 			die("A branch named '%s' already exists.", name);
 		else if (!strcmp(head, name))
 			die("Cannot force update the current branch.");
+		forcing = 1;
 	}
 
 	if (start_sha1)
@@ -342,11 +344,15 @@ static void create_branch(const char *name, const char *start_name,
 	if (!lock)
 		die("Failed to lock ref for update: %s.", strerror(errno));
 
-	if (reflog) {
+	if (reflog)
 		log_all_ref_updates = 1;
+
+	if (forcing)
+		snprintf(msg, sizeof msg, "branch: Reset from %s",
+			 start_name);
+	else
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
-	}
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
