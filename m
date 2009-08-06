From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 5 Aug 2009 21:50:21 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908052137400.3390@localhost.localdomain>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
 <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain> <4A7A4BC5.7010106@gmail.com> <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain> <alpine.LFD.2.01.0908052043082.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908052056500.3390@localhost.localdomain> <4A7A5BE2.5070401@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 06:51:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYuwo-0005sz-Mt
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 06:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbZHFEvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 00:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbZHFEvI
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 00:51:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46204 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750706AbZHFEvH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 00:51:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n764oMsA023153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 21:50:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n764oL8A009349;
	Wed, 5 Aug 2009 21:50:21 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A7A5BE2.5070401@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125038>



On Thu, 6 Aug 2009, Artur Skawina wrote:
> 
> #             TIME[s] SPEED[MB/s]
> rfc3174         1.357       44.99
> rfc3174         1.352       45.13
> mozilla         1.509       40.44
> mozillaas       1.133       53.87
> linus          0.5818       104.9
> 
> so it's more than twice as fast as the mozilla implementation.

So that's some general SHA1 benchmark you have?

I hope it tests correctness too. 

Although I can't imagine it being wrong - I've made mistakes (oh, yes, 
many mistakes) when trying to convert the code to something efficient, and 
even the smallest mistake results in 'git fsck' immediately complaining 
about every single object.

But still. I literally haven't tested it any other way (well, the git 
test-suite ends up doing a fair amount of testing too, and I _have_ run 
that).

As to my atom testing: my poor little atom is a sad little thing, and 
it's almost painful to benchmark that thing. But it's worth it to look at 
how the 32-bit code compares to the openssl asm code too:

 - BLK_SHA1:

	real	2m27.160s
	user	2m23.651s
	sys	0m2.392s

 - OpenSSL:

	real	2m12.580s
	user	2m9.998s
	sys	0m1.811s

 - Mozilla-SHA1:

	real	3m21.836s
	user	3m18.369s
	sys	0m2.862s

As expected, the hand-tuned assembly does better (and by a bigger margin). 
Probably partly because scheduling is important when in-order, and partly 
because gcc will have a harder time with the small register set.

But it's still a big improvement over mozilla one.

(This is, as always, 'git fsck --full'. It spends about 50% on that SHA1 
calculation, so the SHA1 speedup is larger than you see from just th 
enumbers)

		Linus
