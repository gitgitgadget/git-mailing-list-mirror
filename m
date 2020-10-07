Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A93C47095
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C967215A4
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 15:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgJGPpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:45:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:52264 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgJGPpe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 11:45:34 -0400
Received: (qmail 20352 invoked by uid 109); 7 Oct 2020 15:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Oct 2020 15:45:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12789 invoked by uid 111); 7 Oct 2020 15:45:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Oct 2020 11:45:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Oct 2020 11:45:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
Message-ID: <20201007154533.GA186764@coredump.intra.peff.net>
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
 <20201007153947.GA181281@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007153947.GA181281@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 07, 2020 at 11:39:47AM -0400, Jeff King wrote:

> You should see the:
> 
>   Receiving objects: 100% (300970/300970), 74.39 MiB | 57.93 MiB/s, done.
> 
> progress. We used to follow that with:
> 
>   Resolving deltas: 100% (249340/249340), done.
> 
> but now you get nothing for several seconds while we resolve deltas.
> 
> The problem bisects to f08cbf60fe (index-pack: make quantum of work
> smaller, 2020-09-08) at the tip of jt/threaded-index-pack. I haven't dug
> further yet.

Hmm. That commit removes the call to display_progress() from the main
loop of threaded_second_pass(), and doesn't appear to add another one
anywhere. Is the solution really as simple as adding it back in? I.e.

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8acd078aa0..6dbb4317e0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1028,6 +1028,10 @@ static void *threaded_second_pass(void *data)
 		struct object_entry *child_obj;
 		struct base_data *child;
 
+		counter_lock();
+		display_progress(progress, nr_resolved_deltas);
+		counter_unlock();
+
 		work_lock();
 		if (list_empty(&work_head)) {
 			/*

That _seems_ to work fine, but I'm not sure why it was removed in the
first place (for a good reason, or simply as an accident when rewriting
the variable declarations at the top of the loop?).

-Peff
