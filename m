Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC4C433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E9E2065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Fyh2WNzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGZTym (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40652 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgGZTyl (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CE6EE607E8;
        Sun, 26 Jul 2020 19:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793281;
        bh=Ni60BVyy3697LdUPCNff0L0kAJ2/erkulVYjnf5hQSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Fyh2WNzhWMh79migcveGLGD851Y7iFcGi4towx4Dx2n06tLKxvP7JNx2VW5bMpbcH
         sCpD4by17RO7D/ugJqcJehllLC992tgIR5XnO/5Xdfi1ojdu4LZ+59GxqCch6RiuS3
         MsdNMTL1B+nDGnYzOHLbNtk+YAXpLvkWhdVqPiXMxmwI+LhwsOscGBAOi7It7sxLt4
         oQoAA2pdUmI9XBbRGZ6qKG25SDu39ygaPUAuWUv84d+1L84uYr1ZcgxHEDcJ4yA4au
         vI4VYACRwg+wAB2fmpWjaO1yKgZNIjVPZwH1oMRWLaS7JFybmVih+7I5ff9Z2OZUPY
         N/8h+OwRmR+APd7HKl5gF5NffOfNOsBCS0EsfKziIGpWR1wiaBwmXC7sH5fPAzT8HS
         uAeEONnBmSvh2bz6k5NaG2p7AK5OSMayALplJkjnAwkq+C/HBx0K8v0ARZ2dIavDo6
         OhNWP6SS1mtp1kyKO2LwftU2fdpIFRHrSkC41ucN9FOIR771E2a
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 01/39] t: make test-bloom initialize repository
Date:   Sun, 26 Jul 2020 19:53:46 +0000
Message-Id: <20200726195424.626969-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bloom filter code relies on reading object IDs using parse_oid_hex.
In order to make that work with an appropriate size, we need to have
initialized the repository's hash algorithm.  Since the values we're
processing depend on the repository in use, let's set up the repository
when we run the test helper.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/helper/test-bloom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index f0aa80b98e..5e77d56f59 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -50,6 +50,8 @@ static const char *bloom_usage = "\n"
 
 int cmd__bloom(int argc, const char **argv)
 {
+	setup_git_directory();
+
 	if (argc < 2)
 		usage(bloom_usage);
 
