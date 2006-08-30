From: Junio C Hamano <junkio@cox.net>
Subject: Re: Mozilla .git tree
Date: Wed, 30 Aug 2006 04:42:05 -0700
Message-ID: <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
References: <20060829165811.GB21729@spearce.org>
	<9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
	<20060829175819.GE21729@spearce.org>
	<9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
	<20060829190548.GK21729@spearce.org>
	<9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	<20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 30 13:41:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIORd-0004ec-FG
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 13:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWH3LlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 07:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWH3LlM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 07:41:12 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18574 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750775AbWH3LlL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 07:41:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060830114111.MRFP18458.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Wed, 30 Aug 2006 07:41:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GBhB1V0091kojtg0000000
	Wed, 30 Aug 2006 07:41:11 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608300124550.9796@xanadu.home> (Nicolas Pitre's
	message of "Wed, 30 Aug 2006 01:53:48 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26226>

Nicolas Pitre <nico@cam.org> writes:

> And the zlib header contains a CRC which we're about to use for 
> validating the data when doing delta data reuse in order to prevent pack 
> corruption propagation like the one recently posted on the list.  

Ah, never thought of using the CRC directly.  I was thinking
about inflating into void and see if it succeeds, which as you
say is perhaps quite expensive.

This brings me back to my pet-peeve, though.  I do not think
zlib stream seeks back and leaves some clue at the beginning to
tell me the deflated length, so it is quite hard to find where
each deflated stream ends in a packfile cheaply.  Loose objects
(with new or legacy style header) are easy (st.st_size is
available), but I do not think of a way short of building a
reverse index of pack .idx file, which means I am already
talking about not so cheap way X-<.

It might be a reason to define a new .idx format.  We could lift
32-bit offset limitation while we are at it.  Each entry could
have 20-byte hash, 64-bit offset into the corresponding .pack,
and 32-bit deflated length (heh, why not make it 64-bit while we
are at it).  Luckily, .idx _is_ a local matter so we can even
have a flag day and tell people to run the updated index-pack on
existing packfiles to regenerate .idx.

> Using an offset instead of a sha1 to reference a delta base object is 
> certainly a good idea though.  But I'd use the same variable encoding as 
> the object size to avoid the 32-bit limit issue.  When generating a thin 
> pack the real sha1 of the delta object could be substituted for the 
> offset quite easily if the base object is not sent a part of the same 
> pack.

That sounds quite a reasonable suggestion.  I love this kind of
moment when I find us very fortunate to have bright people on
the list ;-).
