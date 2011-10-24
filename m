From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 2/3] compat/win32/poll.c: upgrade from upstream
Date: Mon, 24 Oct 2011 18:02:10 +0200
Message-ID: <1319472131-3968-3-git-send-email-kusmabite@gmail.com>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org, peff@peff.net,
	rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 18:02:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIMyk-0008WM-UK
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 18:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945Ab1JXQCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 12:02:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38696 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826Ab1JXQCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 12:02:16 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so8365950bkb.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=G54NvUXGMAgW0ZIqPyZybY+cVhqbLB29aUVKQUzsgK4=;
        b=PgpBRLRtoZnXaOEnWFbtia7eTD+1BSZwWdgZUYlaL/PGeGGqVHYVApYeuJ5vbVIOb2
         w/u/DIm8e1Tg6ZSGdo0dwAtc+fHJCeGpuFZFBOtpLRIPWn91/xclPslxvq/ygd6sAPvb
         MZsvpgWtvCl3j9/kmnNsDAERHus/mw+DT9fYE=
Received: by 10.204.15.80 with SMTP id j16mr1087750bka.26.1319472135438;
        Mon, 24 Oct 2011 09:02:15 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id f7sm15540411bkc.1.2011.10.24.09.02.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Oct 2011 09:02:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.msysgit.1.1.g7b316
In-Reply-To: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184178>

poll.c is updated from revision adc3a5b in
git://git.savannah.gnu.org/gnulib.git

The changes are applied with --whitespace=fix to reduce noise.

poll.h is not upgraded, because the most recent version now
contains template-stuff that breaks compilation for us.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/win32/poll.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/compat/win32/poll.c b/compat/win32/poll.c
index 708a6c9..403eaa7 100644
--- a/compat/win32/poll.c
+++ b/compat/win32/poll.c
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
1.7.7.msysgit.1.1.g7b316
