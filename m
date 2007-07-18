From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Wed, 18 Jul 2007 12:17:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181205260.14781@racer.site>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707141140510.14781@racer.site>
 <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707160054340.14781@racer.site> <20070716200404.GT999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed Jul 18 13:17:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB7XU-0005nK-Rt
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 13:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916AbXGRLR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 07:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756401AbXGRLR2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 07:17:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:37492 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752088AbXGRLR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 07:17:27 -0400
Received: (qmail invoked by alias); 18 Jul 2007 11:17:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 18 Jul 2007 13:17:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+blGlZ3QmbFGzd0tcivvFleDfKtT8FSb/2DR7Nhl
	m7ZXoq33zRBTxa
X-X-Sender: gene099@racer.site
In-Reply-To: <20070716200404.GT999MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52852>

Hi,

On Mon, 16 Jul 2007, Sven Verdoolaege wrote:

> On Mon, Jul 16, 2007 at 01:38:11AM +0100, Johannes Schindelin wrote:
> > Didn't I mention that it was a severe limitation to think of the sha1 
> > mapping of a 1-to-1 mapping?  Think of it more as a relation.
> 
> The mapping is used in several operations.
> First, there are several things that can happen to a commit
> 
> - it's pruned.  This includes, for me, path pruning, matching
>   and a commit filter returning no SHA1s.

Okay.

> - it's rewritten to another commit that can be considered the
>   "moral equivalent" of that commit.  This occurs when a commit
>   is not pruned, but something else happened to the commit itself or
>   one of its ancestors.  This excludes, for me, the case
>   where a commit filter returns more than one SHA1.

Okay.  For me it does not at all exclude that.  If I want to replace a 
commit by no commit, I write a commit-filter which does not return 
anything.  If I return more than one SHA1s, I damned well want all of 
those be the replacement "commit".

To say "the" replacement "commit", means to mistake the mapping as a 
function, a non-relation.

> - it's replaced by more than one SHA1.  This can only happen
>   in a commit filter.

For the moment, yes.

> There are at least four operations in which this mapping is used:
> 
> - if the parents of a commit have been rewritten to one or more
>   commits, then they are replaced by the new commits.

Yes, that is the primary use for the mapping.

>   If any parent has been pruned, then it is replaced by
>   the result of applying this operation on _its_ parents.

Why?  This is overy complicated.  If a commit has been pruned, why does 
the mapping not point to the _non-pruned_ parent? IOW if you have 
something like this:

	A - B - C - D - E - F

and all commits except A and F are pruned, the mapping for A, B, C, D and 
E should _all_ point to the (possibly rewritten) A.

> - any reference (in refs/) that points to a rewritten or pruned
>   commit is removed and
>     * if the commit was rewritten to a single commit, then it is
>       replaced by this commit
>     * otherwise, there is no moral equivalent single commit, but
>       we want to ensure we can still access the new commits, so
>       I create several references, either to each of the many
>       commits the old commit was rewritten to, or to each of
>       its nearest unpruned ancestors (i.e., the same set as
>       described in the previous operation).

I'd argue that it should be an error if a to-be-rewritten ref (and I still 
strongly disagree with you that all refs should be rewritten) would point 
to multiple commits.  Possibly overridable with "--allow-octopus-refs".  
But the default should be to error out.

> - a SHA1 of a commit that appears in a commit message is replaced
>   by the rewritten commit iff it was rewritten to a single commit.
>   That is, if the commit was pruned or rewritten (through a commit
>   filter to more than one commit), then the SHA1 is left alone.

Both this behaviour and the one you described in your reply are wrong.

> - the mapping available to filters
>     * if the commit was pruned, an empty file is created
>     * otherwise a file is created containing all rewritten SHA1s

As I stated above: it is utterly wrong to create an empty mapping for a 
commit that was pruned.  It does not take long to think of an example:

	A - B - C - D

Now, A and D get pruned.  Do you want the whole branch to vanish?  _Hell, 
no_.

> I understand you want the second operation to only apply to refs 
> explicitly mentioned on the command line.

You have to at least give the users a chance to grasp what they are doing.  
And if that means to change the semantics to something saner, then so be 
it.

Ciao,
Dscho
