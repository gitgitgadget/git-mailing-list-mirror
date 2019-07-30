Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E891F462
	for <e@80x24.org>; Tue, 30 Jul 2019 20:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfG3UCF (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 16:02:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:55806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726698AbfG3UCE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 16:02:04 -0400
Received: (qmail 7471 invoked by uid 109); 30 Jul 2019 20:02:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Jul 2019 20:02:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10270 invoked by uid 111); 30 Jul 2019 20:03:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2019 16:03:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jul 2019 16:02:03 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190730200203.GA4882@sigill.intra.peff.net>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730194938.GZ4545@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 03:49:38PM -0400, Todd Zullinger wrote:

> > Subtest 6 had an ordering issue. We do not know whether
> > the problem is the code or the test result not keeping up
> > with the code changes.
> >
> > --- expect      2019-07-30 16:56:36 +0000
> > +++ actual      2019-07-30 16:56:36 +0000
> > @@ -1,6 +1,6 @@
> >  NULL
> >  NULL
> >  NULL
> > +7c7cd714e262561f73f3079dfca4e8724682ac21 3
> >  139b20d8e6c5b496de61f033f642d0e3dbff528d 2
> >  d79ce1670bdcb76e6d1da2ae095e890ccb326ae9 1
> > -7c7cd714e262561f73f3079dfca4e8724682ac21 3
> 
> I hit the same failure while building for Fedora on the
> s390x architecture.  I have not dug into it much yet, but
> perhaps this is an endianess issue?

Ah, of course. Our oid hashing is done by just picking off the first
bytes of the sha1, and it doesn't care about endianness (because these
are just internal-to-memory hashes).

We _could_ reconcile that like this:

diff --git a/hashmap.h b/hashmap.h
index 8424911566..493229ac54 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -116,19 +116,11 @@ unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
  * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
  * for use in hash tables. Cryptographic hashes are supposed to have
  * uniform distribution, so in contrast to `memhash()`, this just copies
- * the first `sizeof(int)` bytes without shuffling any bits. Note that
- * the results will be different on big-endian and little-endian
- * platforms, so they should not be stored or transferred over the net.
+ * the first `sizeof(int)` bytes without shuffling any bits.
  */
 static inline unsigned int oidhash(const struct object_id *oid)
 {
-	/*
-	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
-	 * platforms that don't support unaligned reads.
-	 */
-	unsigned int hash;
-	memcpy(&hash, oid->hash, sizeof(hash));
-	return hash;
+	return get_be32(oid->hash);
 }
 
 /*
diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
index bbe719e950..6656db9d69 100755
--- a/t/t0016-oidmap.sh
+++ b/t/t0016-oidmap.sh
@@ -93,9 +93,9 @@ put three 3
 iterate" "NULL
 NULL
 NULL
+$(git rev-parse three) 3
 $(git rev-parse two) 2
-$(git rev-parse one) 1
-$(git rev-parse three) 3"
+$(git rev-parse one) 1"
 
 '
 

which not only fixes this test but any other hash-based oddities. I
wonder if it's appreciably less efficient. I'll bet I could nerd-snipe
René into doing a bunch of measurements and explorations of the
disassembled code. ;)

-Peff
