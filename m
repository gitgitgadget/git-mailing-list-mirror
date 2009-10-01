From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: MSVC build broken (on cygwin)
Date: Thu, 01 Oct 2009 18:11:30 +0100
Message-ID: <4AC4E2C2.6030509@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: mstormo@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 01 19:16:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtPGQ-00057G-Ty
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 19:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbZJARQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 13:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755866AbZJARQF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 13:16:05 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:63527 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755885AbZJARQE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Oct 2009 13:16:04 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1MtPG8-0003aa-lH; Thu, 01 Oct 2009 17:16:07 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129403>

Hi Marius,

I know that I'm somewhat late to comment on your recent MSVC
build patches, but I was busy at the time; better late than
never... maybe ;-)

While the patches were traversing the list, I was feeling
somewhat nervous about the effect of the patches on the
cygwin build; in fact I remember thinking that they had
*probably* broken the build. But I was busy...

Well I finally found time, yesterday, to take a closer look.
I spent 10-15 minutes squinting at the code in order to
convince myself that you had in fact *not* broken the cygwin
build. :)

(which I already suspected, since they were committed some time 
ago and nobody else had screamed!)

[Note: I was mainly concerned about commit 435bdf8 and, to a
lesser degree, commit 71064e3]

I'm sure you are probably aware of the following, but for the
benefit of others, the following session on cygwin may help to
explain my nervousness:

    $ cat -n hello.c
         1	#include <stdio.h>
         2	
         3	#ifdef IW_H
         4	# include <windows.h>
         5	#endif
         6	
         7	int main(int argc, char *argv[])
         8	{
         9	
        10	#ifdef __CYGWIN__
        11		printf("__CYGWIN__\n");
        12	#endif
        13	#ifdef __MINGW32__
        14		printf("__MINGW32__\n");
        15	#endif
        16	#ifdef _WIN32
        17		printf("_WIN32\n");
        18	#endif
        19	#ifdef WIN32
        20		printf("WIN32\n");
        21	#endif
        22		printf("Hello world\n");
        23		return 0;
        24	}
        25	
    $ 

    $ gcc hello.c
    $ ./a.exe
    __CYGWIN__
    Hello world
    $ 

    $ gcc -DIW_H hello.c
    $ ./a.exe
    __CYGWIN__
    _WIN32
    WIN32
    Hello world
    $ 

    $ gcc -mno-cygwin hello.c
    $ ./a.exe
    __MINGW32__
    _WIN32
    WIN32
    Hello world
    $ 
[Note: I don't know if the above is exactly equivalent to an
MSYS/Mingw-gcc installation, but it does, at least, not link with
the cygwin dll]

However, while squinting at the code, I noticed what I think is a
problem with the MSVC build on cygwin. Viz:

    $ cl hello.c
    [...compiler output snipped...]
    $ ./hello.exe
    _WIN32
    Hello world
    $ 

    $ cl -DIW_H hello.c
    [...compiler output snipped...]
    $ ./hello.exe
    _WIN32
    WIN32
    Hello world
    $ 

    $ cl -DWIN32-D_CONSOLE hello.c
    [...compiler output snipped...]
    $ ./hello.exe
    _WIN32
    Hello world
    $ 

Note the last compiler command line above. As part of commit 164a5e3,
the Makefile (on line 917) sets the BASIC_CFLAGS macro to contain the
above string. I had expected the compiler to complain about this
malformed -Define (gcc does), but it remains quiet and seems to be
ignoring the parameter entirely. So I tried upping the warning level:

    $ cl -W4 -DWIN32-D_CONSOLE hello.c
    Microsoft (R) 32-bit C/C++ Optimizing Compiler Version 15.00.30729.01 for 80x86
    Copyright (C) Microsoft Corporation.  All rights reserved.

    hello.c
    hello.c(7) : warning C4100: 'argv' : unreferenced formal parameter
    hello.c(7) : warning C4100: 'argc' : unreferenced formal parameter
    Microsoft (R) Incremental Linker Version 9.00.30729.01
    Copyright (C) Microsoft Corporation.  All rights reserved.

    /out:hello.exe 
    hello.obj 
    $ ./hello.exe
    _WIN32
    Hello world
    $ 

[Note: I also tried the above using the "Visual Studio 2008 command
prompt" with exactly the same result]

So, at least on cygwin with the version of msvc I'm using (see above),
the build should be broken; as a quick check I made the following
change (on top of commit f5c3178):

-- >8 --
diff --git a/git-compat-util.h b/git-compat-util.h
index 8d6e29c..72275a3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -69,6 +69,8 @@
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
+#else
+#error "WIN32 *not* defined in MSVC build"
 #endif
 
 #include <unistd.h>
-- >8 --

and then tried to build using msvc, thus:

    $ make MSVC=1
    GIT_VERSION = 1.6.5.rc1.37.gf5c31.dirty
        * new build flags or prefix
        CC fast-import.o
    fast-import.c
    c:\cygwin\home\ramsay\git\git-compat-util.h(73) : fatal error C1189: #error :  "WIN32 *not* defined in MSVC build"
    [...lots of similar output (940 lines) snipped...]
    $ 

Finally, I removed the above change and applied the patch given below.
Now, I didn't expect this to work because I don't have all of the
dependencies installed, and those that I do have installed are not
where the Makefile expects them to be (eg zlib is at C:\zlib).
However, the build does at least compile all of the C source files, but
then all of the link's fail since it can't find zlib.lib.

[Note: I was a little surprised that it got that far, since I didn't
expect it to find the zlib header files. However, I have set the
INCLUDE environment variable which msvc is respecting! yeah, a bit old
fashioned!  Having also set the LIB environment variable, I was then
a bit surprised that the linker didn't find the library; until I
noticed that my library is called libz.lib *not* zlib.lib!]

Note that the patch below includes some line-wrapping which you can
ignore if you like, it just makes the Makefile easier to read.
The only change that matters is inserting a space between -DWIN32 and
-D_CONSOLE.

Anyway, the point is *not* to get the msvc build to work for me; rather
it is to understand why the build *works* for you. ;-)

ATB,
Ramsay Jones

-- >8 --
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Wed, 30 Sep 2009 20:08:41 +0100
Subject: [PATCH] Fix the MSVC build on cygwin


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 12defd4..e6ec8ed 100644
--- a/Makefile
+++ b/Makefile
@@ -914,10 +914,17 @@ ifdef MSVC
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
-	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32-D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
+	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild \
+		       -Icompat/vcbuild/include -DWIN32 -D_CONSOLE \
+		       -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS \
+		       -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -DSTRIP_EXTENSION=\".exe\"
-	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H \
+			-DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch \
+			-Icompat/regex -Icompat/fnmatch \
+			-DSTRIP_EXTENSION=\".exe\"
+	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE \
+			-NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	lib =
 ifndef DEBUG
-- 
1.6.4
