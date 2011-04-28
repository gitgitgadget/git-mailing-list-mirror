From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 14:17:51 +0200
Message-ID: <4DB95AEF.5060609@op5.se>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org> <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com> <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com> <4DB93D16.4000603@cs.helsinki.fi> <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com> <4DB941CD.2050403@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, Ingo Molnar <mingo@elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-15?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:18:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFQAU-0005nM-Im
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 14:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab1D1MR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 08:17:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42939 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab1D1MR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 08:17:57 -0400
Received: by fxm17 with SMTP id 17so1771613fxm.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 05:17:55 -0700 (PDT)
Received: by 10.223.23.212 with SMTP id s20mr1389220fab.120.1303993075442;
        Thu, 28 Apr 2011 05:17:55 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id g5sm571082faa.2.2011.04.28.05.17.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 05:17:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <4DB941CD.2050403@cs.helsinki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172359>

On 04/28/2011 12:30 PM, Pekka Enberg wrote:
> Hi,
> 
> On 4/28/11 1:19 PM, Erik Faye-Lund wrote:
>> On Thu, Apr 28, 2011 at 12:10 PM, Pekka Enberg<penberg@cs.helsinki.fi> wrote:
>>> On 4/28/11 12:50 PM, Erik Faye-Lund wrote:
>>>>>
>>>>> Alas, i have not seen these sha1 hash buffers being allocated unaligned
>>>>> (in my
>>>>> very limited testing). In which spots are they allocated unaligned?
>>>>
>>>> Like I said above, it can happen when allocated on the stack. But it
>>>> can also happen in malloc'ed structs, or in global variables. An array
>>>> is aligned to the size of it's base member type. But malloc does
>>>> worst-case-allignment, because it happens at run-time without
>>>> type-information.
>>>
>>> I'd be very surprised if malloc() did "worst case alignment" - that'd suck
>>> pretty badly from performance point of view.
>>
>> From POSIX (I don't have K&R at hand, but it's also specified there):
>> "The pointer returned if the allocation succeeds shall be suitably
>> aligned so that it may be assigned to a pointer to any type of object
>> and then used to access such an object in the space allocated (until
>> the space is explicitly freed or reallocated)."
>>
>> I put it in quotes because it's not the worst-case alignment you can
>> ever think of, but rather the worst case alignment of your CPUs
>> alignment requirements. This is 4 bytes for most CPUs.
> 
> That's just the minimum guarantee! Why do you think modern malloc() implementations don't try *very* hard to provide best possible alignment?
> 
>>> Stack allocation alignment is a harder issue but I doubt it's as bad as you
>>> make it out to be. On x86, for example, stack pointer is almost always 8 or
>>> 16 byte aligned with compilers whose writers have spent any time reading the
>>> Intel optimization manuals.
>>>
>>> So yes, your statements are absolutely correct but I strongly doubt it
>>> matters that much in practice unless you're using a really crappy
>>> compiler...
>>
>> I'm sorry, but the the fact of the matter is that we don't write code
>> for one compiler, we try to please many. Crappy compilers are very
>> much out there in the wild, and we have to deal with it. So, we can't
>> depend on char-arrays being aligned to 32-bytes. This code WILL break
>> on GCC for ARM, so it's not a theoretical issue at all. It will also
>> most likely break on GCC for x86 when optimizations are disabled.
> 
> Yes, ARM is a problem and I didn't try to claim otherwise. However, it's not "impossible to fix" as you say with memalign().
> 

#define is_aligned(ptr) (ptr & (sizeof(void *) - 1))
if (is_aligned(sha1) && is_aligned(sha2))
	return aligned_and_fast_hashcmp(sha1, sha2);

return memcmp(sha1, sha2, 20);

Problem solved for all architectures. Not as fast as the original
patch when we're lucky with alignment, but we cater to sucky
compilers and make the good ones go a lot faster. The really good
compilers that recognizes "is it aligned?" checks will optimize the
is_aligned() checks away or at least hint at the branch prediction
which path it should prefer.

Once again; Bear in mind that x86 style architectures with gcc is
almost certainly the most common combo for git users by a very wide
margin, so a 25-30% speedup for those users is pretty worthwhile.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
