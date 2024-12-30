Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406E171C9
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 04:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735532913; cv=none; b=kX8J5/wQRMAyohuhJfqC2KSRB1DM6kgkKOtgXkBnBVa+6UKdp4ahG3uqyRphJEvyZfduyptQmTSi5WgJ/rEKRWe3SOxeWhEGmMGIlIyyQrniZV1zEKeNURr4HZSzp4opRKFchmxj9COBkFQvdEjhRBWhRw/PV1KGc7pkiV4K7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735532913; c=relaxed/simple;
	bh=X49/AKLQUv13TMj9wHX+Q1lFS9GKp/AyYZ5ubUGeD/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIYP2V6N+tMXQj+CFUn4oQZnlFZr8ZmtIgZu95CZIShHq3A0sDPPt9buI/mqdLa6aA8q0icZ8nBt4wmayzn64ebVFM3fVQCwwxzJhHbLYFQ0V7ZkGxZDnK2tffylnV4wj/FentVOBLAJ+07HsQ8HyoThMlgv1KcVBUXmvgkaP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U84/ZdpJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U84/ZdpJ"
Received: (qmail 14748 invoked by uid 109); 30 Dec 2024 04:28:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=X49/AKLQUv13TMj9wHX+Q1lFS9GKp/AyYZ5ubUGeD/g=; b=U84/ZdpJtBzZVZ6XFPw0uWENG1uN6jUxqL//wl+NJTRxS9PdxbXpC4ueFS5w8uJH/A+tQbxIt01qsbl0VbBZIakBwnm+HolAs5os4J4GDbpMTQQ2iNkJTRO8RNOpnfQSoIeZf1cKjHx2urdjZHQ7FwNZHGG0rrsiWVg99NujbQ33bCKcp4DbcgowwrFpdz6goWAwe7pOrxwnWRY5TM7h3Q9zJq2uorIoecudBSHRq6pGxs5Wg9nsau9o3fL1mkaDZXJBKa3idF/QnlRxET7MM/m66sMyIJOLq7i9biNx03axW2GZgl6d+cH2n6B7r+253Vb9js/mjDNU6Hy104Evfw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Dec 2024 04:28:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14295 invoked by uid 111); 30 Dec 2024 04:28:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2024 23:28:30 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 29 Dec 2024 23:28:30 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] thread-utils: introduce optional barrier type
Message-ID: <20241230042830.GC113400@coredump.intra.peff.net>
References: <20241230042325.GA112439@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230042325.GA112439@coredump.intra.peff.net>

One thread primitive we don't yet support is a barrier: it waits for all
threads to reach a synchronization point before letting any of them
continue. This would be useful for avoiding the LSan race we see in
index-pack (and other places) by having all threads complete their
initialization before any of them start to do real work.

POSIX introduced a pthread_barrier_t in 2004, which does what we want.
But if we want to rely on it:

  1. Our Windows pthread emulation would need a new set of wrapper
     functions. There's a Synchronization Barrier primitive there, which
     was introduced in Windows 8 (which is old enough for us to depend
     on).

  2. macOS (and possibly other systems) has pthreads but not
     pthread_barrier_t. So there we'd have to implement our own barrier
     based on the mutex and cond primitives.

Those are do-able, but since we only care about avoiding races in our
LSan builds, there's an easier way: make it a noop on systems without a
native pthread barrier.

This patch introduces a "maybe_thread_barrier" API. The clunky name
(rather than just using pthread_barrier directly) should hopefully clue
people in that on some systems it will do nothing. It's wired to a
Makefile knob which has to be triggered manually, and we enable it for
the linux-leaks CI jobs (since we know we'll have it there).

There are some other possible options:

  - we could turn it on all the time for Linux systems based on uname.
    But we really only care about it for LSan builds, and there is no
    need to add extra code to regular builds.

  - we could turn it on only for LSan builds. But that would break
    builds on non-Linux platforms (like macOS) that otherwise should
    support sanitizers.

  - we could trigger only on the combination of Linux and LSan together.
    This isn't too hard to do, but the uname check isn't completely
    accurate. It is really about what your libc supports, and non-glibc
    systems might not have it (though at least musl seems to).

    So we'd risk breaking builds on those systems, which would need to
    add a new knob. Though the upside would be that running local "make
    SANITIZE=leak test" would be protected automatically.

And of course none of this protects LSan runs from races on systems
without pthread barriers. It's probably OK in practice to protect only
our CI jobs, though. The race is rare-ish and most leak-checking happens
through CI.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile       |  7 +++++++
 ci/lib.sh      |  1 +
 thread-utils.h | 17 +++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Makefile b/Makefile
index 97e8385b66..2c6dad8a75 100644
--- a/Makefile
+++ b/Makefile
@@ -141,6 +141,10 @@ include shared.mak
 #
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
 #
+# Define THREAD_BARRIER_PTHREAD if your system has pthread_barrier_t. Barrier
+# support is optional and is only helpful when building with SANITIZE=leak, as
+# it is used to eliminate some races in the leak-checker.
+#
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
 # cygwin1.dll before v1.5.22).
 #
@@ -2079,6 +2083,9 @@ ifdef NO_PTHREADS
 else
 	BASIC_CFLAGS += $(PTHREAD_CFLAGS)
 	EXTLIBS += $(PTHREAD_LIBS)
+	ifdef THREAD_BARRIER_PTHREAD
+		BASIC_CFLAGS += -DTHREAD_BARRIER_PTHREAD
+	endif
 endif
 
 ifdef HAVE_PATHS_H
diff --git a/ci/lib.sh b/ci/lib.sh
index 8885ee3c3f..6a1267fbcb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -385,6 +385,7 @@ linux-musl)
 	;;
 linux-leaks|linux-reftable-leaks)
 	export SANITIZE=leak
+	export THREAD_BARRIER_PTHREAD=1
 	;;
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
diff --git a/thread-utils.h b/thread-utils.h
index 4961487ed9..3df5be9916 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -53,5 +53,22 @@ int dummy_pthread_init(void *);
 int online_cpus(void);
 int init_recursive_mutex(pthread_mutex_t*);
 
+#ifdef THREAD_BARRIER_PTHREAD
+#define maybe_thread_barrier_t pthread_barrier_t
+#define maybe_thread_barrier_init pthread_barrier_init
+#define maybe_thread_barrier_wait pthread_barrier_wait
+#define maybe_thread_barrier_destroy pthread_barrier_destroy
+#else
+#define maybe_thread_barrier_t int
+static inline int maybe_thread_barrier_init(maybe_thread_barrier_t *b UNUSED,
+					    void *attr UNUSED,
+					    unsigned nr UNUSED)
+{
+	errno = ENOSYS;
+	return -1;
+}
+#define maybe_thread_barrier_wait(barrier)
+#define maybe_thread_barrier_destroy(barrier)
+#endif
 
 #endif /* THREAD_COMPAT_H */
-- 
bar

