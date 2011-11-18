From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 2/3] Compile fix for MSVC: fix poll-related macro redefines
Date: Fri, 18 Nov 2011 17:44:29 +0100
Message-ID: <1321634670-4968-2-git-send-email-vfr@lyx.org>
References: <1321634670-4968-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, kusmabite@gmail.com, msysgit@googlegroups.com,
	j.sixt@viscovery.net, Vincent van Ravesteijn <vfr@lyx.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 17:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRRa6-0006sN-J8
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 17:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248Ab1KRQpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 11:45:49 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61269 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228Ab1KRQpr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 11:45:47 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so3544688eye.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 08:45:46 -0800 (PST)
Received: by 10.14.34.195 with SMTP id s43mr338235eea.122.1321634746434;
        Fri, 18 Nov 2011 08:45:46 -0800 (PST)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id z58sm4088253eea.3.2011.11.18.08.45.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 08:45:45 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1321634670-4968-1-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185667>

This seems to be related to the poll-emulation... I see that these things
are guarded by an "#if(_WIN32_WINNT >= 0x0600)" in <winsock2.h>, which
means it's supported for Windows Vista and above... We still support
Windows XP, so it seems someone has set this too high :)

I'd prefer to set this from the Makefile, but this generates a warning in
compat/win32/poll.c about redefining a macro (poll.c wants it to be 0x502,
which is Windows XP with SP2, rather than 0x501 which is normal Windows
XP).

Proposed-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Submitted-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 compat/mingw.h    |    1 +
 git-compat-util.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index fecf0d0..ff18401 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,3 +1,4 @@
+#define _WIN32_WINNT 0x0501
 #include <winsock2.h>
 #include <ws2tcpip.h>
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 5ef8ff7..76cbfe6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,6 +85,7 @@
 #define _SGI_SOURCE 1
 
 #ifdef WIN32 /* Both MinGW and MSVC */
+#  define _WIN32_WINNT 0x0501
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
-- 
1.7.4.1
