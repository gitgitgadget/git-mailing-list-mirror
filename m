From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] entry.c: checkout available submodules
Date: Fri, 25 May 2007 16:06:19 -0700
Message-ID: <7vfy5kpkpg.fsf@assigned-by-dhcp.cox.net>
References: <1180127233729-git-send-email-skimo@liacs.nl>
	<1180127233893-git-send-email-skimo@liacs.nl>
	<20070525213103.GA8361@admingilde.org>
	<20070525214205.GJ942MdfPADPa@greensroom.kotnet.org>
	<20070525221913.GB8361@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sat May 26 01:06:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrird-0003yb-D7
	for gcvg-git@gmane.org; Sat, 26 May 2007 01:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbXEYXGW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 19:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbXEYXGW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 19:06:22 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:37321 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbXEYXGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 19:06:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525230621.JCAD12190.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 May 2007 19:06:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3b6L1X0091kojtg0000000; Fri, 25 May 2007 19:06:20 -0400
In-Reply-To: <20070525221913.GB8361@admingilde.org> (Martin Waitz's message of
	"Sat, 26 May 2007 00:19:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48431>

Martin Waitz <tali@admingilde.org> writes:

> But we can also leave those details for later when we are clear about
> the complete semantics.  At the moment it is important to reach a
> common base everybody agrees on and which is enough to experiment with
> all the high level tools.

Overall I am reasonably happy with the direction these "smaller"
patches take us, although I suspect the semantics implemented by
this series _might_ need to be scrapped when we start talking
about switching between branches that has and does not have a
subproject at that path, and other corner cases we do not forsee
right now.

I think we are Ok, as long as we make it is clear that we
currently do not support switching from a commit that has a
submodule at one path to another commit that does not (in which
case with a naive implementation we would end up having to nuke
the submodule, and we need to have a way to save it, which we
discussed yesterday, with .git/subproject/$name.git/ being the
stashed away mirror to either quick-clone from, or symlink to).
And more importantly, we would need to make it crystal clear
that the superproject support by the Porcelain layer is still
experimental and is subject to change in potentially backward
incompatible way.  We haven't had enough experience to decide
the best semantics from day one, and experience cannot be gained
without playing with something small like this series anyway.

We may come up with a much superior design after gaining the
experience, and if that is incompatible with the layout this
series assumes, so be it.  We'd have a big feature release that
changes the semantics and that will incur some transition pain,
but overall we would be better off with the final result.

A clear separation of the superproject and the projects it uses
as its submodules helps us here.  At the worst case, migrating
to the updated layout in the future would involve moving .git
directories around in the checked out tree and perhaps making
symlinks and/or setting up various .git/config files by hand to
imitate what the final toolset would have done for the user,
which should be manageable.
