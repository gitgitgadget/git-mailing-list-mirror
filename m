From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] Update cygwin.c for new mingw-64 win32 api headers
Date: Sun, 11 Nov 2012 19:17:20 -0500
Message-ID: <1352679440-4098-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 01:19:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXhkg-0007Lq-52
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 01:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337Ab2KLAR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 19:17:26 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45332 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab2KLAR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 19:17:26 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so5584225vcb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 16:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=a/61EqWv8kT1jR7N/ZwMS4idHNIEpvbYU6j0R+w7zgA=;
        b=zukVOjJpF8T6iHPuo5misoN/OuukPP7JTJPpPQYsZ/IHpDWdTWEfCsmZQjSTAQ/T/o
         gaN2Pd61ON+Wkvf4Hv6TXHNe3sQQ4cm3JkuNbQJ2OnyAVYygovxHDzvqcIEULWxkQkvt
         vq55YoCl54vvUKxckkx+wQBkpJzyd0uabuEWdvKZi58aaPJ/q7pp6Vdf6s6BNlNCp/Vf
         GUwGtTCJ/VaSKLFCZLG4GTR51voWbSH+USUtXMB64XfZekTTluO1x3M7YLjnKiKKChSM
         XdxeyAbUY4Glnv3b/8eLT7npMlMBjDpwraXPSvkQSoseyCWU9lBvNlxrun1rybDz70OU
         SIgA==
Received: by 10.58.64.51 with SMTP id l19mr15840762ves.15.1352679445264;
        Sun, 11 Nov 2012 16:17:25 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-107-139.washdc.fios.verizon.net. [173.79.107.139])
        by mx.google.com with ESMTPS id k4sm5549524vdg.2.2012.11.11.16.17.24
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 16:17:24 -0800 (PST)
X-Mailer: git-send-email 1.8.0.0.0.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209457>

The cygwin project recently switched to a new implementation of the
windows api, now using header files from the mingw-64 project. These
new header files are incompatible with the way cygwin.c included the
old headers: cygwin.c can be compiled using the new or the older (mingw)
headers, but different files must be included in different order for each
to work. The new headers are in use only for the current release series
(based upon the v1.7.x dll version). The previous release series using
the v1.5 dll is kept available but unmaintained for use on older versions
of Windows. So, patch cygwin.c to use the new include ordering only if
the dll version is 1.7 or higher.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Makefile        | 4 ++++
 compat/cygwin.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/Makefile b/Makefile
index f69979e..1cc5d96 100644
--- a/Makefile
+++ b/Makefile
@@ -1082,6 +1082,7 @@ ifeq ($(uname_O),Cygwin)
 		NO_SYMLINK_HEAD = YesPlease
 		NO_IPV6 = YesPlease
 		OLD_ICONV = UnfortunatelyYes
+		V15_MINGW_HEADERS = YesPlease
 	endif
 	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
@@ -1889,6 +1890,9 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 endif
+ifdef V15_MINGW_HEADERS
+	COMPAT_CFLAGS += -DV15_MINGW_HEADERS
+endif
 
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS += -Icompat/nedmalloc
diff --git a/compat/cygwin.c b/compat/cygwin.c
index dfe9b30..59d86e4 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,6 +1,13 @@
 #define WIN32_LEAN_AND_MEAN
+#ifdef V15_MINGW_HEADERS
 #include "../git-compat-util.h"
 #include "win32.h"
+#else
+#include <sys/stat.h>
+#include <sys/errno.h>
+#include "win32.h"
+#include "../git-compat-util.h"
+#endif
 #include "../cache.h" /* to read configuration */
 
 static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
-- 
1.8.0.0.0.14
