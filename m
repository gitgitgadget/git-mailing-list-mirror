From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Tue, 1 Nov 2011 12:56:21 +0100
Message-ID: <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
 <7vd3dcq4s5.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1110311908240.1930@bonsai2>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	Karsten Blees <blees@dcon.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 01 12:57:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLCxr-00082p-QZ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 12:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab1KAL5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 07:57:05 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44614 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab1KAL5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 07:57:04 -0400
Received: by qabj40 with SMTP id j40so5669733qab.19
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=e4/m/eVt18nhlmW9CXnatAgGKu4SpEC2RjVAEOFRNco=;
        b=Ok7nAZVRma5qrLZD3LxPGhsXqbaJ1d0qtxZ2ermh1NJ7zFmsP4GxBPoJAiddU7H7bD
         PIGnrycIhqJOswcOtFWyUk8+BDiMOTdXzHwfp3xVEU5SM2sfHJz8BisSA945tKF8u56+
         EP9K73H/AU6M+4RjedgwQSFnj8ghZ6SgxwiRc=
Received: by 10.68.72.104 with SMTP id c8mr155577pbv.34.1320148622080; Tue, 01
 Nov 2011 04:57:02 -0700 (PDT)
Received: by 10.68.71.135 with HTTP; Tue, 1 Nov 2011 04:56:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1110311908240.1930@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184565>

On Tue, Nov 1, 2011 at 1:09 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 31 Oct 2011, Junio C Hamano wrote:
>
>> Thanks. The patch looks good from a POSIX person's point of view, and I
>> do not immediately see how this would break other variants of Windows
>> build at least from the code inspection.
>
> As my virtual machine still ran the test suite after my latest rebasing
> merge when I left work, I could not test the MSVC stuff just yet. I wanted
> to do that tomorrow and either merge or come back with suggestions.

I've applied the patches to 'devel', verified that the result builds,
and pushed it out.

However, it still doesn't compile with MSVC on top of our 'devel':
make: *** No rule to make target `compat/win32/sys/poll.h', needed by `daemon.o'

The fix for this problem is the following:

---8<---
diff --git a/Makefile b/Makefile
index 2837e79..70edb11 100644
--- a/Makefile
+++ b/Makefile
@@ -518,7 +518,7 @@ LIB_H += compat/mingw.h
 LIB_H += compat/obstack.h
 LIB_H += compat/win32/pthread.h
 LIB_H += compat/win32/syslog.h
-LIB_H += compat/win32/sys/poll.h
+LIB_H += compat/win32/poll.h
 LIB_H += compat/win32/dirent.h
 LIB_H += connected.h
 LIB_H += csum-file.h
---8<---

This is a slip-up in my patch 0f77dea, but I don't quite understand
why this didn't cause any troubles until now... I guess the MSVC parts
of Makefile are somehow more dependent on LIB_H or something...

Junio, is it too late to squash in a fix-up? If it is, I can send a
fixup-patch instead...

Anyway, with that fix in place, it still breaks here:
compat/win32\poll.h(26) : warning C4005: 'POLLIN' : macro redefinition
        C:\Program Files\Microsoft SDKs\Windows\v6.0A\include\winsock2.h(1495) :
 see previous definition of 'POLLIN'
compat/win32\poll.h(27) : warning C4005: 'POLLPRI' : macro redefinition
        C:\Program Files\Microsoft SDKs\Windows\v6.0A\include\winsock2.h(1496) :
 see previous definition of 'POLLPRI'
[...]
compat/win32\poll.h(35) : warning C4005: 'POLLWRBAND' : macro redefinition
        C:\Program Files\Microsoft SDKs\Windows\v6.0A\include\winsock2.h(1500) :
 see previous definition of 'POLLWRBAND'
compat/win32\poll.h(38) : error C2011: 'pollfd' : 'struct' type redefinition
        C:\Program Files\Microsoft SDKs\Windows\v6.0A\include\winsock2.h(1506) :
 see declaration of 'pollfd'

Again, this seems to be related to the poll-emulation... I see that
these things are guarded by an "#if(_WIN32_WINNT >= 0x0600)" in
<winsock2.h>, which means it's supported for Windows Vista and
above... We still support Windows XP, so it seems someone has set this
too high :)

And this seems to indeed be the case, as compat/win32/poll.c takes
care to set it to 0x0502 before including. Something like this fixes
that problem for me:
---8<---
diff --git a/compat/mingw.h b/compat/mingw.h
index cdaa7ba..0b8e1aa 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,3 +1,4 @@
+#define _WIN32_WINNT 0x0501
 #include <winsock2.h>
 #include <ws2tcpip.h>

diff --git a/git-compat-util.h b/git-compat-util.h
index 0135dcc..e66c21e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,6 +85,7 @@
 #define _SGI_SOURCE 1

 #ifdef WIN32 /* Both MinGW and MSVC */
+#define _WIN32_WINNT 0x0501
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
---8<---

I'd prefer to set this from the Makefile, but this generates a warning
in compat/win32/poll.c about redefining a macro (poll.c wants it to be
0x502, which is Windows XP with SP2, rather than 0x501 which is normal
Windows XP):
---8<---
diff --git a/Makefile b/Makefile
index 2837e79..a4aa785 100644
--- a/Makefile
+++ b/Makefile
@@ -1131,7 +1131,10 @@ ifeq ($(uname_S),Windows)
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
-	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild
-Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H
-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
+	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild \
+	        -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H \
+		-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE \
+		-D_WIN32_WINNT=0x501
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/poll.o compat/win32/dirent.o
---8<---

(this will probably both be line-wrapped and white-space-broken, but
you get the point)

...But now I get a complaint about LF_FACESIZE and TMPF_TRUETYPE:
    CC compat/winansi.o
winansi.c
compat/winansi.c(39) : error C2065: 'LF_FACESIZE' : undeclared identifier
compat/winansi.c(39) : error C2057: expected constant expression
compat/winansi.c(56) : warning C4113: 'FARPROC' differs in parameter lists from
'PGETCURRENTCONSOLEFONTEX'
compat/winansi.c(74) : error C2065: 'TMPF_TRUETYPE' : undeclared identifier
make: *** [compat/winansi.o] Error 1

Luckily, Karsten Blees already sent a patch for this:
http://osdir.com/ml/msysgit/2011-10/msg00031.html

...And with that applied, that problem goes away.

Unfortunately, it's not the last error I get:
    LINK git-daemon.exe
daemon.o : error LNK2001: unresolved external symbol _inet_pton
daemon.o : error LNK2001: unresolved external symbol _inet_ntop
git-daemon.exe : fatal error LNK1120: 2 unresolved externals
make: *** [git-daemon.exe] Error 1

The following patch makes that go away:
---8<---
diff --git a/Makefile b/Makefile
index 2837e79..c87c7c5 100644
--- a/Makefile
+++ b/Makefile
@@ -1124,6 +1124,8 @@ ifeq ($(uname_S),Windows)
        NO_CURL = YesPlease
        NO_PYTHON = YesPlease
        BLK_SHA1 = YesPlease
+       NO_INET_PTON = YesPlease
+       NO_INET_NTOP = YesPlease
        NO_POSIX_GOODIES = UnfortunatelyYes
        NATIVE_CRLF = YesPlease
        NO_D_INO_IN_DIRENT = YesPlease
---8<---
(again, probably white-space broken, but you get the point)

And THEN it compiles fine from 'devel'.

So there's some more work left to be done. Unfortunately, I don't have
time to polish these changes for at least a week, so unless someone
volunteers it'll take some time...
