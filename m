Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7651C433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16DC6113A
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhDJPXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:23:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58544 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234925AbhDJPXW (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:23:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 46E9E61476;
        Sat, 10 Apr 2021 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068157;
        bh=ClGCesE1SIe+b/Imzrcr0sG/x6kpClI8elvjQ/fsv/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uEhbIYoD4o1MpZX+XghbAYRM5m6NbglhkupaIxDzFFNeRWDLb4xAiiUC9i+ORuxlH
         xnxYP/DIvQxF5bs6rT3jfKBD8RfV6mCkKUQO9S95AzCPXXl+Mn+NnbYeLbBb/qkAec
         8IBEhU1/bmKZj4Amd4R9lzgVvYSXwSe/ZIlj08+xAAT0i1HOEJJDoZLaRunmP9BAql
         RLn/1wczC9VzaXa+8ICf5vf0VYz3sbAU6Aig3gV0jKdREB5Sfn6hcJjmBfetMCgcNq
         Dazwtr66WMHEKD+oScRVl2eRXyJtyJZu+ubfsC7hahlnWdp2iDhe89TKpBAkX76kc1
         yMpPi4wkweVQh5SvD5yRTaAP92KIIN3wuODZdqVfDSmn18EoX8pKUH/1eiLNOkc2kd
         WUY6U4mCjp1Q8m2NQ8zoNe/oE08L56DX6tvk4GbOFZ8Ny6fJQFI+6GZWbjjTJy2yRu
         i7k2+aZPp1Jp8loPp0fHqmotwzdaprfEDujkbMWcofybxFblfJK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 14/15] hex: default to the_hash_algo on zero algorithm value
Date:   Sat, 10 Apr 2021 15:21:39 +0000
Message-Id: <20210410152140.3525040-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are numerous places in the codebase where we assume we can
initialize data by zeroing all its bytes.  However, when we do that with
a struct object_id, it leaves the structure with a zero value for the
algorithm, which is invalid.

We could forbid this pattern and require that all struct object_id
instances be initialized using oidclr, but this seems burdensome and
it's unnatural to most C programmers.  Instead, if the algorithm is
zero, assume we wanted to use the default hash algorithm instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hex.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hex.c b/hex.c
index 5fa3e71cb9..43597b2dbb 100644
--- a/hex.c
+++ b/hex.c
@@ -124,6 +124,13 @@ char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
 	char *buf = buffer;
 	int i;
 
+	/*
+	 * Our struct object_id has been memset to 0, so default to printing
+	 * using the default hash.
+	 */
+	if (algop == &hash_algos[0])
+		algop = the_hash_algo;
+
 	for (i = 0; i < algop->rawsz; i++) {
 		unsigned int val = *hash++;
 		*buf++ = hex[val >> 4];
