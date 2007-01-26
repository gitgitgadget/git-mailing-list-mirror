From: Junio C Hamano <junkio@cox.net>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 00:54:19 -0800
Message-ID: <7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
References: <45B8E61E.C9C5E6C6@eudaptics.com>
	<7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
	<45B9B80E.E2534F97@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 09:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAMqm-0001xY-H1
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 09:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030830AbXAZIyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 03:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030835AbXAZIyV
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 03:54:21 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64921 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030830AbXAZIyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 03:54:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126085420.MQLE29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 03:54:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FktN1W00F1kojtg0000000; Fri, 26 Jan 2007 03:53:23 -0500
In-Reply-To: <45B9B80E.E2534F97@eudaptics.com> (Johannes Sixt's message of
	"Fri, 26 Jan 2007 09:13:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37813>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Oh, the original repo *does* loose the object after step 3, but you
> would not notice it until you remove the grafts file.

That is Ok -- you did want to lose that object B because you
told git you want to pretend A's parent is not B in _your_ local
repository.

>> grafts are local matter for archaeologist's convenience to glue
>> two independent histories together, and not much more.
>
> Agreed. Then grafts must be disregarded by (almost) all plumbing, most
> notably fsck-objects, prune, pack-objects,...

You are not agreeing.

Graft is a local matter, but that does not mean it should
introduce inconsistencies.  It is a way to _locally_ change the
world view, and to give the consistent world view locally, not
only the commands you listed (fsck, prune, pack-objects) but
also log, rev-list and friends all should take grafts into
account, which is why losing B is the right thing to do if you
repack or prune.  In your altered world, B is not part of any
remaining history.

The problem you noticed is a limitation of fetch/clone.
Exposing the locally modified world view to the other end so
that a cloned repository has the exactly the same view by
copying the grafts file would be trivial [*1*].

However, it is rather tricky if you try to extend it to fetching
into an existing repository.  Which may have its own grafts and
define an altered world view in its own way.  And that altered
world view may conflict (e.g. it may already say the parent of A
is not B but not X as in the repository you are cloning from but
some other commit Y).

That's why traditionally we just punt the whole issue by saying
don't exchange objects between repositories that have grafts
without thinking (primarily because we haven't thought things
through -- we are lazy bastards).

One thing you could do is to take the local-ness of grafts more
literally and enforce it more strictly by dropping grafts while
fetch-pack and receive-pack exchange common objects and spawn
pack-objects to come up with objects needed to be sent.  But
because we currently punt, we do not even do that.

If we were to spend the effort to do that temporary dropping of
grafts (which I would expect to be quite ugly code), I suspect
we are better off thinking things through to define the desired
semantics, what should happen when objects are exchanged between
two repositories that have their world views altered with their
grafts.  The end result would most likely update the info/grafts
in your repository when you fetch from a repository with grafts,
and probably update info/grafts at the remote when you push from
a repository with grafts.

[*1*] It does require fetch-pack protocol update, though, so it
is some work.  It is still trivial in the sense that it is clear
what is needed to realize exactly the same the world view -- the
copy should have the exact copy of info/grafts file.
