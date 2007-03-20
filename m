From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Mon, 19 Mar 2007 22:44:08 -0700
Message-ID: <7vhcsgbhav.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703172136440.18328@xanadu.home>
	<Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703172200060.18328@xanadu.home>
	<Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
	<7v8xdunavr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703200400230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070320032947.GA29145@spearce.org>
	<20070320034020.GB29145@spearce.org>
	<Pine.LNX.4.64.0703192052380.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:44:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTX8n-0005Yp-Oq
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 06:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbXCTFoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 01:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbXCTFoK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 01:44:10 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39082 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbXCTFoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 01:44:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320054408.OWNE28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 20 Mar 2007 01:44:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ctk81W0071kojtg0000000; Tue, 20 Mar 2007 01:44:09 -0400
In-Reply-To: <Pine.LNX.4.64.0703192052380.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 19 Mar 2007 21:11:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42714>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Dscho's bigger patch probably helps more on an in-order architecture, and 
> should be equally good on a P4 (or Opteron). On Core 2, neither of the 
> patches seem to make a huge difference.

Because hoisting stable test outside loop is always better for
any architecture, I thought picking between Gitte and Gitney
patches is a no brainer, and I didn't bother to compare-bench,
but I got curious.

(plain)
7.89user 0.15system 0:08.08elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+41608minor)pagefaults 0swaps
7.93user 0.18system 0:08.14elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+41608minor)pagefaults 0swaps

(gitte -- separate function for slow path)
6.98user 0.18system 0:07.17elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+41606minor)pagefaults 0swaps
7.14user 0.12system 0:07.26elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+41607minor)pagefaults 0swaps

(gitney -- cheap test first before isspace)
7.23user 0.18system 0:07.42elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+41608minor)pagefaults 0swaps
7.32user 0.14system 0:07.48elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+41607minor)pagefaults 0swaps

So it does not seem to make much difference on Athlon 64x2 either.

Will apply the "stupid hashcmp() removal" and Dscho's patch and
call it a day.
