Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68A3C2D0FC
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48C42078C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WQcl2WmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbgEMAzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38266 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732042AbgEMAzX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DDB4660D11;
        Wed, 13 May 2020 00:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331292;
        bh=lDj+6iVRyV36yqcSu1WE1ftEbOZxQhSslHVg1FJqDT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WQcl2WmXEHKfs4tFf8Svc4+BJFkocJgLpQzeauAsqqX+2g2d3c8ahcgG9JWBANV4g
         Nu+xNUc1zplGwX6rpqoeVHK4yrbJqGzhc7xXH2U7BX2lSkURfU5b2Jp1gjyKRRgCR7
         l11NX2B+c0oQqWNBCZZF9iqx4HeA2lPWmibxo8lHEf/bakfrELXbEoCnpZOiwi8LzA
         rVhxWUbzQgIJyN7rj44pUye3f1Nqqsh8Im/MRz9ajw8kQZYgOmVHKFXvggk+Di4kvx
         Bo3qZmDtx4U9PypYF4sR+5n8/VHU+OraVw3bsQ7Qu4h3aIpONYePx81Wcu8PvHQ5wq
         52ekSbk9ICgVJTPFPRlkuZmEhqL8GySAdk00bU+a+vrZ/x3iCIfhwPybcQAEX7zZHI
         BXZ4qF5u0McHpq2TBKH7Jl/uxCpnnj9+i8rN5Pu3eWLdqUpXQwZkStCATIBZ18kFOb
         V8eB5GuReSLb0gjy4ZyKd7MSgOql+DCBaIhGLzg3RuZtJIryoVB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 33/44] t5500: make hash independent
Date:   Wed, 13 May 2020 00:54:13 +0000
Message-Id: <20200513005424.81369-34-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test has hard-coded pkt-lines with object IDs.  The pkt-line
lengths necessarily differ between hash algorithms, so generate these
lines with the packetize helper so they're always the right size.  In
addition, we will require an object-format capability for SHA-256, so
pass that capability on to the upload-pack process.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5500-fetch-pack.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 52dd1a688c..8fee99ecfb 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -871,9 +871,10 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 
 	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
 	0012command=fetch
+	$(echo "object-format=$(test_oid algo)" | packetize)
 	00010013deepen-since 1
-	0032want $(git rev-parse other)
-	0032have $(git rev-parse master)
+	$(echo "want $(git rev-parse other)" | packetize)
+	$(echo "have $(git rev-parse master)" | packetize)
 	0000
 	EOF
 	)
