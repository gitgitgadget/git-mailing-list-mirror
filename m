Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A7FC2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BA123129
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ft0rWhKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbgEMAz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38274 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732059AbgEMAzZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0278D60D16;
        Wed, 13 May 2020 00:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331294;
        bh=Q7QGgr71ZvOWyLOax8q5JM3VXmokxTeKAMbY9xJ0AFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ft0rWhKtRzrZfRDJSfY78A2YQnye4joRPHAdyvCZRBRfUIqtl7jndUksNw2wWJx8a
         ZoIc6H/v5+9CYUGEwv9xYaM24yaQSFYpu08li1cuQaJjMuopb7944jAQl1jnEprvyQ
         1W6lwZifVe1bwy7oDMhuUWhKEiubAVfzv+J+IZgmAgulVyYZ2V/xr79Egfj4yWA8v8
         fRptg75qTicIYNiuwWMhntUCEOphVboG0ihOk7+JOmn9JQHgiqE6ChHiyRUPWH/gUO
         rUJ0bSvlFJpboqK8gc/OwaPCJJbCkxFuR5s2S3VIq0kf2vKVyWXfwUk/7STG2wnUAN
         QPixSL0AIzn/vD13nQyN77ARqBy+MUSjucKq9OWSR7swVBGJfvY2weR1iXGPnOXQC8
         DsMihB5n2VG75d6+Z0x9LB1fOrAE9H7cvFnSibrDxrG2w77osq9HyF2ZxDurtD3Zit
         WyqkCy1ZkRWZho24h2VFSM28QwxspqX1q2SLA5n/qASpodbl447
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 38/44] remote-curl: avoid truncating refs with ls-remote
Date:   Wed, 13 May 2020 00:54:18 +0000
Message-Id: <20200513005424.81369-39-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally, the remote-curl transport helper is aware of the hash
algorithm we're using because we're in a repo with the appropriate hash
algorithm set. However, when using git ls-remote outside of a
repository, we won't have initialized the hash algorithm properly, so
use hash_to_hex_algop to print the ref corresponding to the algorithm
we've detected.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 35275b42e9..9808e53182 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -548,7 +548,9 @@ static void output_refs(struct ref *refs)
 		if (posn->symref)
 			printf("@%s %s\n", posn->symref, posn->name);
 		else
-			printf("%s %s\n", oid_to_hex(&posn->old_oid), posn->name);
+			printf("%s %s\n", hash_to_hex_algop(posn->old_oid.hash,
+							    options.hash_algo),
+					  posn->name);
 	}
 	printf("\n");
 	fflush(stdout);
