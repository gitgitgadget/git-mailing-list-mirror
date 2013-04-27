From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 6/6] compat/nedmalloc: Fix compiler warnings on linux
Date: Sat, 27 Apr 2013 19:46:17 +0100
Message-ID: <517C1CF9.2080903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:46:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB53-0008N7-5Q
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368Ab3D0Tqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:46:38 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33100 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756296Ab3D0Tqh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:46:37 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id CFE36384081;
	Sat, 27 Apr 2013 20:46:36 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 3290F384082;
	Sat, 27 Apr 2013 20:46:36 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:46:35 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222669>


On linux, when the build variable USE_NED_ALLOCATOR is set, gcc
issues the following warnings:

    In file included from compat/nedmalloc/nedmalloc.c:63:
    .../malloc.c.h: In function 'mmap_resize':
    .../malloc.c.h:3762: warning: implicit declaration of function 'mremap'
    .../malloc.c.h: In function 'sys_trim':
    .../malloc.c.h:4195: warning: comparison between pointer and integer

The warnings are caused by the <sys/mman.h> header not enabling the
(conditional) declaration of the mremap() function.  The declaration
can be enabled by defining the _GNU_SOURCE symbol prior to including
certain system header files. In particular, it may not be sufficient
to simply define _GNU_SOURCE just prior to including the <sys/mman.h>
header. (e.g. defining the symbol after including <sys/types.h> will
be completely ineffective.)

In order to suppress the warnings, we define the _GNU_SOURCE symbol
at the start of the malloc.c.h header file.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/nedmalloc/malloc.c.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index fdcca82..5a44dea 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -484,6 +484,10 @@ MAX_RELEASE_CHECK_RATE   default: 4095 unless not HAVE_MMAP
 #define DLMALLOC_VERSION 20804
 #endif /* DLMALLOC_VERSION */
 
+#if defined(linux)
+#define _GNU_SOURCE 1
+#endif
+
 #ifndef WIN32
 #ifdef _WIN32
 #define WIN32 1
-- 
1.8.2
