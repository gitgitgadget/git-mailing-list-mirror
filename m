From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: bug: update hook failure doesn't prevent local deletion of a branch
Date: Fri, 27 Jul 2007 00:26:06 -0400
Message-ID: <20070727042606.GE20052@spearce.org>
References: <200707251250.08166.andyparkins@gmail.com> <7vk5sm5vrd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 06:26:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEHP6-00052e-1q
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 06:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbXG0E0M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 00:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbXG0E0M
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 00:26:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50451 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbXG0E0L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 00:26:11 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IEHOx-0000fT-Mo; Fri, 27 Jul 2007 00:26:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6E7BC20FBAE; Fri, 27 Jul 2007 00:26:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vk5sm5vrd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53881>

Junio C Hamano <gitster@pobox.com> wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> > Summary: when using git-push to delete a remote branch, and that deletion is 
> > disallowed by the update hook, the local tracking branch _is_ deleted.
> 
> Yes, a few months ago with b516968f, "send-pack" started to
> pretend that it turned around and fetched immediately after it
> attempted to push.
> 
> There are two problems with it.  One is this exact problem Andy
> reported.
...
> I think this is correctable without major changes.
> If the remote end refused to update only one of the refs, and
> send-pack as a whole fails, we could refrain from updating
> anything local.

Reasonable.  Probably pretty simple too.

> But another more fundamental issue is that post-update hook on
> the receiving end could do anything it pleases (for example, it
> could try to rebase what was pushed), and at the protocol level
> there is no way to say "you tried to push this SHA-1 but we
> replaced it with this other SHA-1 instead".

You keep raising this argument against the "git-push updates local
refs" feature.  Its not just the post-update hook that could alter
the ref.  Another user could just push behind you (and I mean right
behind you) and either force an update, delete the ref entirely, or
just fast-forward it.  (Its entirely possible that the other user
does have the commit you just pushed, because you had previously
supplied it to them.)  So its actually possible for the ref to have
changed again before you even see the successful update message on
your console.

I don't think it really matters.  Based on the output you see from
git-push on screen you have good reason to believe that the ref
you just pushed to is now at the commit SHA-1 displayed.  For that
reason alone I think it is correct to update the corresponding
tracking branch, because an immediate git-fetch just wastes the
user's time and will (usually) fetch the SHA-1 just pushed.

We should make our repository state reflect the user's internal
mental view of what just happened, especially here, because the
user's mental view is probably correct.

-- 
Shawn.
