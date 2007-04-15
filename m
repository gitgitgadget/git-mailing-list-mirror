From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix 'diff' attribute semantics.
Date: Sun, 15 Apr 2007 16:12:11 -0700
Message-ID: <7vlkgt1bck.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
	<200704131033.15751.andyparkins@gmail.com>
	<7vejmm78qp.fsf@assigned-by-dhcp.cox.net>
	<7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
	<7vr6qm5r73.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704142103210.5473@woody.linux-foundation.org>
	<7vr6ql1ben.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:12:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdDtJ-0005Su-Sk
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbXDOXMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbXDOXMO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:12:14 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:53748 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbXDOXMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:12:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415231212.KMLI1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 19:12:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nbCB1W00l1kojtg0000000; Sun, 15 Apr 2007 19:12:12 -0400
In-Reply-To: <7vr6ql1ben.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 15 Apr 2007 16:10:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44542>

This is in the same spirit as the previous one.  Earlier 'diff'
meant 'do the built-in binary heuristics and disable patch text
generation based on it' while '!diff' meant 'do not guess, do
not generate patch text'.  There was no way to say 'do generate
patch text even when the heuristics says it has NUL in it'.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * And this is a companion patch to 'crlf' one.

 diff.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index e4efb65..dcea405 100644
--- a/diff.c
+++ b/diff.c
@@ -1069,8 +1069,9 @@ static int file_is_binary(struct diff_filespec *one)
 
 	setup_diff_attr_check(&attr_diff_check);
 	if (!git_checkattr(one->path, 1, &attr_diff_check) &&
-	    (0 == attr_diff_check.isset))
-		return 1;
+	    (0 <= attr_diff_check.isset))
+		return !attr_diff_check.isset;
+
 	if (!one->data) {
 		if (!DIFF_FILE_VALID(one))
 			return 0;
-- 
1.5.1.1.815.g3e763
