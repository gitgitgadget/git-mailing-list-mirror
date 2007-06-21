From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Thu, 21 Jun 2007 10:52:19 -0700
Message-ID: <7vfy4lw5yk.fsf@assigned-by-dhcp.pobox.com>
References: <20070621030622.GD8477@spearce.org>
	<alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
	<Pine.LNX.4.64.0706211248420.4059@racer.site>
	<20070621131915.GD4487@coredump.intra.peff.net>
	<alpine.LFD.0.98.0706210910390.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 19:52:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Qpu-0000N1-Du
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 19:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759597AbXFURwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 13:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759592AbXFURwW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 13:52:22 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:40205 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759578AbXFURwV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 13:52:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621175220.GNXH4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 13:52:20 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EHsK1X00c1kojtg0000000; Thu, 21 Jun 2007 13:52:20 -0400
In-Reply-To: <alpine.LFD.0.98.0706210910390.3593@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 21 Jun 2007 09:20:51 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50649>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We'e also had things like
>
> 	arch/i386/kernel/pci-pc.c -> arch/i386/kernel/pci/common.c
>
> so it's not always the ending of a file that is unchanged, but you still 
> often have some "similarity" of the name (ie the "pci" substring is still 
> common there).

This is not an example to draw very useful conclusions, is it?

The heuristics to say '-pc => common' is a more likely rename
than '-obscure-arch => common' heavily depends on human
intelligence in the context of a particular project, the kernel,
where there are rules such as "peripherals are tested most
widely on PC architectures, so assume that the vendors might
have tested their stuff only on PCs".

But I do agree that not limiting to basename has values.
Taking example from the "I cannot draw so here is a red big X",
it is quite possible that two red big X's are replaced with
properly rendered icons, while their format modified, like so:

    images/ok-button.gif => images/buttons/ok.png
    images/cancel-button.gif => images/buttons/cancel.png

This suggests that we might be able to look around to see what
other rename src/target candidate files there are, so that we
can figure out if there is a common pattern (i.e. in the above
example, "patsubst images/%-button.gif,images/buttons/%.png" is
what is going on).  If we find such a pattern, we can base the
assignment of "basename similarity bonus" on that pattern.
