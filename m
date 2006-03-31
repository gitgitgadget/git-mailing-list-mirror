From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Thu, 30 Mar 2006 22:45:55 -0800
Message-ID: <7v3bgzxgbg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603302153350.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 31 08:46:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPDOT-0006uR-DU
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 08:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWCaGp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 01:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWCaGp7
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 01:45:59 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62369 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751133AbWCaGp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 01:45:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060331064557.QUSO3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 31 Mar 2006 01:45:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603302153350.27203@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 30 Mar 2006 22:05:26 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18220>

Linus Torvalds <torvalds@osdl.org> writes:

> Sadly, it seems to react really badly to Junio's new --boundary logic for 
> some reason that I haven't quite figured out yet.

There already was a report that --boundary stuff is not quite
right, so what you are seeing might be that the new code exposes
its original breakage even more.  I haven't looked into the
breakage of the original version yet either, so I cannot really
say how your change breaks it.

> That reaction is independent of the actual pathname restriction, and seems 
> to be related to how the --boundary logic expected 
> pop_most_recent_commit() to work. In particular:
>
> 	...
>                         if (commit->object.flags & BOUNDARY) {
>                                 /* this is already uninteresting,
>                                  * so there is no point popping its
>                                  * parents into the list.
>                                  */
>
> that code is magic, and seems to depend on something subtle going on with 
> the list, and the incremental thing already popped the parent earlier and 
> screwed up whatever magic that the BOUNDARY code depends on.

This was not so magic, but the magic was actually in the code
added to limit_list().  Usually, "newlist" consists interesting
commits, and what are found interesting initially but marked as
uninteresting when a different ancestry chain coming from an
uninteresting head leading to it was later discovered.  The
magic code looks at still-interesting commits, and re-injects
its parents that are uninteresting to the list (and I just
spotted a bug there -- it does not check if what is being "re-"
injected are already on the list -- should I check for SEEN flag
there perhaps?), while marking them as boundary.  This was done
to make sure that all the open-circle (in gitk) commits are on
the resulting list.

The part of the code you quoted is just a short-cut for not
doing pop_most_recent_commit() -- we used to have
pop_most_recent_commit() there, which pushed the parents of the
commit being processed into the list.  Because we are processing
a boundary commit, we know it is uninteresting -- and by
definition, its parents are uninteresting and that is why it
just advances the list without calling pop_most_recent_commit(),
bypassing its side effect to push its parents into the list.

Since the new code has already advanced the list immediately
after the beginning of do {} block, I think you can remove the
entire "if (revs->max_count) {}" block.  As the code currently
stands, you are skipping what happens to be next to the boundary
commit on the result list.

> Junio? I think you did some funky special case with BOUNDARY commits, and 
> I broke it for you, can you look at the patch and see if you can see it? 
> I'd really like to have the incremental path-limiter, because it really 
> makes a huge difference in the usability of "git log pathname".

Oh, there is no question about making it streamable in more
cases is a good thing.
