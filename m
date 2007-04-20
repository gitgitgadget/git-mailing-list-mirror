From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-log "fatal: bad revision ''"
Date: Fri, 20 Apr 2007 16:47:07 -0700
Message-ID: <7vwt06wqv8.fsf@assigned-by-dhcp.cox.net>
References: <1Hergt-0EBwVE0@fwd29.aul.t-online.de>
	<20070420135816.GO4489@pasky.or.cz>
	<Pine.LNX.4.64.0704201900430.4275@castor.milkiway.cos>
	<alpine.LFD.0.98.0704201554550.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 21 01:47:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf2os-0008JD-4r
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 01:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbXDTXrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 19:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbXDTXrK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 19:47:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41939 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbXDTXrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 19:47:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420234707.NOQN1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 19:47:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pbn71W00E1kojtg0000000; Fri, 20 Apr 2007 19:47:08 -0400
In-Reply-To: <alpine.LFD.0.98.0704201554550.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 20 Apr 2007 16:25:50 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45138>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 20 Apr 2007, Michael Dressel wrote:
>> 
>> Thanx for the reply. Is there a way to follow renaming at all, either 
>> with cogito or git?
>
> "git blame" will follow renames, but doesn't really show things as a log, 
> more just as a "these commits mattered" thing.
>
> You can use something like this patch to then make it *look* like a "log" 
> function.
>
> Junio - I really think that something along these lines is worth doing, 
> but I wonder what the right semantics are. This patch is stupid, and just 
> keeps the "blame" semantics, just showing it in a "log format". It does 
> mean that when I do
>
> 	git blame -C --log block/ll_rw_block.c
>
> it will show entries for the old drivers/block/ll_rw_blk.c location.
>
> HOWEVER, it's still broken, because when you do logging, you don't 
> actually care about the diffs at all, so *any* difference from the 
> previous version should show up, even if the lines don't show up in the 
> end result. So this doesn't really do what people actually *want* to do, 
> it does somethign much more complicated ;)
>
> 		Linus

Yeah, I've been thinking about it but in the back of my head.

I think by hooking in found_guilty_entry(), you show the same
commit more than once when the commit is attributed to more than
one region.  This can probably be solved by remembering if the
current suspect commit matched, and show the log once if so.

And while you are remembering if the current <commit,file> pair
has some chunks attributed to it in that caller loop, I _think_
you would also want to remember which lines in the suspect
(i.e. <commit,file> pair) were blamed, and to which file in
which child commit (i.e. previous suspect).  Then after the
caller loop finds out that there are some lines that are
attributed to the current suspect, you can show the log, and
diff between the suspects' blobs, limited to the line ranges
that mattered. 

Currently that information is not recorded in blame_entry.  It
only has s_lno which indexes into the final image; the necessary
information is found in "struct patch", but after it is used to
split the blame entries and assign blame to the current suspect,
it is discarded.  For the purpose of this application you need
to record that as well.

While I do not think it is a rocket surgery, the change needed
to do this is not entirely trivial.
