From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC PATCH 2/2] MSVC: Fix an "incompatible pointer types" compiler
 warning
Date: Fri, 04 Dec 2009 22:50:33 +0000
Message-ID: <4B199239.2050709@ramsay1.demon.co.uk>
References: <4B1806FB.2050401@ramsay1.demon.co.uk> <4B18BDE7.3050004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 00:16:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGhNj-0004S8-OM
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 00:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbZLDXPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 18:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbZLDXPn
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 18:15:43 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:42898 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755431AbZLDXPn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 18:15:43 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1NGhNM-0002jS-eE; Fri, 04 Dec 2009 23:15:49 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4B18BDE7.3050004@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134585>

Johannes Sixt wrote:
> Ramsay Jones schrieb:
>> In order to avoid the compiler warning, we use the appropriate
>> structure type names (and function names) from the msvc headers.
>> This allows us to compile with -D_USE_32BIT_TIME_T if necessary.
> 
> "if necessary"? Who defines when -D_USE_32BIT_TIME_T is necessary?

If I'm reading the msdn documentation correctly, from msvc 2005 onwards,
the time_t type is 64-bits by default. In order to support "legacy apps"
which break with a 64-bit time_t, the _USE_32BIT_TIME_T macro may be set
in the makefile/project-file to enable the old 32-bit time_t type.
(The headers contain a lot of appropriately defined "static __inline"
functions which call 32- or 64-bit versions of the main time related
functions; eg. mktime() will call either _mktime64() or _mktime32()).

Note that 64-bit windows does not support a 32-bit time_t.

So, the "if necessary" means: if git is broken with a 64-bit time_t and it
may take some time to fix it (or we can defer fixing it for a long time).
And the "Who" is: er... well "us" ;-)

>> Also, I added the "&& defined(_stati64)" in the hope that it would work with
>> older msvc/sdk versions.
> 
> I think that this is an unnecessary complication and I did wonder why you
> added this extra check. Anybody doing some serious development with MS's
> tools is using VS2005 at least.

Great! So, I will drop that part of the patch.

>                                  But isn't the .vcproj file made for VS2008
> anyway?

I don't know - I don't use it. (Marius?)

>> The reason for the RFC is:
>>
>>     - maybe we don't need the flexibility of compiling with/without the 32-bit
>>       time_t definition (which *works* BTW) and can revert to the original patch?
> 
> Indeed I'm wondering why we should cater for 64 bit time_t. It is an
> unnessary complication as long as MinGW gcc supports only 32 bit time_t
> and the old MSVCRT.DLL.

Ah, so you want to add -D_USE_32BIT_TIME_T to the Makefile?
Do we care about 64-bit Windows?

> 
>>     - I've tried to be careful not to break the MinGW build, but again I can't
>>       test it. (I will be shocked if I have ;-)
> 
> It compiles without warnings and doesn't break t/t[01]* ;)

Thanks! v2 of patch comming soon.

ATB,
Ramsay Jones
