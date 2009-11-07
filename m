From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 4/4] Add explicit Cygwin check to guard WIN32 header inclusion
Date: Sat, 07 Nov 2009 20:22:16 +0000
Message-ID: <4AF5D6F8.40608@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 21:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6rqM-0000ib-SV
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 21:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbZKGUYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 15:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbZKGUYz
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 15:24:55 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:40390 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753092AbZKGUYz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2009 15:24:55 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1N6rqF-0003St-am; Sat, 07 Nov 2009 20:25:00 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132377>


Since commit 435bdf8c ("Make usage of windows.h lean and mean",
16-9-2009), the amount of code potentially including the WIN32
API header files has greatly increased. In particular, the Cygwin
build is at greater risk of inadvertently including WIN32 code
within preprocessor sections protected by the WIN32 or _WIN32
macros.

The previous commit message, along with comments elsewhere, assert
that the WIN32 macro is not defined on Cygwin. Currently, this is
true for the cygwin build. However, the cygwin platform can be
used to develop WIN32 GUI, WIN32 console, and POSIX applications.
Indeed it is possible to create applications which use a mix of
the WIN32 API and POSIX code (eg git!).

Unlike native WIN32 compilers, gcc on cygwin does not automatically
define the _WIN32 macro. However, as soon as you include the
<windows.h> header file, the _WIN32 and WIN32 macros are defined.

In order to reduce the risk of problems in the future, we protect
the inclusion of the windows header with an explicit check for
__CYGWIN__. Also, we move the other use of the <windows.h> header
from compat/win32.h to compat/cygwin.c

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Changes since v1:
    - removed the definition of the WIN32_API macro.
    - removed all usage of WIN32_API as a replacement for the use
      of the _WIN32 and WIN32 macros in #if(n)def sections.

I wanted to separate these (remaining) changes from the WIN32_API
issue, since that is likely to require further discussion (along
with some bike-shedding), and I didn't want these to get held up.

 compat/cygwin.c   |    1 +
 compat/win32.h    |    3 ---
 git-compat-util.h |    8 ++++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/compat/cygwin.c b/compat/cygwin.c
index b4a51b9..6695515 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,5 +1,6 @@
 #define WIN32_LEAN_AND_MEAN
 #include "../git-compat-util.h"
+#include <windows.h>
 #include "win32.h"
 #include "../cache.h" /* to read configuration */
 
diff --git a/compat/win32.h b/compat/win32.h
index 8ce9104..a7ed72b 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -2,9 +2,6 @@
 #define WIN32_H
 
 /* common Win32 functions for MinGW and Cygwin */
-#ifndef WIN32         /* Not defined by Cygwin */
-#include <windows.h>
-#endif
 
 static inline int file_attr_to_st_mode (DWORD attr)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index ef60803..c4b9e5a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -65,10 +65,10 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
-#ifdef WIN32 /* Both MinGW and MSVC */
-#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
-#include <winsock2.h>
-#include <windows.h>
+#if defined(_WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
+# define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
+# include <winsock2.h>
+# include <windows.h>
 #endif
 
 #include <unistd.h>
-- 
1.6.5
