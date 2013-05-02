From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 2/2] cygwin: Remove the CYGWIN_V15_WIN32API build variable
Date: Thu, 02 May 2013 20:29:04 +0100
Message-ID: <5182BE80.7060400@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, mlevedahl@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 21:39:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXzLe-0003lj-HL
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 21:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708Ab3EBTjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 15:39:18 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:35174 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752562Ab3EBTjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 15:39:16 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2013 15:39:16 EDT
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id AC1E740078B
	for <git@vger.kernel.org>; Thu,  2 May 2013 20:32:33 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 20205AC4213;
	Thu,  2 May 2013 20:31:50 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 2835AAC420C;
	Thu,  2 May 2013 20:31:49 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Thu,  2 May 2013 20:31:44 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223253>


Commit 380a4d92 ("Update cygwin.c for new mingw-64 win32 api headers",
11-11-2012) solved an header include order problem on cygwin 1.7 when
using the new mingw-64 WIN32 API headers. The solution involved using
a new build variable (V15_MINGW_HEADERS) to conditionally compile the
cygwin.c source file to use an include order appropriate for the old
and new header files. (The build variable was later renamed in commit
9fca6cff to CYGWIN_V15_WIN32API).

The include order used for cygwin 1.7 includes the "win32.h" header
before "../git-compat-util.h". This order was problematic on cygwin
1.5, since it lead to the WIN32 symbol being defined along with the
inclusion of some WIN32 API headers (e.g. <winsock2.h>) which cause
compilation errors.

The header include order problem on cygwin 1.5 has since been fixed
(see commit "mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE"),
so we can now remove the conditional compilation along with the
associated CYGWIN_V15_WIN32API build variable.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile         | 7 -------
 compat/cygwin.c  | 5 -----
 config.mak.uname | 1 -
 3 files changed, 13 deletions(-)

diff --git a/Makefile b/Makefile
index 0f931a2..32c49ba 100644
--- a/Makefile
+++ b/Makefile
@@ -290,10 +290,6 @@ all::
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
@@ -1449,9 +1445,6 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 endif
-ifdef CYGWIN_V15_WIN32API
-	COMPAT_CFLAGS += -DCYGWIN_V15_WIN32API
-endif
 
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS += -Icompat/nedmalloc
diff --git a/compat/cygwin.c b/compat/cygwin.c
index 871b41d..91ce5d4 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,14 +1,9 @@
 #define CYGWIN_C
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
 
 /*
diff --git a/config.mak.uname b/config.mak.uname
index d78fd3d..28aa239 100644
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
-- 
1.8.2
