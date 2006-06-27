From: Junio C Hamano <junkio@cox.net>
Subject: Re: CFT: merge-recursive in C
Date: Mon, 26 Jun 2006 17:25:46 -0700
Message-ID: <7v4py7h2b9.fsf@assigned-by-dhcp.cox.net>
References: <20060626233838.GA3121@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 02:25:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv1Or-0004Ym-I7
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 02:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWF0AZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 20:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWF0AZu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 20:25:50 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45786 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030253AbWF0AZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 20:25:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627002548.JVBU554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 20:25:48 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060626233838.GA3121@steel.home> (Alex Riesen's message of
	"Tue, 27 Jun 2006 01:38:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22702>

fork0@t-online.de (Alex Riesen) writes:

> To my deep disappointment, it didn't work out as good as I hoped: one
> program I see most often and for longest time in the process list
> (git-diff-tree) is a too complex thing to be put directly into
> merge-recursive.c, so any help in this direction will be greatly
> appreciated.

Actually, diff-tree is (and to similar degree the internal diff
machinery is) quite reusable as library piece, far more reusable
than other parts of the core git.  If you present what you want
to achieve nicely and ask politely I might even get conned into
helping you interface with the rest of your code ;-).

I am guessing that you want to find out how to do the diff-tree -M
used by the recursive merge without spitting out patch text nor
raw output.  That's quite doable and should be easy.  Most
likely you would use NO_OUTPUT option when you call diff_tree().

First look at builtin-diff.c::builtin_diff_tree() to see how you
can call the diff machinery given two tree object names.  diff_tree()
itself does not emit the diff, but leaves the result in "diff
queue".

After calling diff_tree(), inspect diff_queued_diff() and use
the result to do whatever sensible.  The queue is an array of
diff_filepair that records the (path, sha1, mode) among other
things from old tree and from new tree (the one from the old
tree is called "one", and the new tree is called "two").

So if you have one->path = "old-name.c" and two->path = "new-name.c"
then you see the old-name.c file was renamed to new-name.c

When you are done, do not forget to call diff_flush() to get rid
of queued_diff(); otherwise you would leak.

Have fun.
