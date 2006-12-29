From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFH] send-pack: fix pipeline.
Date: Fri, 29 Dec 2006 02:37:33 -0800
Message-ID: <7v1wmjoumq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Fri Dec 29 11:37:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0F7K-00068j-P0
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 11:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWL2Khe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 05:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWL2Khe
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 05:37:34 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51314 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbWL2Khe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 05:37:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229103733.REGN15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Dec 2006 05:37:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4aco1W00F1kojtg0000000; Fri, 29 Dec 2006 05:36:48 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35586>

send-pack builds a pipeline that runs "rev-list | pack-objects"
and sends the output from pack-objects to the other side, while
feeding the input side of that pipe from itself.  However, the
file descriptor that is given to this pipeline (so that it can
be dup2(2)'ed into file descriptor 1 of pack-objects) is closed
by the caller before the complex fork+exec dance!  Worse yet,
the caller already dup2's it to 1, so the child process did not
even have to.

I do not understand how this code could possibly have been
working, but it somehow was working by accident.

Merging the sliding mmap() code reveals this problem, presumably
because it keeps one extra file descriptor open for a packfile
and changes the way file descriptors are allocated.  I am too
tired to diagnose the problem now, but this seems to be a
sensible fix.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * With this patch (and another one I sent out a fix already),
   it appears that the send-pack problem I was having with
   sp/mmap topic seems to have disappeared.  But that is no way
   a proof that everything is peachy now.

   Somebody less tired than myself should really audit the
   pipeline built by send-pack.

 send-pack.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index cc884f3..54de96e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -58,7 +58,7 @@ static void exec_rev_list(struct ref *refs)
 /*
  * Run "rev-list --stdin | pack-objects" pipe.
  */
-static void rev_list(int fd, struct ref *refs)
+static void rev_list(struct ref *refs)
 {
 	int pipe_fd[2];
 	pid_t pack_objects_pid;
@@ -71,10 +71,8 @@ static void rev_list(int fd, struct ref *refs)
 		 * and writes to the original fd
 		 */
 		dup2(pipe_fd[0], 0);
-		dup2(fd, 1);
 		close(pipe_fd[0]);
 		close(pipe_fd[1]);
-		close(fd);
 		exec_pack_objects();
 		die("pack-objects setup failed");
 	}
@@ -85,7 +83,6 @@ static void rev_list(int fd, struct ref *refs)
 	dup2(pipe_fd[1], 1);
 	close(pipe_fd[0]);
 	close(pipe_fd[1]);
-	close(fd);
 	exec_rev_list(refs);
 }
 
@@ -111,7 +108,7 @@ static void rev_list_generate(int fd, struct ref *refs)
 		close(pipe_fd[0]);
 		close(pipe_fd[1]);
 		close(fd);
-		rev_list(fd, refs);
+		rev_list(refs);
 		die("rev-list setup failed");
 	}
 	if (rev_list_generate_pid < 0)
