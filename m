From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/6] compat/fnmatch/fnmatch.c: Fix a sparse error
Date: Sat, 27 Apr 2013 19:44:08 +0100
Message-ID: <517C1C78.3060206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB4u-0008GU-RF
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279Ab3D0Tqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:46:32 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33076 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756237Ab3D0Tqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:46:32 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 48F48384083;
	Sat, 27 Apr 2013 20:46:31 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id A2BB0384081;
	Sat, 27 Apr 2013 20:46:30 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:46:28 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222667>


Sparse issues the following error and warnings:

    SP compat/fnmatch/fnmatch.c
.../fnmatch.c:144:17: warning: Using plain integer as NULL pointer
.../fnmatch.c:238:67: warning: Using plain integer as NULL pointer
.../fnmatch.c:303:40: error: too many arguments for function getenv

The error is caused by the extern declaration for the getenv function
not including the function prototype. Without the prototype, sparse
effectively sees the declaration as 'char *getenv(void)'. In order to
suppress the error, we simply include the function prototype.

In order to suppress the warnings, we include the <stddef.h> header
which provides an appropriate definition of the NULL macro, rather
than using the (inappropriate) default definition at fnmatch.c:132.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/fnmatch/fnmatch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 5ef0685..378c467 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -25,6 +25,7 @@
 # define _GNU_SOURCE	1
 #endif
 
+#include <stddef.h>
 #include <errno.h>
 #include <fnmatch.h>
 #include <ctype.h>
@@ -121,7 +122,7 @@
    whose names are inconsistent.  */
 
 # if !defined _LIBC && !defined getenv
-extern char *getenv ();
+extern char *getenv (const char *name);
 # endif
 
 # ifndef errno
-- 
1.8.2
