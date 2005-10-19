From: Junio C Hamano <junkio@cox.net>
Subject: Re: [CORRECTED PATCH] git-fetch-pack: avoid unnecessary zero packing
Date: Tue, 18 Oct 2005 17:27:53 -0700
Message-ID: <7v7jcal59y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510181049050.17201@g5.osdl.org>
	<7vmzl6r78e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510181333380.3369@g5.osdl.org>
	<Pine.LNX.4.64.0510181339220.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 02:28:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES1oF-0002MB-TL
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 02:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVJSA14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 20:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVJSA14
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 20:27:56 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:48895 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932314AbVJSA1z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 20:27:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019002731.VIGV29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 20:27:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510181339220.3369@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Oct 2005 13:42:36 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10244>

Linus Torvalds <torvalds@osdl.org> writes:

> I see you already did. Looks fine. I'd suggest limiting the commits by 
> number in mark_recent_commit_complete(), because
>
>  (a) somebody might have their clock set wrong and you don't want to walk 
>      a huge tree just because of something like that.
>  (b) you might just have imported a huge history (badly) from somewhere 
>      else
>  (c) a _lot_ can happen in five days with automated things.
>
> but yes, the approach looks very sane otherwise.

When you have several dozen commits on top of a head you fetched
from the remote last time you polled them, and the remote has
not updated that head since then, it may be worthwhile to have
the client dig deeper to avoid asking the server.

What I am thinking is:

    - For objects our refs directly refer to, mark them COMPLETE
      as the patch I sent out.

    - See if we have any objects the remote refs refer to
      already; find the timestamp of the latest one if we have
      commits among them, and use its time as the cutoff time.

      It is likely that we have synched with them after that
      timestamp (either upload or download).  walk the commits
      from our ref, and mark *everything* that are newer than
      that timestamp.  This can turn out to be a huge walking
      but that happens on the client side.

This way I can get rid of the arbitrary 5-day window, and I do
not have to invent another arbitrary number to limit the commits
we walk.

In other words, let's put the burden on the client if its effort
possibly can help the server.
