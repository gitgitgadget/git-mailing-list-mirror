Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE34A2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 21:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755146AbcJZV5l (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 17:57:41 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34989 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754809AbcJZV5k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 17:57:40 -0400
Received: by mail-pf0-f169.google.com with SMTP id s8so3700781pfj.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UhORlxcfo//uU8YbKObw1G+O5+F88zzTEbUAeNsypIE=;
        b=hIzDkNAO95gjT/VYpx3fujiCpzpM+nEqEeoT16NXxW47Eqp8ZUyGB2i6eGcBeb7vXb
         JDfHFO7cuA6gwzaVXHbXm9HNMPX0yLee3oj9rP9WdgyjfBxg8FfojCdnWplQGpGDS61Z
         QcWDzDNQLOYTuSpWtJKGpfrZgnNgCFa277rwpb3nZfipt+Bb3jRV20dlWl5saSSL/tBg
         CAOieDP6PKY79kJUs4OsCMlwjOjYY/YzoiB7cmaJI/z7M/OtOKIshM2o77pRZiK1j12m
         uswq0djnHEdPp166pESpc7dS9axVjFr0BNhMPcyIIB9uPIF8IoVaVH3cO5x80+fOjz5f
         KmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UhORlxcfo//uU8YbKObw1G+O5+F88zzTEbUAeNsypIE=;
        b=h+eOiWsY2cPRRDRYTgOcJI2ElVULrYZmezd3tpHEOUpbIqDNNs8IbtOs+SBi96MmI9
         /99QjFiat/hUsi5fsT9O7y6sx/hGtJvHnLZN4E+F9celRjTUTyyDB4jKbu75Y8WLeyKm
         QFUMFeOQaUBvoUeUo2EkWeytBD2qrgorNAo3ecaTc19Pkv99unrYWfRs+fihr30H9uT4
         5jPCiCwwBENIDUGdBLSAuKvgv8yERZ3ta93mMxj9bPu8g8X7Xb3ZfqXjvuemG+uJtkcz
         r6We5wHSpz8SIh3JpaVl4sH1Di/LElc9Vl/lMGx44vEhMCBuhOwDSkVADn+2DadEBLjd
         qpng==
X-Gm-Message-State: ABUngveQoNovG4gP/r1LTaeC/2UbeqX3O9/C6NU8G3ARjYyOGJ60r7+DvUGtB+J/kkUzs3LZ
X-Received: by 10.98.21.197 with SMTP id 188mr7968138pfv.38.1477519059114;
        Wed, 26 Oct 2016 14:57:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:14d0:6024:c11b:baba])
        by smtp.gmail.com with ESMTPSA id t5sm6330732pfb.58.2016.10.26.14.57.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Oct 2016 14:57:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     Johannes.Schindelin@gmx.de, j6t@kdbg.org
Cc:     git@vger.kernel.org, simon@ruderich.org, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] compat: Allow static initializer for pthreads on Windows
Date:   Wed, 26 Oct 2016 14:57:32 -0700
Message-Id: <20161026215732.16411-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Windows it is not possible to have a static initialized mutex as of
now, but that seems to be painful for the upcoming refactoring of the
attribute subsystem, as we have no good place to put the initialization
of the attr global lock.

The trick is to get a named mutex as CreateMutex[1] will return the
existing named mutex if it exists in a thread safe way, or return
a newly created mutex with that name.

Inside the critical section of the single named mutex, we need to double
check if the mutex was already initialized because the outer check is
not sufficient.
(e.g. 2 threads enter the first condition `(!a)` at the same time, but
only one of them will acquire the named mutex first and proceeds to
initialize the given mutex a. The second thread shall not re-initialize
the given mutex `a`, which is why we have the inner condition on `(!a)`.

Due to the use of memory barriers inside the critical section the mutex
`a` gets updated to other threads, such that any further invocation
will skip the initialization check code altogether on the first condition.

[1] https://msdn.microsoft.com/en-us/library/windows/desktop/ms682411(v=vs.85).aspx

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Flying blind here, i.e. not compiled, not tested. For a system I do not
 have deep knowledge of. The only help was the online documentation.

 compat/win32/pthread.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 1c16408..a900513 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -21,9 +21,25 @@
 static inline int return_0(int i) {
 	return 0;
 }
+
+#define PTHREAD_MUTEX_INITIALIZER NULL
 #define pthread_mutex_init(a,b) return_0((InitializeCriticalSection((a)), 0))
 #define pthread_mutex_destroy(a) DeleteCriticalSection((a))
-#define pthread_mutex_lock EnterCriticalSection
+#define pthread_mutex_lock(a) \
+{ \
+	if (!a) { \
+		HANDLE p = CreateMutex(NULL, FALSE, "Git-Global-Windows-Mutex"); \
+		EnterCriticalSection(p); \
+		MemoryBarrier(); \
+		if (!a)
+			pthread_mutex_init(a); \
+		MemoryBarrier(); \
+		ReleaseMutex(p); \
+	} \
+	EnterCriticalSection(a); \
+}
+
+
 #define pthread_mutex_unlock LeaveCriticalSection
 
 typedef int pthread_mutexattr_t;
-- 
2.10.1.508.g6572022

