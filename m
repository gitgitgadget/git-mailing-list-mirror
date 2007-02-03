From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing to a non-bare repository
Date: Fri, 02 Feb 2007 19:26:22 -0800
Message-ID: <7vfy9ndiqp.fsf@assigned-by-dhcp.cox.net>
References: <45C3FB08.1020805@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 04:26:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDBXn-0007qh-Ii
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 04:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946304AbXBCD0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 22:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946309AbXBCD0X
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 22:26:23 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:39113 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946304AbXBCD0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 22:26:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203032622.JNOX1349.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Feb 2007 22:26:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JrSM1W00W1kojtg0000000; Fri, 02 Feb 2007 22:26:22 -0500
In-Reply-To: <45C3FB08.1020805@midwinter.com> (Steven Grimm's message of "Fri,
	02 Feb 2007 19:01:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38549>

Steven Grimm <koreth@midwinter.com> writes:

> This keeps coming up as I introduce people to git. In previous
> discussions, the conclusion often seems to be that users don't really
> know what they want the semantics to be.

I do not think that was the conclusion.  My suggestion to you
would be to stop thinking as if push is a converse of pull
(because it is not; push is a counterpart of fetch), and leave
push as is.

In a typical mothership-satellite configuration, I would
recommend a workflow like this:

On Mothership:
	remote.satellite.url: satellite:project.git
        remote.satellite.push: refs/heads/master:remotes/mothership/master

On Satellite:
	remote.mothership.url: mothership:project.git
        remote.mothership.fetch: refs/heads/master:remotes/mothership/master

So when you happen to be on the mothership and you would want to
sync the satellite (because you are tired of working at your
office and would want to continue on your satellite notebook
sitting on the couch, relaxed), you would push:

	mothership$ git push satellite

Then you go to the satellite machine, and merge the mothership in:

	satellite$ git merge mothership

If you forgot to push before leaving the mothership, you do not
have to worry; you can initiate the transfer from the satellite:

	satellite$ git fetch mothership

and then do the same merge:

        satellite$ git merge mothership

Of course you could do "git pull mothership" to do the above two
as a single step, but the point is then the "patch flow" would
always be the same no matter from which side you initiate the
transfer from mothership to satellite.  The changes made on the
mothership will be done on 'master' branch on the mothership and
flow into remote/mothership/master on the satellite.  And you
will merge changes from the mothership to the satellite always
via remotes/mothership/master tracking branch.

To go the other way, you would further define these two:

On Mothership:
        remote.satellite.fetch: refs/heads/master:remotes/satellite/master

On Satellite:
        remote.mothership.push: refs/heads/master:remotes/satellite/master

and "git push mothership" from satellite, or "git fetch
satellite" from the mothership.

Another reason not to do what you described inside git-push is
that you do not need to -- I think you should be able to do all
that from your update (or post-update) hook.
