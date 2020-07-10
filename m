Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7773AC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5742320663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="f8ttuu3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGJCsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40426 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbgGJCsr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BF74160A77;
        Fri, 10 Jul 2020 02:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349319;
        bh=jUu0oP4lRPRplgRpS1ga2lTHRxXHzYqAK/HHH9Hr7bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=f8ttuu3GjqUzJ8fosDdhcDg3d+grtWz3vnl9bd4r7uys+qjhHQLs06+ik6imOqGPX
         lefU95kg25x7jYQGYWOYmu6/W9oARIGqkMu4IQFaZxxK4LXX8PXfIo5Yr5xDGvUXQ+
         tc+dOmwTACfbOQOotZKmeYwFRVE75QqvYNs9hiV3rzUv9bFo8lviqJei+1/fMFT+M0
         6gUZAmTj2rVkCiwtcuwUB4s/p+VpDmw0ehKzUf9V19s+nid1FboCVGaiH+920PPikZ
         b0lrkN/2YkGcZTGIMfOPBA72MG1ajQHLkFNccmK2z8s5QLjYHMi1Gr+D2wr5NQwq3t
         bl/pjvdHdxTL1ROBkXKbUAYoAXEm4rm/Eu5p+CqkVwwxNaozls1vZpjdrTAWO7xzNF
         ZGeHKQ0efNA29HO8y/UIide9oQ48VRknxJgrYEBQ6fSWpd/Uk7NCeH4OfAu0k8Z54H
         /UkeDkop61OP9r1TWKZjxQnryYKf/496FUhhE3LrUNwfGmUj2M8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 35/38] t: make SHA1 prerequisite depend on default hash
Date:   Fri, 10 Jul 2020 02:47:25 +0000
Message-Id: <20200710024728.3100527-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the SHA1 prerequisite depends on the output of git
hash-object.  However, in order for that to produce sane behavior, we
must be in a repository.  If we are not, the default will remain SHA-1,
and we'll produce wrong results if we're using SHA-256 for the testsuite
but the test assertion starts when we're not in a repository.

Check the environment variable we use for this purpose, leaving it to
default to SHA-1 if none is specified.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 307bb2207e..30ab0428fb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1689,7 +1689,8 @@ test_lazy_prereq CURL '
 # which will not work with other hash algorithms and tests that work but don't
 # test anything meaningful (e.g. special values which cause short collisions).
 test_lazy_prereq SHA1 '
-	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
+	([ -z "$GIT_DEFAULT_HASH" ] || [ "$GIT_DEFAULT_HASH" = "sha1" ])
 '
 
 test_lazy_prereq REBASE_P '
