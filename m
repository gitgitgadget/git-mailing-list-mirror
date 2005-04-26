From: Paul Mackerras <paulus@samba.org>
Subject: Re: Revised PPC assembly implementation
Date: Tue, 26 Apr 2005 11:22:49 +1000
Message-ID: <17005.38889.738457.359270@cargo.ozlabs.ibm.com>
References: <17004.47876.414.756912@cargo.ozlabs.ibm.com>
	<20050425173430.11031.qmail@science.horizon.com>
	<17005.30365.995256.963911@cargo.ozlabs.ibm.com>
	<20050425161746.7d943e62.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 03:18:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQEiX-0006Fo-WB
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 03:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDZBXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 21:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVDZBXW
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 21:23:22 -0400
Received: from ozlabs.org ([203.10.76.45]:51841 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261196AbVDZBXS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 21:23:18 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9AE5367B26; Tue, 26 Apr 2005 11:23:16 +1000 (EST)
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050425161746.7d943e62.davem@davemloft.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David S. Miller writes:

> Time to bust out the altivec perhaps :)

I looked at this but I couldn't see a way to use altivec effectively
for SHA1.

The problem is that we have a chain of dependencies with the A
variable (which is 32-bit) where each A value depends on the previous
A value and on one of the 80 W values.  The W values are derived from
the 16 words (32-bit) of the input data block.

It might be possible to use altivec for generating the W values
(although there is the problem that W[k] depends on W[k-3], making it
hard to do a 4-way parallelization), but I don't see any way of
parallelizing the calculation of the A values, which is the critical
path.  Using altivec for generating the W values but the integer ALUs
for the A calculations would mean we had to go via memory, too, since
there isn't any way to transfer stuff directly between altivec
registers and GPRs.

We can't do four blocks from the same sequence in parallel either.  We
could do four blocks from four separate streams in parallel, but that
seems hard to organize...

Regards,
Paul.
