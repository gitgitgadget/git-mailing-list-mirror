Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3404C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFBA2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UfukM/5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390680AbgEYUAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38844 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390570AbgEYUAY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:24 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 53CBE60D0A;
        Mon, 25 May 2020 19:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436792;
        bh=5tWITec1XvUpGU34jbqxhafBFLo7Ap2izOu3L993MKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UfukM/5j5oXTgDcwVw2bFQ8SsTT5lyfqKlHaVPaGdk2aZP9ZMoxVdvzotVoxH/cnD
         b2l+h4HHPams+ZSo4fL5qlP/EMvOGdICAiXZlVPtYqNUcUy0g7N/S04ziNlnOg2L4O
         4q4qsyPqP2Me2IwIPmCEeZvU5RM5TnbxbaeL5HmFY9lZ2PytY/B1VA732YtvpcoY7t
         ABvYcls48u6de2GTTqnkq+U/nvbNbIPmX78utaGU5LsGKcdYbRmEiQuLifbOI1nzat
         h3JpNCw9HgX065no15d54yN+/ll/KZFHCQ9UpUhOvQbbGAPYn7tVTuktkGTpqkpyaR
         E9t0luF1X3KswWktoWEZVYxpjArQxJvyn2X2R6LeiRraBnOxnxfrSsRRlim+CAZRsp
         lpfHTuEFmYMXb6LQ0xBJumqTZp156FNVlh/AIk5iKeXul43vvqHVtzBjbcSprmZqyd
         FxAsdFvO/7aB/IOXvrKTgaKWwpbwb/6pQY/S1rWt1frvsZbdMaL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 22/44] setup: set the_repository's hash algo when checking format
Date:   Mon, 25 May 2020 19:59:08 +0000
Message-Id: <20200525195930.309665-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
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
about the hash algorithm, resulting in segfaults when working with
SHA-256 repositories.

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
 
