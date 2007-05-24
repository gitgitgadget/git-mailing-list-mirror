From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] name-rev: tolerate clock skew in committer dates
Date: Thu, 24 May 2007 12:21:55 -0700
Message-ID: <7vr6p6vxgs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 21:22:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrIsr-00022E-Vv
	for gcvg-git@gmane.org; Thu, 24 May 2007 21:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbXEXTV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 15:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbXEXTV5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 15:21:57 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:61084 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbXEXTV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 15:21:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524192156.SXUD6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 15:21:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 37Mv1X0081kojtg0000000; Thu, 24 May 2007 15:21:55 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48295>

In git.git repository, "git-name-rev v1.3.0~158" cannot name the
rev, while adjacent revs can be named.

This was because it gives up traversal from the tips of existing
refs as soon as it sees a commit that has older commit timestamp
than what is being named.  This is usually a good heuristics,
but v1.3.0~158 has a slightly older commit timestamp than
v1.3.0~157 (i.e. it's child), as these two were made in a
separate repostiory (in fact, in a different continent).

This adds a hardcoded slop value (1 day) to the cut-off
heuristics to work this kind of problem around.  The current
algorithm essentially runs around from the available tips down
to ancient commits and names every single rev available that are
newer than cut-off date, so a single day slop would not add that
much overhead in repositories with long enough history where the
performance of name-rev matters.

I think the algorithm could be made a bit smarter by deepening
the graph on demand as a new commit is asked to be named (this
would require rewriting of name_rev() function not to recurse
itself but use a traversal list like revision.c traverser does),
but that would be a separate issue.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-name-rev.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index a639e2f..d3c42ed 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -4,6 +4,8 @@
 #include "tag.h"
 #include "refs.h"
 
+#define CUTOFF_DATE_SLOP 86400 /* one day */
+
 static const char name_rev_usage[] =
 	"git-name-rev [--tags | --refs=<pattern>] ( --all | --stdin | committish [committish...] )\n";
 
@@ -216,6 +218,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		add_object_array((struct object *)commit, *argv, &revs);
 	}
 
+	if (cutoff)
+		cutoff = cutoff - CUTOFF_DATE_SLOP;
 	for_each_ref(name_ref, &data);
 
 	if (transform_stdin) {
-- 
1.5.2.58.g98ee
