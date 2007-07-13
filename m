From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sharing between local "work" and "nightly build" git repos
Date: Thu, 12 Jul 2007 17:03:21 -0700
Message-ID: <7vmyy1rwza.fsf@assigned-by-dhcp.cox.net>
References: <7154c5c60707121636l585b42d4l931b08f1468ddfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David Frech" <nimblemachines@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 02:03:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I98dH-0001qJ-6P
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 02:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758696AbXGMADa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 20:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758488AbXGMADa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 20:03:30 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:61130 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437AbXGMADW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 20:03:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070713000322.DSHO1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Jul 2007 20:03:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id No3M1X00Z1kojtg0000000; Thu, 12 Jul 2007 20:03:22 -0400
In-Reply-To: <7154c5c60707121636l585b42d4l931b08f1468ddfc@mail.gmail.com>
	(David Frech's message of "Thu, 12 Jul 2007 16:36:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52347>

"David Frech" <nimblemachines@gmail.com> writes:

> I'd like to share as much as possible between the two repos. My naive
> first attempt was to clone the local repo (~david/git) using -l and -s
> (which I admit I do not completely understand). This sort of worked,
> but one issue is that doing a "git pull" in nightly is going to pull
> from the *locally*-cloned repo, not from the main git. Another is that
> a checkout in nightly failed with the obscure error:
>
> [david@tashtego ~/git-nightly]% git checkout -b nightly-next next
> git checkout: updating paths is incompatible with switching branches/forcing
> Did you intend to checkout 'next' which can not be resolved as commit?
>
> I assume this is because too much state is being shared the repos, and
> something is unfinished in the "git" directory.

You assumed wrong.  "-l and -s" does not have to do anything
with the above symptoms.

git-clone helps people by setting up the new repository to
follow where you cloned from, but there is no rule that you
cannot change it.  Look at .git/config in the nightly repository
and find [remote "origin"] section; update its URL to whichever
repository you would want to track from and you are done.

"git checkout -b nightly-next next" is telling git to:

 - create a new branch nightly-next starting from 'next'
 - check it out

You most likely would want to fork off of "origin/next", not
'next' which probably does not exist in your repository.

If you are willing to redo the nightly repository from scratch,
I would probably recommend using --reference option when
cloning, like this:

 $ git clone --reference ~david/git git://git.kernel.org/... ~/nightly-git
 $ cd ~/nightly-git
 $ git checkout --track -b next origin/next

Then a nightly update would go like this:

 $ cd ~/nightly-git
 $ git pull origin next
 $ make clean
 $ make test || barf
