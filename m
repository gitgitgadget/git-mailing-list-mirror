From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-commit: Disallow unchanged tree in non-merge mode
Date: Fri, 14 Sep 2007 11:24:08 -0700
Message-ID: <7vsl5h9kc7.fsf@gitster.siamese.dyndns.org>
References: <20070906101648.GD6665@basalt.office.altlinux.org>
	<20070909044648.GH18160@spearce.org>
	<7vir6fjmuv.fsf@gitster.siamese.dyndns.org>
	<20070913035137.GM3099@spearce.org>
	<7vr6l2gxyw.fsf@gitster.siamese.dyndns.org>
	<20070914000108.GE3619@basalt.office.altlinux.org>
	<7vr6l2f6k1.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0709131850060.16478@woody.linux-foundation.org>
	<20070914024303.GH3619@basalt.office.altlinux.org>
	<alpine.LFD.0.999.0709132123570.16478@woody.linux-foundation.org>
	<20070914050410.GA11402@coredump.intra.peff.net>
	<alpine.LFD.0.999.0709132215250.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Dmitry V. Levin" <ldv@altlinux.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 14 20:38:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWFpu-0004ZJ-Q2
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 20:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbXINSYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 14:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbXINSYM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 14:24:12 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48367 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbXINSYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 14:24:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070914182408.DQEO20651.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 14 Sep 2007 14:24:08 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id oJQ81X0091gtr5g0000000; Fri, 14 Sep 2007 14:24:08 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58175>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Yeah, we should probably:
>  - default to something larger but still reasonably sane (ie not 100, but 
>    perhaps 1000)
>  - special-case the "identical rename", and have a higher limit for that 
>    (we already handle the identicals as a separate pass before we even 
>    start doing the similarity analysis - and it's the similarity analysis 
>    that can be the really expensive part)
>
> There's really no point in trying to do rename analysis for tons and tons 
> of files - even if we find perfect renames, the diff is going to be 
> unreadable by a human, so realistically nobody is ever going to care! A 
> machine won't care whether it was done as a create/delete or a rename, and 
> a human won't be bothered to read about thousands of renames, so we're 
> just wasting time trying to make it prettier.
>
> So quite arguably, the only case we really care about for renames is when 
> the numbers are small enough to be human-readable.

I agree with that.  At the same time we might want to revisit
the earlier "build a full matrix and pick the best ones"
approach commit 5c97558c9a813a0a775c438a79cfc438def00c22 (Detect
renames in diff family) introduced.

A tangent.

I've been thinking about updating the diffcore-rename for some
time to give bonus points to a filepair whose neighbors are
detected to be renames.  E.g. if you have this pair of preimage
and postimage:

	(preimage)		(postimage)

	arch/i386/foo.c		arch/x86/foo-32.c
	arch/i386/bar.c		arch/x86/bar-32.c
	arch/i386/baz.c		arch/x86/baz-32.c

and if foo.c and bar.c are found to be very similar to foo-32.c
and bar-32.c while baz.c and baz-32.c are not that much, we may
want to take hints from the movement of neighbouring files and
boost the similarity score between baz.c and baz-32.c pair.

It would be a quite an interesting coding challenge for anybody
who wants to get his hands dirty.  Would this be worth it in
practice?  I dunno.




        
