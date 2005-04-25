From: Paul Mackerras <paulus@samba.org>
Subject: Re: Revised PPC assembly implementation
Date: Mon, 25 Apr 2005 19:40:19 +1000
Message-ID: <17004.47876.414.756912@cargo.ozlabs.ibm.com>
References: <17003.9009.226712.220822@cargo.ozlabs.ibm.com>
	<20050425031337.16605.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 11:36:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ00W-00072O-Ok
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 11:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVDYJkz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 05:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVDYJkz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 05:40:55 -0400
Received: from ozlabs.org ([203.10.76.45]:44744 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262552AbVDYJks (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 05:40:48 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id BCDB067A6C; Mon, 25 Apr 2005 19:40:46 +1000 (EST)
To: linux@horizon.com
In-Reply-To: <20050425031337.16605.qmail@science.horizon.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

linux@horizon.com writes:

> Three changes:
> - Added stack frame as per your description.
> - Found two bugs.  (Cutting & pasting too fast.)  Fixed.
> - Minor scheduling improvements.  More to come.
> 
> Which lead to three questions:
> - Is the stack set properly now?

Not quite; you are saving 20 registers, so you need a 96-byte stack
frame, like this:

	stwu	%r1,-96(%r1)
	stmw	%r13,16(%r1)
	...
	lmw	%r13,16(%r1)
	addi	%r1,%r1,96
	blr

Since sha1_core is a leaf function, I suppose you could use the lr
save area (do stwu %r1,-80(%r1); stmw %r13,0(%r1)) but it seems a bit
dodgy.

> - Does it produce the right answer now?

Yes.

> - Is it any faster?

I did 10 repetitions of my program that calls SHA1_Update with a
4096-byte block of zeroes 256,000 times.  With my version, the average
time was 4.6191 seconds with a standard deviation of 0.0157.  With your
version, the average was 4.6063 and the standard deviation 0.0148.  So
I would say that your version is probably just a little faster - of the
order of 0.3% faster.

Paul.
