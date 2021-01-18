Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DFDC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA2922E00
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389097AbhARXvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 18:51:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55892 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387806AbhARXuv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Jan 2021 18:50:51 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 134AA60782;
        Mon, 18 Jan 2021 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611013809;
        bh=L7ADkjDP1frigp6VTY1f3MKD0s5aKVlbrPm/qFiCz6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=g3qf4bDfCd4C3J/N9wYCSoU+ZclWejYPbcLLJbyn5pHOuQJgokSkKeIJ4ZSLPQuhk
         3isE0ubCN1SCepni0xzTe8z3S7W+gkXSzLInJRFM1oLdnspVDBdEwC5pIKJ9HMb6yt
         ml3PtUmMYl3pot+tgp9DpQS+SzRHLfTQOLs3x+hc0ei+Q+Hnpuwv+yHXvLTs7KLvqA
         A6uvLOlTqQ4x1R0/TIc/Ub/OMg/eDdOhna6TMBfw430kj8zUWro/YmAFLSYRC0SenT
         Fe2He5Zy5wgtyP4fTHtTAZDg8aivL2YR6tIvT6P9T6Jwe8FCdTFXNbHR4bE2ddQrxR
         b8u+UjvxXbvMysob9mFA8hWmzpPkavgFo3LOgxYTzYHybGQg28UswTac3U1Le3gU5X
         AJ/m3mDQAHy44Coq72/T9HxzKHoyuOej9RdCuissf+F6YH/B4G96qfvnFQXFjaRjas
         y3ZQzQVU6gyCgESt1hyxHfCEgaZz1nxxTZErhMNBm5kkJKRtbCK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/6] ref-filter: switch some uses of unsigned long to size_t
Date:   Mon, 18 Jan 2021 23:49:10 +0000
Message-Id: <20210118234915.2036197-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
References: <20210111035840.2437737-1-sandals@crustytoothpaste.net>
 <20210118234915.2036197-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we'll want to pass some of the arguments of find_subpos
to strbuf_detach, which takes a size_t.  This is fine on systems where
that's the same size as unsigned long, but that isn't the case on all
systems.  Moreover, size_t makes sense since it's not possible to use a
buffer here that's larger than memory anyway.

Let's switch each use to size_t for these lengths in
grab_sub_body_contents and find_subpos.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ref-filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index aa260bfd09..606f638ab1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1210,10 +1210,10 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 }
 
 static void find_subpos(const char *buf,
-			const char **sub, unsigned long *sublen,
-			const char **body, unsigned long *bodylen,
-			unsigned long *nonsiglen,
-			const char **sig, unsigned long *siglen)
+			const char **sub, size_t *sublen,
+			const char **body, size_t *bodylen,
+			size_t *nonsiglen,
+			const char **sig, size_t *siglen)
 {
 	const char *eol;
 	/* skip past header until we hit empty line */
@@ -1285,7 +1285,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
-	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
+	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
