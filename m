Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC67C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C2C20DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="w8sGFVO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392011AbgFSR4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39560 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404585AbgFSR4h (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:37 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1491360A7C;
        Fri, 19 Jun 2020 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589392;
        bh=9/XCfoD9D8bLE+oXVKT1bfTngQ0zsWd7xXxEJCNWFvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=w8sGFVO+s9/ANQ+ONL6BgzycPXT4RflGYlaodsT47/C2YyT1WDAV8eYw9DxCUNxZO
         TPpBGqb314VzIuGT0MVIRuuoJWhW3Hxv0XQW8EvC3OaOOEu4YC6wmr7kbPtuvlZjxD
         EifToHGeHZsTKhnVX0oXE2P4kP9v57H5g/LCgynZ+F5/qm4KQRvrf4N6Quo9jZNJNQ
         nSEZz9PVTH63DtT/IvfJM4mkyQ/pvVJhENfMOxRqL2MUZL1lgtiNhD14tD/XZhzw8N
         dfpRrGtyXB1uALTbZkao2DfNwfEjgaN3ClZlcWFs2EX5fYdumz/R2QZ4UoxbU/OD/a
         k2r4GGdGmy2m20a93wBe2yarYJlh9Gmhr5uNCPxa8qb5hpY8PmTGvSP5e7EXktZGUf
         1j9fy5SZOtc0qgH/0LPA3UWZgLt7qGBQlesQEJqhP8u+1J0TTR2kms0rK0XKcNbwkw
         m89DOvRmtZB8fuQvYDC61/5WOoXWu1dP+p57YMmFcN56i4n4EUa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 37/44] remote-curl: avoid truncating refs with ls-remote
Date:   Fri, 19 Jun 2020 17:55:54 +0000
Message-Id: <20200619175601.569856-38-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
index e666845d9d..5cbc6e5002 100644
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
