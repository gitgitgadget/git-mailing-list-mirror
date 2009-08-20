From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Wed, 19 Aug 2009 21:45:40 -0500
Message-ID: <swB1Tb3ZWzkSggFnb4OlG99G0HKv1Bv9CEnk5hC0dseH5Wq60whE0w@cipher.nrlssc.navy.mil>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com> <4A8AA511.1060205@gmail.com> <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com> <7v4os5gs0p.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908181147510.6044@xanadu.home> <alpine.LFD.2.00.0908181240400.6044@xanadu.home> <7v1vn9f4mz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908181357330.6044@xanadu.home> <7vk511dk11.fsf@alter.siamese.dyndns.org> <XJM0H8pTiCJpryS-arPltHCHwsm0djqVixaH1NwBqT2pci2MA9karw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0908192201180.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 20 04:46:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdxft-0001aO-RF
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 04:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbZHTCqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 22:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbZHTCqk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 22:46:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33533 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbZHTCqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 22:46:39 -0400
Received: by mail.nrlssc.navy.mil id n7K2jf1C003374; Wed, 19 Aug 2009 21:45:41 -0500
In-Reply-To: <alpine.LFD.2.00.0908192201180.6044@xanadu.home>
X-OriginalArrivalTime: 20 Aug 2009 02:45:41.0064 (UTC) FILETIME=[4E697C80:01CA2140]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126606>

Nicolas Pitre wrote:
> On Tue, 18 Aug 2009, Brandon Casey wrote:
> 
>> The SUNWspro compiler doesn't set __i386__.  Instead it sets __i386, and
>> I think __x86_64 and __amd64 where appropriate.  So, compilation with
>> the SUNWspro compiler on x86 is currently unaffected by these changes and
>> falls back to the generic routines.
>>
>> It seems that v5.10 of the compiler can grok both the __asm__ statements
>> and the ({...}) naked block notation and passes all of the tests when the
>> block_sha1 code is modified to add defined(__i386) to each of the macro
>> statements.
>>
>> The 5.8 version cannot grok the naked block, and requires spelling __asm__
>> as __asm for inline assembly.  Even then it appears that there is a bug in
>> the assembly that is produced (a google search told me so), so the assembly
>> code does not successfully compile.
>>
>> I haven't had much time to think about how or whether to address this.
>>
>> Adding something like the following would get ugly real quick:
>>
>>    (defined(__i386) && defined(__SUNPRO_C) && (__SUNPRO_C >= 0x5100))
> 
> I think the best solution in this case might simply be to add something 
> like this somewhere at the top of git-compat-util.h after the system 
> includes:
> 
> /*
>  * The SUNWspro compiler uses different symbols than gcc.
>  * Let's standardize on the gcc flavor.
>  */
> #if defined(__i386) && !defined(__i386__)
> #define __i386__
> #endif
> #if (defined(__x86_64) || defined(__amd64)) && !defined(__x86_64__)
> #define __x86_64__
> #endif

Yes, I had this idea too.

> /*
>  * SUNWspro from version 5.10 supports gcc extensions such as gcc's 
>  * statement expressions and extended inline asm, so let's pretend...
>  */
> #if defined(__SUNPRO_C) && (__SUNPRO_C >= 0x5100))
> #define __GNUC__
> #endif

I hadn't thought of this.  I'll test to make sure the other statements
that are protected by ifdef __GNUC__ work correctly with SUNWspro v5.10.

-brandon
