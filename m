From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/5] msvc: Fix compilation errors caused by poll.h emulation
Date: Thu, 09 May 2013 21:35:28 +0100
Message-ID: <518C0890.9050508@ramsay1.demon.co.uk>
References: <510AB7D3.7010407@ramsay1.demon.co.uk> <518AFEFC.8010904@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Thu May 09 22:40:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaXdz-0007R4-9n
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 22:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab3EIUkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 16:40:47 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:33999 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752412Ab3EIUkq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 16:40:46 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id B827F4005FB;
	Thu,  9 May 2013 21:40:44 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 6DFD64005F9;
	Thu,  9 May 2013 21:40:43 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu,  9 May 2013 21:40:41 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <518AFEFC.8010904@cs-ware.de>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223780>

Sven Strickroth wrote:
> Am 31.01.2013 19:28 schrieb Ramsay Jones:
>> Commit 0f77dea9 ("mingw: move poll out of sys-folder", 24-10-2011), along
>> with other commits in the 'ef/mingw-upload-archive' branch (see commit
>> 7406aa20), effectively reintroduced the same problem addressed by commit
>> 56fb3ddc ("msvc: Fix compilation errors in compat/win32/sys/poll.c",
>> 04-12-2010).
>>
>> In order to fix the compilation errors, we use the same solution adopted
>> in that earlier commit. In particular, we set _WIN32_WINNT to 0x0502
>> (which would target Windows Server 2003) prior to including the winsock2.h
>> header file.
> 
> This change causes problems compiling with MSVC2012 for me. If I don't
> define NO_SYS_POLL_H git-compat-util.h now tries to include <sys/poll.h>
> which does not exist for MSVC and if I define NO_SYS_POLL_H
> git-compat-util.h now tries to include <poll.h> which also doesn't exist
> for MSVC.
> 
> Including compat/poll into the includes path causes redefinition errors.
> 
> How have you tested this?

I used the Makefile, with the Visual C++ 2008 command line compiler on
Windows XP (SP3), to build a vanilla git on MinGW.
Viz:

    ramsay (pu) ms $ git checkout master
    Switched to branch 'master'
    ramsay (master) ms $ git rev-parse master
    423ecb0bb66e9d60b6667aebc2844e82205369a1
    ramsay (master) ms $ make clean >/dev/null 2>&1
    ramsay (master) ms $ make >ms-out1 2>&1
    ramsay (master) ms $ grep error ms-out1
    ramsay (master) ms $ ./git version
    git version 1.8.3.rc1.25.g423ecb0.MSVC
    ramsay (master) ms $

Also

    ramsay (tmp) ms $ rm git.o
    ramsay (tmp) ms $ make V=1 git.o
    compat/vcbuild/scripts/clink.pl -o git.o -c    -nologo -I. -I../zlib -Icompat/vc
    build -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_
    NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -GL -Os -MT -DNO_CURL -DNO_ST_BLOCKS_IN_
    STRUCT_STAT -DNO_NSEC -DNO_SYMLINK_HEAD -DNO_GETTEXT -DNO_SYS_POLL_H -DNO_THREAD
    _SAFE_PREAD -DNO_IPV6 -DNO_INET_NTOP -DNO_INET_PTON -DNO_ICONV -DNO_POSIX_GOODIE
    S  -DUNRELIABLE_FSTAT -DSHA1_HEADER='"block-sha1/sha1.h"' -D__USE_MINGW_ACCESS -
    DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -D
    STRIP_EXTENSION=\".exe\" -DNO_LIBGEN_H -DSNPRINTF_RETURNS_BOGUS -DNO_POLL -Icomp
    at/poll -DNO_STRCASESTR -DNO_STRLCPY -DNO_STRTOUMAX -Icompat/fnmatch -DNO_FNMATC
    H -DNO_SETENV -DNO_MKDTEMP -DNO_MKSTEMPS -DNO_UNSETENV -DUSE_WIN32_MMAP -DOBJECT
    _CREATION_MODE=1 -DNO_PREAD -DNO_MEMMEM -DRUNTIME_PREFIX -Icompat/regex -DSHELL_
    PATH='"/bin/sh"' -DDEFAULT_HELP_FORMAT='"html"' '-DGIT_HTML_PATH="share/doc/git-
    doc"' '-DGIT_MAN_PATH="share/man"' '-DGIT_INFO_PATH="share/info"' git.c
    git.c
    git.c(204) : warning C4090: 'function' : different 'const' qualifiers
    git.c(218) : warning C4090: 'function' : different 'const' qualifiers
    git.c(221) : warning C4090: 'function' : different 'const' qualifiers
    ramsay (tmp) ms $

Note that '-Icompat/poll' is passed on the command-line (it is split at -Icomp
above), which comes from:

    ramsay (tmp) ms $ git grep -n 'compat/poll'
    Makefile:647:LIB_H += compat/poll/poll.h
    Makefile:1235:  COMPAT_CFLAGS += -DNO_POLL -Icompat/poll
    Makefile:1236:  COMPAT_OBJS += compat/poll/poll.o
    ramsay (tmp) ms $

I have a patch which allows me to generate the preprocessed output file
and, after running it on git.c (=> git.i), I can see that msvc reads the
compat/poll/poll.h file. (from line 128 of git-compat-util.h).

Are you using a MSVC "project" file? If so, is it equivalent to the Makefile?
Has the "#include" behaviour changed between MSVC 2008 -> MSVC 2012?

ATB,
Ramsay Jones
