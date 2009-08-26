From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (Aug 2009, #04; Sun, 23)
Date: Wed, 26 Aug 2009 18:07:48 -0500
Message-ID: <3q83-66LnwhagKVYq4njQoZm22YUiZbyweZ4RhKMzZWWgix28tZEgA@cipher.nrlssc.navy.mil>
References: <7v1vn2qb29.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908232117460.6044@xanadu.home> <YE4QMh4rA1r2X3ZG5TvGJZspm0UdCWyP-r6KFthp8PuFewAhHPJ3GQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 01:08:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgRbD-0002n3-Oj
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 01:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbZHZXIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 19:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbZHZXIF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 19:08:05 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36311 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZHZXIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 19:08:04 -0400
Received: by mail.nrlssc.navy.mil id n7QN7nf5023682; Wed, 26 Aug 2009 18:07:49 -0500
In-Reply-To: <YE4QMh4rA1r2X3ZG5TvGJZspm0UdCWyP-r6KFthp8PuFewAhHPJ3GQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 26 Aug 2009 23:07:48.0491 (UTC) FILETIME=[077165B0:01CA26A2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127119>

Brandon Casey wrote:
> Nicolas Pitre wrote:
>> On Sun, 23 Aug 2009, Junio C Hamano wrote:
>>
>>> * lt/block-sha1 (2009-08-17) 4 commits
>>>   (merged to 'next' on 2009-08-18 at 67a1ce8)
>>>  + remove ARM and Mozilla SHA1 implementations
>>>  + block-sha1: guard gcc extensions with __GNUC__
>>>  + make sure byte swapping is optimal for git
>>>  + block-sha1: make the size member first in the context struct
>>>
>>> Finishing touches ;-)  There were a few Solaris portability patches
>>> floated around that I didn't pick up, waiting for them to finalize.
>> Those would be described better as Solaris _optimization_ patches.  The 
>> code is already fully portable as it is, except not necessarily optimal 
>> in some cases.
> 
> Nicolas is right, the code compiles and executes correctly on Solaris as-is.
> 
> Here is the state of the two unsubmitted optimization patches:
> 
>   1) Change things like __i386__ to __i386 since GCC defines both, but
>      SUNWspro only defines __i386.
> 
>      This works correctly in my testing.  I'm assuming that a test for
>      __amd64 is not necessary and expect that __x86_64 is set whenever
>      __amd64 is set.
> 
>   2) Set __GNUC__ on SUNWspro v5.10 and up.
> 
>      This compiles correctly and passes the test suite, but produces
>      warnings for __attribute__'s that sun's compiler has not implemented.
>      This produces a very noisy compile.
> 
> I've wanted to do some performance testing to see whether this actually
> produces an _improvement_.  I'll try today.

Ok, I've done some testing.

I've compiled on two Solaris 5.10 x86 boxes.  One has Sun compiler 5.10,
the other has version 5.8.  The 5.10 version supports GCC inline assembler,
statement expressions, and __builtin_x functions.  I timed how long
'git fsck --full HEAD' took on the git repository (best of three runs at
each stage).

It seems that #1 provides almost 1% improvement when using Sun compiler
v5.10, but a 2.5% regression on compiler v5.8.  #2 (implemented using
Junio's suggestion, not by setting __GNUC__), which additionally enables
the fast htonl/ntohl and the rol/ror assembly in block-sha1 when using
the v5.10 compiler, produces a performance regression.  I tried compiling
with '-fast -native', and also with just '-O', and both were slower with
the addition of part #2.

If this is the only data point for non-GNU compilers on x86, and since
there was only <1% improvement with the v5.10 compiler, I'm inclined
to say that we leave the series as it is and don't apply either change.

-brandon
