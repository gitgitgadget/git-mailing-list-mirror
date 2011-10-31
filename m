From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 1/3] Compile fix for MSVC: Do not include sys/resources.h
Date: Mon, 31 Oct 2011 20:12:42 +0100
Message-ID: <1320088364-25916-2-git-send-email-vfr@lyx.org>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
Cc: kusmabite@gmail.com, ramsay@ramsay1.demon.co.uk,
	msysgit@googlegroups.com, gitster@pobox.com,
	Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 20:13:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKxIY-00047a-Va
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 20:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933742Ab1JaTN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 15:13:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60415 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933236Ab1JaTNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 15:13:25 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so5598224eye.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 12:13:25 -0700 (PDT)
Received: by 10.14.11.4 with SMTP id 4mr1401447eew.79.1320088405221;
        Mon, 31 Oct 2011 12:13:25 -0700 (PDT)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id d6sm25272860eec.10.2011.10.31.12.13.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 12:13:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1320088364-25916-1-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184513>

Do not include header files when compiling with MSVC that do not
exist and which are also not included when compiling with MINGW.
A direct consequence is that git can be compiled again with MSVC
because the missing "sys/resources.h" is no longer included.

Instead of current

	#ifndef mingw32 is the only one that is strange
        ... everything for systems that is not strange ...
        #else
        ... include mingw specific tweaks ...
        #endif
        #ifdef msvc is also strange
        ... include msvc specific tweaks ...
        #endif

it turns things around and says what it wants to achieve in a more direct
way, i.e.

	#if mingw32
        #include "compat/mingw.h"
	#elif msvc
        #include "compat/msvc.h"
	#else
        ... all the others ...
	#endif

which makes it look simpler.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5ef8ff7..53186da 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -116,7 +116,12 @@
 #else
 #include <poll.h>
 #endif
-#ifndef __MINGW32__
+#if defined(__MINGW32__)
+/* pull in Windows compatibility stuff */
+#include "compat/mingw.h"
+#elif defined(_MSC_VER)
+#include "compat/msvc.h"
+#else
 #include <sys/wait.h>
 #include <sys/resource.h>
 #include <sys/socket.h>
@@ -145,12 +150,6 @@
 #include <grp.h>
 #define _ALL_SOURCE 1
 #endif
-#else 	/* __MINGW32__ */
-/* pull in Windows compatibility stuff */
-#include "compat/mingw.h"
-#endif	/* __MINGW32__ */
-#ifdef _MSC_VER
-#include "compat/msvc.h"
 #endif
 
 #ifndef NO_LIBGEN_H
-- 
1.7.4.1
