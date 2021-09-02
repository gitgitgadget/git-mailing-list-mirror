Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE151C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 08:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53E661051
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 08:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244361AbhIBIxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 04:53:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:37222 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233546AbhIBIxw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 04:53:52 -0400
Received: (qmail 21704 invoked by uid 109); 2 Sep 2021 08:52:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 08:52:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22650 invoked by uid 111); 2 Sep 2021 08:52:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 04:52:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 04:52:53 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote: avoid -Wunused-but-set-variable in gcc with
 -DNDEBUG
Message-ID: <YTCQ5aJXPMTUpKs8@coredump.intra.peff.net>
References: <20210902073631.50062-1-carenas@gmail.com>
 <YTCO56kbtQbODDeK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTCO56kbtQbODDeK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[dropped Patrick from cc; that address isn't valid anymore, and he's not
active in Git development these days]

On Thu, Sep 02, 2021 at 04:44:23AM -0400, Jeff King wrote:

> > this breaks the build with -DNDEBUG because the assert gets compiled
> > out and therefore the variable used to check is never used
> 
> Right, this is the real point of the patch. Compiling with NDEBUG will
> result in a warning.

Taking all of my suggestions together yields something like:

-- >8 --
From: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Subject: [PATCH] remote: avoid -Wunused-but-set-variable in gcc with -DNDEBUG

In make_remote(), we store the return value of hashmap_put() and check
it using assert(), but don't otherwise use it. If Git is compiled with
NDEBUG, then the assert() becomes a noop, and nobody looks at the
variable at all. This causes some compilers to produce warnings.

Let's switch it instead to a BUG(). This accomplishes the same thing,
but is always compiled in (and we don't have to worry about the cost;
the check is cheap, and this is not a hot code path).

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index dfb863d808..40e785da38 100644
--- a/remote.c
+++ b/remote.c
@@ -135,7 +135,7 @@ static inline void init_remotes_hash(void)
 
 static struct remote *make_remote(const char *name, int len)
 {
-	struct remote *ret, *replaced;
+	struct remote *ret;
 	struct remotes_hash_key lookup;
 	struct hashmap_entry lookup_entry, *e;
 
@@ -162,8 +162,8 @@ static struct remote *make_remote(const char *name, int len)
 	remotes[remotes_nr++] = ret;
 
 	hashmap_entry_init(&ret->ent, lookup_entry.hash);
-	replaced = hashmap_put_entry(&remotes_hash, ret, ent);
-	assert(replaced == NULL);  /* no previous entry overwritten */
+	if (hashmap_put_entry(&remotes_hash, ret, ent))
+		BUG("hashmap_put overwrote entry after hashmap_get returned NULL");
 	return ret;
 }
 
-- 
2.33.0.446.g793367f49a

