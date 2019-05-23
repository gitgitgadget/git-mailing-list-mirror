Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2F51F462
	for <e@80x24.org>; Thu, 23 May 2019 05:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfEWFvL (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 01:51:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:36688 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725873AbfEWFvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 01:51:11 -0400
Received: (qmail 7452 invoked by uid 109); 23 May 2019 05:51:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 May 2019 05:51:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27803 invoked by uid 111); 23 May 2019 05:51:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 May 2019 01:51:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 May 2019 01:51:09 -0400
Date:   Thu, 23 May 2019 01:51:09 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] trace2: fix tracing when NO_PTHREADS is defined
Message-ID: <20190523055108.GA20871@sigill.intra.peff.net>
References: <pull.222.git.gitgitgadget@gmail.com>
 <20190521212744.GC14807@sigill.intra.peff.net>
 <97796007-db6e-f2ea-91ae-3113b74e4ae9@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97796007-db6e-f2ea-91ae-3113b74e4ae9@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 22, 2019 at 09:23:39AM -0400, Jeff Hostetler wrote:

> I was wondering about that too as the proper long term solution.
> We would need (as the discussion suggests [1]) to properly
> respect/represent the pthread_key_t argument.
> 
> For now, I've guarded my usage of pthread_getspecific() in the trace2
> (similar to what index-pack does), so its not urgent that we update it.
> And I'd rather we take this simple trace2 fix now and not try to combine
> it with fixes for the pthread macros.  Especially now as we're in the RC
> cycle for 2.22.

Yeah, I think that makes sense.

> I'll make a note to revisit the pthread code after 2.22.

For fun, here's a constant-time zero-allocation implementation that I
came up with. It passes t0211 with NO_PTHREADS, but I didn't test it
beyond that.

diff --git a/thread-utils.h b/thread-utils.h
index 4961487ed9..f466215742 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -18,7 +18,7 @@
 #define pthread_t int
 #define pthread_mutex_t int
 #define pthread_cond_t int
-#define pthread_key_t int
+#define pthread_key_t git_pthread_key_t
 
 #define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
 #define pthread_mutex_lock(mutex)
@@ -31,16 +31,49 @@
 #define pthread_cond_broadcast(cond)
 #define pthread_cond_destroy(cond)
 
-#define pthread_key_create(key, attr) dummy_pthread_init(key)
-#define pthread_key_delete(key)
+#define pthread_key_create(key, destroy) git_pthread_key_create(key, destroy)
+#define pthread_key_delete(key) git_pthread_key_delete(key)
 
 #define pthread_create(thread, attr, fn, data) \
 	dummy_pthread_create(thread, attr, fn, data)
 #define pthread_join(thread, retval) \
 	dummy_pthread_join(thread, retval)
 
-#define pthread_setspecific(key, data)
-#define pthread_getspecific(key) NULL
+#define pthread_setspecific(key, data) git_pthread_setspecific(key, data)
+#define pthread_getspecific(key) git_pthread_getspecific(key)
+
+typedef struct {
+	void *data;
+	/* extra indirection because setspecific is passed key by value */
+	void **vdata;
+} git_pthread_key_t;
+
+static inline int git_pthread_key_create(git_pthread_key_t *key,
+					 void (*destroy)(void *))
+{
+	key->data = NULL;
+	key->vdata = &key->data;
+	/* We don't use this; alternatively we could all via atexit(). */
+	if (destroy)
+		BUG("NO_PTHREADS does not support pthread key destructors");
+	return 0;
+}
+
+static inline int git_pthread_key_delete(git_pthread_key_t key)
+{
+	/* noop */
+	return 0;
+}
+
+static inline void git_pthread_setspecific(git_pthread_key_t key, void *data)
+{
+	*(key.vdata) = data;
+}
+
+static inline void *git_pthread_getspecific(git_pthread_key_t key)
+{
+	return key.data;
+}
 
 int dummy_pthread_create(pthread_t *pthread, const void *attr,
 			 void *(*fn)(void *), void *data);
