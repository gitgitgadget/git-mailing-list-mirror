Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D4A20705
	for <e@80x24.org>; Thu,  7 Jul 2016 20:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbcGGUtJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:49:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34740 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbcGGUsU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:48:20 -0400
Received: by mail-it0-f65.google.com with SMTP id f6so4487191ith.1
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 13:48:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=diuT+NkWpGeyv72tu1qb2hEsbX2qrWyCC33QVwEWa5Y=;
        b=zTPtF+ZKVpvaVDjX/XFnj9XAET3qhoP+IdXgXp0p7mdd/NmycR2PZ7b8iTnkzb6+fK
         43E+UhQj/AWyTqlzfJJUhdv63QycXEH7+Do8y+sPbvb9XxY0jFEFWR2umGImEeH0/6HI
         ISGiw4yxXXqjyOzbwHokiG9BX0YWZXk9bD+Lt8wVZXl2oOwRFPJHJbZ6pm0ZNqONDfhm
         0yDM048sSFS8bTZ2JOB373iGGIF1kdvM87F/NME1KFBGCQjxAlWuPX1ckO8SWt0ux0Jl
         bdQErj45vpjALmqCyMN7JZufM242BG3Acer3iRTvVAcI428mh8z8ZFlYBeArsR2+6EkG
         AP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=diuT+NkWpGeyv72tu1qb2hEsbX2qrWyCC33QVwEWa5Y=;
        b=NCCWtjM4H1G+P+oDijUO43iSkSkdCx5vwGL/d3mWl7BFU5em0cE2c7rdYB/HIDPvuU
         Y3HRfDLJnlFYU4A5dhVDIbjGk86ADUXLFNAKRL5jetoiTenS7n9zqCtPfgVClKmFK0ki
         zure7+jHI3XeDjAPPccltDxmtYg7CS2kQbQv+5XBImVu/HmENc7CNZ6S0i4CaXDt5CHi
         tCqNMNqUZnqxGRN5CIJiBHObSbzjZjvEbYZ7kTIDTPs2923hHJC9eX3OBypXIMsqpZE9
         FH5WHiXbMDKF15K1TO1wJPu6lhksTNq05YIdK42zlWZV0JLCdoFfazLkdiR/H1Vvdt54
         KftQ==
X-Gm-Message-State: ALyK8tIyKdy2cpRg50duMQ2umcCmdmp48XPMW5sjEqmrgfTUTTpiOFAlBHO8IRRA4nGyOw==
X-Received: by 10.36.222.11 with SMTP id d11mr24537289itg.4.1467924498548;
        Thu, 07 Jul 2016 13:48:18 -0700 (PDT)
Received: from ronalds-mbp.indigobio.com (207-250-246-98.static.twtelecom.net. [207.250.246.98])
        by smtp.gmail.com with ESMTPSA id a17sm2105687ioa.27.2016.07.07.13.48.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 07 Jul 2016 13:48:18 -0700 (PDT)
From:	Ronald Wampler <rdwampler@gmail.com>
To:	git@vger.kernel.org
Cc:	mackyle@gmail.com, reubenhwk@gmail.com, sunshine@sunshineco.com,
	Ronald Wampler <rdwampler@gmail.com>
Subject: [PATCH] Makefile: add NEEDS_LIBRT to optionally link with librt
Date:	Thu,  7 Jul 2016 16:45:54 -0400
Message-Id: <20160707204554.14961-1-rdwampler@gmail.com>
X-Mailer: git-send-email 2.8.2.874.gcf4c2cf
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We unconditionally link with librt, when HAVE_CLOCK_GETTIME is defined.
But clock_gettime() has been available in most libc implementations for
some time now (e.g., for glibc since version 2.17) and no longer
requires linking with librt. Furthermore, commit a6c3c63 (configure.ac:
check for clock_gettime() and CLOCK_MONOTONIC) will automatically
determined which library (libc or librt) is required for linking when
checking for clock_gettime().

The assumption to unconditionally link with librt was OK, since either
almost every Unix-like system provides a version of librt for backwards
compatibility or other systems, namely Windows or OS X, never provided
clock_gettime(). However, in the latest release of OS X (macOS Sierra),
this function has been added to OS X libc version. As a result, when
running the configuration script, HAVE_CLOCK_GETTIME is set and since
librt is not present, it causes a linker error.

This patches requires those not building via the configuration scripts
to define NEEDS_LIBRT in addition to HAVE_CLOCK_GETTIME, if needed.

Signed-off-by: Ronald Wampler <rdwampler@gmail.com>
---
I am not sure if this the correction solution. Another option I
considered was to wrap the EXTLIBS += -lrt is an ifndef NO_RT and only
defining NO_RT for Mac OS X in config.mak.uname.

 Makefile | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index de5a030..32f503e 100644
--- a/Makefile
+++ b/Makefile
@@ -351,9 +351,12 @@ all::
 # Define GMTIME_UNRELIABLE_ERRORS if your gmtime() function does not
 # return NULL when it receives a bogus time_t.
 #
-# Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
+# Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
 #
-# Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC in librt.
+# Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
+#
+# Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
+# before 2.17) for clock_gettime and CLOCK_MONOTONIC.
 #
 # Define USE_PARENS_AROUND_GETTEXT_N to "yes" if your compiler happily
 # compiles the following initialization:
@@ -1465,13 +1468,16 @@ endif

 ifdef HAVE_CLOCK_GETTIME
 	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
-	EXTLIBS += -lrt
 endif

 ifdef HAVE_CLOCK_MONOTONIC
 	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
 endif

+ifdef NEEDS_LIBRT
+	EXTLIBS += -lrt
+endif
+
 ifdef HAVE_BSD_SYSCTL
 	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
 endif
--
2.8.2.874.gcf4c2cf

