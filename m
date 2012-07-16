From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [PATCH maint-1.6.5 v2] block-sha1: avoid pointer conversion that
 violates alignment constraints
Date: Mon, 16 Jul 2012 21:53:53 +1200
Message-ID: <5003E4B1.605@orcon.net.nz>
References: <20120713233957.6928.87541.reportbug@electro.phys.waikato.ac.nz> <20120714002950.GA3159@burratino> <5000CBCA.8020607@orcon.net.nz> <20120714021856.GA3062@burratino> <50010B84.5030606@orcon.net.nz> <20120714075906.GD3693@burratino> <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com> <20120714205049.GA28502@burratino> <FDFB73BB-64E8-48F8-95DB-94C0EC7FFB2A@orcon.net.nz> <20120715212731.GG1986@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 11:54:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqi0B-0001Nt-TS
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 11:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845Ab2GPJx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 05:53:59 -0400
Received: from nctlincom02.orcon.net.nz ([60.234.4.75]:59997 "EHLO
	nctlincom02.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab2GPJx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 05:53:57 -0400
Received: from mx3.orcon.net.nz (mx3.orcon.net.nz [219.88.242.53])
	by nctlincom02.orcon.net.nz (8.14.3/8.14.3/Debian-9.4) with ESMTP id q6G9xxDW020992
	for <git@vger.kernel.org>; Mon, 16 Jul 2012 21:59:59 +1200
Received: from Debian-exim by mx3.orcon.net.nz with local (Exim 4.69)
	(envelope-from <mcree@orcon.net.nz>)
	id 1Sqi02-0004Bl-L2
	for git@vger.kernel.org; Mon, 16 Jul 2012 21:53:54 +1200
Received: from 60-234-221-162.bitstream.orcon.net.nz ([60.234.221.162] helo=[192.168.1.5])
	by mx3.orcon.net.nz with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mcree@orcon.net.nz>)
	id 1Sqi02-0004BJ-Bn; Mon, 16 Jul 2012 21:53:54 +1200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20120613 Icedove/3.0.11
In-Reply-To: <20120715212731.GG1986@burratino>
X-Enigmail-Version: 1.0.1
X-DSPAM-Check: by mx3.orcon.net.nz on Mon, 16 Jul 2012 21:53:54 +1200
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Mon Jul 16 21:53:54 2012
X-DSPAM-Confidence: 0.6524
X-DSPAM-Probability: 0.0000
X-Bayes-Prob: 0.0001 (Score 0, tokens from: @@RPTN, default)
X-Spam-Score: 0.00 () [Hold at 5.50] 
X-CanIt-Geo: ip=60.234.221.162; country=NZ; region=E7; city=Auckland; latitude=-36.8667; longitude=174.7667; http://maps.google.com/maps?q=-36.8667,174.7667&z=6
X-CanItPRO-Stream: base:default
X-Canit-Stats-ID: 05HyVXXUi - a900286e8408 - 20120716
X-Scanned-By: CanIt (www . roaringpenguin . com) on 172.16.100.175
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201498>

On 16/07/12 09:27, Jonathan Nieder wrote:
> Michael Cree wrote:
> 
>> On 15/07/2012, at 8:50 AM, Jonathan Nieder wrote:
> 
>>>                   gcc takes full advantage by converting the get_be32
>>> calls back to a load and bswap and producing a whole bunch of
>>> unaligned access traps.
>>
>> Alpha does not have a bswap (or similar) instruction.
> [...]
>>                                    .  If the pointer is unaligned
>> then two neighbouring aligned 32bit loads are required to ensure
>> that all four bytes are loaded.  If the pointer is aligned then a
>> single 32bit load gets all the four bytes.  Having never looked at
>> the generated assembler code, I nevertheless suspect that is the
>> guts of the optimisation --- the compiler can eliminate an access to
>> memory if it knows the pointer is aligned.
> 
> How about:
> 
> 	gcc takes full advantage by using a single 32-bit load,
> 	resulting in a whole bunch of unaligned access traps.

Yes, that's good.

I just checked the generated assembler and I am correct except that I
underestimated the number of memory accesses for the a priori known
unaligned data case.  It is actually doing four long-word memory access,
i.e. a memory access for each individual byte despite that it only needs
to do a maximum of two, so the optimisation for the a priori known
aligned data saves three memory accesses, not just one.  (And probably
also saves on a load-load replay trap on the EV6 and later CPUs, i.e., a
complete and very costly replay of the whole pipeline when the CPU
realises just in the nick of time that it has cocked up the
interrelationships between reordered load instructions.)

Cheers
Michael.
