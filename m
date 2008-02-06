From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Tue, 05 Feb 2008 22:17:30 -0800
Message-ID: <7vd4ra4nid.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
	<alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
	<7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
	<alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org>
	<7vir13g9hx.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
	<alpine.LSU.1.00.0802052228280.8543@racer.site>
	<7v7ihi7syj.fsf@gitster.siamese.dyndns.org>
	<7vhcgm4o1p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 07:18:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMdbq-0004QX-AK
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 07:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbYBFGRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 01:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbYBFGRl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 01:17:41 -0500
Received: from rune.pobox.com ([208.210.124.79]:54529 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbYBFGRl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 01:17:41 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id C2FC6192047;
	Wed,  6 Feb 2008 01:18:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 286BE1918E4;
	Wed,  6 Feb 2008 01:17:54 -0500 (EST)
In-Reply-To: <7vhcgm4o1p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Feb 2008 22:05:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72758>

Junio C Hamano <gitster@pobox.com> writes:

> Once we find the set of bottom commits in "newlist", we would
> need to prove that none of them can be reached from any of the
> negative commits still in "list".  We can do this traversal
> using two bits from flags, exactly like commit.c::merge_bases()
>
>     for each bottom commit B {
>       L = empty list
>       B.flags |= PARENT2
>       L.append(B)
>       for each negative commit C in "list from limit_list()"
>           C.flags |= PARENT1
>           L.append(C)
>       while (L) {
>           C = shift L;
>           flag = C.flags & (PARENT1|PARENT2);
>             if (flag ==  (PARENT1|PARENT2))
>               continue; /* common */
>           for each parent P of commit C:
>               pflag = P.flags & (PARENT1|PARENT2);
>               if (pflag == flag)
>                     continue;
>               P.flags |= flags;
>                 L.append(P)
>       }
>       if (B.flags & PARENT1)
>           we still need to traverse -- everybody_uninteresting()
>           in limit_list() main loop was not enough!
>     }

Actually when we do this traversal, we can mark the positive
commits on "newlist" as negative when it is painted with
PARENT1.  I was assuming that as soon as we find that we are in
problematic history with this procedure we exit the whole thing
and resume to limit_list(), but we may be able to use this as
the postprocessing step to clean-up the result.  I just need to
prove that this postprocessing step will smudge all the "falsely
positive but in reality negative" ones...
