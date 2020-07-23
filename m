Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339CC4345E
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDA820771
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IUbSAiAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbgGWBKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387636AbgGWBKW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7CD246047A
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466591;
        bh=Ni60BVyy3697LdUPCNff0L0kAJ2/erkulVYjnf5hQSc=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=IUbSAiAx9dhPoohIvrdy6yxP0aGxHEIdlG1hRdatGpSLXrBsQWZHWG0E/v5qKVX5p
         Jr6klDGYtnZ5MBPCM6pA82XeIPtElG3ax+tlLFzCr7HnfVdrabFnU1wk1IvK8hwFiC
         22cyYq4fjUMsyZDbNmZVwjK5eb7BhsopOQluIcqg/ztB/ztiy57cQveLBrlFJ+rCZa
         fq6RKoiuBcyxdk0tNRqsFRxWyfUSttLco3EISAEhoz1WYOg/5mOM99xoex03p8Afnk
         9ngBzV86qckOq9PahE9Ek3CQS+SLb13GRtJmvwBlKcvgJKwtcB3Q3p2Xb5WhQXazwi
         PiTQoFKg0EhaM0KyomwevEM4FHi6A+UvHv4ENsk96mKxPvwf+8HpWrYHHkuVoL+84p
         ry380oVzxIrfFgS3eH5d2Io5cmSX3dfXPtYXrPJ+AEbo6VRcMgiFeNdv/8ooMyUUfR
         leL2t9gVmoD80rOdDglsT3VXXUkM7mO+m8XxnIWqOPg2LWYvgf+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 01/39] t: make test-bloom initialize repository
Date:   Thu, 23 Jul 2020 01:09:05 +0000
Message-Id: <20200723010943.2329634-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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
 
