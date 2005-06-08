From: Junio C Hamano <junkio@cox.net>
Subject: 3-way read-tree case matrix.
Date: Tue, 07 Jun 2005 20:53:07 -0700
Message-ID: <7vzmu1ec7w.fsf_-_@assigned-by-dhcp.cox.net>
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
X-From: git-owner@vger.kernel.org Wed Jun 08 05:50:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfrZP-0005fd-Mo
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 05:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVFHDxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 23:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVFHDxX
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 23:53:23 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64421 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262091AbVFHDxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2005 23:53:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050608035307.MZOF8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Jun 2005 23:53:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506070808180.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 7 Jun 2005 08:15:59 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I did. It looks fine, although I'd like to point out that even the
LT> three-way merge _does_ mix in the original state for the case where the
LT> merge was trivially resolved...

Thanks.  I have another request for sanity checking.

I am not sure if salvaging a dirty tree in a 3-way merge (as
opposed to just downright refusing) would have as much practical
value as the 2-tree fast-forward case, but here is a proposed
case matrix for the 3-way merge.

"git-diff-tree -m O H M"

    O       H       M         result      index requirements
------------------------------------------------------------------
  1 missing missing missing   -           must not exist.
 -----------------------------------------------------------------
  2 missing missing exists    take M      must match M if exists.
 -----------------------------------------------------------------
  3 missing exists  missing   remove      must match H and be
					  up-to-date, if exists.
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
					  up-to-date, if exists.
 -----------------------------------------------------------------
 11 exists  O!=H    O==M      take H      must match H, if exists.
 -----------------------------------------------------------------
 12 exists  O==H    O!=M      take M      if exists, must either (1)
    					  match H and be up-to-date,
                                          or (2) match M.
 -----------------------------------------------------------------
 13 exists  O==H    O==M      take M      must match H if exists.
------------------------------------------------------------------

In all "take H" or "take M" cases, if the original index matches
what is taken, I would reuse it, and keep it dirty if it is.

The goal is, "(1) do not clobber the current index; (2) arrive
at the same result as in the case started with an empty index;
(3) favor success over failure as long as (1) and (2) are
satisfied".

