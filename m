From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Introduce "rev-list --stop-at=<commit>".
Date: Thu, 12 May 2005 17:15:15 -0700
Message-ID: <7v3bssc770.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 02:08:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWNit-0007vV-3A
	for gcvg-git@gmane.org; Fri, 13 May 2005 02:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVEMAPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 20:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVEMAPk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 20:15:40 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11504 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262186AbVEMAPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 20:15:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050513001516.ODX7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 20:15:16 -0400
To: Petr Baudis <pasky@ucw.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Additional option, --stop-at=<commit>, is introduced.  The
git-rev-list output stops just before showing the named commit.

This is based on Thoms Gleixner's patch but slightly reworked.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-rev-list.txt |   18 +++++++++++++++++-
rev-list.c                     |   20 ++++++++++++++++----
2 files changed, 33 insertions(+), 5 deletions(-)

--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,7 +9,10 @@
 
 SYNOPSIS
 --------
-'git-rev-list' <commit>
+'git-rev-list'	[--max-count=<number>]
+		[--max-age=<unixtime>]
+		[--min-age=<unixtime>]
+		[--stop-at=<commit>] <commit>
 
 DESCRIPTION
 -----------
@@ -17,6 +20,19 @@
 given commit, taking ancestry relationship into account.  This is
 useful to produce human-readable log output.
 
+OPTIONS
+-------
+--max-count=<number>::
+	Stop after showing <number> commits.
+
+--max-age=<unixtime>::
+	Stop after showing commit made before <unixtime>.
+
+--min-age=<unixtime>::
+	Skip until commit made before <unixtime>.
+
+--stop-at=<commit>::
+	Stop just before showing <commit>.
 
 Author
 ------
--- a/rev-list.c
+++ b/rev-list.c
@@ -1,12 +1,21 @@
 #include "cache.h"
 #include "commit.h"
 
+static const char *rev_list_usage = 
+"usage: rev-list [OPTION] commit-id\n"
+"  --max-count=nr\n"
+"  --max-age=epoch\n"
+"  --min-age=epoch\n"
+"  --stop-at=commit\n";
+
 int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
 	struct commit_list *list = NULL;
 	struct commit *commit;
 	char *commit_arg = NULL;
+	unsigned char stop_at[20];
+	int has_stop_at = 0;
 	int i;
 	unsigned long max_age = -1;
 	unsigned long min_age = -1;
@@ -21,16 +30,17 @@
 			max_age = atoi(arg + 10);
 		} else if (!strncmp(arg, "--min-age=", 10)) {
 			min_age = atoi(arg + 10);
+		} else if (!strncmp(arg, "--stop-at=", 10)) {
+			if (get_sha1(arg + 10, stop_at))
+				usage(rev_list_usage);
+			has_stop_at = 1;
 		} else {
 			commit_arg = arg;
 		}
 	}
 
 	if (!commit_arg || get_sha1(commit_arg, sha1))
-		usage("usage: rev-list [OPTION] commit-id\n"
-		      "  --max-count=nr\n"
-		      "  --max-age=epoch\n"
-		      "  --min-age=epoch\n");
+		usage(rev_list_usage);
 
 	commit = lookup_commit(sha1);
 	if (!commit || parse_commit(commit) < 0)
@@ -46,6 +56,8 @@
 			break;
 		if (max_count != -1 && !max_count--)
 			break;
+		if (has_stop_at && !memcmp(stop_at, commit->object.sha1, 20))
+			break;
 		printf("%s\n", sha1_to_hex(commit->object.sha1));
 	} while (list);
 	return 0;
------------------------------------------------

