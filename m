From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Sat, 8 Aug 2009 10:10:35 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908081004560.3288@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
 <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <alpine.LFD.2.01.0908061909310.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908071614310.3288@localhost.localdomain> <4A7CBD28.6070306@gmail.com> <4A7CBF47.9000903@gmail.com> <alpine.LFD.2.01.0908071700290.3288@localhost.localdomain> <4A7CC380.3070008@gmail.com> <alpine.LFD.2.01.0908072107170.3288@localhost.localdomain>
 <4A7D0E7B.3030601@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 19:11:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZpRu-0001bC-AV
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 19:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbZHHRLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 13:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbZHHRLI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 13:11:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36366 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752459AbZHHRLH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Aug 2009 13:11:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n78HAZnN016833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Aug 2009 10:10:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n78HAZcd015931;
	Sat, 8 Aug 2009 10:10:35 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A7D0E7B.3030601@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.965 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125291>



On Sat, 8 Aug 2009, Artur Skawina wrote:
> 
> I've inlined the byteswapping in 'opensslb', maybe that one will
> do a bit better.
> 
> http://www.src.multimo.pl/YDpqIo7Li27O0L0h/sha1bench.tar.gz

Hmm. Testing on my atom, the inlined bswap is worse, but the asm versions 
are generally superior to any C one:

	#             TIME[s] SPEED[MB/s]
	rfc3174         2.194       27.82
	rfc3174          2.19       27.87
	linus           0.947       64.45
	linusph        0.9381       65.06
	linusv         0.8943       68.25
	linusvph       0.8803       69.34
	linusasm       0.9349       65.29
	linusp4         1.006       60.66
	linusas         1.062       57.48
	linusas2        1.009        60.5
	mozilla         2.264       26.96
	mozillaas       2.197       27.78
	openssl         0.648       94.19
	opensslb       0.7419       82.27
	spelvin         0.636       95.96
	spelvina       0.6671       91.49
	nettle          0.717       85.12
	nettle-ror     0.7137       85.52
	nettle-p4sch   0.7158       85.27

Interestingly, -mtune=prescott does well for that 'linusv' version on atom 
too, and gets it up to

	linusv         0.8365       72.96

and it's the only one that improves. Odd interactions.

			Linus
