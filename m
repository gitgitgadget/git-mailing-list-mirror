Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF8C47409
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D2121556
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EEEqGn55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAMMk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37648 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728669AbgAMMkj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:39 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5682F60800;
        Mon, 13 Jan 2020 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919238;
        bh=rt5DiMkEaojCqryZXItjFk7ouIEXKkpQBMjtvt74YP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=EEEqGn55AOBXWhxUQRHH3gWX9YW8zLNPLaftrQQtFTLXScbxUNWcq1RyZYnOz4kQG
         VutIlNZRdPdB4qMwp5/2UnOzmb4GV0Jkjndj36pxC+oVgcNCrdOn1oJoTwQjOorOWW
         I6xAmFC69nT/8izu4zt715PpHzg5e1kWdgkgaFma+1ladR3iixo5eA995waoAvnX6Z
         CfkFOrGB+EoMYj0kovWBkq0h1Br6l4Jqn/iRw24Q8sfIodh9cVH2yK5+1iVnU8qtJU
         Lb9q/YBxFJ+wOZiEZtGxMksm0jM1PJ+ACs2Sj/73z/dhvzOQS8h98f4zYo+fDDvcsO
         WS4BCtaKtjVs4RVCYa4rQsMZE3L07SLlwKt+o9cxBk7hvfhGgCa+mycKd9FVeL91HO
         4J1lQEV1wa00Uo1WR644JqAjdFdy7mCar7KTvMnJSlS0bzpWTysqaVCul+N9ptbqKn
         YJPyQ3UJnUY4QjAZDQV0Z8doGvyL9VFtqTtnR0Q6Yh6urbORN4C
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 13/24] t5309: make test hash independent
Date:   Mon, 13 Jan 2020 12:38:46 +0000
Message-Id: <20200113123857.3684632-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the proper pack constants defined in lib-pack.sh to make this test
work with SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5309-pack-delta-cycles.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 491556dad9..b6b9792913 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -4,15 +4,9 @@ test_description='test index-pack handling of delta cycles in packfiles'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
-if ! test_have_prereq SHA1
-then
-       skip_all='not using SHA-1 for objects'
-       test_done
-fi
-
 # Two similar-ish objects that we have computed deltas between.
-A=01d7713666f4de822776c7622c10f1b07de280dc
-B=e68fe8129b546b101aee9510c5328e7f21ca1d18
+A=$(test_oid packlib_7_0)
+B=$(test_oid packlib_7_76)
 
 # double-check our hand-constucted packs
 test_expect_success 'index-pack works with a single delta (A->B)' '
