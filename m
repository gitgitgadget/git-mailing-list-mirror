From: Junio C Hamano <junkio@cox.net>
Subject: Re: 3-way read-tree case matrix.
Date: Tue, 07 Jun 2005 22:32:48 -0700
Message-ID: <7v7jh5ct1b.fsf@assigned-by-dhcp.cox.net>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org>
	<7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
	<20050606054356.GB3669@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org>
	<20050606064456.GC3669@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0506052351470.1876@ppc970.osdl.org>
	<7vekbgufra.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506060730510.1876@ppc970.osdl.org>
	<7vy89ns354.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506061312520.1876@ppc970.osdl.org>
	<Pine.LNX.4.58.0506061403170.1876@ppc970.osdl.org>
	<7vekbfnot9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506061453400.1876@ppc970.osdl.org>
	<7vy89mlmsv.fsf_-_@assigned-by-dhcp.cox.net>
	<7vis0qk2jo.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506070808180.2286@ppc970.osdl.o
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 07:29:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dft7k-0004fm-UK
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 07:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVFHFdA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 01:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVFHFdA
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 01:33:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43745 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262108AbVFHFcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 01:32:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050608053248.JHHN22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Jun 2005 01:32:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vzmu1ec7w.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 07 Jun 2005 20:53:07 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I suspect my mailer dropped your response on the floor when it
polled my ISP at around 21:27 my time.  I found its log
mentioning your address but no message in my mailbox.

Since the last message I sent you, I updated read-tree.c to
match the proposed behaviour, and I found a couple of problems
with it by running the 3-way merge test we already have.  I am
attaching a revised one.  I have not finished a new test suite
that runs on a populated index file yet, which is what I plan to
do next.

There is one thing that the proposed table changes from the
traditional 3-way merge semantics.  I think this is a sensible
change.

 - #2 and #3 (I botched #3 in the earlier one I sent you);
   traditionally we left <O,H,M>=<none,none,exists> and
   <O,H,M>=<none,exists,none> cases to the script policy; we
   could salvage a (potentially dirty) cache entry if we say we
   pick the one created in only one branch.

Earlier I botched <O,H,M>=<some,H!=O,M!=O> case in the table; we
should collapse to H/M if H==M; this is now handled differently
from H!=O,M!=O,H!=M case (case #10) as case #11 in the updated
table.

------------

"git-diff-tree -m O H M"

    O       H       M         result      index requirements
------------------------------------------------------------------
  1 missing missing missing   -           must not exist.
 -----------------------------------------------------------------
  2 missing missing exists    take M      must match M, if exists.
 -----------------------------------------------------------------
  3 missing exists  missing   take H      must match H, if exists.
 -----------------------------------------------------------------
  4 missing exists  exists    no merge    must match H and be
					  up-to-date, if exists.
 -----------------------------------------------------------------
  5 exists  missing missing   no merge    must not exist.
 -----------------------------------------------------------------
  6 exists  missing O==M      remove      must not exist.
 -----------------------------------------------------------------
  7 exists  missing O!=M      no merge    must not exist.
 -----------------------------------------------------------------
  8 exists  O==H    missing   remove      must match H and be
					  up-to-date, if exists.
 -----------------------------------------------------------------
  9 exists  O!=H    missing   no merge    must match H and be
					  up-to-date, if exists.
 -----------------------------------------------------------------
 10 exists  O!=H    O!=M      no merge    must match H and be
		    M!=H		  up-to-date, if exists.
 -----------------------------------------------------------------
 11 exists  O!=H    O!=M      take H	  must match H, if exists.
		    M==H
 -----------------------------------------------------------------
 12 exists  O!=H    O==M      take H      must match H, if exists.
 -----------------------------------------------------------------
 13 exists  O==H    O!=M      take M      if exists, must either (1)
    					  match H and be up-to-date,
                                          or (2) match M.
 -----------------------------------------------------------------
 14 exists  O==H    O==M      take M      must match H if exists.
------------------------------------------------------------------

In all "take H" or "take M" cases, if the original index matches
what is taken, I would reuse it, and keep it dirty if it is.

The goal is, "(a) do not clobber the current index; (b) arrive
at the same result as in the case started with an empty index;
(c) favor success over failure as long as (a) and (b) are
satisfied."

