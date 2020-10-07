Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329AFC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC87A2177B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgJGSTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:19:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:52638 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgJGSTo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:19:44 -0400
Received: (qmail 21276 invoked by uid 109); 7 Oct 2020 18:19:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Oct 2020 18:19:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14915 invoked by uid 111); 7 Oct 2020 18:19:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Oct 2020 14:19:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Oct 2020 14:19:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: [PATCH 2/3] index-pack: drop type_cas mutex
Message-ID: <20201007181943.GB1976631@coredump.intra.peff.net>
References: <20201007181708.GA222564@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007181708.GA222564@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The type_cas lock lost all of its callers in f08cbf60fe (index-pack:
make quantum of work smaller, 2020-09-08), so we can safely delete it.
The compiler didn't alert us that the variable became unused, because we
still call pthread_mutex_init() and pthread_mutex_destroy() on it.

It's worth considering also whether that commit was in error to remove
the use of the lock. Why don't we need it now, if we did before, as
described in ab791dd138 (index-pack: fix race condition with duplicate
bases, 2014-08-29)? I think the answer is that we now look at and assign
the child_obj->real_type field in the main thread while holding the
work_lock(). So we don't have to worry about racing with the worker
threads.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0f05533902..f8f1b48e56 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -159,10 +159,6 @@ static pthread_mutex_t deepest_delta_mutex;
 #define deepest_delta_lock()	lock_mutex(&deepest_delta_mutex)
 #define deepest_delta_unlock()	unlock_mutex(&deepest_delta_mutex)
 
-static pthread_mutex_t type_cas_mutex;
-#define type_cas_lock()		lock_mutex(&type_cas_mutex)
-#define type_cas_unlock()	unlock_mutex(&type_cas_mutex)
-
 static pthread_key_t key;
 
 static inline void lock_mutex(pthread_mutex_t *mutex)
@@ -186,7 +182,6 @@ static void init_thread(void)
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
-	pthread_mutex_init(&type_cas_mutex, NULL);
 	if (show_stat)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
@@ -209,7 +204,6 @@ static void cleanup_thread(void)
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
-	pthread_mutex_destroy(&type_cas_mutex);
 	if (show_stat)
 		pthread_mutex_destroy(&deepest_delta_mutex);
 	for (i = 0; i < nr_threads; i++)
-- 
2.29.0.rc0.520.gccaf68d5cd

