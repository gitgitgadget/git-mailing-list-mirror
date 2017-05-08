Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6E32018D
	for <e@80x24.org>; Mon,  8 May 2017 20:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754074AbdEHUp7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 16:45:59 -0400
Received: from avasout08.plus.net ([212.159.14.20]:44301 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbdEHUp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 16:45:59 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id Hwlw1v0041keHif01wlxpv; Mon, 08 May 2017 21:45:57 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=CWGfFUOg59lARSWTUH8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] git_fopen: fix a sparse 'not declared' warning
Message-ID: <2bf7d61e-c70f-a033-5cb2-2a66ac6fe459@ramsayjones.plus.com>
Date:   Mon, 8 May 2017 21:45:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


If git is built with the FREAD_READS_DIRECTORIES build variable set, this
would cause sparse to issue a 'not declared, should it be static?' warning
on Linux. This is a result of the method employed by 'compat/fopen.c' to
suppress the (possible) redefinition of the (system) fopen macro, which
also removes the extern declaration of the git_fopen function.

In order to suppress the warning, introduce a new macro to suppress the
definition (or possibly the re-definition) of the fopen symbol as a macro
override. This new macro (SUPPRESS_FOPEN_REDEFINITION) is only defined in
'compat/fopen.c', just prior to the inclusion of the 'git-compat-util.h'
header file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

I noticed the "What's cooking" entry for Duy's 'nd/fopen-errors'
branch 'needs to resurrect' this patch, so I re-worded the commit
message (because commit 8f4f6e53d2 is no more ...) so that it could
stand alone. (or on the new re-rolled branch).

Thanks.

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
index df7b41524..33e06cac1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -694,10 +694,12 @@ char *gitstrdup(const char *s);
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
