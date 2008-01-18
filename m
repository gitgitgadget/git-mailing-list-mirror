From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 21:33:27 -0500
Message-ID: <20080118023327.GT24004@spearce.org>
References: <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org> <7vodblpmyc.fsf@gitster.siamese.dyndns.org> <20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net> <20080117110132.GB12285@hashpling.org> <478F4CDC.2090703@viscovery.net> <7vbq7jkixg.fsf@gitster.siamese.dyndns.org> <7v63xrki29.fsf@gitster.siamese.dyndns.org> <20080118021300.GR24004@spearce.org> <7v1w8fkgy9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 03:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFh3S-00013e-Mg
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 03:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892AbYARCde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 21:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756263AbYARCdd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 21:33:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37752 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634AbYARCdc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 21:33:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JFh2j-0003TI-Da; Thu, 17 Jan 2008 21:33:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5F1A420FBAE; Thu, 17 Jan 2008 21:33:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v1w8fkgy9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70953>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > I think the problem is nobody has tested fast-import updating an
> > existing ref while using NO_MMAP.  Or if they did, they didn't report
> > the problem as they didn't figure they needed fast-import that badly.
> >
> > Updating an existing ref is not a common operation, but the test
> > suite does test for it.  So it must be the NO_MMAP configuration
> > is simply not being tested well enough.
> 
> Now a more important question is how we would properly fix this
> issue?
> 
> I suspect that fast-import is the only one that opens windows
> into an unfinalized pack, and if that is the case, it would be
> the only program that may be hit by the issue of mmap emulation
> getting stale data.

Yes, it is the only program that is foolish enough to access a
partial packfile.  index-pack uses pread(), and only after it has
the entire packfile downloaded to the local system.  The only other
reader of a partial packfile is unpack-objects, and obviously that
doesn't care about seeking backwards within the packfile.

So its probably the only user who suffers from the mmap emulation.
 
> I do not think the patch I posted was correct at all.
> 
> Especially, I am not sure if the issue only exists at the
> end_packfile() boundary.  Don't we have the same issue reading
> from the packfile being built, and isn't the only reason my hack
> works it around is because access patterns of the testsuite
> happens to not trigger it?

Yes, that's my take on it as well (see my other email).  The
testsuite must just be really lucky that its not hitting the
boundary condition.

I almost said gfi_unpack_entry() was immune from this bug, but
I went back and read the code again and determined that it does
in fact suffer from this under NO_MMAP, and we're just really
damn lucky nobody has caused it.

I'll try to work up a patch this evening.

-- 
Shawn.
