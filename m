From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] shortlog: prompt when reading from terminal by mistake
Date: Thu, 08 Mar 2007 02:12:06 -0800
Message-ID: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 11:12:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFbb-00031M-73
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 11:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945AbXCHKMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 05:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932969AbXCHKMJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 05:12:09 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54844 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932945AbXCHKMI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 05:12:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308101208.ZRKJ2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Mar 2007 05:12:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YAC61W00G1kojtg0000000; Thu, 08 Mar 2007 05:12:07 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41733>

I was trying to see who have been active recently to find GSoC
mentor candidates by running:

	$ git shortlog -s -n --since=4.months | head -n 20

After waiting for about 20 seconds, I started getting worried,
thinking that the recent revision traversal updates might have
had an unintended side effect.

Not so.  "git shortlog" acts as a filter when no revs are given,
unlike "git log" which defaults to HEAD.  It was reading from
its standard input.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

   Arguably because --since=4.months clearly states I am
   expecting it to start digging from somewhere, it would be
   more sensible to default to HEAD in this case.  I suspect it
   might be as simple as checking argc before we call
   setup_revisions() and pass "HEAD" as the default parameter to
   it, but it is getting late here.

 builtin-shortlog.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 2d7726e..29343ae 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -304,8 +304,11 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	if (!access(".mailmap", R_OK))
 		read_mailmap(".mailmap");
 
-	if (rev.pending.nr == 0)
+	if (rev.pending.nr == 0) {
+		if (isatty(0))
+			fprintf(stderr, "(reading log to summarize from standard input)\n");
 		read_from_stdin(&list);
+	}
 	else
 		get_from_rev(&rev, &list);
 
