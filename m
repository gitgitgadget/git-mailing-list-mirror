From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Pickaxe fixes.
Date: Sat, 28 May 2005 09:16:56 -0700
Message-ID: <7vpsvbuxzb.fsf@assigned-by-dhcp.cox.net>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
	<7v7jhjy8uw.fsf@assigned-by-dhcp.cox.net>
	<20050528105914.GA8467@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 18:17:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dc3yG-0000DG-4e
	for gcvg-git@gmane.org; Sat, 28 May 2005 18:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVE1QRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 12:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVE1QRF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 12:17:05 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3532 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261159AbVE1QQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 12:16:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528161657.YVGP550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 12:16:57 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050528105914.GA8467@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Sat, 28 May 2005 12:59:14 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> Btw. When doing the.  'git-whatchanged drivers/ide' thing
TG> ... does that show only deltas which happened actually in
TG> this tree or if a changeset contains deltas inside and
TG> outside?

That's up to Linus right now.  The behaviour is different
before and after the 12-part patch I sent out yesterday [*1*].

My earlier thinking was to use the pathspec (e.g. drivers/ide)
as the output filter, but Linus corrected me yesterday morning
that he wants the pathspec as the input filter.  What this means
to your question is:

 - Under my earlier thinking, if drivers/ide/foo is a rename
   from drivers/usb/bar, diffcore gets both creation of foo and
   deletion of bar, diffcore-rename matches them up, and
   diffcore-pathspec filters the output to drivers/ide tree.
   Earlier pathspec picked up filepair that had the specified
   path on either src or dst side, so this would have been shown
   as a rename from usb/bar to ide/foo.

 - After the 12-part patch, the pathspec comes first and
   establishes a narrowed down world we operate in.  So in the
   same situation, diffcore is fed only creation of foo but does
   not see deletion of bar (which happened in drivers/usb, which
   is outside our world).  Hence diffcore-rename does not have
   anything to match up and this would be shown as a creation of
   ide/foo.

I agree with Linus that the latter is the semantics we usually
want.  If we make diffcore filters stackable (I mean, the order
of applications controllable by the program and the user), we
could also have the older semantics when the user wants it, but
I would do that after this series stabilizes.


[Footnote]

*1* When I talk about time of the day, it is in US Pacific
timezone.



