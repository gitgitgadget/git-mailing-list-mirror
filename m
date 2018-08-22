Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814951F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeHVSj0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 14:39:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728568AbeHVSj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 14:39:26 -0400
Received: (qmail 18293 invoked by uid 109); 22 Aug 2018 15:14:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 15:14:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 374 invoked by uid 111); 22 Aug 2018 15:14:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 11:14:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 11:14:07 -0400
Date:   Wed, 22 Aug 2018 11:14:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180822151407.GA32630@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <20180822053626.GB535143@genre.crustytoothpaste.net>
 <20180822060735.GA13195@sigill.intra.peff.net>
 <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 09:39:57AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I don't have a good option. The assert() thing works until I add in the
> > "32" branch, but that's just punting the issue off until you add support
> > for the new hash.
> >
> > Hand-rolling our own asm or C is a portability headache, and we need to
> > change all of the callsites to use a new hasheq().
> >
> > Hiding it behind a per-hash function is conceptually cleanest, but not
> > quite as fast. And it also requires hasheq().
> >
> > So all of the solutions seem non-trivial.  Again, I'm starting to wonder
> > if it's worth chasing this few percent.
> 
> Did you try __builtin_expect? It's a GCC builtin for these sorts of
> situations, and sometimes helps:
> https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
> 
> I.e. you'd tell GCC we expect to have the 20 there with:
> 
>     if (__builtin_expect(the_hash_algo->rawsz == 20, 1)) { ... }
> 
> The perl codebase has LIKELY() and UNLIKELY() macros for this which if
> the feature isn't available fall back on just plain C code:
> https://github.com/Perl/perl5/blob/v5.27.7/perl.h#L3335-L3344

Sadly, no, this doesn't seem to change anything. We still end up with a
single call to memcmp.

I also tried "hiding" the fallback call like this:

diff --git a/cache.h b/cache.h
index b1fd3d58ab..7808bf3d6b 100644
--- a/cache.h
+++ b/cache.h
@@ -1021,9 +1021,13 @@ extern int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 extern const unsigned char null_sha1[GIT_MAX_RAWSZ];
 extern const struct object_id null_oid;
 
+int super_secret_memcmp(const void *a, const void *b, size_t len);
+
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
-	return memcmp(sha1, sha2, the_hash_algo->rawsz);
+	if (the_hash_algo->rawsz == 20)
+		return memcmp(sha1, sha2, 20);
+	return super_secret_memcmp(sha1, sha2, the_hash_algo->rawsz);
 }
 
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
diff --git a/sha1-file.c b/sha1-file.c
index 97b7423848..5cd0a4b73f 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2280,3 +2280,8 @@ int read_loose_object(const char *path,
 		munmap(map, mapsize);
 	return ret;
 }
+
+int super_secret_memcmp(const void *a, const void *b, size_t len)
+{
+	return memcmp(a, b, len);
+}

but that just results in calling memcmp and super_secret_memcmp on the
two codepaths (with or without the __builtin_expect).

-Peff
