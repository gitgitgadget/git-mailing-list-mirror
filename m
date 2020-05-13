Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F816C2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D5020675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="j1474I/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbgEMAy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38140 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731871AbgEMAys (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6936760D02;
        Wed, 13 May 2020 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331287;
        bh=BfA/BVldsKduzgAB919RC6B20stnCTVSH4nJ7cJBXRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=j1474I/sgiG9xck7CNGselBaAdzAbjQWwRRTyAYI/Cj1E5BXJbPYuTJnQbTFmGG6f
         8UaNL5zfs3J7zJ3Dp8mq+CBkoVE76N9bUkZmpVC1CGxsMXNaI7gidpmU87mcNn0VXO
         qLeiN/j/Zy07w12NpfYNSmtzB9tz6JkoVJyDPRVoLZzPBchm/A87SWQZf7eIESV1tR
         IhnFbNzC3St7pwSE88yP4c4rKVPb7v+Xu8y5n4wXOok3Xe1p6RYkRTe5LzzRKG5BPW
         83K70bGyvhTvQ0BWkg4ucTd2ren9IrFkLeHEpqFkdtJe3GrXZsvna+MnsgLeCyRbyk
         8BFyuWs5gsFHRi7+e6/sodCpyLCewId8wrkBu6P825S4FKNjGu2K3EGv+XG3XX3hXr
         pYTKvaSXQEiTNnVprdPQ9s/Zt7TqIfjoJHMUioDp/d54JDTl0bOofU4uEBxiNjBqyB
         10kvBp28IkLTXjC1Bq4Yf05u2jDQdX6ZkscOXpSTqZe2Rimvovi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 23/44] setup: set the_repository's hash algo when checking format
Date:   Wed, 13 May 2020 00:54:03 +0000
Message-Id: <20200513005424.81369-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're checking the repository's format, set the hash algorithm at
the same time.  This ensures that we perform a suitable initialization
early enough to avoid confusing any parts of the code.  If we defer
until later, we can end up with portions of the code which are confused
about the hash algorithm, resulting in segfaults.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.c b/setup.c
index 65fe5ecefb..019a1c6367 100644
--- a/setup.c
+++ b/setup.c
@@ -1273,6 +1273,7 @@ void check_repository_format(struct repository_format *fmt)
 		fmt = &repo_fmt;
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
+	repo_set_hash_algo(the_repository, fmt->hash_algo);
 	clear_repository_format(&repo_fmt);
 }
 
