From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 3/3] MSVC: fix stat definition hell
Date: Wed, 11 Sep 2013 18:02:09 +0200
Message-ID: <52309401.7000508@gmail.com>
References: <522FA959.80108@gmail.com> <522FA9E1.7010705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 18:02:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJms1-0002R6-2G
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 18:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab3IKQCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 12:02:17 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:34713 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab3IKQCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 12:02:16 -0400
Received: by mail-bk0-f42.google.com with SMTP id my10so3744899bkb.29
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=bZoYDlgcGRLpgQGp91UutNDh2CVLfvviPV3HD979FsA=;
        b=DeMZDJFyq7KrOfpXeGnp/YzyMo029sggjqSxMkgcT1ZbIUHK4iuRTzyshwGoZhb1bw
         DTeIjzTR6XHHG4ehNeWVuUiyfwIunBn/awm30sM2gh87GMK22Z8rEDJYfjW7NCKd+TeA
         GBB41c91cEjK0C0TPZMsIhkR+4ulK8e7p1+5t9TG+D8FxBfZI9KAp4rLn8eUinE+xJfh
         pIeASiBpEHTyU2mm6S0lKO/YciD0fmltOrgIldig9TSLG1xDJkQt0aU5g9BCAOBZRLCr
         FAnYTkLlwgI9j1wXyoLqyvuaT1HweP9C8YgKLSO50j/zmOQY+0DoPvgaIh993RQL15FH
         CSbg==
X-Received: by 10.204.247.71 with SMTP id mb7mr2190710bkb.7.1378915334809;
        Wed, 11 Sep 2013 09:02:14 -0700 (PDT)
Received: from [192.168.188.20] (p5DDB36D8.dip0.t-ipconnect.de. [93.219.54.216])
        by mx.google.com with ESMTPSA id qx2sm7851130bkb.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 09:02:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <522FA9E1.7010705@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234570>

On 11.09.2013 01:23, Karsten Blees wrote:

> In msvc.h, there's a couple of stat related functions defined diffently
> from mingw.h. When we remove these definitions, the only problem we get is
> "warning C4005: '_stati64' : macro redefinition" for this line in mingw.h:
> 
> #define _stati64(x,y) mingw_stat(x,y)

I have a similar patch at [1] to fix similar compilation issues with MinGW runtime version 4.0, which was recently released. I like your patch better, so I've rebased mine on top of yours:

[PATCH] MinGW: Fix stat definitions to work with MinGW runtime version 4.0

For an overview of changes in mingwrt-4.0 see:

    http://sourceforge.net/p/mingw/mingw-org-wsl/ci/4.0.0/tree/NEWS

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 compat/mingw.c   | 1 -
 compat/mingw.h   | 9 +++++++++
 config.mak.uname | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 96d9ac4..29c051f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -616,7 +616,6 @@ int mingw_stat(const char *file_name, struct stat *buf)
 	return do_stat_internal(1, file_name, buf);
 }
 
-#undef fstat
 int mingw_fstat(int fd, struct stat *buf)
 {
 	HANDLE fh = (HANDLE)_get_osfhandle(fd);
diff --git a/compat/mingw.h b/compat/mingw.h
index b521900..0d2faac 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -278,11 +278,20 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
 #define lseek _lseeki64
 
 /* use struct stat with 64 bit st_size */
+#ifdef stat
+#undef stat
+#endif
 #define stat _stati64
 int mingw_lstat(const char *file_name, struct stat *buf);
 int mingw_stat(const char *file_name, struct stat *buf);
 int mingw_fstat(int fd, struct stat *buf);
+#ifdef fstat
+#undef fstat
+#endif
 #define fstat mingw_fstat
+#ifdef lstat
+#undef lstat
+#endif
 #define lstat mingw_lstat
 
 #ifndef _stati64
diff --git a/config.mak.uname b/config.mak.uname
index 9249ee3..983ecc1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -499,7 +499,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
 	NO_D_INO_IN_DIRENT = YesPlease
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-- 
1.8.3.mingw.1.2.g56240b5.dirty

I don't think we should squash this patch to yours, however, because yours addressed MSVC compilation issues, and mine address MinGW compilation issues. But my patch could go to your branch.

[1] https://github.com/sschuberth/git/commit/841cdf60faa134eef031a7cf6d6692473a18cb65

-- 
Sebastian Schuberth
