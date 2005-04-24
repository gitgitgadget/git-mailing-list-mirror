From: linux@horizon.com
Subject: Re: Hash collision count
Date: 24 Apr 2005 23:16:05 -0000
Message-ID: <20050424231605.30173.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 01:11:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPqFt-0002Fn-2u
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 01:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVDXXQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 19:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVDXXQJ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 19:16:09 -0400
Received: from science.horizon.com ([192.35.100.1]:50996 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262477AbVDXXQG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 19:16:06 -0400
Received: (qmail 30174 invoked by uid 1000); 24 Apr 2005 23:16:06 -0000
To: jgarzik@pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

*Sigh*.

> A collision -will- occur eventually, and it is trivial to avoid this 
> problem:

Yes, it will occur *eventually*.  Let's put some numbers on this
"eventually" business.

The earth's sun will run out of hydrogen and become a red giant in about
6 billion years, 1.3 * 2^57 seconds.  (Many people say 5 billion. but
I'll round up for safety.)  Suppose we add 1 file per second to our
repository until we are interrupted by the sun's photosphere engulfing
the planet and melting all our computers.

That's a total of n*(n-1)/2 = 1.7 * 2^113 pairs of files which can
possibly collide.  I'll round up to 2^114 for simplicity.

Assuming we have a good uniform hash function, the chance that any given
pair of different file versions produces an identical hash is 1/2^160.

The chance that there are no collsions is (1-1/2^160)^(2^114).  What is
this numerically?  Well, (1-a)*(1-b) = 1 - a - b + a*b.  When multiplying
probabilities very close to 1 (a and b small), the probability is
a little bit larger than (1-(a+b)).

Likewise, when exponentiating proabilities very close to 1, (1-a)^n is
a bit larger than 1-n*a.

Thus, the probability of no collisions is a bit larger than (1 - 2^114/2^160),
or (1 - 2^-46).  The probability of one or more collisions is a bit *less*
than 2^-46, 1 in 70 trillion.


With odds like that, I submit that it's not worth fixing; the odds
of introducing a bug are far higher than that.


If you can't find a hard drive large enough to store 183 quadrillion
file versions, the probability of a collision decreases as the square of
the fraction of that number you do store.  For example, if you only have
400 billion versions, the chance of a collision is around 2^-84.

We have a fair bit of safety margin in our "good uniform hash" assumption.

Running out of 32-bit inode number space is a *far* more urgent problem.

Not to mention that over the next 1000 years of kernel maintainers, one
of them may find something they like better than git.
