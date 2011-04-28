From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 11:42:19 +0200
Message-ID: <4DB9367B.2050607@op5.se>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org> <20110428003541.GA18382@linux-mips.org> <20110428081817.GA29344@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-15?Q?Fr=E9d=E9ric?= =?ISO-8859-15?Q?_Weisbecker?= 
	<fweisbec@gmail.com>, Pekka Enberg <penberg@cs.helsinki.fi>
To: "Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:42:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNk3-0001N1-7r
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab1D1Jmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 05:42:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45269 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab1D1Jma (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:42:30 -0400
Received: by bwz15 with SMTP id 15so2136737bwz.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:42:29 -0700 (PDT)
Received: by 10.204.181.7 with SMTP id bw7mr3020806bkb.16.1303983749128;
        Thu, 28 Apr 2011 02:42:29 -0700 (PDT)
Received: from vix.int.op5.se (m83-186-240-35.cust.tele2.se [83.186.240.35])
        by mx.google.com with ESMTPS id f21sm910409bkd.11.2011.04.28.02.42.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 02:42:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <20110428081817.GA29344@pcpool00.mathematik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172337>

On 04/28/2011 10:18 AM, Bernhard R. Link wrote:
> * Ralf Baechle<ralf@linux-mips.org>  [110428 02:35]:
>> On Wed, Apr 27, 2011 at 04:32:12PM -0700, Junio C Hamano wrote:
>>
>>>> +static inline int is_null_sha1(const unsigned char *sha1)
>>>>   {
>>>> -	return memcmp(sha1, sha2, 20);
>>>> +	const unsigned long long *sha1_64 = (void *)sha1;
>>>> +	const unsigned int *sha1_32 = (void *)sha1;
>>>
>>> Can everybody do unaligned accesses just fine?
>>
>> Misaligned accesses cause exceptions on some architectures which then
>> are fixed up in software making these accesses _very_ slow.  You can
>> use __attribute__((packed)) to work around that but that will on the
>> affected architectures make gcc generate code pessimistically that is
>> slower than not using __attribute__((packed)) in case of proper
>> alignment.  And __attribute__((packed)) only works with GCC.
> 
> Even __attribute__((packed)) usually does not allow arbitrary aligned
> data, but can intruct the code to generate code to access code
> misaligned in a special way. (I have already seen code where thus
> accessing a properly aligned long caused a SIGBUS, because it was
> aligned because being in a misaligned packed struct).
> 
> In short: misaligning stuff works on x86, everywhere else it is disaster
> waiting to happen. (And people claiming compiler bugs or broken
> architectures, just because they do not know the basic rules of C).
> 

Given that the vast majority of user systems are x86 style ones, it's
probably worth using this patch on such systems and stick to a
partially unrolled byte-by-byte comparison that finishes early on
the rest of them. Properly pipelined, it will just mean that the early
return undoes the fetch steps for the 3-4 unrolled bytes that it
computes in advance, so if the diff comes in the first 10-12 bytes,
it will still be a win.

For bonus points, check if both bytestrings are equally (un)aligned
first and, if they are, half-Duff it out with a fallthrough switch
statement (without the while() loop) to compare byte-by-byte first
and then word-for-word on the rest of it. The setup and complexity
is probably not worth it for our meager 20-byte strings though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
