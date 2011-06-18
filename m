From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/3] help.c: Fix detection of custom merge strategy on
 cygwin
Date: Sat, 18 Jun 2011 17:57:05 +0100
Message-ID: <4DFCD8E1.3060102@ramsay1.demon.co.uk>
References: <4DFA65F8.5010806@ramsay1.demon.co.uk> <7v1uyth0t9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 18 21:08:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY0sa-0005w6-H9
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 21:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553Ab1FRTIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 15:08:13 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:35350 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752087Ab1FRTII (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2011 15:08:08 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1QY0qd-00016a-m1; Sat, 18 Jun 2011 19:06:24 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v1uyth0t9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175982>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> -#ifdef WIN32
>> +#if defined(WIN32) || defined(__CYGWIN__)
>> +#if defined(__CYGWIN__)
>> +if ((st.st_mode & S_IXUSR) == 0)
>> +#endif
>>  {	/* cannot trust the executable bit, peek into the file instead */
>>  	char buf[3] = { 0 };
>>  	int n;
> 
> This looks somewhat ugly.

;-) Yeah, Johannes Sixt had a similar complaint last time ...

> I guess we could make the inner #if/#endif slightly more readable by
> letting the compiler do more work, like this:
> 
> 	#if defined(WIN32) || defined(__CYGWIN__)
>         if (!defined(__CYGWIN__) || !(st.st_mode & S_IXUSR)) {
              ^^^^^^^^^
This would have to be something like:

    #if defined(__CYGWIN__)
    #define IS_CYGWIN 1
    #else
    #define IS_CYGWIN 0
    #endif
    if (!IS_CYGWIN || !(st.st_mode & S_IXUSR)) {

no?
>         	...
> 	}
>         #endif
> 
> I dunno.

The first version of this patch looked like:

-#ifdef WIN32
+#if defined(WIN32) || defined(__CYGWIN__)
+if ((st.st_mode & S_IXUSR) == 0)
 {	/* cannot trust the executable bit, peek into the file instead */

The idea being that the WIN32 builds (ie MinGW and MSVC) would never set
the executable bit, so this should only be false on cygwin when *not*
using the WIN32 l/stat implementation. So it should be safe ...

However, I got cold feet (and being lazy didn't want to test on MinGW and
MSVC) and decided on the more conservative approach.

Anyway, if you don't mind executing the "WIN32 code block" unnecessarily
on cygwin (I don't think it would be too expensive) then we could simply
reduce the patch to:

-#ifdef WIN32
+#if defined(WIN32) || defined(__CYGWIN__)
 {	/* cannot trust the executable bit, peek into the file instead */

(I've simply typed the above in my MUA, so not tested, obviously!)

This is exactly what Johannes proposed last year. :)

ATB,
Ramsay Jones
