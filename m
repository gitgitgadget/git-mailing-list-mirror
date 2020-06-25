Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CF6C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71072076E
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406844AbgFYTsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:48:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:43384 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406926AbgFYTsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 15:48:39 -0400
Received: (qmail 31499 invoked by uid 109); 25 Jun 2020 19:48:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Jun 2020 19:48:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19746 invoked by uid 111); 25 Jun 2020 19:48:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Jun 2020 15:48:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Jun 2020 15:48:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 11/11] fast-export: use local array to store anonymized oid
Message-ID: <20200625194837.GK4029374@coredump.intra.peff.net>
References: <20200625194802.GA4028913@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625194802.GA4028913@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some older versions of gcc complain about this line:

  builtin/fast-export.c:412:2: error: dereferencing type-punned pointer
       will break strict-aliasing rules [-Werror=strict-aliasing]
    put_be32(oid.hash + hashsz - 4, counter++);
    ^

This seems to be a false positive, as there's no type-punning at all
here. oid.hash is an array of unsigned char; when we pass it to a
function it decays to a pointer to unsigned char. We do take a void
pointer in put_be32(), but it's immediately aliased with another pointer
to unsigned char (and clearly the compiler is looking inside the inlined
put_be32(), since the warning doesn't happen with -O0).

This happens on gcc 4.8 and 4.9, but not later versions (I tested gcc 6,
7, 8, and 9).

We can work around it by using a local array instead of an object_id
struct. This is a little more intimate with the details of object_id,
but for whatever reason doesn't seem to trigger the compiler warning.
We can revert this patch once we decide that those gcc versions are too
old to care about for a warning like this (gcc 4.8 is the default
compiler for Ubuntu Trusty, which is out-of-support but not fully
end-of-life'd until April 2022).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c6ecf404d7..9f37895d4c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -405,12 +405,12 @@ static char *generate_fake_oid(void *data)
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
-- 
2.27.0.593.gb3082a2aaf
