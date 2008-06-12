From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Consolidate SHA1 object file close
Date: Thu, 12 Jun 2008 08:33:53 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806120758090.3041@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org> <20080611074309.GB28629@artemis.madism.org> <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org> <20080611154020.GE28629@artemis.madism.org>
 <alpine.LFD.1.10.0806110952290.3101@woody.linux-foundation.org> <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org> <20080611074309.GB28629@artemis.madism.org> <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org>
 <20080611154020.GE28629@artemis.madism.org> <alpine.LFD.1.10.0806111030580.3101@woody.linux-foundation.org> <20080611222534.GC16439@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 17:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6opy-0005rz-Mk
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 17:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbYFLPes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 11:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYFLPer
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 11:34:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32939 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752696AbYFLPeq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 11:34:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5CFXsY7015725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jun 2008 08:33:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5CFXrwF026022;
	Thu, 12 Jun 2008 08:33:53 -0700
In-Reply-To: <20080611222534.GC16439@artemis.madism.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.371 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84761>



On Thu, 12 Jun 2008, Pierre Habouzit wrote:
> 
>   No, we're not using a shared git object repository, each developper
> has a git checkout in his /home (on NFS) but works for real in a workdir
> that lives on his local hard drive (to get faster compilation times,
> because NFS really sucks at speed for compilation). Though, people
> working on plain NFS have had the same problems.

Ahhh..

In that case it's not going to be a client caching issue - at least not in 
the sense that two different clients are out-of-sync with each other wrt 
caches. It sounds as it you only ever have one client that reads and 
writes to the same git repository at a time.

So scratch all the previous theory.

Quite frankly, in that case, it sounds more like simply some NFS problem. 
And we _have_ had NFS problems before. See the threads

 - bug: git-repack -a -d produces broken pack on NFS

   Turned out to apparently be ethernet packet corruption that was not 
   detected by the hardware and was due to a badly seated ethernet card!

 - git 1.5.3.5 error over NFS

   Some unexplained corruption due to problms with pread() on NFS not 
   returning data that was previously written.

for example.

Basically, NFS has many serious failure cases that can go undetected, and 
it _could_ be that you actually have flaky NFS but never noticed it before 
because most tools don't care as deeply as git does (ie if a bit is 
flipped in some random data, a lot of tools will never notice). There are 
supposed to be checksums etc on the network packets that NFS uses, but:

 - the ethernet checksum (which is a fairly strong CRC) is sadly often not 
   even checked by some switches and/or cards, and especially if it's a 
   store-and-forward switch that doesn't check the CRC properly, it can 
   end up re-sending a corrupt packet with a recomputed ethernet CRC that 
   now matches the _corrupt_ data. Oops.

 - Perhaps worse, the ethernet checksum is purely a physical layer one, 
   not an end-to-end checksum, which not only explains how a switch can 
   re-generate a broken one, but also means that even if the ethernet card 
   checks it properly, it doesn't actually account for any corruption that 
   happens _afterwards_. So if there is corruption going from the card to 
   memory (which was apparently the problem in the first git thread 
   above), the CRC got checked earlier and the new corruption isn't found.

 - there _is_ an TCP/IP-level packet check, with a checksum of the IP 
   header, and a separate checksum of UDP and TCP data. HOWEVER. All these 
   checksums are very very weak, and to make things worse, the UDP 
   checksum can be entirely disabled, and quite often "better" ethernet 
   cards will do checksumming for you in hardware, which again means that 
   it's not an end-to-end checksum, and you have the exact same failure 
   case as with the ethernet CRC.

IOW, there are safety nets in place, but they tend to be fairly easily 
broken under certain circumstances.

Add to the above the possibility of just a kernel NFS bug (or a NFSd one), 
and it would really be very interesting to hear:

 - do the errors seem to happen more at certain clients than others?

   If it's a client-side problem, it really should happen more for certain 
   kernel versions or certain hardware.

 - have you had any other anecdotal evidence of problems with non-git 
   usage? Unexplained SIGSEGV's if you have binaries over NFS, for 
   example? Strange syntax errors when compiling over NFS?

I'm not discounting a git bug, but quite frankly, it really is worth 
checking that your network/NFS setup is solid.

			Linus
