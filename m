Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E26491F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeGMRMA (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:31804 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbeGMRL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:11:59 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 312F13F413E;
        Fri, 13 Jul 2018 12:56:32 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BD98C3F4139;
        Fri, 13 Jul 2018 12:56:31 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 02/25] structured-logging: add STRUCTURED_LOGGING=1 to Makefile
Date:   Fri, 13 Jul 2018 16:55:58 +0000
Message-Id: <20180713165621.52017-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the Makefile to take STRUCTURED_LOGGING=1 variable to
compile in/out structured logging feature.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile             |  8 ++++++++
 structured-logging.c |  9 +++++++++
 structured-logging.h | 13 +++++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 structured-logging.c
 create mode 100644 structured-logging.h

diff --git a/Makefile b/Makefile
index 39ca66b..ccc39bf 100644
--- a/Makefile
+++ b/Makefile
@@ -442,6 +442,8 @@ all::
 # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
 # which the built Git will run (for instance "x86_64").
 #
+# Define STRUCTURED_LOGGING if you want structured logging to be available.
+#
 # Define RUNTIME_PREFIX to configure Git to resolve its ancillary tooling and
 # support files relative to the location of the runtime binary, rather than
 # hard-coding them into the binary. Git installations built with RUNTIME_PREFIX
@@ -955,6 +957,7 @@ LIB_OBJS += split-index.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
+LIB_OBJS += structured-logging.o
 LIB_OBJS += submodule.o
 LIB_OBJS += submodule-config.o
 LIB_OBJS += sub-process.o
@@ -1326,6 +1329,10 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS += -lz
 
+ifdef STRUCTURED_LOGGING
+	BASIC_CFLAGS += -DSTRUCTURED_LOGGING
+endif
+
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
@@ -2543,6 +2550,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@+
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
+	@echo STRUCTURED_LOGGING=\''$(subst ','\'',$(subst ','\'',$(STRUCTURED_LOGGING)))'\' >>$@+
 	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE1)))'\' >>$@+
 	@echo USE_LIBPCRE2=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2)))'\' >>$@+
 	@echo NO_LIBPCRE1_JIT=\''$(subst ','\'',$(subst ','\'',$(NO_LIBPCRE1_JIT)))'\' >>$@+
diff --git a/structured-logging.c b/structured-logging.c
new file mode 100644
index 0000000..702fd84
--- /dev/null
+++ b/structured-logging.c
@@ -0,0 +1,9 @@
+#if !defined(STRUCTURED_LOGGING)
+/*
+ * Structured logging is not available.
+ * Stub out all API routines.
+ */
+
+#else
+
+#endif
diff --git a/structured-logging.h b/structured-logging.h
new file mode 100644
index 0000000..c9e8c1d
--- /dev/null
+++ b/structured-logging.h
@@ -0,0 +1,13 @@
+#ifndef STRUCTURED_LOGGING_H
+#define STRUCTURED_LOGGING_H
+
+#if !defined(STRUCTURED_LOGGING)
+/*
+ * Structured logging is not available.
+ * Stub out all API routines.
+ */
+
+#else
+
+#endif /* STRUCTURED_LOGGING */
+#endif /* STRUCTURED_LOGGING_H */
-- 
2.9.3

