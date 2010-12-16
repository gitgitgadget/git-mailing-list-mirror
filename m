From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 08/14] help.c: Fix detection of custom merge strategy
 on cygwin
Date: Thu, 16 Dec 2010 21:03:03 +0000
Message-ID: <4D0A7E87.3020203@ramsay1.demon.co.uk>
References: <4D07B786.2060602@ramsay1.demon.co.uk> <AANLkTimt3w9GVCXa_n1_HXivyRmnRyUhhdSArrHOT6fs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, j6t@kdbg.org,
	jrnieder@gmail.com, vmiklos@frugalware.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 16 23:41:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMWA-0000cx-8K
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab0LPWll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:41:41 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:65267 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608Ab0LPWlk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 17:41:40 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PTMW3-00044J-oS; Thu, 16 Dec 2010 22:41:40 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <AANLkTimt3w9GVCXa_n1_HXivyRmnRyUhhdSArrHOT6fs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163832>

Erik Faye-Lund wrote:
>> diff --git a/help.c b/help.c
>> index 7f4928e..eabadc9 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -126,7 +126,10 @@ static int is_executable(const char *name)
>>            !S_ISREG(st.st_mode))
>>                return 0;
>>
>> -#ifdef WIN32
>> +#if defined(WIN32) || defined(__CYGWIN__)
>> +#if defined(__CYGWIN__)
>> +if ((st.st_mode & S_IXUSR) == 0)
>> +#endif
> 
> Perhaps the first check should simply be changed to check for _WIN32
> instead of WIN32? IIRC _WIN32 is set on Cygwin, but I could be
> mistaken...

No, neither WIN32 or _WIN32 will be defined here (and they should not be).
It's actually quite tricky, particularly when #including <windows.h>, viz:

    $ cat -n test.c
     1	#include <stdio.h>
     2	
     3	#ifdef IW
     4	# include <windows.h>
     5	#endif
     6	
     7	int main(int argc, char *argv[])
     8	{
     9	#ifdef WIN32
    10		printf("WIN32 ");
    11	#endif
    12	#ifdef _WIN32
    13		printf("_WIN32 ");
    14	#endif
    15	#ifdef __CYGWIN__
    16		printf("__CYGWIN__ ");
    17	#endif
    18	#ifdef __MINGW32__
    19		printf("__MINGW32__ ");
    20	#endif
    21		printf("\n");
    22		return 0;
    23	}

    $ gcc -o test test.c
    $ ./test
    __CYGWIN__ 

    $ gcc -o test -DIW test.c
    $ ./test
    WIN32 _WIN32 __CYGWIN__ 

    $ gcc -o test -mno-cygwin test.c
    $ ./test
    WIN32 _WIN32 __MINGW32__ 

ATB,
Ramsay Jones
