From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-blame --porcelain: quote filename in c-style when needed.
Date: Sun, 28 Jan 2007 01:44:38 -0800
Message-ID: <7virerfptl.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 28 10:44:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB6aa-0003uh-7t
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 10:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbXA1Jok (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 04:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbXA1Jok
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 04:44:40 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:65206 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514AbXA1Joj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 04:44:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128094439.GAJD18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 04:44:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GZjh1W0081kojtg0000000; Sun, 28 Jan 2007 04:43:41 -0500
In-Reply-To: <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 28 Jan 2007 01:27:38 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38027>

Otherwise a pathname that has funny characters such as LF would
screw up the parsing programs of the output.

Strictly speaking, this is not backward compatible, but the
current output for pathnames that have embedded LF and such
cannot be sanely parsed anyway, and pathnames that only use
characters from the portable pathname character set won't be
affected.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-blame.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 54ab675..7a58ee3 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1182,6 +1182,13 @@ static void get_commit_info(struct commit *commit,
 	summary_buf[len] = 0;
 }
 
+static void write_filename_info(const char *path)
+{
+	printf("filename ");
+	write_name_quoted(NULL, 0, path, 1, stdout);
+	putchar('\n');
+}
+
 static void found_guilty_entry(struct blame_entry *ent)
 {
 	if (ent->guilty)
@@ -1209,9 +1216,7 @@ static void found_guilty_entry(struct blame_entry *ent)
 			if (suspect->commit->object.flags & UNINTERESTING)
 				printf("boundary\n");
 		}
-		printf("filename ");
-		write_name_quoted(NULL, 0, suspect->path, 1, stdout);
-		putchar('\n');
+		write_filename_info(suspect->path);
 	}
 }
 
@@ -1315,13 +1320,13 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 		printf("committer-mail %s\n", ci.committer_mail);
 		printf("committer-time %lu\n", ci.committer_time);
 		printf("committer-tz %s\n", ci.committer_tz);
-		printf("filename %s\n", suspect->path);
+		write_filename_info(suspect->path);
 		printf("summary %s\n", ci.summary);
 		if (suspect->commit->object.flags & UNINTERESTING)
 			printf("boundary\n");
 	}
 	else if (suspect->commit->object.flags & MORE_THAN_ONE_PATH)
-		printf("filename %s\n", suspect->path);
+		write_filename_info(suspect->path);
 
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
-- 
1.5.0.rc2.g1650-dirty
