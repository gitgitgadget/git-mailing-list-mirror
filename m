Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96941C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFEA2088E
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 15:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbgFYPtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:49:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:43030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgFYPtt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 11:49:49 -0400
Received: (qmail 30094 invoked by uid 109); 25 Jun 2020 15:49:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Jun 2020 15:49:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17196 invoked by uid 111); 25 Jun 2020 15:49:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Jun 2020 11:49:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Jun 2020 11:49:48 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/10] fast-export: store anonymized oids as hex strings
Message-ID: <20200625154948.GA3968780@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152451.GC1435482@coredump.intra.peff.net>
 <20200624114313.GJ2898@szeder.dev>
 <20200624155420.GC2088459@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624155420.GC2088459@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 24, 2020 at 11:54:20AM -0400, Jeff King wrote:

> > GCC 4.8 complains about this change in our CI job:
> > 
> >   $ make CC=gcc-4.8 builtin/fast-export.o
> >       CC builtin/fast-export.o
> >   builtin/fast-export.c: In function ‘generate_fake_oid’:
> >   builtin/fast-export.c:394:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
> >     put_be32(oid.hash + hashsz - 4, counter++);
> >     ^
> >   cc1: all warnings being treated as errors
> 
> Interesting. The only change on this line is swapping out the local
> "unsigned char *" for an object_id, which also stores an "unsigned
> char" (though as an array). And while put_be32() takes a void pointer,
> it's inlined and treats it the argument an "unsigned char *" internally.
> So I'm not sure I see that any type punning is going on at all.
> 
> I'll see if I can appease the compiler, though.

Hmm. Switching to a local array makes the warning go away:

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 4a3a4c93..eae2ec5 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -387,12 +387,12 @@ static void *generate_fake_oid(const void *old, size_t *len)
 {
 	static uint32_t counter = 1; /* avoid null oid */
 	const unsigned hashsz = the_hash_algo->rawsz;
-	struct object_id oid;
+	unsigned char out[GIT_MAX_RAWSZ];
 	char *hex = xmallocz(GIT_MAX_HEXSZ);
 
-	oidclr(&oid);
-	put_be32(oid.hash + hashsz - 4, counter++);
-	return oid_to_hex_r(hex, &oid);
+	hashclr(out);
+	put_be32(out + hashsz - 4, counter++);
+	return hash_to_hex_algop_r(hex, out, the_hash_algo);
 }
 
 static const char *anonymize_oid(const char *oid_hex)

at the cost of some uglier use of the_hash_algo and RAWSZ. But
curiously, even with the array, if I adjust the write only slightly to
write at the begining instead of the end (we don't really care where our
counter appears in the hash, since the point is to anonymize):

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index eae2ec5..1f52247 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -386,12 +386,11 @@ static void print_path(const char *path)
 static void *generate_fake_oid(const void *old, size_t *len)
 {
 	static uint32_t counter = 1; /* avoid null oid */
-	const unsigned hashsz = the_hash_algo->rawsz;
 	unsigned char out[GIT_MAX_RAWSZ];
 	char *hex = xmallocz(GIT_MAX_HEXSZ);
 
 	hashclr(out);
-	put_be32(out + hashsz - 4, counter++);
+	put_be32(out, counter++);
 	return hash_to_hex_algop_r(hex, out, the_hash_algo);
 }
 

...then the warning comes back. I tried that because I was wondering
whether the same thing might make the warning go away on the object_id
version, but it doesn't.

So this really seems like a pointless false positive from the compiler,
and it's a rather old compiler (the warning no longer triggers in gcc 6
and up). Is it worth caring about? Ubuntu Trusty is out of standard
support but not fully EOL'd until 2022. Debian jessie has gcc 4.9
which triggers the warning, but will hit EOL in 5 days. If it were an
actual breakage I'd be more concerned, but keeping such an old compiler
-Werror clean doesn't seem that important.

I'd note also that none of the Actions CI jobs run with this compiler
version. If we _do_ want to care about it, it might be worth covering it
there.

-Peff
