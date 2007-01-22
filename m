From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make sure git_connect() always give two file descriptors.
Date: Sun, 21 Jan 2007 17:10:51 -0800
Message-ID: <7v3b63zx0k.fsf_-_@assigned-by-dhcp.cox.net>
References: <17843.29798.866272.414435@lisa.zopyra.com>
	<ep00nl$mop$1@sea.gmane.org>
	<Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
	<17843.55730.456139.247155@lisa.zopyra.com>
	<Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
	<Pine.LNX.4.64.0701211554450.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 02:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8ni4-0004tX-WA
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 02:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbXAVBKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 20:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbXAVBKx
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 20:10:53 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:58859 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbXAVBKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 20:10:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122011052.JRZA2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jan 2007 20:10:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E1BA1W00C1kojtg0000000; Sun, 21 Jan 2007 20:11:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211554450.14248@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 21 Jan 2007 16:17:20 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37375>

Earlier, git_connect() returned the same fd when the destination
was remote (i.e.  we used socket to communicate with it) and two
separate fds when the destination was local (i.e. we used
pipe(2)).

This forced callers who do close() and dup() to really care
which was which, and most of the existing callers got this
wrong, although without much visible ill effect.

Fix it to uniformly use two separate fd, so if somebody wants to
close only reader side can just do close() on it without
worrying about it accidentally also closing the writer side or
vice versa.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Your patch; just checking if the above log message makes sense...

 connect.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index 66daa11..7844888 100644
--- a/connect.c
+++ b/connect.c
@@ -529,7 +529,7 @@ static void git_tcp_connect(int fd[2], char *host)
 	int sockfd = git_tcp_connect_sock(host);
 
 	fd[0] = sockfd;
-	fd[1] = sockfd;
+	fd[1] = dup(sockfd);
 }
 
 
-- 
1.5.0.rc2
