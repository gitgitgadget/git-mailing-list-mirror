From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] plumber's puzzle
Date: Sun, 22 Apr 2007 15:34:46 -0700
Message-ID: <7vps5wkph5.fsf@assigned-by-dhcp.cox.net>
References: <7v647ombi6.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221341080.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 00:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfkdw-0001HR-Ru
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 00:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbXDVWes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 18:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbXDVWes
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 18:34:48 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52053 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbXDVWer (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 18:34:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422223447.ULHZ1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 18:34:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qNam1W00o1kojtg0000000; Sun, 22 Apr 2007 18:34:47 -0400
In-Reply-To: <alpine.LFD.0.98.0704221341080.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 22 Apr 2007 13:43:02 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45284>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 22 Apr 2007, Junio C Hamano wrote:
>> 
>> This shows the single "diff --git" header line without anything,
>> to show that the path is not stat-clean, but the contents are
>> unchanged, which is what is expected.
>
> Actually, I think the "good" case is the broken one.
>
> Do an "strace -f" on the two cases, and you'll see an EBADF in the case 
> that you think is good: the missing output *is* there, it's just that you 
> closed the file descriptor so you don't see it.
>
> So if the output you want is with the close(1) (ie with the output 
> discarded), then you have some other bug there.

I think I figured it out.  The extra EBADF output comes from the
process that calls finish_command() in filter_buffer().

That is because the caller is diff_flush() which prepares its
output using stdio, and when apply_filter -> filter_bufer
callchain forks, the unflushed stdout hangs around in the
child.  Then we call exit() in apply_filter() to terminate the
child we spawned to do the filtering.  It flushes its copy of
stdio buffer.

Yuck.

I should be happy that I figured out what is going on, but I am
not very happy with this patch.

diff --git a/convert.c b/convert.c
index 845825b..35bb8cf 100644
--- a/convert.c
+++ b/convert.c
@@ -233,7 +233,6 @@ static int filter_buffer(const char *path, const char *src,
 		return 1;
 	}
 	close(pipe_feed[0]);
-	close(1);
 
 	write_err = (write_in_full(pipe_feed[1], src, size) < 0);
 	if (close(pipe_feed[1]))
@@ -273,6 +272,7 @@ static char *apply_filter(const char *path, const char *src,
 		return NULL;
 	}
 
+	fflush(stdout);
 	child_process.pid = fork();
 	if (child_process.pid < 0) {
 		error("cannot fork to run external filter %s", cmd);
