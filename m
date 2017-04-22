Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B224D207D6
	for <e@80x24.org>; Sat, 22 Apr 2017 00:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163016AbdDVA61 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 20:58:27 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38945 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163012AbdDVA60 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 20:58:26 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id BCyP1v0021keHif01CyQ6b; Sat, 22 Apr 2017 01:58:24 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Y8KIilWN c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=CWGfFUOg59lARSWTUH8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] git_fopen: fix a sparse 'not declared' warning
Message-ID: <130ef8bd-1c7b-0206-e1cd-076afae7e292@ramsayjones.plus.com>
Date:   Sat, 22 Apr 2017 01:58:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit 8f4f6e53d2 ("config.mak.uname: set FREAD_READS_DIRECTORIES for
Linux and FreeBSD", 20-04-2017) caused sparse to issue a 'not declared,
should it be static?' warning on Linux. This is a result of the method
employed by 'compat/fopen.c' to suppress the (possible) redefinition of
the (system) fopen macro, which also removes the extern declaration of
the git_fopen function.

In order to suppress the warning, introduce a new macro to suppress the
definition (or possibly the re-definition) of the fopen symbol as a
macro override. This new macro (SUPPRESS_FOPEN_REDEFINITION) is only
defined in 'compat/fopen.c', just prior to the inclusion of the
'git-compat-util.h' header file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Duy,

Could you (or Junio) please add this to your 'nd/fopen-errors' branch, either
as a separate patch or squash it into commit 8f4f6e53d2 ("config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD", 20-04-2017). I think it would
be better as a separate commit, but I will leave you to decide on that. ;-)

Thanks!

ATB,
Ramsay Jones

 compat/fopen.c    |  4 ++--
 git-compat-util.h | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/compat/fopen.c b/compat/fopen.c
index b5ca142fe..107b3e818 100644
--- a/compat/fopen.c
+++ b/compat/fopen.c
@@ -1,14 +1,14 @@
 /*
  *  The order of the following two lines is important.
  *
- *  FREAD_READS_DIRECTORIES is undefined before including git-compat-util.h
+ *  SUPPRESS_FOPEN_REDEFINITION is defined before including git-compat-util.h
  *  to avoid the redefinition of fopen within git-compat-util.h. This is
  *  necessary since fopen is a macro on some platforms which may be set
  *  based on compiler options. For example, on AIX fopen is set to fopen64
  *  when _LARGE_FILES is defined. The previous technique of merely undefining
  *  fopen after including git-compat-util.h is inadequate in this case.
  */
-#undef FREAD_READS_DIRECTORIES
+#define SUPPRESS_FOPEN_REDEFINITION
 #include "../git-compat-util.h"
 
 FILE *git_fopen(const char *path, const char *mode)
diff --git a/git-compat-util.h b/git-compat-util.h
index b1e48e5e9..691ebf370 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -698,10 +698,12 @@ char *gitstrdup(const char *s);
 #endif
 
 #ifdef FREAD_READS_DIRECTORIES
-#ifdef fopen
-#undef fopen
-#endif
-#define fopen(a,b) git_fopen(a,b)
+# if !defined(SUPPRESS_FOPEN_REDEFINITION)
+#  ifdef fopen
+#   undef fopen
+#  endif
+#  define fopen(a,b) git_fopen(a,b)
+# endif
 extern FILE *git_fopen(const char*, const char*);
 #endif
 
-- 
2.12.0
