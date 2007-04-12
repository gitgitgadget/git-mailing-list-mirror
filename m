From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Thu, 12 Apr 2007 16:02:56 -0700
Message-ID: <7vodlti4bj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:03:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc8Jk-0006fP-5f
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 01:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbXDLXC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 19:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbXDLXC6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 19:02:58 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42212 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbXDLXC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 19:02:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412230258.JCKB1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Apr 2007 19:02:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mP2w1W00s1kojtg0000000; Thu, 12 Apr 2007 19:02:57 -0400
In-Reply-To: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 12 Apr 2007 14:58:28 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44364>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I'm normally actually very good at doing that "grep" mentally, and don't 
> actually often need to do it explicitly at all, unless the patch is just 
> pretty messy. But sometimes the patch is just confusing enough that it 
> helps to explicitly filter it.
>
> Now, the reason I mention this is that I was just in "gitk", and while I 
> love the gitk graphical revision view, I just noticed (once again) why I 
> tend to hate most GUI programs. I can't do the clever tricks! The gitk 
> diffs are nice and colorized, but the "show just end result" trick just 
> doesn't work.

> So I can see two ways to fix this:
>  - bug Paul about alternate diff viewing capabilities in gitk. He's cc'd 
>    here. A way to make the "diff" pane show just the new one, the old one, 
>    or even both side-by-side with some mousy interface?
>  - add some actual switch to git diff generation to hide the negative side 
>    of a unified diff, and add some way to just make gitk pass that switch 
>    in.

The switch itself would literally be a one-liner (see below).

However, I suspect what you want is _not_ "turn the negative
side completely off", but "make the negative side visually more
easily ignorable".

How about displaying the deleted lines with light gray on white
background, or something like that?

> I dunno. I realize that it's not just gitk - gitweb, qgit etc don't allow 
> the tricks *either*, but gitk was the one I just hit this with. I ended up 
> just cutting-and-pasting the SHA1 and doing the thing in a terminal with 
> the shell pipeline instead. Am wondering if maybe other people have ideas 
> on this.

diff --git a/diff.c b/diff.c
index fbb79d7..e61abed 100644
--- a/diff.c
+++ b/diff.c
@@ -565,6 +565,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	if (color != DIFF_FILE_NEW) {
+		if (diff_no_deleted_lines && color == DIFF_FILE_OLD)
+			return;
 		emit_line(diff_get_color(ecbdata->color_diff, color),
 			  reset, line, len);
 		return;
