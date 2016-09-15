Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33393207DF
	for <e@80x24.org>; Thu, 15 Sep 2016 07:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933952AbcIOHIQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 03:08:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:43563 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933563AbcIOHIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 03:08:16 -0400
Received: (qmail 14756 invoked by uid 109); 15 Sep 2016 07:01:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 07:01:33 +0000
Received: (qmail 7118 invoked by uid 111); 15 Sep 2016 07:01:44 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 03:01:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2016 00:01:30 -0700
Date:   Thu, 15 Sep 2016 00:01:30 -0700
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] object: measure time needed for resolving hash collisions
Message-ID: <20160915070129.w66dxntm45qngceo@sigill.intra.peff.net>
References: <20160915020141.32000-1-sbeller@google.com>
 <20160915064701.c4ishixuynbzpgwx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160915064701.c4ishixuynbzpgwx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 11:47:01PM -0700, Jeff King wrote:

> >  	first = i = hash_obj(sha1, obj_hash_size);
> > +	clock_gettime(CLOCK_MONOTONIC, &time1);
> >  	while ((obj = obj_hash[i]) != NULL) {
> >  		if (!hashcmp(sha1, obj->oid.hash))
> >  			break;
> > @@ -98,6 +131,9 @@ struct object *lookup_object(const unsigned char *sha1)
> >  		if (i == obj_hash_size)
> >  			i = 0;
> >  	}
> > +	clock_gettime(CLOCK_MONOTONIC, &time2);
> > +	diff(&time1, &time2, &t_diff);
> > +	add_time_to(&caching, &t_diff);
> >  	if (obj && i != first) {
> 
> I don't think this is actually measuring the time spent on collisions.
> It's measuring the time we spend in hashcmp(), but that includes the
> non-collision case where we find it in the first hashcmp.
> 
> Measuring _just_ the collisions is more like the patch below. In my
> measurements it's more like 30ms, compared to 10s for all of the
> hashcmps.

I forgot to send the patch. Which is just as well, because I realized it
was totally buggy.

Here's a patch that I believe is correct (it counts only times when we
move past the first hash slot). It spends about 280ms. Which is still a
lot less than 10s, so I think my other comments stand.

---
diff --git a/object.c b/object.c
index e9e73e0..7a74a1d 100644
--- a/object.c
+++ b/object.c
@@ -123,17 +123,20 @@ struct object *lookup_object(const unsigned char *sha1)
 		return NULL;
 
 	first = i = hash_obj(sha1, obj_hash_size);
-	clock_gettime(CLOCK_MONOTONIC, &time1);
 	while ((obj = obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->oid.hash))
 			break;
+		if (first == i)
+			clock_gettime(CLOCK_MONOTONIC, &time1);
 		i++;
 		if (i == obj_hash_size)
 			i = 0;
 	}
-	clock_gettime(CLOCK_MONOTONIC, &time2);
-	diff(&time1, &time2, &t_diff);
-	add_time_to(&caching, &t_diff);
+	if (i != first) {
+		clock_gettime(CLOCK_MONOTONIC, &time2);
+		diff(&time1, &time2, &t_diff);
+		add_time_to(&caching, &t_diff);
+	}
 	if (obj && i != first) {
 		/*
 		 * Move object to where we started to look for it so
