From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 3/3] MSVC: fix stat definition hell
Date: Wed, 11 Sep 2013 01:23:13 +0200
Message-ID: <522FA9E1.7010705@gmail.com>
References: <522FA959.80108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 01:23:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJXHB-0001JO-OL
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 01:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab3IJXXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 19:23:14 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:53447 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab3IJXXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 19:23:13 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so4248562eak.36
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=uDqDx4ciRKFLgbikRCxQcRD4aqM8NOVPDSBPZ1sEZsk=;
        b=mexBzFSsVORBqG1k/VJFuf3J0v5lx1756gfv/e4l7xcS8xycC4dB6IJw9M0cQi5D95
         GNsptcaEWt2cTLiVqEASsv/xTLUtvUVp9GmTg48oyMyDkf5XWM2FSQs7rXDLV0G9nTy7
         oeUcfMbf5Ai3J5QuEogX2eOr7Kw3xxMFgHiymtbDPcZCOC3ImjctTjnK1TJqQm34D10j
         otHesU8WJh0XzrfEojrwhir67PpOGHzlAFyHRNutkC3DaB6NVCiWH2PIttz8h0/3944H
         SxUvLxVE+DFohOFWTdv0hLpQja9hMT0I2VXOZuNP8JIkGdeYLPwpfQaT0q6OKzQOD90i
         Pw9A==
X-Received: by 10.14.184.3 with SMTP id r3mr16278027eem.49.1378855392348;
        Tue, 10 Sep 2013 16:23:12 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id f49sm35442508eec.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 16:23:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <522FA959.80108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234507>

In msvc.h, there's a couple of stat related functions defined diffently
from mingw.h. When we remove these definitions, the only problem we get is
"warning C4005: '_stati64' : macro redefinition" for this line in mingw.h:

#define _stati64(x,y) mingw_stat(x,y)

The reason is that as of MSVCR80.dll (distributed with MSVC 2005), the
original _stati64 family of functions was renamed to _stat32i64, and the
former function names became macros (pointing to the appropriate function
based on the definition of _USE_32BIT_TIME_T).

Defining _stati64 works on MinGW because MinGW by default compiles against
the MSVCRT.DLL that is part of Windows (i.e. _stati64 is a function rather
than a macro).

Note: MinGW *can* compile for newer MSVC runtime versions, and MSVC
apparently can also compile for the Windows MSVCRT.DLL via the DDK (see
http://www.syndicateofideas.com/posts/fighting-the-msvcrt-dll-hell ).

Remove the stat definitions from msvc.h, as they are not compiler related.

In mingw.h, determine the runtime version in use from the definitions of
_stati64 and _USE_32BIT_TIME_T, and define stat() accordingly.

This also fixes that stat() in MSVC builds still resolves to mingw_lstat()
instead of mingw_stat().

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 compat/mingw.h | 15 +++++++++++----
 compat/msvc.h  | 15 ---------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 6b531e4..3c3a9d9 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -264,19 +264,26 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
 	return 0;
 }
 
-/* Use mingw_lstat() instead of lstat()/stat() and
- * mingw_fstat() instead of fstat() on Windows.
+/*
+ * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
  */
 #define off_t off64_t
 #define lseek _lseeki64
-#ifndef ALREADY_DECLARED_STAT_FUNCS
+
+/* use struct stat with 64 bit st_size */
 #define stat _stati64
 int mingw_lstat(const char *file_name, struct stat *buf);
 int mingw_stat(const char *file_name, struct stat *buf);
 int mingw_fstat(int fd, struct stat *buf);
 #define fstat mingw_fstat
 #define lstat mingw_lstat
-#define _stati64(x,y) mingw_stat(x,y)
+
+#ifndef _stati64
+# define _stati64(x,y) mingw_stat(x,y)
+#elif defined (_USE_32BIT_TIME_T)
+# define _stat32i64(x,y) mingw_stat(x,y)
+#else
+# define _stat64(x,y) mingw_stat(x,y)
 #endif
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
diff --git a/compat/msvc.h b/compat/msvc.h
index 96b6d60..580bb55 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -24,21 +24,6 @@ static __inline int strcasecmp (const char *s1, const char *s2)
 
 #undef ERROR
 
-/* Use mingw_lstat() instead of lstat()/stat() and mingw_fstat() instead
- * of fstat(). We add the declaration of these functions here, suppressing
- * the corresponding declarations in mingw.h, so that we can use the
- * appropriate structure type (and function) names from the msvc headers.
- */
-#define stat _stat64
-int mingw_lstat(const char *file_name, struct stat *buf);
-int mingw_fstat(int fd, struct stat *buf);
-#define fstat mingw_fstat
-#define lstat mingw_lstat
-#define _stat64(x,y) mingw_lstat(x,y)
-#define ALREADY_DECLARED_STAT_FUNCS
-
 #include "compat/mingw.h"
 
-#undef ALREADY_DECLARED_STAT_FUNCS
-
 #endif
-- 
1.8.4.8243.gbcbdefd
