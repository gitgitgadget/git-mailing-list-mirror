From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Wed, 11 May 2005 19:11:32 -0700
Message-ID: <7vy8alkxbf.fsf@assigned-by-dhcp.cox.net>
References: <1115839456.22180.79.camel@tglx>
	<7vy8alr0mz.fsf@assigned-by-dhcp.cox.net>
	<1115843429.22180.90.camel@tglx>
	<7vis1pqvi4.fsf@assigned-by-dhcp.cox.net>
	<20050511221719.GH22686@pasky.ji.cz>
	<7v4qd9mcp1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 04:04:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW34E-0007Y0-MI
	for gcvg-git@gmane.org; Thu, 12 May 2005 04:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVELCMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 22:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVELCMR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 22:12:17 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51898 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261283AbVELCME (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 22:12:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512021137.NKTO16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 22:11:37 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <7v4qd9mcp1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 11 May 2005 18:54:02 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:
>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

>>> --- a/checkout-cache.c
>>> +++ b/checkout-cache.c
PB> I assume this is irrelevant here?
JCH> Sorry for sending a dirty patch in.  Will fix it up.

------------
Introduce "rev-list --stop-at=<commit>".

Additional option, --stop-at=<commit>, is introduced.  The
git-rev-list output stops just before showing the named commit.

This is based on Thoms Gleixner's patch but slightly reworked,
with documentation updates.

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

