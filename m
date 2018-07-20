Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB921F597
	for <e@80x24.org>; Fri, 20 Jul 2018 05:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbeGTGO7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 02:14:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:53622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726555AbeGTGO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 02:14:59 -0400
Received: (qmail 28021 invoked by uid 109); 20 Jul 2018 05:28:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 05:28:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19915 invoked by uid 111); 20 Jul 2018 05:28:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 20 Jul 2018 01:28:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2018 01:28:29 -0400
Date:   Fri, 20 Jul 2018 01:28:29 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
Message-ID: <20180720052829.GA3852@sigill.intra.peff.net>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
 <20180719151640.GA24997@duynguyen.home>
 <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
 <20180719172358.GD4868@sigill.intra.peff.net>
 <20180719173135.GA24563@duynguyen.home>
 <20180719182442.GA5796@duynguyen.home>
 <CABPp-BEo1Ar17uwX=ib8iVYosdwhTXhdMWvi7kgqDb3iPQoj5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEo1Ar17uwX=ib8iVYosdwhTXhdMWvi7kgqDb3iPQoj5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 04:11:01PM -0700, Elijah Newren wrote:

> Looking at the output from Peff's instrumentation elsewhere in this
> thread, I see a lot of lines like
>    mismatched get: 32889efd307c7be376da9e3d45a78305f14ba73a = (, 28)
> Does that mean it was reading the array when it wasn't ready?

Yes, it looks like we saw a "get" without a "set". Though this could
also be due to threading. The tracing isn't atomic with respect to the
actual get/set operation, so it's possible that the ordering of the
trace output does not match the ordering of the actual operations.

> However, it's interesting to also look at the effect on packing
> linux.git (on the same beefy hardware):
> 
> Version  Pack (MB)  MaxRSS(kB)  Time (s)
> -------  ---------  ----------  --------
>  2.17.0     1279     11382932      632.24
>  2.18.0     1279     10817568      621.97
>  fiv-v4     1279     11484168     1193.67
> 
> While the pack size is nice and small, the original memory savings
> added in 2.18.0 are gone and the performance is much worse.  :-(

Interesting. I can't reproduce here. The fix-v4 case is only slightly
slower than 2.18.0. Can you double check that your compiler flags, etc,
were the same? Many times I've accidentally compared -O0 to -O0. :)

You might also try the patch below (on top of fix-v4), which moves the
locking to its own dedicated mutex. That should reduce lock contention,
and it fixes the remaining realloc where I think we're still racy. On my
repack of linux.git, it dropped the runtime from 6m3s to 5m41s, almost
entirely in system CPU.

I didn't measure my max rss. However, I'd caution slightly against
drawing too much conclusion from it, for two reasons:

  1. RSS includes mmap'd packfiles, which is subject to whatever pages
     the OS feels like keeping in RAM. So using more heap can sometimes
     go unnoticed in that count, since you're just trading heap pages
     for mmap pages. Although that implies some memory pressure, and it
     sounds like your machine is sufficiently beefy to avoid that.

  2. Peak heap is going to depend on the threading. You have one thread
     per CPU working on a window of objects, each of which will be in
     memory at once. So I'd expect a fair bit of fluctuation in the peak
     just depending on how the threads line up with each other (some of
     it random, and some of it maybe impacted by what the code does, but
     in a way that just happens to fall out for this specific workload).

Which isn't to say measuring it is useless. The trends may override the
noise from those two things. I've just run into problems in the past
trying to get consistent measurements.

Here's the lock patch.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba14a1bfbc..b76ce04cb9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1926,12 +1926,12 @@ static unsigned long oe_delta_size(struct packing_data *pack,
 {
 	unsigned long size;
 
-	read_lock();	 /* to protect access to pack->delta_size[] */
+	pack_delta_lock(pack);
 	if (pack->delta_size)
 		size = pack->delta_size[e - pack->objects];
 	else
 		size = e->delta_size_;
-	read_unlock();
+	pack_delta_unlock(pack);
 	return size;
 }
 
@@ -1939,10 +1939,10 @@ static void oe_set_delta_size(struct packing_data *pack,
 			      struct object_entry *e,
 			      unsigned long size)
 {
-	read_lock();	 /* to protect access to pack->delta_size[] */
+	pack_delta_lock(pack);
 	if (!pack->delta_size && size < pack->oe_delta_size_limit) {
 		e->delta_size_ = size;
-		read_unlock();
+		pack_delta_unlock(pack);
 		return;
 	}
 	/*
@@ -1963,7 +1963,7 @@ static void oe_set_delta_size(struct packing_data *pack,
 			pack->delta_size[i] = pack->objects[i].delta_size_;
 	}
 	pack->delta_size[e - pack->objects] = size;
-	read_unlock();
+	pack_delta_unlock(pack);
 }
 
 static int try_delta(struct unpacked *trg, struct unpacked *src,
diff --git a/pack-objects.c b/pack-objects.c
index e3c32bbfc2..8d9c2dfb82 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -148,6 +148,10 @@ void prepare_packing_data(struct packing_data *pdata)
 					     1U << OE_SIZE_BITS);
 	pdata->oe_delta_size_limit = git_env_ulong("GIT_TEST_OE_DELTA_SIZE",
 						   1U << OE_DELTA_SIZE_BITS);
+
+#ifndef NO_PTHREADS
+	pthread_mutex_init(&pdata->delta_lock, NULL);
+#endif
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -162,8 +166,10 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 		if (!pdata->in_pack_by_idx)
 			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
+		pack_delta_lock(pdata);
 		if (pdata->delta_size)
 			REALLOC_ARRAY(pdata->delta_size, pdata->nr_alloc);
+		pack_delta_unlock(pdata);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
diff --git a/pack-objects.h b/pack-objects.h
index 730990c5d2..29b6006949 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -130,6 +130,9 @@ struct packing_data {
 
 	unsigned int *in_pack_pos;
 	uint32_t *delta_size;
+#ifndef NO_PTHREADS
+	pthread_mutex_t delta_lock;
+#endif
 
 	/*
 	 * Only one of these can be non-NULL and they have different
@@ -144,6 +147,14 @@ struct packing_data {
 	uintmax_t oe_delta_size_limit;
 };
 
+#ifndef NO_PTHREADS
+#define pack_delta_lock(pdata) pthread_mutex_lock(&pdata->delta_lock)
+#define pack_delta_unlock(pdata) pthread_mutex_unlock(&pdata->delta_lock)
+#else
+#define pack_delta_lock(pdata)
+#define pack_delta_unlock(pdata)
+#endif
+
 void prepare_packing_data(struct packing_data *pdata);
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
