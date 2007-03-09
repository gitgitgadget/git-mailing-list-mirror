From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in bundle
Date: Fri, 09 Mar 2007 15:37:12 -0800
Message-ID: <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
	<45F17EF0.5060008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 00:37:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPoeL-0008Cj-L9
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 00:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767658AbXCIXhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767654AbXCIXhP
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 18:37:15 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50893 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767658AbXCIXhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 18:37:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070309233713.GMSK3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 18:37:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YndC1W00U1kojtg0000000; Fri, 09 Mar 2007 18:37:13 -0500
In-Reply-To: <45F17EF0.5060008@gmail.com> (Mark Levedahl's message of "Fri, 09
	Mar 2007 10:36:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41822>

Mark Levedahl <mlevedahl@gmail.com> writes:

> git>git bundle create t.bdl master --not master
> Generating pack...
> Done counting 0 objects.
> Writing 0 objects.
> Total 0 (delta 0), reused 0 (delta 0)
> git>git ls-remote t.bdl
> git>
>
> e.g, an empty bundle is created without any error or warning. This is
> the one case I believe an error should result: there is no use to
> sending (or even creating) an empty bundle.

I agree that erroring on an empty output is a sensible _option_
just like pack-objects has --no-empty option.

The above is actually an interesting example in a different
sense.  When somebody did the following, what should be output?

	$ edit; git commit -a ;# on master
        $ git checkout -b side
        $ edit; git commit -a ;# on side
        $ git bundle create foo.bdl master side ^master
	$ git bundle verify foo.bdl

My answer is that it should list master and side as the
available heads and master itself as also a prerequisite (which
is not what the current code does).  

I think unbundling foo.bdl should be the moral equivalent of
fetching from the originating repository by somebody who has its
prerequisites as tips of some branches.  So I think foo.bdl
should list refs/heads/master as one of the available heads to
fetch/pull from, while requiring the same commit as prerequisite
of the bundle.  It is as if you tried "git fetch" and found out
that you are up to date.  Listing where the 'master' tip is,
even though you did not have to include any commits from that
branch, gives you a useful bit of information ("I am up to date
with respect to that branch").

So I think if you did this instead in the above sequence: 

	$ git bundle create foo.bdl master ^master

it would be sensible to have an option to error out because of
empty pack, but at the same time it would equally be sensible to
have an option to still create a bundle with an empty pack
contents.  In either case, the head and prerequisite section
should include the tip of the master.  Earlier, I said we should
error out if we do not find 'master' in the list of shown
objects, but I think it is more sensible to add it to both the
list of head _and_ prerequisites.
