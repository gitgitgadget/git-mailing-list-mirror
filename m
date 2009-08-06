From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 6 Aug 2009 11:09:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 20:09:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ7PK-0006ae-GF
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 20:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbZHFSJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 14:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbZHFSJ2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 14:09:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36573 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205AbZHFSJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 14:09:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76I9Qab024163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 11:09:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76I9PWG024724;
	Thu, 6 Aug 2009 11:09:25 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A7B1166.8020507@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125101>



On Thu, 6 Aug 2009, Artur Skawina wrote:
> 
> For those curious just how close the C version is to the various
> asm and C implementations, the q&d microbenchmark is at 
> http://www.src.multimo.pl/YDpqIo7Li27O0L0h/sha1bench.tar.gz

Hmm. That thing doesn't work at all on x86-64. Even apart from the asm 
sources, your timing thing does soem really odd things (why do you do that 
odd "iret" in GETCYCLES and GETTIME?). You're better off using 
lfence/mfence/cpuid, and I think you could make it work on 64-bit that 
way too.

I just hacked it away for testing.

> In short: 88% of openssl speed on P3, 42% on P4, 66% on Atom.

I'll use this to see if I can improve the 32-bit case.

On Nehalem, with your benchmark, I get:

	#             TIME[s] SPEED[MB/s]
	rfc3174         5.122       119.2
	# New hash result: d829b9e028e64840094ab6702f9acdf11bec3937
	rfc3174         5.153       118.5
	linus           2.092       291.8
	linusas         2.056       296.8
	linusas2        1.909       319.8
	mozilla         5.139       118.8
	mozillaas       5.775       105.7
	openssl         1.627       375.1
	spelvin         1.678       363.7
	spelvina        1.603       380.8
	nettle          1.592       383.4

And with the hacked version to get some 64-bit numbers:

	#             TIME[s] SPEED[MB/s]
	rfc3174         3.992       152.9
	# New hash result: b78fd74c0033a4dfe0ededccb85ab00cb56880ab
	rfc3174         3.991       152.9
	linus            1.54       396.3
	linusas         1.533       398.1
	linusas2        1.603       380.9
	mozilla         4.352       140.3
	mozillaas       4.227       144.4

so as you can see, your improvements in 32-bit mode are actually 
de-provements in 64-bit mode (ok, your first one seems to be a tiny 
improvement, but I think it's in the noise).

But you're right, I need to try to improve the 32-bit case.

			Linus
