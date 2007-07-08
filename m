From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-branch: default to --track
Date: Sun, 08 Jul 2007 01:59:40 -0700
Message-ID: <7vhcof2rur.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 10:59:56 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ScT-0000jf-DK
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 10:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXGHI7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 04:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbXGHI7m
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 04:59:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:39420 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbXGHI7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 04:59:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708085941.RFIA17683.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Jul 2007 04:59:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lwzg1X0031kojtg0000000; Sun, 08 Jul 2007 04:59:40 -0400
In-Reply-To: <Pine.LNX.4.64.0707062252390.4093@racer.site> (Johannes
	Schindelin's message of "Fri, 6 Jul 2007 22:54:09 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51868>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> "git branch --track" will setup config variables when branching from 
> a remote branch, so that if you say "git pull" while being on that
> branch, it automatically fetches the correct remote, and merges the
> correct branch.

While I think it would have been the right thing to do if the
code did this only for a remote branch, I think there is a bug
somewhere.  I just saw this:

	... some random changes ...
        master$ git commit -a -s -m 'Some work meant for topic.'
        master$ git branch jc/new-topic
	Branch jc/new-topic set up to track local branch refs/heads/master

Eh?  I did not want this to get applied for my local branches.

The intention of the above command sequence was to do a branch
and then "reset --hard HEAD^" to rewind the 'master', as if I
did not commit but instead did "checkout -b jc/new-topic &&
commit && checkout master".

But "checkout -b jc/newtopic" has the same problem, as it
eventually uses the same "git-branch" that defaults to --track
even for a case where I branch off of a local branch.

I do not necessarily think the command line --track is broken.
If the user explicitly says a branch tracks a local branch, so
be it.  If --track comes from autosetupmerge or built-in default
like your patch, however, I do not think it makes much sense to
pollute the config file with useless "tracking" information.

I am very tempted to revert this, but won't do so tonight, yet.
