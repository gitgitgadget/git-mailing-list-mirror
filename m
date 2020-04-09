Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D072C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F7920757
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qigmwEpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgDIXhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:37:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51748 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726825AbgDIXhl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Apr 2020 19:37:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DC6C06042C;
        Thu,  9 Apr 2020 23:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586475461;
        bh=aKx7bhDjhX8nLEmG3NV+K2qOr2Uamp+qEL39WUTBBIA=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qigmwEpGjTismtZwcJMDjQpaSizg0nNBJFfG0/9Zzxl6Swgd1lYxgJK2zdbHv9SNf
         BWVJu3zG6aAlXgfglZ806XcTOMjG6+drbu6wHXlzLDPQdXWOhnTpSehWPK2wy6RQHB
         ev25zUnmFIC51BG5zjNdDutyD7q86RkNecl2BEOc+sz+mKyugYdoiizQ2Fz04FQIjD
         0jVznTjCYuZT173EybUlBY9Gtyov4sOF5YPNXVg77hmh0sP4CmZw7+8Z5x7jwuyDBk
         ZOH6Pj+A4JUYR2LY/oMbN4RiAbJscQlWpwG+MAHvG8wJKUv+g0JE4nmV1xPszxa8UC
         nlG+IlOrvbObhebPKcrNz8BbjD/7KdAXaFwwC8TCh0pju0365GqAcM5Iv/fbo8LNgi
         kJmeBdCptAPJRUOo6v88p1rIDKIbVpL0sbGhfqiuZum+hqojHqfCSQn1eSj7Vr5Wpc
         e+M5FLmzBBrQDGNZ+VYuFX5RVM1ewavyDxceD+/xMQEYSxIAe0P
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/receive-pack: use constant-time comparison for HMAC value
Date:   Thu,  9 Apr 2020 23:37:30 +0000
Message-Id: <20200409233730.680612-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're comparing a push cert nonce, we currently do so using strcmp.
Most implementations of strcmp short-circuit and exit as soon as they
know whether two values are equal.  This, however, is a problem when
we're comparing the output of HMAC, as it leaks information in the time
taken about how much of the two values match if they do indeed differ.

In our case, the nonce is used to prevent replay attacks against our
server via the embedded timestamp and replay attacks using requests from
a different server via the HMAC.  Push certs, which contain the nonces,
are signed, so an attacker cannot tamper with the nonces without
breaking validation of the signature.  They can, of course, create their
own signatures with invalid nonces, but they can also create their own
signatures with valid nonces, so there's nothing to be gained.  Thus,
there is no security problem.

Even though it doesn't appear that there are any negative consequences
from the current technique, for safety and to encourage good practices,
let's use a constant time comparison function for nonce verification.
POSIX does not provide one, but they are easy to write.

The technique we use here is also used in NaCl and the Go standard
library and relies on the fact that bitwise or and xor are constant time
on all known architectures.

We need not be concerned about exiting early if the actual and expected
lengths differ, since the standard cryptographic assumption is that
everyone, including an attacker, knows the format of and algorithm used
in our nonces (and in any event, they have the source code and can
determine it easily).  As a result, we assume everyone knows how long
our nonces should be.  This philosophy is also taken by the Go standard
library and other cryptographic libraries when performing constant time
comparisons on HMAC values.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
When I was writing this, I determined that this doesn't have any
security impact, but Dscho suggested I send it to the security list
anyway to be sure.  That was a good idea, so I did it, and folks there
agreed that there's no viable attack we can think of.  Therefore, this
patch is purely precautionary.

This came to my attention as I was looking into similar problems in
other software and thought about what we do in Git as well.

 builtin/receive-pack.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2cc18bbffd..2c26ef9132 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -499,12 +499,25 @@ static char *find_header(const char *msg, size_t len, const char *key,
 	return NULL;
 }
 
+/*
+ * Return zero if a and b are equal up to n bytes and nonzero if they are not.
+ * This operation is guaranteed to run in constant time to avoid leaking data.
+ */
+static int constant_memequal(const char *a, const char *b, size_t n)
+{
+	int res = 0;
+	for (size_t i = 0; i < n; i++)
+		res |= a[i] ^ b[i];
+	return res;
+}
+
 static const char *check_nonce(const char *buf, size_t len)
 {
 	char *nonce = find_header(buf, len, "nonce", NULL);
 	timestamp_t stamp, ostamp;
 	char *bohmac, *expect = NULL;
 	const char *retval = NONCE_BAD;
+	size_t noncelen;
 
 	if (!nonce) {
 		retval = NONCE_MISSING;
@@ -546,8 +559,14 @@ static const char *check_nonce(const char *buf, size_t len)
 		goto leave;
 	}
 
+	noncelen = strlen(nonce);
 	expect = prepare_push_cert_nonce(service_dir, stamp);
-	if (strcmp(expect, nonce)) {
+	if (noncelen != strlen(expect)) {
+		/* This is not even the right size. */
+		retval = NONCE_BAD;
+		goto leave;
+	}
+	if (constant_memequal(expect, nonce, noncelen)) {
 		/* Not what we would have signed earlier */
 		retval = NONCE_BAD;
 		goto leave;
