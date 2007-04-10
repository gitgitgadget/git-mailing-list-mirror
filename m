From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] Add %m to '--pretty=format:'
Date: Tue, 10 Apr 2007 15:39:03 -0700
Message-ID: <7vslb7ua60.fsf_-_@assigned-by-dhcp.cox.net>
References: <1175686583.19898.68.camel@okra.transitives.com>
	<Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
	<7vircbwfym.fsf@assigned-by-dhcp.cox.net>
	<7virc524cd.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 07:50:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbOzZ-0000uQ-Bt
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030688AbXDJWjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030653AbXDJWjI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:39:08 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63863 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030682AbXDJWjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:39:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410223904.MCJA1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 18:39:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id laf31W00l1kojtg0000000; Tue, 10 Apr 2007 18:39:04 -0400
In-Reply-To: <7virc524cd.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 09 Apr 2007 04:07:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44189>

When used with '--boundary A...B', this shows the -/</> marker
you would get with --left-right option to 'git-log' family.
When symmetric diff is not used, everybody is shown to be on the
"right" branch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * This was one thing I found missing from the "--pretty=format:"
   Dscho did.  This time it comes with a documentation updates ;-).

 Documentation/pretty-formats.txt |    1 +
 commit.c                         |   16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 2fe6c31..d7ffc21 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -117,6 +117,7 @@ The placeholders are:
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
 - '%Creset': reset color
+- '%m': left, right or boundary mark
 - '%n': newline
 
 
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
-- 
1.5.1.777.gd14d3
