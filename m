From: Junio C Hamano <junkio@cox.net>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Sun, 16 Oct 2005 15:12:03 -0700
Message-ID: <7vwtkd6rik.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
	<434EABFD.5070604@zytor.com> <434EC07C.30505@pobox.com>
	<Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
	<435264B1.2010204@de.bosch.com>
	<Pine.LNX.4.63.0510161122570.23242@iabervon.org>
	<20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org>
	<7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net>
	<20051016213341.GF5509@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 00:13:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERGk4-0005iy-NA
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 00:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVJPWMH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 18:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVJPWMG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 18:12:06 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38561 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932065AbVJPWMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 18:12:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051016221142.FLHZ29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Oct 2005 18:11:42 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051016213341.GF5509@reactrix.com> (Nick Hengeveld's message of
	"Sun, 16 Oct 2005 14:33:41 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10174>

Nick Hengeveld <nickh@reactrix.com> writes:

> On Sun, Oct 16, 2005 at 09:56:49AM -0700, Junio C Hamano wrote:
>
>> That's what the .idx file is for, except that after you fetch
>> the range, you may find you would need something else that the
>> object is delta against.
>
> Would it make sense to load the pack indexes for each base up front,
> and then fetch individual objects from a pack if they exist in one of
> a base's pack indexes?  In such a case, it may not even make sense to
> try fetching the object directly first.
>
> What are the circumstances under which it makes more sense to fetch the
> whole pack rather than fetching individual objects from it?

It would make sense if we end up needing most them anyway, I
think.

We are probably far from this, but ideally, we should be able to
set up something like this.

We encourage the server side to prepare packs this way [*1*].

 -- development --> time --> flows --> this --> way -->

 (optional)
 full ------------------------------------------------

 base ---------------
 6mo                 ---------------------------------
 3mo                               -------------------
 1mo                                    --------------
 2wk                                        ----------
 1wk                                             -----
                                                      ^
                                 last pack optimization


That is, a big base pack (say v2.6.12), and multiple packs to
bring people that were in-sync at various time up-to-date to the
time when the set of packs were last optimized.  Any objects
created after the last pack optimization time are left unpacked
until the next pack optimization time.  It might not be a bad
idea to also have a "full" pack.

For example, if you were in-sync 5-months ago, fetching 3mo pack
would not be enough and you would need to get 6mo pack to become
up-to-date wrt the last pack optimization (say 3 days ago).  You
would have obtained the objects not in pack, created within the
last 3 days, already as individual objects before realizing that
you would need to fetch some pack.

Then, we can teach git-http-fetch to do:

 - If an object is unavailable unpacked, get all the indices
   from that repository (and probably its alternates while we
   are at it).

 - Among the set of packs that contain the object we are
   currently interested in, try to find the "best" pack.  The
   definition of "best" would be a balancing act of finding the
   one that contains the least number of objects we already
   have, and the one that contains the most number of objects we
   do not have yet.

The commit walker always goes from present to past, so you would
start from fetching the latest, presumably unpacked objects, and
as soon as you hit the last pack optimization boundary, you have
choices of multiple packs.  If you are relatively up-to-date,
you would find that 1mo pack has more things you already have
than 1wk pack, although both of them would fit the bill -- at
that point you choose to download 1wk pack.  On the other hand,
if you are behind, you may find that 3mo pack has more things
you do not have than 1wk or 2wk or 1mo pack, and using 3mo pack
would become the right choice for you.

I think most repositories have a few related heads and their
heads almost never rewind, so favoring the pack that contains
the most number of objects we do not have would be the right
strategy in practice for the downloader.


[Footnote]

*1* This is different from a proposal posted on the list earlier
by somebody (I think it was Pasky but I may be mistaken) which
looked like this:

 -- development --> time --> flows --> this --> way -->

 base ---------------
 6mo                 --------------
 3mo                               -----
 1mo                                    ----
 2wk                                        -----
 1wk                                             -----

The thing is, sum of 3mo+1mo+2wk+1wk packs in the latter scheme
tends to be a lot bigger than the size of 3mo pack in the former
scheme.
