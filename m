From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really menas XPG6
Date: Thu, 28 May 2009 13:37:09 -0700
Message-ID: <7viqjlge16.fsf@alter.siamese.dyndns.org>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com>
	<1243106697-6424-2-git-send-email-gitster@pobox.com>
	<WLNdjYtfqcg2bT6yOBtAykIqOBTeSLRUdlB6-sTM2KzTjwOmzN3fLg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 28 22:37:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9mMC-00067k-Cf
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 22:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764353AbZE1UhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 16:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764114AbZE1UhJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 16:37:09 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48224 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759820AbZE1UhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 16:37:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090528203709.JWUO20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 28 May 2009 16:37:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id x8d91b00F4aMwMQ038d9kh; Thu, 28 May 2009 16:37:09 -0400
X-Authority-Analysis: v=1.0 c=1 a=UYOYdknvHTQA:10 a=aXQZQtK9SsAA:10
 a=DujndSHeXfpZKyUntsoA:9 a=ncFZiLJFtHVnYd8ezBsA:7
 a=gfvOW5zgkHY_w-CYWvdSpw0uyOwA:4
X-CM-Score: 0.00
In-Reply-To: <WLNdjYtfqcg2bT6yOBtAykIqOBTeSLRUdlB6-sTM2KzTjwOmzN3fLg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu\, 28 May 2009 11\:46\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120226>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> So we either require compiling with a c99 compiler (by ensuring that
> _XPG6 is set) or exclude compiling with a c99 compiler on sun (by
> ensuring that _XPG6 is not set).  Actually, this would only affect Solaris
> versions which support XPG6.  Solaris 11 and 10 do.  I don't know about
> Solaris 9 and 8.  Solaris 7 doesn't.
>
> Which do we want to do?

If possible, both ;-), because people would have or want to use different
compilers.

I use "gcc -std=c99" on all platforms I compile git on (for details see
"Make" in the 'todo' branch; I have a checkout of the todo branch at Meta/
and say "Meta/Make --pedantic" from the toplevel), and that is how I
noticed this breakage on OpenSolaris 08.11 (it identifies itself as 5.11,
so presumably it falls into "Solaris 11" category you cited above?)

>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index c7cf2d5..4236647 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -41,8 +41,10 @@
>>  
>>  #if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
>>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */

Judging from their header files, I guess Sun's attitude is incompatible
with the above comment for _XOPEN_SOURCE.  We say "... need 500" and set
it to 600 because we merely mean "need to be at least 500" by "need 500",
but Sun wants us to be very precise.  So instead of saying __sun__, we
could do something more explicit with a huge comment...

	#if !defined(__APPLE__) ...
        # define _XOPEN_SOURCE 600
        /*
         * On Solaris, when _XOPEN_EXTENDED is set, its header file
         * forces the programs to be XPG4v2, defeating the _XOPEN_SOURCE
         * setting we just made to say we are XPG6.  Also on Solaris,
         * XPG6 programs must be compiled with a c99 compiler, while
         * non XPG6 programs must be compiled with a pre-c99 compiler.
         */
        # if defined(__sun__) && !(__STDC_VERSION__ - 0 >= 199901L)
        # define _XOPEN_EXTENDED 1 /* AIX 5.3L wants this */
        # endif
	#endif

We might want to flatten this a bit more to special case Solaris, which
might make it easier to maintain, e.g.

	#if defined(__sun__)
        # ... whatever _XOPEN_SOURCE and _XOPEN_EXTENDED magic
        # ... Solaris wants
        #elif !defined(__APPLE__) && ...
        # ... existing code
        #endif
