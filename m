From: Junio C Hamano <junkio@cox.net>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 02:15:33 -0800
Message-ID: <7vmz46ytyy.fsf@assigned-by-dhcp.cox.net>
References: <45B8E61E.C9C5E6C6@eudaptics.com>
	<7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
	<45B9B80E.E2534F97@eudaptics.com>
	<7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
	<45B9C836.728F31EC@eudaptics.com>
	<7vzm86yw0q.fsf@assigned-by-dhcp.cox.net>
	<45B9CE56.D16DFC81@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 11:15:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAO7O-0005KB-4J
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 11:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbXAZKPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 05:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbXAZKPf
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 05:15:35 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36226 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161022AbXAZKPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 05:15:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126101534.YSBN19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 05:15:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FmEc1W00B1kojtg0000000; Fri, 26 Jan 2007 05:14:36 -0500
In-Reply-To: <45B9CE56.D16DFC81@eudaptics.com> (Johannes Sixt's message of
	"Fri, 26 Jan 2007 10:48:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37831>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Sure, if I connect my linux repo with a graft to the historical BK tree,
> then toss the ref that pointed to the historical tree, then git prune:
> - then currently it won't prune the historical tree
> - but under my proposal it would. Silly me. Why did I remove that ref?

If your version of git worked the way you describe, the only
reason you removed that ref would be to make sure that your
altered view would be destroyed (you won't be able to do "git
log" across that graft boundary anymore).  Indeed that would be
a silly thing to do.

Thankfully, the real git does not behave that way.  That is why
fsck/prune _must_ honor grafts.  That makes the locally altered
view consistent.  To the altered world view, what are stored in
the object database do not change, but your view of how they are
connected does.  And if your altered view thinks commit
v2.6.12-rc2 has one of the commits in the bkcvs history as its
parent, you do not want to lose that history merely because you
lost a ref to it -- as long as the commit tagged as v2.6.12-rc2
is reachable, its (imaginary) parent should be as well.

If you want to switch out of an altered universe, you may need
to do more than just remove grafts (objects that were hidden by
grafts were immaterial in the altered universe, but now you may
need to get them back, as in your fixed-up imported repository
example, and objects that existed only because grafts pulled
them in are now made unreachable and become prunable), but that
goes without saying.

If you want to make it easier to switch back and forth between
altered reality and the real world, fsck/prune/repack may need
to be taught to consider both real and grafted parents to be
connected, so that you do not have to lose objects that will
become necessary when you come out of the altered world, but I
am not sure if it is worth it.  If you prune while in the real
world the "both real and grafted" safety would obviously not
kick in when you run prune, so when you reinstall the grafts,
some of the necessary objects would be already gone.
