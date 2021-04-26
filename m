Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE05C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37E4611CD
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhDZBEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41754 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231403AbhDZBEM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DD6546078B;
        Mon, 26 Apr 2021 01:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399010;
        bh=/YGve5cDUEh1PYIa3iooGJbxQJijQBF9Ub8JAznS4Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=m8XU5mP6epcvZ8JZ6OcbQxj8n/v2OFc/pWIvo+ZAlinD1L/vFsFoP2egEiodTteAq
         dAe8ezKIgXfxoqQ/wOuPRPhxfR0CRPxi/upuwCeADzYJmKawa7dn/RAHtLBdSU1O4h
         qniTl/Md3FlZd7iDsP1DoIyilYaFSKmD7Q5S7UJE8wYeWM8o+gVEcROUN5nLlCqsgV
         Z/lvp0K++09C6uztNAoVTrGNtt9WJ9ITlsXZ2kZHPyUOzLgVDQ9csDhUXSQxBUcadW
         NYag5a0mGcgRwT+akUUPhDv37i0gW1MfcZJOkdp6JoX3Fxk2trGkK9xMtVaXuBaZ6Y
         y8VX9Um3yVu7wXIWx8be8XnwRL61hif0E/jIlhu8pjp8yMGwvrdIWBbYXPirvWFTmg
         9xkOvoFiieCFSIyi4dUN7jjeMMcPIW2XpRSHrcmJ3ZzG2RC4zWQ/RUsJTYkWxcz6JX
         f0lqN/N8U+dDYfC2JhTbPkidMemPEFjd3dKJKIvu153aIr1fWsv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/13] hash: add an algo member to struct object_id
Date:   Mon, 26 Apr 2021 01:02:49 +0000
Message-Id: <20210426010301.1093562-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we're working with multiple hash algorithms in the same repo,
it's best if we label each object ID with its algorithm so we can
determine how to format a given object ID. Add a member called algo to
struct object_id.

Performance testing on object ID-heavy workloads doesn't reveal a clear
change in performance.  Out of performance tests t0001 and t1450, there
are slight variations in performance both up and down, but all
measurements are within the margin of error.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hash.h b/hash.h
index 3fb0c3d400..dafdcb3335 100644
--- a/hash.h
+++ b/hash.h
@@ -181,6 +181,7 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
+	int algo;
 };
 
 #define the_hash_algo the_repository->hash_algo
