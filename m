From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC 1/3] compat/win32/sys/poll.c: upgrade from upstream
Date: Thu,  7 Jul 2011 13:43:07 +0200
Message-ID: <1310038989-5724-2-git-send-email-kusmabite@gmail.com>
References: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 13:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QemzS-000089-Bc
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 13:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab1GGLnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 07:43:21 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55032 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab1GGLnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 07:43:20 -0400
Received: by eyx24 with SMTP id 24so280265eyx.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rWWCbrMQRUn+Brbbef1pWEzipvqjTn+g8C8EjFpX6p0=;
        b=E7im1eBp1hT39tsQj4SnkKM5r6K5H6Sb8facu1hv3nc+mV+b4rZpvICxAilF2S3WgO
         cx0B4mxGeaa7k9GMKUfHpn+lZuATkZueV0cvPqZlcAL3JS2FhzrxNC5v1c5JPBTaGSZY
         LUlxnE7LtMfmqTMc1So+pl4oGvquxabevOh5s=
Received: by 10.213.99.207 with SMTP id v15mr290171ebn.108.1310038998457;
        Thu, 07 Jul 2011 04:43:18 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id s14sm1263015eef.15.2011.07.07.04.43.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 04:43:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.4055.gbf1a7
In-Reply-To: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176756>

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
1.7.6.135.ge14e3f
