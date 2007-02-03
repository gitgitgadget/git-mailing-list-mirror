From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Fri, 02 Feb 2007 19:00:29 -0800
Message-ID: <7vmz3wdjxu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070201234706.GP17617@mellanox.co.il>
	<Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz3xmju9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702021146440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 03 04:00:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDB8o-000554-JU
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 04:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946246AbXBCDAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 22:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946244AbXBCDAb
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 22:00:31 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:62995 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946265AbXBCDAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 22:00:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203030029.GNTZ1302.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Feb 2007 22:00:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jr0U1W00N1kojtg0000000; Fri, 02 Feb 2007 22:00:29 -0500
In-Reply-To: <Pine.LNX.4.63.0702021146440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 2 Feb 2007 11:48:10 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38545>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 1 Feb 2007, Junio C Hamano wrote:
> ...
>> I am not against the general idea of tracking a subset of
>> branches, but issues include:
>>
>> [explains why git-remote is a better place for this]
>
> Seeing your patch to git-remote, it feels more natural, too. Especially 
> since that (or which? :-D) does not give the term "clone" a 
> Microsoft'esque completely new meaning.

I did not find anything MS'esque in what MST did in his patch,
though.  I think it is a reasonable thing to ask for from a
clone.  For example, if you are coming from CVS or have used
Cogito, cloning a single branch is not an unusual operation at
all.

The real point of my 'remote add -f -t -m' patch is that I think
we are much better off to do it in a bottom up way, by having a
tool that can be used in any repository first.  Then we could
even rewrite 'git clone' along these lines:

	#/bin/sh
	track="*" ;# command line parameter to override...
	... decide what $name to use ...
	mkdir "$name"
	cd "$name"
	git init-db
        git remote add -f -t "$track" origin $url
	git branch -f master remotes/origin/master

Of course you would need to deal with -n, --bare and stuff, but
that is a minor detail.

While I am talking about post 1.5.0 git-clone changes, one thing
I've always hated about git-clone is that the cloner always has
to guess where the HEAD pointer at the other side points at.
This comes from a shortcoming in the fetch-pack protocol (it
simply does not tell).  A stupid consequence of this is that
cloning over dumb protocols also have to guess, although they
are _capable_ of letting the cloner know this information.

I think the logic to decide where to point remotes/$origin/HEAD
to should be moved to "git-remote add -m" when we eventually
rewrite "git-clone" to use "git-remote add -f".  And while we
would do so, we can make a trivial extension to fetch-pack
protocol to carry the HEAD symref information.  All will be
good once that happens.
