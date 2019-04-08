Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E235C20248
	for <e@80x24.org>; Tue,  9 Apr 2019 11:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDIL1Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 07:27:25 -0400
Received: from srv1.79p.de ([213.239.234.118]:44726 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfDIL1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 07:27:25 -0400
Received: from srv1.79p.de (localhost [127.0.0.1])
        by srv1.79p.de (Postfix) with ESMTP id A70EC220063;
        Tue,  9 Apr 2019 13:27:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: by srv1.79p.de (Postfix, from userid 1000)
        id 46279220068; Tue,  9 Apr 2019 13:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2019; t=1554809243;
        bh=vcr6UaxptFV3t6ds4j1bd5o0klD5ysBucBu6omwWH8Q=;
        h=From:Date:Subject:To:Cc:In-Reply-To:References:From;
        b=E9jBMfhsLCq3X2AssUpfqwBpobQyLiQeu2y+CmohQhutmH35BDAGGtxfuZ5DTiA7X
         o+qdwyhvdqKiC+35AihDtZzSyKhXMw1zFbLv5n57lziTes59hD/Jwci+TDL7EwiCCL
         Suj7hzKGXRz0HcZ13y3gm7zggwZ7uopmewZ/i4KTm7sH/UCRWkio3uUSGCf7IGvY/c
         w/14Iz69U9bOrAvkEc5FWtnuV8g5XR5838G8Tld3wAvZoE2BAQPAN9dbDNw76eHebE
         a6a9uaGjB1Ej7SgGGhH1Uz90L3Oy5UhF9ZLL6CKjXfu8RoL+6MPHNjqejsMnpXINCc
         PVr7WE7jn6WAA==
From:   Sven Strickroth <email@cs-ware.de>
Date:   Mon, 8 Apr 2019 13:26:16 +0200
Subject: [PATCH v2] MSVC: Unbreak real_path for Windows paths
To:     =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2VuIA==?= <tboegi@web.de>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de
Message-Id: <31485f76-13a9-ec3b-16b9-78864490164d@cs-ware.de>
In-Reply-To: <950ee9b8-786f-28cd-3e89-ad174fd857a4@cs-ware.de>
References: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
 <0f629384-638f-bfb9-89da-ade335e364fd@web.de>
 <950ee9b8-786f-28cd-3e89-ad174fd857a4@cs-ware.de>
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A path such as 'c:/somepath/submodule/../.git/modules/submodule' wasn't
resolved correctly any more, because the *nix variant of offset_1st_component
is used instead of the Win32 specific version.

Regression was introduced in commit 1cadad6f6 when mingw_offset_1st_component
was moved from mingw.c which is included by msvc.c to a separate file. Then,
the new file "compat/win32/path-utils.h" was only included for the __CYGWIN__
and __MINGW32__ cases in git-compat-util.h, the case for _MSC_VER was missing.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 config.mak.uname  | 1 +
 git-compat-util.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 32381f5fd1..eb1428858c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -426,6 +426,7 @@ ifeq ($(uname_S),Windows)
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
+		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o compat/win32/fscache.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
diff --git a/git-compat-util.h b/git-compat-util.h
index e0275da7e0..9be177e588 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -210,6 +210,7 @@
 #include "compat/mingw.h"
 #include "compat/win32/fscache.h"
 #elif defined(_MSC_VER)
+#include "compat/win32/path-utils.h"
 #include "compat/msvc.h"
 #include "compat/win32/fscache.h"
 #else
-- 
2.21.0.windows.1
