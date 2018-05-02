Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ECA021847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeEBA1G (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37732 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751925AbeEBA0s (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B8F0860B3B;
        Wed,  2 May 2018 00:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220807;
        bh=vEL1PEfZ12ulXHBsoLQvtaLyrS7IvGjQS9+PXGp9jpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Tc9WnEKo4x4XcFuslchM5oRcHukvQHEMgYSApVSjDqx3fSmVPITzHe6fUZuW1aMn4
         BidRx3+FMCt64TzOtrtj6xjY28q1NYYE6ZBDq0DIUU4UDyWHxecBZA+g2d9yjO9mCd
         U1uPBTTrlzvE4VTikF1PaiYv4Q2Rl74I1068AvfbcAWliU+pKENKs1yu6MYzBc2aHy
         z7UZ1eCZQWw4SzuoUt3TxQQ0K2tVtGaHaMDLrVMz5bVsVFZzFwWQEFDuyQvQxVLSJ3
         CNZDXp6d6bCsJBv/z1wlrkoW9sZUpGxxo8f5we4IXGbxgqRsWU1HomHSfaAlBblThE
         alqRS7snw1C9iF1+CuJRMP7IVhjvTzoOwaSX/QVZbolqYkZYQ6C2QSJo8STxjREJsW
         xdus0anOZbyyRoldvcPZ9T1X1MwcsuiQOEw+1rKN0iaR6dYf3Slkoqt3fwhVhWsOSM
         m0fe5CqSpe9OhEOxwo6vfpG6EJlihKu7QphK8ok2WFTwHh8ZhDO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 26/42] sha1-file: add functions for hex empty tree and blob OIDs
Date:   Wed,  2 May 2018 00:25:54 +0000
Message-Id: <20180502002610.915892-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oftentimes, we'll want to refer to an empty tree or empty blob by its
hex name without having to call oid_to_hex or explicitly refer to
the_hash_algo.  Add helper functions that format these values into
static buffers and return them for easy use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     |  3 +++
 sha1-file.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/cache.h b/cache.h
index 37d081b8e4..7115770fa6 100644
--- a/cache.h
+++ b/cache.h
@@ -1049,6 +1049,9 @@ static inline int is_empty_tree_oid(const struct object_id *oid)
 	return !oidcmp(oid, the_hash_algo->empty_tree);
 }
 
+const char *empty_tree_oid_hex(void);
+const char *empty_blob_oid_hex(void);
+
 /* set default permissions by passing mode arguments to open(2) */
 int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
diff --git a/sha1-file.c b/sha1-file.c
index 4328c61285..11598b43eb 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -100,6 +100,18 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	},
 };
 
+const char *empty_tree_oid_hex(void)
+{
+	static char buf[GIT_MAX_HEXSZ + 1];
+	return oid_to_hex_r(buf, the_hash_algo->empty_tree);
+}
+
+const char *empty_blob_oid_hex(void)
+{
+	static char buf[GIT_MAX_HEXSZ + 1];
+	return oid_to_hex_r(buf, the_hash_algo->empty_blob);
+}
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
