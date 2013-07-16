From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Tue, 16 Jul 2013 04:06:53 +0200
Message-ID: <51E4AABD.9010701@web.de>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk> <51E2CE97.2040900@gmail.com> <7vppuja9ip.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 04:07:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyufi-0002Is-K6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 04:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200Ab3GPCHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 22:07:17 -0400
Received: from mout.web.de ([212.227.17.11]:50133 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908Ab3GPCHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 22:07:16 -0400
Received: from [192.168.1.18] ([68.61.5.157]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MOj14-1V2mXg0rgM-0063pd; Tue, 16 Jul 2013 04:06:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vppuja9ip.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V03:K0:FJHEbDDvPq5/baI+8tQoOhi9fLAAcA6OicMFu5NSLQCc2n8YdUJ
 JQe1bbLE8wCowm7MzUcg6QdFqKfGAobhyAcd9FYPCzN/h60Yse+GbypnGBTCoNvwvbKV11s
 tqKr0Ygv09gXCbx8/pwk/s3Omuoo31WMfG491sEQmv5FDqqBPx2o6lTD74JvCQOMhAzKxDF
 GrCDwToxfWPTzF/lre6YQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230535>

On 2013-07-15 21.49, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
> 
>>> In order to limit the adverse effects caused by this implementation,
>>> we provide a new "fast stat" interface, which allows us to use this
>>> only for interactions with the index (i.e. the cached stat data).
>>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> ---
>>
>> I've tested this on Cygwin 1.7 on WIndows 7 , comparing to the results
>> using your prior patch (removing the Cygwin specific lstat entirely)
>> and get the same results with both, so this seems ok from me.
>>
>> My comparison point was created by reverting your current patch from
>> pu, then reapplying your earlier patch on top, so the only difference
>> was which approach was used to address the stat functions.
>>
>> Caveats:
>> 1) I don't find any speed improvement of the current patch over the
>> previous one (the tests actually ran faster with the earlier patch,
>> though the difference was less than 1%).
Hm, measuring the time for the test suite is one thing,
did you measure the time of "git status" with and without the patch?

(I don't have my test system at hand, so I can test in a few days/weeks)

>> 2) I still question this whole approach, especially having this
>> non-POSIX compliant mode be the default. Running in this mode breaks
>> interoperability with Linux, but providing a Linux environment is the
>> *primary* goal of Cygwin.
> 
> Sounds like we are better off without this patch, and instead remove
> the "schizophrenic stat"?  I do not have a strong opinion either
> way, except that I tend to agree with your point 2) above.

My understanding is that we want both:
Introduction of fast_lstat() as phase 1,
and the removal of the "schizophrenic stat" in compat/cygwin.c
as phase 2. (or do I missunderstand something ?)


And yes, phase 3:
The day we have a both reliable and fast 
lstat() in cygwin, we can remove compat/cygwin.[ch]
