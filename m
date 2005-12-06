From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Initial AIX portability fixes.
Date: Tue, 06 Dec 2005 14:20:16 -0800
Message-ID: <20493.1133907616@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Tue Dec 06 23:22:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjlAb-00034X-RU
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 23:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVLFWUS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 17:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVLFWUS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 17:20:18 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:53657 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S965041AbVLFWUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 17:20:16 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB6MKG6d020496
	for <git@vger.kernel.org>; Tue, 6 Dec 2005 14:20:16 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB6MKGJ1020495
	for <git@vger.kernel.org>; Tue, 6 Dec 2005 14:20:16 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13299>


Added an AIX clause in the Makefile; that clause likely
will be wrong for any AIX pre-5.2, but I can only test
on 5.3.  mailinfo.c was missing the compat header file,
and convert-objects.c needs to define a specific
_XOPEN_SOURCE as well as _XOPEN_SOURCE_EXTENDED.

Signed-off-by: E. Jason Riedy <ejr@cs.berkeley.edu>

---

 Makefile          |    4 ++++
 convert-objects.c |    3 ++-
 mailinfo.c        |    1 +
 3 files changed, 7 insertions(+), 1 deletions(-)

54b8c282e017b246612b94bcbf5b88ab39c042a0
diff --git a/Makefile b/Makefile
index 425c519..01b6643 100644
--- a/Makefile
+++ b/Makefile
@@ -243,6 +243,10 @@ ifeq ($(uname_S),NetBSD)
 	ALL_CFLAGS += -I/usr/pkg/include
 	ALL_LDFLAGS += -L/usr/pkg/lib -Wl,-rpath,/usr/pkg/lib
 endif
+ifeq ($(uname_S),AIX)
+	NO_STRCASESTR=YesPlease
+	NEEDS_LIBICONV=YesPlease
+endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
diff --git a/convert-objects.c b/convert-objects.c
index d78a8b4..b49bce2 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -1,4 +1,5 @@
-#define _XOPEN_SOURCE /* glibc2 needs this */
+#define _XOPEN_SOURCE 500 /* glibc2 and AIX 5.3L need this */
+#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #include <time.h>
 #include "cache.h"
 
diff --git a/mailinfo.c b/mailinfo.c
index 3b97a89..d4b4163 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <iconv.h>
+#include "git-compat-util.h"
 #include "cache.h"
 
 static FILE *cmitmsg, *patchfile;
-- 
0.99.9.GIT
