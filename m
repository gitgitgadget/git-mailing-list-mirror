From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] compat/fnmatch: Rename wchar functions to standard API
Date: Wed,  6 Jun 2012 13:08:16 +0000
Message-ID: <1338988096-2136-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 15:08:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScFyW-0007xR-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622Ab2FFNIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 09:08:32 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62704 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab2FFNIb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:08:31 -0400
Received: by wgbdr13 with SMTP id dr13so6206202wgb.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 06:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=uGEDC+sOJKsIw3P0WaU4rB7muPcXHwJQkokF4zI78AE=;
        b=Zv08l+WAOI+ehO6+8nPt/23eN2dHpWG/1Kr3AxHSe8fdhNpxVcUUmN8ONdsLqSGcr0
         CFxCFjCCS3UdHZLTwWuB1GVkdfKYdLS+RkEDOZ3PWDqMO+E0XOdpnyeXR7a/hDG9YWvn
         3Gr9heRNx5bzep1Hw2swtdLQVZfm+NHe/EWtpg/kiUrEyTs0rWrqOcXFp9g2D4KEFBZ/
         F8jpwokwHABNvmVq732cTDVpgHUCnFSp7S4C4PJ3NYYbsP/6RI32/cmtXSAaEDMun9j+
         GfuuR11dZ6EVVl0ySJBxOuMBl0BGpjoFZRWNERTS4qBM3Ve3l6GUo+n6nAmMh1GyO+Iv
         s+lA==
Received: by 10.216.198.164 with SMTP id v36mr17338271wen.199.1338988109893;
        Wed, 06 Jun 2012 06:08:29 -0700 (PDT)
Received: from localhost (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id gv4sm4109071wib.8.2012.06.06.06.08.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 06:08:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
X-Gm-Message-State: ALoCoQnviaNtyOWbMn+IvZ7SK005nqMmHUpQEJZiI3mRN1vVOifamLbQ6PfpfwimajddUJMy6rAb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199324>

On a platform that does not have glibc but does have 'wchar.h' or
'wctype.h', the functions '__iswctype' and '__btowc' must be renamed to
standard API. If not, git cannot be compiled on the platform.

This code is taken from compat/regex/regex_internal.h.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 compat/fnmatch/fnmatch.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 9473aed..3f9e3d6 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -99,11 +99,19 @@
 #   define CHAR_CLASS_MAX_LENGTH 256
 #  endif
 
-#  ifdef _LIBC
-#   define IS_CHAR_CLASS(string) __wctype (string)
-#  else
-#   define IS_CHAR_CLASS(string) wctype (string)
+/* Rename to standard API for using out of glibc.  */
+#  ifndef _LIBC
+#   ifdef __wctype
+#    undef __wctype
+#   endif
+#   define __wctype wctype
+#   ifdef __iswctype
+#    undef __iswctype
+#   endif
+#   define __iswctype iswctype
+#   define __btowc btowc
 #  endif
+#  define IS_CHAR_CLASS(string) __wctype (string)
 # else
 #  define CHAR_CLASS_MAX_LENGTH  6 /* Namely, `xdigit'.  */
 
-- 
1.7.9.msysgit.0
