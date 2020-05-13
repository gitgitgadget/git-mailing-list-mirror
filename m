Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9BBC2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB7720675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="U+5oXqTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgEMAzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38244 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732016AbgEMAzP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 98B4660D01;
        Wed, 13 May 2020 00:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331283;
        bh=gbBVk96z+lg6+eQy2KlTt0kXUkZxVoEsEzOwqyymPIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=U+5oXqTto1zxEY9jiRjKL/TVaFuu2mlbant1AytegZbzwFvb930JL7OKHt2fnsyHN
         eKDF8TSlaZs2Zc/59hpTbcozub4zaBTiD6uA4JzSzDmphF0+WBR5z3iuyUDUsd7w17
         C+Mokj6MIE+9Q01qyKOO6VQZd5zxLn34KTB4xwwFy+Yb8Bf8brDuQo9abGWQYN36t6
         WHv+n0f7YRJaixVrsYmdX7Q4swZBTzFWp1LhPimrJZwQcD1YBmQBLz25LMBh8nbYdR
         5Z0AycrOmfUJ+D+lTpQpo4LLjVFvvCXrCzRcbecedjmYHI08K4vkiXFg842+VypWWk
         H0tJh+UTdz6X4MnBjx9QD7LJEm4N8w3PnKtQ4lUu8FO2JexOVOSjPmRphYWwiw9n4W
         seNgjRf/xkIxwcxLmsh+e6rmNaYzmQQUTr49UepWAQXodU8tONptuwr609ONcJNt/S
         LFIXrQuKmRk6eOPv/m+et5cb0mgU6va8/H2DDwQMv3sSdUUs7X1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 14/44] connect: detect algorithm when fetching refs
Date:   Wed, 13 May 2020 00:53:54 +0000
Message-Id: <20200513005424.81369-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we're fetching refs, detect the hash algorithm and parse the refs
using that algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index 511a069304..a39b843589 100644
--- a/connect.c
+++ b/connect.c
@@ -220,12 +220,24 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 
 static void process_capabilities(struct packet_reader *reader, int *len)
 {
+	const char *feat_val;
+	int feat_len;
+	int hash_algo;
 	const char *line = reader->line;
 	int nul_location = strlen(line);
 	if (nul_location == *len)
 		return;
 	server_capabilities_v1 = xstrdup(line + nul_location + 1);
 	*len = nul_location;
+
+	feat_val = server_feature_value("object-format", &feat_len);
+	if (feat_val) {
+		char *hash_name = xstrndup(feat_val, feat_len);
+		hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo != GIT_HASH_UNKNOWN)
+			reader->hash_algo = &hash_algos[hash_algo];
+		free(hash_name);
+	}
 }
 
 static int process_dummy_ref(const struct packet_reader *reader)
@@ -234,7 +246,7 @@ static int process_dummy_ref(const struct packet_reader *reader)
 	struct object_id oid;
 	const char *name;
 
-	if (parse_oid_hex(line, &oid, &name))
+	if (parse_oid_hex_algop(line, &oid, &name, reader->hash_algo))
 		return 0;
 	if (*name != ' ')
 		return 0;
@@ -258,7 +270,7 @@ static int process_ref(const struct packet_reader *reader, int len,
 	struct object_id old_oid;
 	const char *name;
 
-	if (parse_oid_hex(line, &old_oid, &name))
+	if (parse_oid_hex_algop(line, &old_oid, &name, reader->hash_algo))
 		return 0;
 	if (*name != ' ')
 		return 0;
@@ -270,7 +282,7 @@ static int process_ref(const struct packet_reader *reader, int len,
 		die(_("protocol error: unexpected capabilities^{}"));
 	} else if (check_ref(name, flags)) {
 		struct ref *ref = alloc_ref(name);
-		oidcpy(&ref->old_oid, &old_oid);
+		memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
 		**list = ref;
 		*list = &ref->next;
 	}
@@ -288,7 +300,7 @@ static int process_shallow(const struct packet_reader *reader, int len,
 	if (!skip_prefix(line, "shallow ", &arg))
 		return 0;
 
-	if (get_oid_hex(arg, &old_oid))
+	if (get_oid_hex_algop(arg, &old_oid, reader->hash_algo))
 		die(_("protocol error: expected shallow sha-1, got '%s'"), arg);
 	if (!shallow_points)
 		die(_("repository on the other end cannot be shallow"));
