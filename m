From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Tue, 22 Jan 2013 18:31:36 +0000
Message-ID: <50FEDB08.6030901@ramsay1.demon.co.uk>
References: <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black> <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk> <20130120101007.GD16339@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 19:41:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txin8-000074-3I
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 19:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab3AVSl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 13:41:28 -0500
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:47187 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab3AVSl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 13:41:27 -0500
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id E96E5A0C084;
	Tue, 22 Jan 2013 18:41:25 +0000 (GMT)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 7893FA0C081;	Tue, 22 Jan 2013 18:41:24 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Tue, 22 Jan 2013 18:41:20 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130120101007.GD16339@elie.Belkin>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214244>

Jonathan Nieder wrote:
> Ramsay Jones wrote:
> 
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -85,12 +85,6 @@
>>  #define _NETBSD_SOURCE 1
>>  #define _SGI_SOURCE 1
>>  
>> -#ifdef WIN32 /* Both MinGW and MSVC */
>> -#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
>> -#include <winsock2.h>
>> -#include <windows.h>
>> -#endif
> 
> So, do I understand correctly that the above conditional should be
> something like
> 
>  #if defined(WIN32) && !defined(__CYGWIN__)
> 
> to allow dropping the CYGWIN_V15_WIN32API setting?

Yes, replacing the git-compat-util.h hunk above with:

    diff --git a/git-compat-util.h b/git-compat-util.h
    index e5a4b74..a38ae8d 100644
    --- a/git-compat-util.h
    +++ b/git-compat-util.h
    @@ -85,7 +85,7 @@
     #define _NETBSD_SOURCE 1
     #define _SGI_SOURCE 1
 
    -#ifdef WIN32 /* Both MinGW and MSVC */
    +#if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
     #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
     #include <winsock2.h>
     #include <windows.h>

will also compile on cygwin 1.5.x

> "defined(WIN32)" is used throughout git to mean "win32 and not
> cygwin", so if I understand correctly we would either need to do

Hmm ... I remember being *very* nervous of commit 435bdf8c ("Make
usage of windows.h lean and mean", 16-09-2009) exactly because it
makes the code (on cygwin) much more fragile with respect to header
include order. ;-)

As I have mentioned here before, the claim that "WIN32 is not defined
on cygwin" is simply nonsense - it depends on if/when certain header
files are included. For example, *as soon as* you include <windows.h>
(and, I suspect, many other win32 headers) then "defined(WIN32)"
is true.

Note that commit 380a4d92 ("Update cygwin.c for new mingw-64 win32 api
headers", 11-11-2012) swaps the include order for the win32.h and
git-compat-util.h header files. [I don't know the details, Mark didn't
elaborate, but it is clearly an include order problem on cygwin 1.7.x :-D ]
This causes compilation errors on cygwin 1.5.x, exactly because win32.h
includes <windows.h>, which defines WIN32, which then leads to
git-compat-util.h including <winsock2.h>.

>  #if defined(WIN32) && defined(__CYGWIN__)
>  # undef WIN32
>  #endif

Hmm, except when you want it defined on cygwin, of course ... ;-)

> Thanks for investigating.

No problem.

I've included the updated patch below, just for completeness.

HTH

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] cygwin: Remove the CYGWIN_V15_WIN32API config


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile          | 7 -------
 compat/cygwin.c   | 5 -----
 config.mak.uname  | 1 -
 git-compat-util.h | 2 +-
 4 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 1b30d7b..1c84f68 100644
--- a/Makefile
+++ b/Makefile
@@ -281,10 +281,6 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
 #
-# Define CYGWIN_V15_WIN32API if you are using Cygwin v1.7.x but are not
-# using the current w32api packages. The recommended approach, however,
-# is to update your installation if compilation errors occur.
-#
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
 # user.
 #
@@ -1402,9 +1398,6 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 endif
-ifdef CYGWIN_V15_WIN32API
-	COMPAT_CFLAGS += -DCYGWIN_V15_WIN32API
-endif
 
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS += -Icompat/nedmalloc
diff --git a/compat/cygwin.c b/compat/cygwin.c
index 5428858..0a9aa6d 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,13 +1,8 @@
 #define WIN32_LEAN_AND_MEAN
-#ifdef CYGWIN_V15_WIN32API
-#include "../git-compat-util.h"
-#include "win32.h"
-#else
 #include <sys/stat.h>
 #include <sys/errno.h>
 #include "win32.h"
 #include "../git-compat-util.h"
-#endif
 #include "../cache.h" /* to read configuration */
 
 static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
diff --git a/config.mak.uname b/config.mak.uname
index bea34f0..5e493c9 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -158,7 +158,6 @@ ifeq ($(uname_O),Cygwin)
 		NO_SYMLINK_HEAD = YesPlease
 		NO_IPV6 = YesPlease
 		OLD_ICONV = UnfortunatelyYes
-		CYGWIN_V15_WIN32API = YesPlease
 	endif
 	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index e5a4b74..a38ae8d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,7 +85,7 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
-#ifdef WIN32 /* Both MinGW and MSVC */
+#if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
-- 
1.8.1
