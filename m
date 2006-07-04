From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Make clear_commit_marks() clean harder
Date: Tue, 04 Jul 2006 01:20:12 -0700
Message-ID: <7vlkr9kchv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
	<7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
	<20060701150926.GA25800@lsrfire.ath.cx>
	<7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
	<44A6CD1D.2000600@lsrfire.ath.cx>
	<Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
	<7vveqhccnk.fsf@assigned-by-dhcp.cox.net>
	<7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
	<20060701232958.GC2513@lsrfire.ath.cx>
	<7vejx3rq33.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607031553570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmfqqxlh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607032309190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0607031552410.12404@g5.osdl.org>
	<Pine.LNX.4.63.0607040951390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 10:20:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxg8o-0000vp-UU
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 10:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWGDIUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 04:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWGDIUO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 04:20:14 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:37026 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750818AbWGDIUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 04:20:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704082012.FTTU27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 04:20:12 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607040951390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 4 Jul 2006 09:53:36 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23271>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If we didn't mark them, then clearing them would be a no-op, so nobody 
>> really cares.
>
> My point being: if we try to clear commits we could not have possibly 
> marked, because they were not yet parsed, this is wrong.

While you say above is correct, object.parsed bit does not give
you enough information to decide if we could not have possibly
marked or not, because it is perfectly valid to mark a commit
that we have not parsed.

As Linus said in this thread already (I am rephrasing):

 - When you have a commit object, which is parsed, you can tell
   who its parents are; more importantly, at that point you have
   access to the commit objects for the parents already, but they
   may not have been parsed.

 - If you can make a decision whether the parents of a commit
   should be marked or not solely by looking at the commit, you
   are allowed to do so before parsing these parents.  The
   commit you look at to make that decision has to be parsed for
   you to know who the parents are, though.

Marking unparsed objects is a valid operation because even
unparsed objects have flags field that is retained when they are
later lazily parsed.

Right now, in the inner loop of the main loop of merge_base()
code, we parse each parent and insert it into the &list, but
instead we could parse commit (if not parsed yet) just before
taking its parents list in the outer loop.  That way we would
parse the parents lazily and will have commits marked but still
not parsed.
