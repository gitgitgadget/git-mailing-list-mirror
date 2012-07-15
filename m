From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [PATCH maint-1.6.5 v2] block-sha1: avoid pointer conversion that violates alignment constraints
Date: Mon, 16 Jul 2012 08:58:34 +1200
Message-ID: <FDFB73BB-64E8-48F8-95DB-94C0EC7FFB2A@orcon.net.nz>
References: <20120713233957.6928.87541.reportbug@electro.phys.waikato.ac.nz> <20120714002950.GA3159@burratino> <5000CBCA.8020607@orcon.net.nz> <20120714021856.GA3062@burratino> <50010B84.5030606@orcon.net.nz> <20120714075906.GD3693@burratino> <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com> <20120714205049.GA28502@burratino>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 23:06:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqW1o-0004rf-2b
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 23:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab2GOVGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 17:06:16 -0400
Received: from nctlincom01.orcon.net.nz ([60.234.4.74]:46151 "EHLO
	nctlincom01.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2GOVGA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 17:06:00 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jul 2012 17:06:00 EDT
Received: from mx7.orcon.net.nz (mx7.orcon.net.nz [219.88.242.57])
	by nctlincom01.orcon.net.nz (8.14.3/8.14.3/Debian-9.4) with ESMTP id q6FL5Hi6011498
	for <git@vger.kernel.org>; Mon, 16 Jul 2012 09:05:17 +1200
Received: from Debian-exim by mx7.orcon.net.nz with local (Exim 4.69)
	(envelope-from <mcree@orcon.net.nz>)
	id 1SqVtz-0003Fk-Iy
	for git@vger.kernel.org; Mon, 16 Jul 2012 08:58:51 +1200
Received: from cree.phys.waikato.ac.nz ([130.217.188.11])
	by mx7.orcon.net.nz with esmtpa (Exim 4.69)
	(envelope-from <mcree@orcon.net.nz>)
	id 1SqVtx-0003AB-PR; Mon, 16 Jul 2012 08:58:49 +1200
In-Reply-To: <20120714205049.GA28502@burratino>
X-Mailer: Apple Mail (2.936)
X-DSPAM-Check: by mx7.orcon.net.nz on Mon, 16 Jul 2012 08:58:51 +1200
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Mon Jul 16 08:58:51 2012
X-DSPAM-Confidence: 0.6191
X-DSPAM-Probability: 0.0000
X-Bayes-Prob: 0.0001 (Score 0, tokens from: @@RPTN, default)
X-Spam-Score: 0.00 () [Hold at 5.50] 
X-CanIt-Geo: ip=130.217.188.11; country=NZ; latitude=-41.0000; longitude=174.0000; http://maps.google.com/maps?q=-41.0000,174.0000&z=6
X-CanItPRO-Stream: base:default
X-Canit-Stats-ID: 06HyJ5hsK - df3efb271d02 - 20120716
X-Scanned-By: CanIt (www . roaringpenguin . com) on 172.16.100.174
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201484>

Jonathan,

Thanks for acting so promptly on this.  Just a minor point on the  
commit message below.

On 15/07/2012, at 8:50 AM, Jonathan Nieder wrote:
> Unfortunately, Michael noticed on an Alpha machine that git was using
> plain 32-bit reads anyway.  As soon as we convert a pointer to int *,
> the compiler can assume that the object pointed to is correctly
> aligned as an int (C99 section 6.3.2.3 "pointer conversions"
> paragraph 7), and gcc takes full advantage by converting the get_be32
> calls back to a load and bswap and producing a whole bunch of
> unaligned access traps.

Alpha does not have a bswap (or similar) instruction.  I do recall  
reading somewhere that one can get halfway to swapping endianness by  
treating a number as a VAX float and converting to IEEE float, with  
only a couple or so more instructions to achieve the full swap.  But I  
don't think that is available to us anyway because on Debian we  
compile for generic Alpha. I suspect that the crux of the matter is  
that compiling for generic Alpha also means that byte access  
instructions are not permitted.  In other words, all memory accesses  
must be long words (32bits) or quad words (64bits).  In the get_be32  
routine the compiler _has_ to issue 32bit memory accesses whether the  
base pointer is char * or int *.  If the pointer is unaligned then two  
neighbouring aligned 32bit loads are required to ensure that all four  
bytes are loaded.  If the pointer is aligned then a single 32bit load  
gets all the four bytes.  Having never looked at the generated  
assembler code, I nevertheless suspect that is the guts of the  
optimisation --- the compiler can eliminate an access to memory if it  
knows the pointer is aligned.

Cheers
Michael.
