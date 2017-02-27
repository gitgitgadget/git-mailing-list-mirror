Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B9E201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 10:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbdB0KpE (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 05:45:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:34689 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdB0KpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 05:45:04 -0500
Received: (qmail 23513 invoked by uid 109); 27 Feb 2017 10:43:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 10:43:40 +0000
Received: (qmail 2865 invoked by uid 111); 27 Feb 2017 10:43:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 05:43:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 05:43:39 -0500
Date:   Mon, 27 Feb 2017 05:43:39 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170227104338.qfaaktf3or4hwfw7@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
 <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
 <8e98a9f9-a431-9170-df9d-24ad8ec59ed7@virtuell-zuhause.de>
 <20170226213042.rd55ykgymmr37c7n@sigill.intra.peff.net>
 <CAMuHMdXZ2ZPsFbPUgmvx8=-xj3GBNBJwLaGAYj+R=Z2zDQJ+hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXZ2ZPsFbPUgmvx8=-xj3GBNBJwLaGAYj+R=Z2zDQJ+hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 10:57:37AM +0100, Geert Uytterhoeven wrote:

> > Yeah, that is a lot more flexible for experimenting. Though I'd think
> > you'd probably want more than 4 bits just to avoid accidental
> > collisions. Something like 24 bits gives you some breathing space (you'd
> > expect a random collision after 4096 objects), but it's still easy to
> > do a preimage attack if you need to.
> 
> Just shortening the hash causes lots of collisions between objects of
> different types. While it's valuable to test git behavior for those cases, you
> probably want some way to explicitly test collisions that do not change
> the object type, as they're not trivial to detect.

Right, that's why I'm suggesting to make a longer truncation so that
you don't get accidental collisions, but can still find a few specific
ones for your testing.

24 bits is enough to make toy repositories. If you wanted to store a
real repository with the truncated sha1s, you might use 36 bits (that's
9 hex characters, which is enough for git.git to avoid any accidental
collisions). But you can still find a collision via brute force in 2^18
tries, which is not so bad.

I.e., something like:

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 22b125cf8..9158e39ed 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -233,6 +233,10 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 
 void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 {
+	/* copy out only the first 36 bits */
+	static const uint32_t mask_bits[5] = {
+		0xffffffff, 0xf0000000
+	};
 	static const unsigned char pad[64] = { 0x80 };
 	unsigned int padlen[2];
 	int i;
@@ -247,5 +251,5 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 
 	/* Output hash */
 	for (i = 0; i < 5; i++)
-		put_be32(hashout + i * 4, ctx->H[i]);
+		put_be32(hashout + i * 4, ctx->H[i] & mask_bits[i]);
 }
Build that and make it available as git.broken, and then feed your repo
into it, like:

  git init --bare fake.git
  git fast-export HEAD | git.broken -C fake.git fast-import

at which point you have an alternate-universe version of the repository,
which you can operate on as usual with your git.broken tool.

And then you can come up with collisions via brute force:

  # hack to convince hash-object to do lots of sha1s in a single
  # invocation
  N=300000
  for i in $(seq $N); do
    echo $i >$i
  done
  seq 300000 | git.broken hash-object --stdin-paths >hashes

  for collision in $(sort hashes | uniq -d); do
	grep -n $collision hashes
  done

The result is that "33713\n" and "170653\n" collide. So you can now add
those to your fake.git repository and watch the chaos ensue.

-Peff
