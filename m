From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] git-compat-util.h: don't define _XOPEN_SOURCE on cygwin
Date: Sun, 23 Nov 2014 17:14:55 +0000
Message-ID: <5472160F.6030509@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 23 18:15:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsakb-0005LA-Sv
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 18:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbaKWRO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 12:14:59 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:48188 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751253AbaKWRO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 12:14:58 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 5B86FA64DFE;
	Sun, 23 Nov 2014 17:14:57 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 184FBA64D3C;
	Sun, 23 Nov 2014 17:14:57 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Sun, 23 Nov 2014 17:14:56 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260091>


A recent update to the gcc compiler (v4.8.3-5 x86_64) on 64-bit
cygwin leads to several new warnings about the implicit declaration
of the memmem(), strlcpy() and strcasestr() functions. For example:

      CC archive.o
  archive.c: In function 'format_subst':
  archive.c:44:3: warning: implicit declaration of function 'memmem' \
    [-Wimplicit-function-declaration]
     b = memmem(src, len, "$Format:", 8);
     ^
  archive.c:44:5: warning: assignment makes pointer from integer \
    without a cast [enabled by default]
     b = memmem(src, len, "$Format:", 8);
     ^
This seems to be caused by a change to the system headers which
results in the _XOPEN_SOURCE macro now having prioity over the
_GNU_SOURCE and _BSD_SOURCE macros (they are simply ignored).
This in turn leads to the declarations of the above functions
to be suppressed.

In order to suppress the warnings, don't define the _XOPEN_SOURCE
macro on cygwin

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 git-compat-util.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 400e921..cef2691 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -75,7 +75,8 @@
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
       !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
-      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__)
+      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
+      !defined(__CYGWIN__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-- 
2.1.0
