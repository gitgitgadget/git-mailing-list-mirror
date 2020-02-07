Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FA6C352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E840A20838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KIbXEtNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBGAxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55578 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727392AbgBGAxj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:39 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D3DEB607F1;
        Fri,  7 Feb 2020 00:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036818;
        bh=rt5DiMkEaojCqryZXItjFk7ouIEXKkpQBMjtvt74YP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KIbXEtNFSTkPpt/z6d70PTpcvtSDqcLKH7yEw216pSL9IZK86jxo10qi7ZtXos3Ul
         1RSv9FPN3qzYIDwAkk9onpH9fByufErXKVBOTiVcJeOZgxhwZb6+JWDYbxohZUNCVU
         31Rjnn+Oc9e5ujgOS329iwBJuaRWyelo8qqXdTHlS4LGqEE7OqVbpRFsFL8muZP0ZF
         pih6GyRFA3Ooo1v+Hoj5mdy+rw05ezUhrFVzMwSJ7LkDCLn/OWO+NF2a3U81hFEGZ8
         3LObUUORwR1PZxj2quTC6vfK9LyQWnXe9ckxQK2B+UjPVyXN8RO7zjUIZnJUc0spxg
         0LuY+lWBXFhFVo7CimqZgtlwMEmeA+O5b7GhFptDJTKOB0spgYfuRs5kPevRXSdRd3
         fURJHMCBjcK88eFy4Iw1xK04gu5QLkmE3j4TuZ9cOTnoYS+Xn5Nt1IexgGg0dAw8v0
         VVR3iHy+BinBq+2J621od52Rdtp3gtLrHJ6gpDqNIoJsaxVYA+s
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/21] t5309: make test hash independent
Date:   Fri,  7 Feb 2020 00:52:45 +0000
Message-Id: <20200207005254.1495851-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
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
