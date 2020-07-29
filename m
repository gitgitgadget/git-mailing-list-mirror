Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719CBC433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEEA2067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bAqR4e1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgG2XPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41116 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728105AbgG2XPE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DD0B86101B;
        Wed, 29 Jul 2020 23:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064502;
        bh=Ycs0MjVExWRB3JGbxwKlzgmzDVKANOql4LGjdlhyZXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=bAqR4e1tqOpviwhiGu16/JNDBMoy9riZpEkI4K6BQFOH9ugWLEtOeQo6WGsMbDJ0Y
         /TzTxDHPnEvL8BlzAk4nu/N9E/tkKdK3bxwysKvUnixDy67LjbgDy8UdiXZzUiaezp
         1Wl739pXVvG5zfS7jQ5k7TwMLHOifbdvOAuus8SVm2Po9gRqgI7fDvVm+XIKXKsEJ1
         8aRHBRKLcg1IyqSyEoa9Oi/I0wDn/cle77IP8RCXW9eNpE6gdOJvmpKcNX4v4iyAxd
         CnD0CmobtEuW1c6axgsQQgX38xSOJMySyrh1lmMB2zc9ccP/Pgdj6cOM5oXLsIQvnC
         +dMyOUZWufM6xOit7sdFv5wF8A/9MzYgUqRpNWED/3wFRFaQ63/7L41rrkWu6/ccdU
         mwAVWv9NDj76ip07WAIj6pFFjBPB4xkZju41TQiP9Vqsi7by4r/mcWAXPrlLyYvVWf
         eNnMNNLwEM2ubJf4IdEoCYQzjmow5Ge1kbwUT/Rs2Y4pqjyT6dQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 36/39] t: make SHA1 prerequisite depend on default hash
Date:   Wed, 29 Jul 2020 23:14:25 +0000
Message-Id: <20200729231428.3658647-37-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
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
 t/test-lib.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 307bb2207e..0483ed51e1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1689,7 +1689,11 @@ test_lazy_prereq CURL '
 # which will not work with other hash algorithms and tests that work but don't
 # test anything meaningful (e.g. special values which cause short collisions).
 test_lazy_prereq SHA1 '
-	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+	case "$GIT_DEFAULT_HASH" in
+	sha1) true ;;
+	"") test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 ;;
+	*) false ;;
+	esac
 '
 
 test_lazy_prereq REBASE_P '
