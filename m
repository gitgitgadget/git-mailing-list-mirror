From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 1/4] compat/win32/sys/poll.c: upgrade from upstream
Date: Thu, 29 Sep 2011 22:59:20 +0200
Message-ID: <1317329963-6656-2-git-send-email-kusmabite@gmail.com>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, j6t@kdbg.org, gitster@pobox.com,
	rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 22:59:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Nhm-00020c-2c
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 22:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757685Ab1I2U7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 16:59:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39978 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757667Ab1I2U7d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 16:59:33 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so1097794bkb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/1QvoXHOX4gKFVkcn/2kxHFGxrPMqAR2iCpJxabaEHs=;
        b=RXIknYB2NEKyKObErAh5DoNy7Ul6B40S+OSWyxrWGvdUxalocJVZj7f1CIBz7YqcD8
         9GVfs7pDIDef3dZABx4+nQDetTTl7tWHpex1MmaQH3Ex/tTOJ0IwVQFu0FRZMgx8Eiad
         upr8W/oX6vAu5lQWaOTIodPovazP0yvAsXxgY=
Received: by 10.204.145.139 with SMTP id d11mr7584988bkv.174.1317329971719;
        Thu, 29 Sep 2011 13:59:31 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no. [84.215.188.225])
        by mx.google.com with ESMTPS id j16sm2859849bks.3.2011.09.29.13.59.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 13:59:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.355.g842ba.dirty
In-Reply-To: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182436>

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
1.7.6.355.g842ba.dirty
