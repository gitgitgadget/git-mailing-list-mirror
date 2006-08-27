From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] dir: do all size checks before seeking back and fix file closing
Date: Sat, 26 Aug 2006 17:07:37 -0700
Message-ID: <7v4pvz11o6.fsf@assigned-by-dhcp.cox.net>
References: <20060826141709.GC11601@diku.dk>
	<Pine.LNX.4.64.0608261509290.11811@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 02:07:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH8BL-0003tj-S9
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 02:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWH0AHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 20:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWH0AHQ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 20:07:16 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62152 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751276AbWH0AHO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 20:07:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827000714.ULCL554.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 20:07:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id Eo7C1V0064Noztg0000000
	Sat, 26 Aug 2006 20:07:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608261509290.11811@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 26 Aug 2006 15:13:00 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26075>

Linus Torvalds <torvalds@osdl.org> writes:

> I really think you'd be better off rewriting that to use "fstat()" 
> instead. I don't know why it uses two lseek's, but it's wrong, and looks 
> like some bad habit Junio picked up at some point.

I think the code was written to avoid getting confused by
unseekable input (pipes) but was done in early morning before
the first shot of caffeine.

> Now, admittedly it's wrong because another bad habit Junio picked up 
> (doing comparisons with constants in the wrong order)

I think you misunderstand the rationale used to encourage the
comparison used there.  It does not have anything to do with
having comparison on the left.

The comparison order is done in textual order.  You list smaller
things on the left and then larger things on the right (iow, you
almost never use >= or >).

> Junio: I realize that you claim that you learnt that syntax from an 
> authorative source, but he was _wrong_....

This does not come from any authoritative source, but I picked
it up because I felt it made a lot of sense.

> ... Doing the constant first is more likely to cause bugs,
> rather than less.

That's a funny thing to say, because I was about to send out a
comment that touches this exact topic.

I spotted the bug the patch was trying to introduce right away
_because_ the original comparison was written in textual order.

The patch changed the comparison operator which first confused
me for a handful seconds, and then after I swapped everything in
my head to read as

	if (fd <= 0)
        	close(fd);

it became blatantly obvious it was a bogus change.  In the
message I was about to send out, I would have said "a fine
example that using texual order comparison consistently avoids
bugs".  So it is really relative to what you are used to.

Get used to it, please ;-).
