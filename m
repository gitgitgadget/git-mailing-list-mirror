Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B319FC63798
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A22124677
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgKQAYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:24:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:59836 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKQAYg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 19:24:36 -0500
Received: (qmail 12593 invoked by uid 109); 17 Nov 2020 00:24:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 00:24:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20550 invoked by uid 111); 17 Nov 2020 00:24:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Nov 2020 19:24:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Nov 2020 19:24:35 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] chdir-notify: UNLEAK registrated callback entries
Message-ID: <20201117002435.GA13516@coredump.intra.peff.net>
References: <8a9cf9ba-f615-3ff5-8d35-c24c22d5d859@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a9cf9ba-f615-3ff5-8d35-c24c22d5d859@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 14, 2020 at 10:40:01PM +0100, René Scharfe wrote:

> chdir_notify_register() allows registering functions to notify when
> chdir() is called.  There is no way to unsubscribe or shut this
> mechanism down, so these entries are present until the program ends.
> 
> Valgrind reports allocations for these registrations as "possibly lost",
> probably because it doesn't see through list.h's offsetof tricks.
> Annotate them using UNLEAK, which causes Valgrind to report them as
> "still reachable" instead.

I can't say I'm excited to see UNLEAK used here. It was really intended
for items going out of scope that weren't worth cleaning up. But here
we're papering over a failure in the memory checking tool for something
that _is_ in scope.

I guess I'm not too surprised that valgrind has trouble with list.h. We
have pointers into a heap-allocated block, but not the start of it.
Curiously, ASan/LSan get this case right. So my first instinct is: use
those tools, they're better. :)

If we did want to paper over this case for valgrind, I think this is a
better way to do so:

diff --git a/chdir-notify.c b/chdir-notify.c
index 5f7f2c2ac2..ddfe703b1a 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -4,10 +4,10 @@
 #include "strbuf.h"
 
 struct chdir_notify_entry {
+	struct list_head list;
 	const char *name;
 	chdir_notify_callback cb;
 	void *data;
-	struct list_head list;
 };
 static LIST_HEAD(chdir_notify_entries);
 

I also wonder if valgrind _is_ aware of the distinction, and that's why
these show up as only "possibly lost". And indeed, the faq[1] says:

 - "possibly lost" means your program is leaking memory, unless you're
   doing unusual things with pointers that could cause them to point
   into the middle of an allocated block; see the user manual for some
   possible causes. Use --show-possibly-lost=no if you don't want to see
   these reports.

and the user manual[2] has a more elaborate example that calls these
"interior pointers". So I think that's exactly what is going on here.

But then I'm not sure why we'd want this patch. List pointers (and now
hashmap entries, which also contain a linked-list chain) are used in
lots of data structures. Fixing this one case manually is not that
interesting. If we're going to use valgrind, we probably need to accept
that its "possibly lost" distinction is not useful for our code and turn
it off.

-Peff

[1] https://valgrind.org/docs/manual/faq.html#faq.deflost

[2] https://valgrind.org/docs/manual/mc-manual.html#mc-manual.leaks
