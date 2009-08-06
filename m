From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 6 Aug 2009 13:53:11 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
 <4A7B384C.2020407@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 22:53:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ9xz-00032k-PB
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 22:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224AbZHFUxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 16:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756181AbZHFUxb
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 16:53:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38604 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755955AbZHFUxa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 16:53:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76KrBrS005622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 13:53:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76KrBdv008966;
	Thu, 6 Aug 2009 13:53:11 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A7B384C.2020407@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125125>



On Thu, 6 Aug 2009, Artur Skawina wrote:
> 
> it's a bit slower (P4):
> 
> before: linus          0.6288       97.06
> after:  linus          0.6604       92.42

Hmm. Ok, I just tested with your harness, and I get

	#             TIME[s] SPEED[MB/s]
	rfc3174           5.1       119.7
	rfc3174         5.097       119.7
	linus           1.836       332.5
	linusas         2.006       304.3
	linusas2        1.879       324.9
	mozilla         5.562       109.7
	mozillaas       5.913       103.2
	openssl         1.613       378.5
	spelvin         1.698       359.5
	spelvina        1.602         381
	nettle          1.594       382.9

with it, so it is faster for me. So your slowdown seems to be yet another 
P4 thing. Dang crazy micro-architecture.

Of course, it might be a compiler version difference too. I'm using 
gcc-4.4.0.

With the cpp variable renaming, the compiler really has less to be smart 
about, but spill decisions will still matter a lot.

(My old 32-bit numbers were 

        linus           2.092       291.8

so it's a clear improvement on my machine and with my compiler).

It also seems to improve the 64-bit numbers a small bit, I'm getting

	#             TIME[s] SPEED[MB/s]
	rfc3174          3.98       153.3
	rfc3174         3.972       153.7
	linus           1.514       403.1
	linusas         1.555       392.6
	linusas2        1.599       381.7
	mozilla          4.34       140.6
	mozillaas       4.223       144.5

with my 64-bit compile, so on a Nehalem it's the best one of the C ones by 
a noticeable margin. (My original 64-bit numbers were

        linus            1.54       396.3

and while the numbers seem to fluctuate a bit, the fluctuation is roughly 
in the 1% range, so that improvement seems to be statistically 
significant.

Oh, I did make a small change, but I doubt it matters. Instead of doing

	TEMP += E + SHA_ROL(A,5) + (fn) + (constant); \
	B = SHA_ROR(B, 2); E = TEMP; } while (0)

I now do

	E += TEMP + SHA_ROL(A,5) + (fn) + (constant); \
	B = SHA_ROR(B, 2); } while (0)

which is a bit more logical (the old TEMP usage was just due to a fairly 
mindless conversion). That _might_ have lower register pressure if the 
compiler is silly enough to not notice that it can do it. Maybe that 
matters.

			Linus
