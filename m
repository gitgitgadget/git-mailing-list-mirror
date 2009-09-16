From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH 0/2] Speed up fetch with large number of tags
Date: Wed, 16 Sep 2009 16:03:50 -0700
Message-ID: <20090916230350.GC14660@spearce.org>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk> <7vbplb2pi7.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0909162141140.13697@reaper.quantumfyre.co.uk> <20090916224253.GB14660@spearce.org> <7vtyz2wlhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 01:04:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo3Xa-0002qX-F6
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 01:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbZIPXDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 19:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755185AbZIPXDr
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 19:03:47 -0400
Received: from george.spearce.org ([209.20.77.23]:56416 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572AbZIPXDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 19:03:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6C39D381FE; Wed, 16 Sep 2009 23:03:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vtyz2wlhm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128691>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > JGit depends on the fact that the refs list is sorted by the remote
> > peer, and that foo^{} immediately follows foo.  I don't think this
> > has ever been documented, but all sane implementations[1] follow
> > this convention and it may be something we could simply codify as
> > part of the protocol standard.
> >
> > [1] Sane implementations are defined to be what I consider to be
> >     the two stable implementations in deployed use, git.git and JGit.
> 
> There is no strong reason for ordering of refs between themselves
> (i.e. refs/heads/master comes before refs/heads/next) other than the fact
> that we sort and then walk due to packed-refs reasons.

Sorry, I misspoke a bit above.

JGit does not care about the ordering between two refs, e.g. in your
master/next example above JGit would accept them in either order
just fine.  Internally we enforce this by hashing the advertised
refs and walking the hash, callers presenting the data for a user
must copy to a list and sort by their desired sorting criteria
(usually name).

What I meant to say was this:
 
> But emitting tag X and then its peeled representation X^{} immediately
> after it is quite fundamental in the way how anybody sane would implement
> ls-remote.  There is no reason to violate the established order other than
> "I could do so", and in order not to show X and X^{} next to each other,
> you would need _more_ processing.

and right, explicitly placing X^{} away from X means that the sender
has to do more work to buffer one of the two values and then show
them later.  This is pointless other than to piss off any more
reasonable implementor.

I think we should formalize this rule of X^{} immediately follows
X if peeling is possible, and if not, then X^{} must not appear.
We already have a similar rule with packed-refs, although there it
is absolutely required by the format.

> Also, you might not have noticed, but my illustration patch was merely
> using it as a hint to optimize, and if the last ref we saw was not X when
> it is turn to handle X^{}, it simply falled back to the original logic,
> iow, the patch never compromised the correctness.

Oh, I missed that.  JGit I think flat out panics and disconnects
if the remote does this to us.  What is the incentive in supporting
a broken server with a slower client?

-- 
Shawn.
