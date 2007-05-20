From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Sun, 20 May 2007 12:10:04 -0700
Message-ID: <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net>
References: <11796842882917-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun May 20 21:10:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpqnH-0000i6-MK
	for gcvg-git@gmane.org; Sun, 20 May 2007 21:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbXETTKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 15:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755407AbXETTKM
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 15:10:12 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33267 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbXETTKK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 15:10:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520191010.BTBD13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 15:10:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1XA91X00H1kojtg0000000; Sun, 20 May 2007 15:10:09 -0400
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl> (skimo@liacs.nl's
	message of "Sun, 20 May 2007 20:04:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47890>

skimo@liacs.nl writes:

> This patch series implements a mechanism for cloning submodules.

Let me start by asking a few stupid questions.

> Each submodule is specified by a 'submodule.<submodule>.url'
> configuration option, e.g.,
>
> bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
> submodule.cloog.url /home/sverdool/public_html/cloog.git
> submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git

You are priming the process by having these configuration
variables in the superproject to be cloned (i.e. this is done by
the owner of the superproject).

> git-checkout will use the first url that works.
> E.g., a
>
> git clone --submodules ssh://liacs/~/public_html/isa.git
>
> followed by
>
> git checkout origin/submodule
>
> (which only works for me), will use the first url, while a
>
> git clone --submodules http://www.liacs.nl/~sverdool/isa.git
>
> followed by
>
> git checkout origin/submodule
>
> will use the second.

What's the design like to make clone and checkout work together?
When you run the first clone with -n ("do not checkout"), what
should happen (I am not asking what your code does, but what the
desired behaviour should be)?  My take on that question is
"subproject cloning is done by checkout, not clone".

> The cloning of submodules is now handled inside git-checkout.

which I guess means your answer is the same as mine, which
is fine.

I am very worried about this big red switch that says "all
subprojects to be cloned and checked out, or nothing".  I think
this would not work well with projects that truly need
superproject support (i.e. very large ones, where most people
would not want to clone and check out every single subproject).

> I currently do not fetch after the initial clone, since
> I'm not sure what ref to use for the revision I need to
> fetch for the supermodule.

I think fetching inside the subproject can be safely done with
the default (i.e. refs/heads/*:refs/remotes/origin/*) of 1.5.0
or later, as long as we tell the users of the feature that they
should make sure that the commit referenced by superproject tree
entries are available with such a fetch, which is a sane thing
to require anyway.

The more important issue I think is at what point in the
superproject operation does a recursive checkout in a subproject
should happen, and how we should do the checkout.  Issues I can
think of offhand are (no way exhaustive):

 - Do we checkout a branch? if so which one?

 - Do we detach HEAD if the commit named by the superproject
   tree is not at the tip of the current branch of subproject?
   do we detach always even if the commit is at the tip?

 - What would we do when the subproject working tree is not
   clean?

 - How can a user decide which subproject to descend into and
   which subproject to ignore, and how does git remember the
   earlier decision made by the user without asking the same
   again, and how does a user express "now I want to also track
   that subproject I've ignored so far" and "now I am not
   interested in following that subproject anymore"?

So I tend to disagree with not having the indirection we
discussed on the other thread about .gitmodules, but I consider
it a minor detail of cloning, and it is not a major deal to me.

However, I agree with Alex that checkout semantics is a much
bigger deal, and would expect people (brighter than myself,
hopefully) to offer ideas.
