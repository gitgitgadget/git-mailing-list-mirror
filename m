From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 1/4] compat/win32/sys/poll.c: upgrade from upstream
Date: Mon, 18 Jul 2011 20:08:33 +0200
Message-ID: <1311012516-4836-2-git-send-email-kusmabite@gmail.com>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 20:09:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QisFZ-0006Ch-BM
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 20:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086Ab1GRSIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 14:08:48 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:35701 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1GRSIq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 14:08:46 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so7013726fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=W3oQgMjKotqTPjWztzZKB6REyn0Iy8yJsvzyn0NFZXA=;
        b=OVUJoPD0CnoujpPGnPAlyJ4yCvGaOaLRwNVfmYfutsNom2wqbB3T8JA0KUfkbB3tqw
         VtiW7UhW+voaaV7DqJGePoriSxt7rVRDYb8kFDHiMXXvgvn3ITAtaAlCJ5hOmAElLEVF
         xf8oB/rsVp/yciYW+z4hShJIXVyBQbog1l+IQ=
Received: by 10.223.7.10 with SMTP id b10mr10484669fab.76.1311012525486;
        Mon, 18 Jul 2011 11:08:45 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 9sm3086582far.13.2011.07.18.11.08.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 11:08:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.4055.gbf1a7
In-Reply-To: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177392>

poll.c is updated from revision adc3a5b in
git://git.savannah.gnu.org/gnulib.git

The changes are applied with --whitespace=fix to reduce noise.

poll.h is not upgraded, because the most recent version now
contains template-stuff that breaks compilation for us.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/win32/sys/poll.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/compat/win32/sys/poll.c b/compat/win32/sys/poll.c
index 708a6c9..403eaa7 100644
--- a/compat/win32/sys/poll.c
+++ b/compat/win32/sys/poll.c
@@ -1,7 +1,7 @@
 /* Emulation for poll(2)
    Contributed by Paolo Bonzini.
 
-   Copyright 2001-2003, 2006-2010 Free Software Foundation, Inc.
+   Copyright 2001-2003, 2006-2011 Free Software Foundation, Inc.
 
    This file is part of gnulib.
 
@@ -27,7 +27,10 @@
 #include <malloc.h>
 
 #include <sys/types.h>
-#include "poll.h"
+
+/* Specification.  */
+#include <poll.h>
+
 #include <errno.h>
 #include <limits.h>
 #include <assert.h>
@@ -314,10 +317,7 @@ compute_revents (int fd, int sought, fd_set *rfds, fd_set *wfds, fd_set *efds)
 #endif /* !MinGW */
 
 int
-poll (pfd, nfd, timeout)
-     struct pollfd *pfd;
-     nfds_t nfd;
-     int timeout;
+poll (struct pollfd *pfd, nfds_t nfd, int timeout)
 {
 #ifndef WIN32_NATIVE
   fd_set rfds, wfds, efds;
@@ -454,6 +454,7 @@ poll (pfd, nfd, timeout)
   if (!hEvent)
     hEvent = CreateEvent (NULL, FALSE, FALSE, NULL);
 
+restart:
   handle_array[0] = hEvent;
   nhandles = 1;
   FD_ZERO (&rfds);
@@ -594,6 +595,12 @@ poll (pfd, nfd, timeout)
 	rc++;
     }
 
+  if (!rc && timeout == INFTIM)
+    {
+      SwitchToThread();
+      goto restart;
+    }
+
   return rc;
 #endif
 }
-- 
1.7.6.135.g378e9
