From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 13:30:37 +0300
Message-ID: <4DB941CD.2050403@cs.helsinki.fi>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org> <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com> <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com> <4DB93D16.4000603@cs.helsinki.fi> <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 28 12:30:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFOUf-0000AA-0l
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 12:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab1D1Kaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 06:30:39 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:43788 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab1D1Kaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 06:30:39 -0400
Received: from l227.local ([192.100.124.156])
  (AUTH: PLAIN penberg, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Thu, 28 Apr 2011 13:30:37 +0300
  id 0008D4E0.4DB941CD.00006004
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172347>

Hi,

On 4/28/11 1:19 PM, Erik Faye-Lund wrote:
> On Thu, Apr 28, 2011 at 12:10 PM, Pekka Enberg<penberg@cs.helsinki.fi>  wrote:
>> On 4/28/11 12:50 PM, Erik Faye-Lund wrote:
>>>>
>>>> Alas, i have not seen these sha1 hash buffers being allocated unaligned
>>>> (in my
>>>> very limited testing). In which spots are they allocated unaligned?
>>>
>>> Like I said above, it can happen when allocated on the stack. But it
>>> can also happen in malloc'ed structs, or in global variables. An array
>>> is aligned to the size of it's base member type. But malloc does
>>> worst-case-allignment, because it happens at run-time without
>>> type-information.
>>
>> I'd be very surprised if malloc() did "worst case alignment" - that'd suck
>> pretty badly from performance point of view.
>
>  From POSIX (I don't have K&R at hand, but it's also specified there):
> "The pointer returned if the allocation succeeds shall be suitably
> aligned so that it may be assigned to a pointer to any type of object
> and then used to access such an object in the space allocated (until
> the space is explicitly freed or reallocated)."
>
> I put it in quotes because it's not the worst-case alignment you can
> ever think of, but rather the worst case alignment of your CPUs
> alignment requirements. This is 4 bytes for most CPUs.

That's just the minimum guarantee! Why do you think modern malloc() 
implementations don't try *very* hard to provide best possible alignment?

>> Stack allocation alignment is a harder issue but I doubt it's as bad as you
>> make it out to be. On x86, for example, stack pointer is almost always 8 or
>> 16 byte aligned with compilers whose writers have spent any time reading the
>> Intel optimization manuals.
>>
>> So yes, your statements are absolutely correct but I strongly doubt it
>> matters that much in practice unless you're using a really crappy
>> compiler...
>
> I'm sorry, but the the fact of the matter is that we don't write code
> for one compiler, we try to please many. Crappy compilers are very
> much out there in the wild, and we have to deal with it. So, we can't
> depend on char-arrays being aligned to 32-bytes. This code WILL break
> on GCC for ARM, so it's not a theoretical issue at all. It will also
> most likely break on GCC for x86 when optimizations are disabled.

Yes, ARM is a problem and I didn't try to claim otherwise. However, it's 
not "impossible to fix" as you say with memalign().

But my comment was mostly about your claim that "we have no guarantee 
that the SHA-1s are aligned on x86 either, and unaligned accesses are 
slow on x86" which only matters in practice if you have a crappy 
compiler. And arguing for performance if you don't have a reasonable 
compiler is pretty uninteresting.

			Pekka
