Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851471F453
	for <e@80x24.org>; Mon, 15 Oct 2018 02:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJOKCc (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 06:02:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50768 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbeJOKCa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 06:02:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8C08961B76;
        Mon, 15 Oct 2018 02:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539569961;
        bh=nSYOCn3BKO6U1BwM/DgMdpuEA3IWjNQci7JWctU4e50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=m9nqDW71iOc+HL1Ia5duH8X7SbYQr1Ptr6SOC5dJtwRrZhv7FPXY26XlzODPMP2Kc
         nIpVchjRb3XJdJlJfglGbUehXqwuJrYT8h8RMes5pg28zg2KfKgttdhcHhlEEWoqhE
         pV+amW7AYCh5jqyKKS//lJv3TlOJEoCjqE5B4FhdzNbvuCRHslP7++kBnrDnjLm4Iu
         xUBo+gzZD/0Q3Cw4kVvia9g6Ybf4xvvViaf350YlCkvb8HJMUUtfmnJoRL8iWL6P88
         6+gxwfIWo18Hy5vM6D2VbuvM3FJyAXW69A1Yr/LatnvfohZr8vONfQrz+jfx3t9VH3
         wNdDbK7ThnGLSyK6lTOdKQ7A8w2crSs/AGCHO0+fAE1wpqbLSh4XHNhbljsPV3KIk4
         Eb0IEWmevf7C+k5mcEuinHVmMrpcJfwVR+HmuKt7Aogd7/PytQAYnh6rYkfTSAIFOi
         Rr+ALisibAc9u+xQTbwplpyJZQTSmUvLE6rnyjE/fkGMrBP/JZi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
Date:   Mon, 15 Oct 2018 02:19:00 +0000
Message-Id: <20181015021900.1030041-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the commit-graph code wants to serialize the hash algorithm into
the data store, specify a version number for each supported algorithm.
Note that we don't use the values of the constants themselves, as they
are internal and could change in the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit-graph.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7a28fbb03f..e587c21bb6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_dir)
 
 static uint8_t oid_version(void)
 {
-	return 1;
+	switch (hash_algo_by_ptr(the_hash_algo)) {
+		case GIT_HASH_SHA1:
+			return 1;
+		case GIT_HASH_SHA256:
+			return 2;
+		default:
+			BUG("unknown hash algorithm");
+	}
 }
 
 static struct commit_graph *alloc_commit_graph(void)
