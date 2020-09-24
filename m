Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A05C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 19:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1125223899
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 19:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgIXTWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 15:22:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:39940 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgIXTWb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 15:22:31 -0400
Received: (qmail 6982 invoked by uid 109); 24 Sep 2020 19:22:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2020 19:22:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10413 invoked by uid 111); 24 Sep 2020 19:22:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2020 15:22:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Sep 2020 15:22:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH 2/2] Revert "fast-export: use local array to store anonymized
 oid"
Message-ID: <20200924192229.GB2528225@coredump.intra.peff.net>
References: <20200924191638.GA2528003@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924191638.GA2528003@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit f39ad38410da554af54966bf74fa0402355852ac.

That commit was trying to silence a type-punning warning on older
versions of gcc. However, its analysis was all wrong. I didn't notice
that we _were_ in fact type-punning because there are two versions of
put_be32(): one that uses casts and unaligned loads, and another that
uses bitshifts. I looked at the latter, but on my platform we were
defaulting to the former.

However, as of the previous commit, we'll always use the bitshift
version. So we can drop this hackery to avoid the warning, making the
code slightly cleaner.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1b8fca3ee0..e266d90a81 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -405,12 +405,12 @@ static char *generate_fake_oid(void *data)
 {
 	static uint32_t counter = 1; /* avoid null oid */
 	const unsigned hashsz = the_hash_algo->rawsz;
-	unsigned char out[GIT_MAX_RAWSZ];
+	struct object_id oid;
 	char *hex = xmallocz(GIT_MAX_HEXSZ);
 
-	hashclr(out);
-	put_be32(out + hashsz - 4, counter++);
-	return hash_to_hex_algop_r(hex, out, the_hash_algo);
+	oidclr(&oid);
+	put_be32(oid.hash + hashsz - 4, counter++);
+	return oid_to_hex_r(hex, &oid);
 }
 
 static const char *anonymize_oid(const char *oid_hex)
-- 
2.28.0.1082.g195fe9fe3f
