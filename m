From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: MSVC build broken (on cygwin)
Date: Sat, 03 Oct 2009 21:06:17 +0100
Message-ID: <4AC7AEB9.3030404@ramsay1.demon.co.uk>
References: <4AC4E2C2.6030509@ramsay1.demon.co.uk> <4AC5B4AE.5070307@gmail.com> <81b0412b0910020123j13c74497w874e301c38cddec9@mail.gmail.com> <4AC5BEA6.5000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 22:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuB0i-0001sL-8x
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 22:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141AbZJCUKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 16:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757134AbZJCUKM
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 16:10:12 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:62010 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757118AbZJCUKL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Oct 2009 16:10:11 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1MuAv2-0004X9-ie; Sat, 03 Oct 2009 20:09:29 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4AC5BEA6.5000102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129499>

Marius Storm-Olsen wrote:
> Apparently, nothing is broken in neither Cygwin, MinGW or MSVC after 
> Ramsays whitespace fix, but I'm sure it might get hairy later, if/when 
> we get more Windows contributions. Keeping the guards right could get 
> tricky.
> 

Right! Thus my earlier nervousness. :P

> So, something like this maybe, in git-compat-util.h:
> 
> #if defined(__MINGW32__) || defined(_MSC_VER)
> #  defined API_WIN32
> #  defined OS_WINDOWS
> #elif defined(__CYGWIN__)
> #  defined API_POSIX
> #  defined OS_WINDOWS
> #else
> #  defined API_POSIX
> #endif
> 

This is a much better idea.

Note that I also have Digital-Mars C/C++ 8.50, Open Watcom C/C++ 1.8
and lcc 4.2 installed. So, lets add to our previous tests:

Digital-Mars:

    $ dmc hello.c
    link hello,,,user32+kernel32/noi;

    $ ./hello.exe
    _WIN32
    WIN32
    Hello world
    $ 

    $ dmc -DIW_H hello.c
    link hello,,,user32+kernel32/noi;

    $ ./hello.exe
    _WIN32
    WIN32
    Hello world
    $ 

    $ dmc -DWIN32-D_CONSOLE hello.c
    Command line error: bad -D switch, need '=' after macro name--- errorlevel 1
    $ 

Open Watcom:

    $ wcl386 hello.c
    [...compiler output snipped...]
    $ ./hello.exe
    _WIN32
    Hello world
    $ 

    $ wcl386 -DIW_H hello.c
    [...compiler output snipped...]
    $ ./hello.exe
    _WIN32
    Hello world
    $ 

    $ wcl386 -DWIN32-D_CONSOLE hello.c
    Open Watcom C/C++32 Compile and Link Utility Version 1.8
    Portions Copyright (c) 1988-2002 Sybase, Inc. All Rights Reserved.
    Source code is available under the Sybase Open Watcom Public License.
    See http://www.openwatcom.org/ for details.
           wcc386 hello.c  -DWIN32 -D_CONSOLE
    Open Watcom C32 Optimizing Compiler Version 1.8
    Portions Copyright (c) 1984-2002 Sybase, Inc. All Rights Reserved.
    Source code is available under the Sybase Open Watcom Public License.
    See http://www.openwatcom.org/ for details.
    hello.c: 25 lines, included 757, 0 warnings, 0 errors
    Code size: 52
           wlink @__wcl__.lnk
    Open Watcom Linker Version 1.8
    Portions Copyright (c) 1985-2002 Sybase, Inc. All Rights Reserved.
    Source code is available under the Sybase Open Watcom Public License.
    See http://www.openwatcom.org/ for details.
    loading object files
    searching libraries
    creating a Windows NT character-mode executable
    $ ./hello.exe
    _WIN32
    WIN32
    Hello world
    $ 
[Note: I didn't snip the compiler output here so that you could see that
the Watcom driver program had "fixed" the malformed -Define and passed
it as two separate parameters to the compiler proper!]

Also note that Open Watcom is currently being ported to Linux, I *think*
Digital-Mars already has a Linux version and lcc does have a Linux
version. However, I think it's reasonably safe to assume we won't see a
Linux version of msvc.

So, I think something like this in git-compat-util.h:

#if defined(_WIN32) && !defined(__CYGWIN__)
# define WIN32_API
# define WIN32_LEAN_AND_MEAN
# include <winsock2.h>
# include <windows.h>
#endif

and replace all #if(n)def WIN32|_WIN32 with #if(n)def WIN32_API.

The only use of the <windows.h> header by cygwin can be moved
into compat/cygwin.c. (I don't much like cygwin using the
Win32 API anyway!)

> So, then we can use #ifdef API_WIN32 when using the Win32 API is the 
> only option/preferred for MinGW or MSVC; and use #ifdef OS_WINDOWS 
> when there are things that affect all the Windows builds.
> 
> Opinions?

see above. I don't think OS_WINDOWS is necessary.

Anyway, *something* like this would be an improvement.

ATB,
Ramsay Jones
