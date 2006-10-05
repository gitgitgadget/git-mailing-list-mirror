From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: blame: All rows have title; print 8 SP when no leading commit-8
Date: Wed, 04 Oct 2006 18:24:19 -0700
Message-ID: <7vwt7fimgs.fsf@assigned-by-dhcp.cox.net>
References: <20061005010215.63402.qmail@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 03:24:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVHyS-0006cD-Gu
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 03:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWJEBYV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 21:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWJEBYV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 21:24:21 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31377 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751301AbWJEBYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 21:24:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005012420.ZEMT22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Oct 2006 21:24:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WRQD1V00S1kojtg0000000
	Wed, 04 Oct 2006 21:24:13 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20061005010215.63402.qmail@web31811.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Wed, 4 Oct 2006 18:02:15 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28340>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Print eight spaces when no leading commit is being printed.
> I.e. on all rows of a commit-block, but the first.  This fixes
> alignment in the destination buffer when blame data lines
> are cut and pasted.
>
> Also, now all rows have title.

Its visuals might be Ok (I haven't had chance to try it), but I
am a bit worried about the output size bloat.  What kind of
bloat factor are we talking about with this patch?

 - compared to the ancient original, which used to have commit-8
   on all lines, title * N lines for a file that is N lines
   long.  A title ("$author, $date") is about say 30 bytes or so
   so for a file that is on average 25 bytes per line (this is
   from "wc *.c" in git.git repository ) we are now spewing out
   roughly twice the bytes back to the browser (25+8 vs 25+8+30)

 - compared to "only first in the block" version, assuming an
   average group size is 10 lines or so (this is a totally made
   up number) we are adding 72 extra bytes per 10 lines for
   commit-8 on top of the title bloat which would be 270 bytes
   per 10 lines.  Again assuming 25-byte per line average, that
   is 250+8+30 vs 250+80+300 per 10 lines.  Again, roughly
   twice.

I am not sure what the numbers of the chunked one I just
reverted from "next" compared to the original.  For the same
group size assumption, it added 8 bytes for commit-8 and 30
bytes for title per the N lines, but we are assuming 10-line
blocks, so 38 byte overhead per 10 lines, which is 250+80 vs
250+38, so it might have been actually slimmer than the
original.
