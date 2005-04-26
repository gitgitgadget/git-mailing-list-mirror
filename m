From: linux@horizon.com
Subject: Re: Revised PPC assembly implementation
Date: 26 Apr 2005 02:35:07 -0000
Message-ID: <20050426023507.24611.qmail@science.horizon.com>
References: <20050425161746.7d943e62.davem@davemloft.net>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Apr 26 04:30:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQFq4-0008KE-U6
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 04:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVDZCfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 22:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVDZCfT
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 22:35:19 -0400
Received: from science.horizon.com ([192.35.100.1]:62512 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261285AbVDZCfI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 22:35:08 -0400
Received: (qmail 24612 invoked by uid 1000); 26 Apr 2005 02:35:07 -0000
To: davem@davemloft.net, paulus@samba.org
In-Reply-To: <20050425161746.7d943e62.davem@davemloft.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(Sorry about that last e-mail.  gnome-terminal crashed and sent the file
before I edited it.  Here's what I meant to send.)

> Do a block with the integer ALUs in parallel with a block done using
> Altivec :-)  There should be enough spare insn slots so that the loads
> are absorbed properly.

Unfortunately, the blocks are connected by a data dependency.
It's basically a large-key block cipher, chained by:

iv[] = fixed_initial_value.
iv[] += encrypt(iv, text[0..63])
iv[] += encrypt(iv, text[64..127])
iv[] += encrypt(iv, text[128..191])
iv[] += encrypt(iv, text[192..255])
etc.

There is no coarse-grain parallelism to exploit, unless you want
to be hashing two separate files at once.  Which would do too much
damage to the structure of the source to be worth considering.

> Unlike UltraSPARC's VIS, with altivec you can reasonably do shifts and
> rotates, which is the only reason I'm suggesting this.

I don't quite think it's worth it, though.  It's not data-parallel
enough.

We could theoretically use it to form the w[] vector, but that's only
4 instructions in registers which are very flexibly schedulable and
nicely fill in the cracks between other instructions.

Oh, here's STEPD1+UPDATEW scheduled optimally for the G4.  %r5 holds the
constant K.  Note that t < s <= t+16.  W(s) and W((s)-16) are actually
the same register.

add   RE(t),RE(t),W(t);	xor    %r0,RD(t),RB(t);	xor    W(s),W((s)-16),W((s)-3);
add   RE(t),RE(t),%r5;	xor    %r0,%r0,RC(t);	xor    W(s),W(s),W((s)-8);
add   RE(t),RE(t),%r0;	rotlwi %r0,RA(t),5;	xor    W(s),W(s),W((s)-14);
add   RE(t),RE(t),%r0;	rotlwi RB(t),RB(t),30;	rotlwi W(s),W(s),1;

However, whether that can be done in 6 cycles on a G5 is a bit unclear.
It can't be 6 consecutive cycles, but with some motion of code
across the edges, perhaps...

0: add   RE(t),RE(t),W(t);		xor    %r0,RD(t),RB(t);
1: xor    W(s),W((s)-16),W((s)-3);	(add)
2: add   RE(t),RE(t),%r5;		xor    %r0,%r0,RC(t);
3: xor    W(s),W(s),W((s)-8);		(rotlwi)
4: add   RE(t),RE(t),%r0;		rotlwi %r0,RA(t),5;
5: xor    W(s),W(s),W((s)-14);		rotlwi RB(t),RB(t),30;
6:
7: add   RE(t),RE(t),%r0;
8:
9: rotlwi W(s),W(s),1;

The problem there is forcing that ordering, rather than issuing the final
add in cycle 6 and pushing everything else ahead of it.


STEPD0+UPDATEW and STEPD1+UPDATEW are 13 and 14 instructions,
respectively, and don't fit into a 3-issue machine as neatly.
