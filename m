From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Add %m to '--pretty=format:'
Date: Mon, 09 Apr 2007 04:11:13 -0700
Message-ID: <7vbqhx246m.fsf_-_@assigned-by-dhcp.cox.net>
References: <1175686583.19898.68.camel@okra.transitives.com>
	<Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
	<7vircbwfym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 13:12:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HarmI-0003Rt-Is
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 13:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbXDILLP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 07:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752812AbXDILLP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 07:11:15 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50605 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbXDILLO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 07:11:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409111115.MFPN373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Apr 2007 07:11:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kzBD1W0061kojtg0000000; Mon, 09 Apr 2007 07:11:14 -0400
In-Reply-To: <7vircbwfym.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 04 Apr 2007 22:25:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44049>

When used with '--boundary A...B', this shows the -/</> marker you
would get with --left-right option to 'git-log' family.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This can be used like this:

	$ git log --cherry-pick --pretty='format:%m%h %s' origin...master
	<e712d0c upstream side commit
        <deadbee upstream side commit
        >cafedee commit on my side

   to identify commits yet to be sent, probably easier to read
   than git-cherry.

 commit.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 754d1b8..952095f 100644
--- a/commit.c
+++ b/commit.c
@@ -4,6 +4,8 @@
 #include "pkt-line.h"
 #include "utf8.h"
 #include "interpolate.h"
+#include "diff.h"
+#include "revision.h"
 
 int save_commit_buffer = 1;
 
@@ -808,7 +810,8 @@ static long format_commit_message(const struct commit *commit,
 		{ "%Cgreen" },	/* green */
 		{ "%Cblue" },	/* blue */
 		{ "%Creset" },	/* reset color */
-		{ "%n" }	/* newline */
+		{ "%n" },	/* newline */
+		{ "%m" },	/* left/right/bottom */
 	};
 	enum interp_index {
 		IHASH = 0, IHASH_ABBREV,
@@ -824,14 +827,15 @@ static long format_commit_message(const struct commit *commit,
 		ISUBJECT,
 		IBODY,
 		IRED, IGREEN, IBLUE, IRESET_COLOR,
-		INEWLINE
+		INEWLINE,
+		ILEFT_RIGHT,
 	};
 	struct commit_list *p;
 	char parents[1024];
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
 
-	if (INEWLINE + 1 != ARRAY_SIZE(table))
+	if (ILEFT_RIGHT + 1 != ARRAY_SIZE(table))
 		die("invalid interp table!");
 
 	/* these are independent of the commit */
@@ -852,6 +856,12 @@ static long format_commit_message(const struct commit *commit,
 	interp_set_entry(table, ITREE_ABBREV,
 			find_unique_abbrev(commit->tree->object.sha1,
 				DEFAULT_ABBREV));
+	interp_set_entry(table, ILEFT_RIGHT,
+			 (commit->object.flags & BOUNDARY)
+			 ? "-"
+			 : (commit->object.flags & SYMMETRIC_LEFT)
+			 ? "<"
+			 : ">");
 
 	parents[1] = 0;
 	for (i = 0, p = commit->parents;
