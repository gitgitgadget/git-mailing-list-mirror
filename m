From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1.5.0.rc1.g4494: Can't use a bare GIT_DIR to add
Date: Fri, 12 Jan 2007 09:56:48 -0800
Message-ID: <7vzm8ot9gf.fsf@assigned-by-dhcp.cox.net>
References: <200701121545.l0CFjMC1017088@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 18:57:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Qe9-0000yl-Mm
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 18:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbXALR4u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 12:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbXALR4u
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 12:56:50 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34181 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbXALR4t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 12:56:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112175648.ZSVN3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 12:56:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AHvx1W0091kojtg0000000; Fri, 12 Jan 2007 12:55:57 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200701121545.l0CFjMC1017088@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Fri, 12 Jan 2007 12:45:22 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36685>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> I tried this:
>   
>   mkdir xyz
>   cd xyz
>   git --git-dir=../xyz.git   
>      # Initialized empty Git repository in ../xyz.git/
>   echo Junk > file-a
>   git --git-dir=../xyz.git add .
>      # fatal: add cannot be used in a bare git directory
>
> I expected that "GIT_DIR is bare, over there, stuff is here" works the same
> as "GIT_DIR is .git, right here among stuff".

Sheesh, why didn't you speak out earlier while the discussion
was on (I am not serious, git mailing list is still moving too
fast for people to be always on top of)?

Now, seriously.

The "bare" topic introduced "is this repository bare?" check,
which can say only "yes" or "no" for any given GIT_DIR.  A
heuristic is there but can be overriden with "core.bare"
configuration.  We allow certain things we usually do not allow
in a repository without working tree (e.g. updating the branch
pointed at with HEAD via "git-fetch"), and we forbid things that
require a working tree in a bare repository (e.g. "git-checkout").

This "your bare repository is my repository with worktree
elsewhere" was not something we considered during the "bare"
discussion.  If we wanted to allow that, the check needs to say
"yes", "no", or "depends", and we need to allow both kinds of
operations in a repository marked as the third kind.

You said "I tried".  Is this something you do in real life?
This _is_ a regression, as we are checking something we did not
check before and refusing to work in cases where we did.  But I
am not sure if reverting to lift the safety (for that matter,
introducing the third "depends" alternative) is better than the
latest behaviour.

For one thing, you could (sometime before the "git add ." and do
this only once) do:

	$ ln -s ../xyz.git .git

and that would make all the future git operation work without
the --git-dir parameter (or GIT_DIR environment) in xyz
directory.  An added benefit is that it would even allow git
command to work from a subdirectory of xyz (specifying GIT_DIR
or --git-dir means you are bypassing the discovery for the top
of the working tree, so you have to always be at the top).

Hmmmm.
