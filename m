From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 04/14] msvc: Fix macro redefinition warnings
Date: Wed, 08 Dec 2010 00:05:12 +0000
Message-ID: <4CFECBB8.2070900@ramsay1.demon.co.uk>
References: <4CFA8FE3.1050009@ramsay1.demon.co.uk> <201012042204.52002.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, sschuberth@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 08 01:30:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ7vb-0007Sm-0k
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 01:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab0LHAad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 19:30:33 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:52072 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754660Ab0LHAad (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 19:30:33 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PQ7vE-0000dK-e7; Wed, 08 Dec 2010 00:30:32 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201012042204.52002.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163153>

Johannes Sixt wrote:
> On Samstag, 4. Dezember 2010, Ramsay Jones wrote:
>> --- a/compat/mingw.h
>> +++ b/compat/mingw.h
>> @@ -14,12 +14,6 @@ typedef int socklen_t;
>>  #define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
>>  #define S_ISSOCK(x) 0
>>
>> -#ifndef _STAT_H_
> 
> Instead of removing the macros, wouldn't we be much safer with just
> 
> #ifndef S_IWUSR
> 
> ? ...

Er... no.

Commit 4091bfc (which added these macros) does not provide any motivation
for the change, and I'm having a hard time trying to imagine a useful
purpose for this part of the commit. (I'm not saying there isn't one - just
that I can't see it :-P )

On MinGW, the <sys/stat.h> header is always included prior to this header,
so the _STAT_H_ include guard is always defined, so these macros will
never be defined (which is a *good* thing; have you looked at the definitions).
Trying to use compat/mingw.h without having first included <sys/stat.h> is
not going to work!

Also, note that the include guard for the msvc <sys/stat.h> file is _INC_STAT.
So, on msvc, including <sys/stat.h> does not suppress these macro definitions
(Not that it actually matters here, because it doesn't define these symbols
anyway!). Which is why msvc issues these macro redefinition warnings (they
conflict with the definitions in compat/vcbuild/include/unistd.h). We most
definitely don't want to use the macros in compat/mingw.h on msvc. (They are
positively *wrong*)

[Hmmm, I've just noticed that the msvc compat header is missing a definition of
the _S_IRWXU macro!]

So, once again, I see no reason to keep them ... Unless you know otherwise.

ATB,
Ramsay Jones
